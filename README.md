# Robotics Kinematics with MATLAB
 
**Forward and Inverse Kinematics of a 3-Link Planar Robot Arm**
 
This project covers the mathematical modelling, implementation, and visualization of a three-link planar robotic arm in MATLAB.
 
Both **Forward Kinematics (FK)** and **Inverse Kinematics (IK)** are implemented to study the relationship between joint angles, link lengths, and the end-effector pose. The workflow starts with deriving the equations by hand, then implements them in MATLAB, computes the joint positions, and finally visualizes the arm through 2D plots and animations.
 
---
 
## Table of Contents
 
- [Robot Model](#robot-model)
- [1. Forward Kinematics](#1-forward-kinematics)
  - [Derivation](#fk-derivation)
  - [Complete FK Equations](#complete-fk-equations)
  - [MATLAB Implementation](#fk-matlab-implementation)
  - [Results](#fk-results)
- [2. Inverse Kinematics](#2-inverse-kinematics)
  - [Derivation](#ik-derivation)
  - [Solving for the Joint Angles](#solving-for-the-joint-angles)
  - [Results](#ik-results)
- [Requirements](#requirements)
- [How to Run](#how-to-run)
---
 
## Robot Model
 
The robot consists of three rigid links connected by three revolute joints. Each joint rotates in the XY plane, and every joint angle is measured **relative to the preceding link**, not with respect to the global frame.
 
| Parameter | Symbol | Value |
|-----------|--------|-------|
| Link 1 length | L₁ | 2.0 m |
| Link 2 length | L₂ | 1.5 m |
| Link 3 length | L₃ | 1.0 m |
| Maximum reach | L₁ + L₂ + L₃ | 4.5 m |
 
Because the angles are relative, the **absolute** orientation of each link with respect to the global X-axis is the running sum of the joint angles:
 
| Link | Absolute orientation |
|------|---------------------|
| Link 1 | θ₁ |
| Link 2 | θ₁ + θ₂ |
| Link 3 | θ₁ + θ₂ + θ₃ |
 
This cumulative relationship is the key to computing the Cartesian position of every joint.
 
---
 
## 1. Forward Kinematics
 
### Objective
 
Forward Kinematics determines the **position and orientation of the end effector** when the link lengths and joint angles are known.
 
For the initial FK implementation the joint angles are:
 
| Joint | Symbol | Value |
|-------|--------|-------|
| Joint 1 | θ₁ | 30° |
| Joint 2 | θ₂ | 40° |
| Joint 3 | θ₃ | −20° |
 
### FK Derivation
 
#### Step 1 — Convert degrees into radians
 
MATLAB's trigonometric functions expect radians, so the joint angles are converted first:
 
```
theta_rad = theta_deg * (pi / 180)
```
 
#### Step 2 — Position of Joint 1
 
The first link starts at the robot base, which is taken as the origin:
 
```
P0 = (0, 0)
```
 
Resolving the first link into its horizontal and vertical components:
 
```
x1 = L1 * cos(θ1)
y1 = L1 * sin(θ1)
```
 
#### Step 3 — Position of Joint 2
 
The second link starts at the tip of the first link, and its absolute orientation is θ₁ + θ₂. Its components are therefore added to the position of Joint 1:
 
```
x2 = x1 + L2 * cos(θ1 + θ2)
y2 = y1 + L2 * sin(θ1 + θ2)
```
 
#### Step 4 — Position of the end effector
 
The third link starts at the tip of the second link with absolute orientation θ₁ + θ₂ + θ₃:
 
```
x3 = x2 + L3 * cos(θ1 + θ2 + θ3)
y3 = y2 + L3 * sin(θ1 + θ2 + θ3)
```
 
The resulting point P₃ = (x₃, y₃) is the position of the end effector.
 
### Complete FK Equations
 
Combining the individual link equations gives the end-effector pose directly in terms of the three joint angles:
 
```
x = L1*cos(θ1) + L2*cos(θ1 + θ2) + L3*cos(θ1 + θ2 + θ3)
 
y = L1*sin(θ1) + L2*sin(θ1 + θ2) + L3*sin(θ1 + θ2 + θ3)
 
φ = θ1 + θ2 + θ3
```
 
These three equations form the complete mathematical model of the arm.
 
### FK MATLAB Implementation
 
The equations above were implemented in MATLAB using `sin` and `cos`. The Cartesian coordinates of each joint are computed sequentially, starting at the base and working outwards to the end effector, and the resulting coordinate list defines the full robot configuration.
 
**Visualization and animation.** The arm is drawn in a 2D Cartesian coordinate system using MATLAB plotting functions. An animation is produced with a `for` loop: the joint angles are updated gradually, the joint positions are recomputed at every iteration, and the existing plot is refreshed — showing how a change in joint angles affects both the configuration and the end-effector position.
 
### FK Results
 
For θ₁ = 30°, θ₂ = 40°, θ₃ = −20° the end-effector pose is:
 
| Quantity | Value |
|----------|-------|
| x | 2.888 m |
| y | 3.176 m |
| φ | 50° |
 
**Robot configuration**
 
<!-- Add your image: ![Robot configuration](images/fk_configuration.png) -->
 
**Robot animation**
 
<!-- Add your image: ![Robot animation](images/fk_animation.gif) -->
 
---
 
## 2. Inverse Kinematics
 
### Objective
 
Inverse Kinematics determines the **joint angles required to reach a specified end-effector position and orientation**. Where FK starts from known joint angles and computes the pose, IK starts from the desired pose and works backwards to the angles.
 
This implementation uses MATLAB's **Symbolic Math Toolbox** to formulate and solve the equations.
 
### Target Pose
 
The same three-link arm is used (L₁ = 2.0 m, L₂ = 1.5 m, L₃ = 1.0 m), with the desired end-effector configuration:
 
| Quantity | Symbol | Value |
|----------|--------|-------|
| Desired X | x_des | 2.0 m |
| Desired Y | y_des | 1.5 m |
| Desired orientation | φ_des | 45° |
 
### IK Derivation
 
#### Step 1 — Desired end-effector configuration
 
The desired pose is expressed as a homogeneous transformation matrix, which packs rotation and translation into a single representation:
 
```
          [ cos(φ_des)   -sin(φ_des)   x_des ]
T_des  =  [ sin(φ_des)    cos(φ_des)   y_des ]
          [     0             0          1   ]
```
 
#### Step 2 — Unknown joint angles
 
The three joint angles are unknown, so they are declared as symbolic variables θ₁, θ₂, θ₃. Symbolic variables let MATLAB manipulate the expressions without requiring numerical values in advance.
 
#### Step 3 — Individual transformation matrices
 
Each link is represented by its own homogeneous transformation, describing the rotation and translation it contributes relative to the preceding frame:
 
```
          [ cos(θ1)   -sin(θ1)   L1*cos(θ1) ]
T_01  =   [ sin(θ1)    cos(θ1)   L1*sin(θ1) ]
          [    0          0           1     ]
 
          [ cos(θ2)   -sin(θ2)   L2*cos(θ2) ]
T_12  =   [ sin(θ2)    cos(θ2)   L2*sin(θ2) ]
          [    0          0           1     ]
 
          [ cos(θ3)   -sin(θ3)   L3*cos(θ3) ]
T_23  =   [ sin(θ3)    cos(θ3)   L3*sin(θ3) ]
          [    0          0           1     ]
```
 
#### Step 4 — Complete transformation matrix
 
The transformation from the base to the end effector is the product of the three individual matrices:
 
```
T_03 = T_01 * T_12 * T_23
```
 
After symbolic multiplication and simplification:
 
```
          [ cos(θ1+θ2+θ3)   -sin(θ1+θ2+θ3)   x ]
T_03  =   [ sin(θ1+θ2+θ3)    cos(θ1+θ2+θ3)   y ]
          [       0                0          1 ]
```
 
Here x and y are exactly the end-effector coordinates derived in the FK section. The matrix therefore describes the full end-effector pose as a function of the three unknown joint angles.
 
#### Step 5 — Formulating the IK equations
 
The computed transformation is set equal to the desired transformation:
 
```
T_03 = T_des
```
 
Comparing the corresponding matrix elements yields three constraints:
 
**X-position constraint**
 
```
L1*cos(θ1) + L2*cos(θ1 + θ2) + L3*cos(θ1 + θ2 + θ3) = x_des
```
 
**Y-position constraint**
 
```
L1*sin(θ1) + L2*sin(θ1 + θ2) + L3*sin(θ1 + θ2 + θ3) = y_des
```
 
**Orientation constraint**
 
```
θ1 + θ2 + θ3 = 45°
```
 
All three must be satisfied simultaneously for the arm to reach the desired pose.
 
#### Step 6 — Reducing the number of unknowns
 
Since the desired orientation is already known, the orientation constraint can be rearranged to express the third joint angle in terms of the first two:
 
```
θ3 = 45° - θ1 - θ2
```
 
Substituting this into the position equations makes the third-link contribution constant, because the total orientation is fixed at 45°:
 
```
L3*cos(45°) = 0.7071
L3*sin(45°) = 0.7071
```
 
Inserting the link lengths and target coordinates gives the reduced system:
 
**Reduced X-position equation**
 
```
2.0 = 2*cos(θ1) + 1.5*cos(θ1 + θ2) + 0.7071
```
 
**Reduced Y-position equation**
 
```
1.5 = 2*sin(θ1) + 1.5*sin(θ1 + θ2) + 0.7071
```
 
The original problem in three unknowns is now **two nonlinear equations in two unknowns**, θ₁ and θ₂.
 
### Solving for the Joint Angles
 
The reduced system is solved simultaneously with MATLAB's symbolic `solve()` function, which returns the possible values of θ₁ and θ₂. The third angle then follows from the orientation constraint:
 
```
θ3 = 45° - θ1 - θ2
```
 
The symbolic results are converted to numerical values with `double()` and from radians into degrees for easier interpretation.
 
> **Note:** depending on the target pose, more than one valid joint configuration may exist. These multiple solutions represent alternative ways for the arm to reach the same end-effector pose — a general property of inverse kinematics, not an error in the solver.
 
### Computing the Joint Positions
 
Once the joint angles are known, the FK position equations are applied again to recover the Cartesian coordinates of every joint. The angles fix the orientation of each link, which allows the complete arm configuration to be reconstructed and plotted in MATLAB with the desired end-effector position marked in the same coordinate system.
 
### Visualizing and Animating the IK Solution
 
An animation shows the transition from the initial configuration to the computed IK configuration:
 
1. All three joint angles start at zero, so the links lie along the positive X-axis.
2. The joint angles are interpolated gradually between their initial and final values.
3. At each step the joint coordinates are recomputed and the drawing is updated.
The result is a clear visual account of how the arm reconfigures itself to reach the specified position and orientation.
 
### IK Results
 
**Final robot configuration**
 
<!-- Add your image: ![IK configuration](images/ik_configuration.png) -->
 
**Inverse Kinematics animation**
 
<!-- Add your image: ![IK animation](images/ik_animation.gif) -->
 
---
 
## Requirements
 
- MATLAB R2020a or newer
- Symbolic Math Toolbox (required for the Inverse Kinematics scripts)
## How to Run
 
1. Clone the repository and open the folder in MATLAB.
2. Run the Forward Kinematics script to compute and plot the end-effector pose.
3. Run the Inverse Kinematics script to solve for the joint angles and animate the motion to the target pose.
4. Link lengths, joint angles, and the target pose can all be edited at the top of each script.
 
