# 🧠 Hybrid PSO-GA-SA Optimizer for Multi-Resource Task Allocation

This Flutter application implements a **hybrid optimization algorithm** that combines **Particle Swarm Optimization (PSO)**, **Genetic Algorithm (GA)** crossover/mutation, and **Simulated Annealing (SA)** for **multi-resource task allocation**. The app visualizes performance metrics like **Mean Squared Error (MSE)** and **Mean Absolute Error (MAE)** in real-time and displays the **best allocation results** and **resource usage analysis**.

---

## 🚀 Features

- Hybrid PSO-GA-SA optimizer
- Real-time charts for MSE and MAE
- Best allocation table (task-resource assignments)
-  Resource usage visualization
- Intelligent tuning via simulated annealing
- Optimized for resource allocation problems with CPU, memory, and bandwidth constraints

## How It Works

PSO initializes a swarm of particles (possible allocations).

Fitness is evaluated using MSE and MAE for CPU, memory, and bandwidth errors.

Every 5 iterations:

GA crossover and mutation improve population diversity.

With a probability of 10%:

Simulated Annealing escapes local minima using probabilistic jumps.

Global best (gBest) and local best (pBest) allocations are updated each iteration.
