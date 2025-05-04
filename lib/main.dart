import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pso/algorithm/pso_algorithm.dart';
import 'package:pso/utils/best_allocation_table.dart';
import 'package:pso/utils/resource_analysis.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/resource-allocation': (context) => PSOSimulation(),
      },
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Header section with gradient background
          SliverAppBar(
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.blue[800]!, Colors.lightBlue[400]!],
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.cloud, size: 60, color: Colors.white),
                        SizedBox(height: 20),
                        Text(
                          'CloudOptimus',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'AI Driven Dynamic Resource Allocation in Cloud Envirnoment',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white.withOpacity(0.9),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Main content section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/resource-allocation');
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5,
                    ),
                    child: Text(
                      'Start Resource Allocation',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 60),
                ],
              ),
            ),
          ),

          // About section
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800],
                    ),
                  ),
                  Divider(color: Colors.grey[300], thickness: 1),
                  SizedBox(height: 16),
                  Text(
                    'CloudOptimus optimizes performance, minimizes costs, and ensures high availability using advanced techniques like Particle Swarm Optimization (PSO), Genetic Algorithm (GA) and Simulated Annealing (SA). It offers a scalable, energy-efficient solution for dynamic resource allocation in diverse cloud workloads.',
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Project Proposes',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'A hybrid approach that combines PSO, GA & SA. Seek to maximize performance, and cost-effectiveness. Enables real-time adaptation to workload fluctuations.',
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Most Important',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'This approach adapts seamlessly to changing workloads and ensuring cloud resources are always allocated in the smartest, most efficient way possible.',
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                ],
              ),
            ),
          ),

          // Members section
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Members',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800],
                    ),
                  ),
                  Divider(color: Colors.grey[300], thickness: 1),
                  SizedBox(height: 16),
                  Text(
                    'CloudOptimus is a project developed by Final year Computer Engineering students at Usha Mittal Institute of Technology.',
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                  SizedBox(height: 20),
                  _buildMemberCard('Suma Gowda', 'gsuma577@gmail.com'),
                  _buildMemberCard('Lakshya Chobdar', 'lakshya26chobdar@gmail.com'),
                  _buildMemberCard('Srishti Gaikwad', 'srishtiGaikwad19@gmail.com'),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }

  Widget _buildMemberCard(String name, String email) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            CircleAvatar(
              child: Icon(Icons.person),
              backgroundColor: Colors.blue[100],
              foregroundColor: Colors.blue[800],
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    email,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PSOSimulation extends StatefulWidget {
  @override
  _PSOSimulationState createState() => _PSOSimulationState();
}

class _PSOSimulationState extends State<PSOSimulation> {
  static const int swarmSize = 50;
  static const int maxIterations = 200;
  final double w = 0.7;
  final double c1 = 2.0;
  final double c2 = 2.0;
  bool isRunning = false;
  List<Resource>? resources;
  List<Task>? tasks;
  PSO? pso;
  List<double> fitnessProgress = [];
  double mse = 0.0;
  double mae = 0.0;
  final stopwatch = Stopwatch();

  List<TextEditingController> resourceControllers = List.generate(
    3,
    (_) => TextEditingController(text: '100.0'),
  );

  List<Map<String, TextEditingController>> taskControllers = [];

  @override
  void initState() {
    super.initState();
    addTaskInput();
  }

  void addTaskInput() {
    taskControllers.add({
      'cpu': TextEditingController(),
      'memory': TextEditingController(),
      'bandwidth': TextEditingController(),
    });
    setState(() {});
  }

  void collectUserInputData() {
    resources = [
      Resource(name: 'CPU', capacity: double.parse(resourceControllers[0].text)),
      Resource(name: 'Memory', capacity: double.parse(resourceControllers[1].text)),
      Resource(name: 'Bandwidth', capacity: double.parse(resourceControllers[2].text)),
    ];

    tasks = [];
    for (int i = 0; i < taskControllers.length; i++) {
      var t = taskControllers[i];
      tasks!.add(Task(
        id: i + 1,
        cpu: double.parse(t['cpu']!.text),
        memory: double.parse(t['memory']!.text),
        bandwidth: double.parse(t['bandwidth']!.text),
      ));
    }

    initializePSO();
  }

  void initializePSO() {
    if (tasks == null || resources == null) return;
    pso = PSO(
      swarmSize: swarmSize,
      maxIterations: maxIterations,
      w: w,
      c1: c1,
      c2: c2,
    );
    pso!.initialize(tasks!, resources!);
  }

  void runPSO() async {
    setState(() {
      isRunning = true;
      fitnessProgress.clear();
    });

    stopwatch.reset();
    stopwatch.start();

    await pso!.run(tasks!, (metrics) {
      setState(() {
        fitnessProgress.add(metrics['mse']!);
        mse = metrics['mse']!;
        mae = metrics['mae']!;
      });
    });

    stopwatch.stop();
    setState(() {
      isRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hybrid PSO-GA-SA Resource Allocator')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Text('Resource Capacities', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            for (int i = 0; i < resourceControllers.length; i++)
              TextField(
                controller: resourceControllers[i],
                decoration: InputDecoration(labelText: ['CPU', 'Memory', 'Bandwidth'][i]),
                keyboardType: TextInputType.number,
              ),
            SizedBox(height: 20),
            Text('Tasks', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            for (int i = 0; i < taskControllers.length; i++)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text('Task ${i + 1}', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextField(controller: taskControllers[i]['cpu'], decoration: InputDecoration(labelText: 'CPU'), keyboardType: TextInputType.number),
                      TextField(controller: taskControllers[i]['memory'], decoration: InputDecoration(labelText: 'Memory'), keyboardType: TextInputType.number),
                      TextField(controller: taskControllers[i]['bandwidth'], decoration: InputDecoration(labelText: 'Bandwidth'), keyboardType: TextInputType.number),
                    ],
                  ),
                ),
              ),
            ElevatedButton(onPressed: addTaskInput, child: Text('Add Task')),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                collectUserInputData();
                runPSO();
              },
              child: Text('Run Hybrid PSO'),
            ),
            SizedBox(height: 20),
            if (isRunning) Center(child: CircularProgressIndicator()),
            if (!isRunning && pso != null && pso!.gBest.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BestAllocationTable(gBest: pso!.gBest, gBestFitness: pso!.gBestFitness, tasks: tasks!),
                  ResourceAnalysis(resources: resources!, tasks: tasks!, gBest: pso!.gBest),
                  FitnessChart(fitnessValues: fitnessProgress),
                  Text('MSE: ${mse.toStringAsFixed(10)}'),
                  Text('MAE: ${mae.toStringAsFixed(10)}'),
                  Text('Time Elapsed: ${stopwatch.elapsedMilliseconds} ms'),
                ],
              )
          ],
        ),
      ),
    );
  }
}

class FitnessChart extends StatelessWidget {
  final List<double> fitnessValues;
  FitnessChart({required this.fitnessValues});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          titlesData: FlTitlesData(show: true),
          borderData: FlBorderData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: fitnessValues
                  .asMap()
                  .entries
                  .map((e) => FlSpot(e.key.toDouble(), e.value))
                  .toList(),
              isCurved: true,
              color: Colors.black,
              barWidth: 2,
            ),
          ],
        ),
      ),
    );
  }
}        
