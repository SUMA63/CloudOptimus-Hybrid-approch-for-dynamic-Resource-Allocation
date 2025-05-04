import 'dart:math';

class Particle {
  List<double> allocation;
  List<double> velocity;
  late double fitness;
  List<double> pBest;

  static final Random _random = Random();

  Particle(int numTasks, int numResources)
      : allocation = List<double>.generate(
            numTasks * numResources, (_) => _random.nextDouble() * 10),
        velocity = List<double>.generate(
            numTasks * numResources, (_) => _random.nextDouble()),
        pBest = List<double>.generate(
            numTasks * numResources, (_) => _random.nextDouble() * 10);
}

class Resource {
  String name;
  double capacity;

  Resource({required this.name, required this.capacity});

  factory Resource.fromJson(Map<String, dynamic> json) {
    return Resource(
      name: json['name'],
      capacity: json['capacity'].toDouble(),
    );
  }
}

class Task {
  int id;
  double cpu;
  double memory;
  double bandwidth;

  Task({required this.id, required this.cpu, required this.memory, required this.bandwidth});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      cpu: json['cpu'].toDouble(),
      memory: json['memory'].toDouble(),
      bandwidth: json['bandwidth'].toDouble(),
    );
  }
}

class PSO {
  final int swarmSize;
  final int maxIterations;
  double w;
  final double c1;
  final double c2;

  List<Particle>? swarm;
  List<double> gBest = [];
  double gBestFitness = double.maxFinite;
  late List<Task> tasks;

  PSO({required this.swarmSize, required this.maxIterations, required this.w, required this.c1, required this.c2});

  void initialize(List<Task> t, List<Resource> resources) {
    tasks = t;
    int numTasks = t.length;
    int numResources = resources.length;
    swarm = List.generate(swarmSize, (_) => Particle(numTasks, numResources));
    gBest = List<double>.from(swarm![0].allocation);
    print('Hybrid PSO initialized.');
  }

  Future<void> run(List<Task> tasks, Function(Map<String, double>) onIteration) async {
    if (swarm == null) return;

    double wMin = 0.1;
    double inertiaWeightDelta = (w - wMin) / maxIterations;

    for (int iter = 0; iter < maxIterations; iter++) {
      await Future.forEach(swarm!, (Particle particle) async {
        var metrics = evaluate(particle.allocation, tasks);
        particle.fitness = metrics['mse']!;

        if (particle.fitness < evaluate(particle.pBest, tasks)['mse']!) {
          particle.pBest = List<double>.from(particle.allocation);
        }
        if (particle.fitness < gBestFitness) {
          gBest = List<double>.from(particle.allocation);
          gBestFitness = particle.fitness;
        }
      });

      onIteration({'mse': gBestFitness, 'mae': evaluate(gBest, tasks)['mae']!});

      for (var particle in swarm!) {
        for (int d = 0; d < particle.allocation.length; d++) {
          particle.velocity[d] = w * particle.velocity[d] +
              c1 * Random().nextDouble() * (particle.pBest[d] - particle.allocation[d]) +
              c2 * Random().nextDouble() * (gBest[d] - particle.allocation[d]);
          particle.allocation[d] += particle.velocity[d];
        }
      }

      if (iter % 5 == 0) _applyCrossoverAndMutation();
      if (Random().nextDouble() < 0.1) _applySimulatedAnnealing();

      w = max(wMin, w - inertiaWeightDelta);
      await Future.delayed(Duration(milliseconds: 30));
    }
  }

  void _applyCrossoverAndMutation() {
    for (int i = 0; i < swarm!.length - 1; i += 2) {
      var p1 = swarm![i];
      var p2 = swarm![i + 1];
      int point = Random().nextInt(p1.allocation.length);
      for (int j = 0; j < point; j++) {
        double temp = p1.allocation[j];
        p1.allocation[j] = p2.allocation[j];
        p2.allocation[j] = temp;
      }
      if (Random().nextDouble() < 0.1) {
        int idx = Random().nextInt(p1.allocation.length);
        p1.allocation[idx] += Random().nextDouble() - 0.5;
      }
    }
  }

  void _applySimulatedAnnealing() {
    for (var particle in swarm!) {
      double currentFitness = evaluate(particle.allocation, tasks)['mse']!;
      List<double> newAllocation = List.from(particle.allocation);
      int idx = Random().nextInt(newAllocation.length);
      newAllocation[idx] += Random().nextDouble() - 0.5;

      double newFitness = evaluate(newAllocation, tasks)['mse']!;
      double temp = 100.0 / (1 + maxIterations);

      if (newFitness < currentFitness ||
          Random().nextDouble() < exp(-(newFitness - currentFitness) / temp)) {
        particle.allocation = newAllocation;
        particle.fitness = newFitness;
      }
    }
  }

  Map<String, double> evaluate(List<double> allocation, List<Task> tasks) {
    double mse = 0.0;
    double mae = 0.0;
    for (int i = 0; i < tasks.length; i++) {
      double cpuError = allocation[i * 3] - tasks[i].cpu;
      double memoryError = allocation[i * 3 + 1] - tasks[i].memory;
      double bandwidthError = allocation[i * 3 + 2] - tasks[i].bandwidth;
      mse += pow(cpuError, 2) + pow(memoryError, 2) + pow(bandwidthError, 2);
      mae += cpuError.abs() + memoryError.abs() + bandwidthError.abs();
    }
    mse /= tasks.length * 3;
    mae /= tasks.length * 3;
    return {'mse': mse, 'mae': mae};
  }
}

class Range {
  final double min;
  final double max;
  Range(this.min, this.max);
  double random() => min + Random().nextDouble() * (max - min);
}
