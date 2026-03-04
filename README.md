# Control of a Self-Balancing Robot

This repository contains the work developed for my Bachelor’s Thesis in Computer Science and Control Engineering at Sapienza University of Rome. The project focuses on the dynamic modeling and control of a self-balancing robot (an inverted pendulum on wheels).

## 🎯 Project Objective
The main goal is to maintain the robot's equilibrium and control its position, effectively managing the system's inherent instabilities and non-linear dynamics.

## 🛠️ Tech Stack & Methodology
* **MATLAB**: Used for numerical analysis, system linearization, and parameter tuning.
* **Simulink**: Used for block-diagram modeling and dynamic simulations.
* **Lagrangian Mechanics**: Applied to derive the equations of motion (EOM).

## 🚀 Control Strategies
Two different advanced control techniques were implemented and compared:

1.  **LQR (Linear Quadratic Regulator)**:
    * Designed by minimizing a quadratic cost function.
    * Stability analysis through pole placement and state-space representation.
2.  **MPC (Model Predictive Control)**:
    * Implemented to handle system constraints (e.g., motor saturation and tilt limits).
    * Performance analysis based on varying prediction and control horizons.

## 📊 Results
The simulations demonstrate the robot's ability to recover from external disturbances and reach the target position with minimal overshoot. The MPC controller showed superior performance in handling physical actuator constraints compared to the standard LQR.
---
*Note: This project was supervised by Prof. Giuseppe Oriolo.*
