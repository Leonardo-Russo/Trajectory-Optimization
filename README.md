# Minimum Time Low-Thrust Trajectory - LEO to GEO

This repository contains a project dedicated to the optimization of a low-thrust trajectory from a Low Earth Orbit (LEO) to a Geosynchronous Orbit (GEO) with the goal of minimizing the transfer time.

## Project

### Low-Thrust Trajectory Optimization

In this project, we use modern optimization techniques to calculate the minimum time low-thrust trajectory for a transfer from LEO to GEO.

#### Theory

The spacecraft propulsion system is assumed to be low-thrust, meaning the thrust levels are much smaller than the weight of the spacecraft. Despite the longer transfer time, low-thrust transfers can be more fuel-efficient than high-thrust (Hohmann) transfers.

The problem of finding the minimum time low-thrust transfer involves determining the spacecraft's control (thrust direction) at each point along the trajectory that will minimize the total transfer time. This is typically a complex, nonlinear optimization problem that involves the spacecraft's equations of motion and various physical and technological constraints.

Various optimization methods can be applied to this problem, such as gradient-based methods, direct methods (such as the method of particular solutions and shooting methods), or indirect methods based on the maximum principle. These techniques transform the continuous-time optimal control problem into a parameter optimization problem that can be solved using traditional optimization techniques.

---

## Disclaimer

This project is created for educational purposes. Please use responsibly and ensure all simulations and data are used in a manner adhering to applicable laws and regulations.

