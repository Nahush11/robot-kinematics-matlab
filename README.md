Robotics Kinematics with MATLAB

Forward and Inverse Kinematics of a 3-Link Planar Robot Arm

This project explores the mathematical modelling and simulation of a 3-link planar robotic arm using MATLAB. It covers both Forward Kinematics (FK) and Inverse Kinematics (IK), including mathematical derivations, joint position calculations, 2D visualization, and animation.

The objective is to understand the relationship between joint angles, link lengths, and end-effector position, and to apply these concepts through MATLAB implementations.

1. Forward Kinematics (FK)

Objective

Forward Kinematics calculates the position and orientation of a robot's end effector when the link lengths and joint angles are known.

The robot consists of three rigid links connected by three revolute joints. Each joint rotates in the 2D plane, with its angle measured relative to the previous link.

Robot Configuration

Parameter

Value

Number of links

3

Link 1 ($L_1$)

2.0 m

Link 2 ($L_2$)

1.5 m

Link 3 ($L_3$)

1.0 m

Joint angle ($\theta_1$)

30°

Joint angle ($\theta_2$)

40°

Joint angle ($\theta_3$)

-20°

Mathematical Derivation

Step 1 – Link orientations

Since each joint angle represents a relative rotation, the absolute orientation of each link with respect to the global X-axis is:

Link

Absolute orientation

Link 1

$\theta_1$

Link 2

$\theta_1+\theta_2$

Link 3

$\theta_1+\theta_2+\theta_3$

Step 2 – Degree to radian conversion

MATLAB's trigonometric functions use radians.

$$
\theta_{\text{rad}}=\theta_{\text{deg}}\times\frac{\pi}{180}
$$

Step 3 – Position of Joint 1

The first link starts at the origin $(0,0)$.

Using basic trigonometry:

$$
x_1=L_1\cos(\theta_1)
$$

$$
y_1=L_1\sin(\theta_1)
$$

Step 4 – Position of Joint 2

The second link starts at the endpoint of the first link. Its absolute orientation is $\theta_1+\theta_2$.

$$
x_2=x_1+L_2\cos(\theta_1+\theta_2)
$$

$$
y_2=y_1+L_2\sin(\theta_1+\theta_2)
$$

Step 5 – End-effector position (Joint 3)

The third link starts at the endpoint of the second link.

Its absolute orientation is:

$$
\theta_1+\theta_2+\theta_3
$$

Therefore:

$$
x_3=x_2+L_3\cos(\theta_1+\theta_2+\theta_3)
$$

$$
y_3=y_2+L_3\sin(\theta_1+\theta_2+\theta_3)
$$

Step 6 – Complete Forward Kinematics model

Combining the three link equations gives the final end-effector coordinates:

$$
\boxed{
x=L_1\cos\theta_1+
L_2\cos(\theta_1+\theta_2)+
L_3\cos(\theta_1+\theta_2+\theta_3)
}
$$

$$
\boxed{
y=L_1\sin\theta_1+
L_2\sin(\theta_1+\theta_2)+
L_3\sin(\theta_1+\theta_2+\theta_3)
}
$$

The end-effector orientation is:

$$
\boxed{\phi=\theta_1+\theta_2+\theta_3}
$$

These equations form the mathematical foundation of the Forward Kinematics model.

Visualization and Animation

After deriving the equations, I implemented them in MATLAB to calculate the Cartesian coordinates of each joint and the end effector.

I used MATLAB plotting functions to visualize the robot arm in a 2D coordinate system. I also implemented an animation using a for loop, where the joint angles are updated at each iteration and the corresponding joint positions are recalculated.

This demonstrates how changes in joint angles affect the robot's configuration and end-effector position.

Results


Forward Kinematics – Robot Configuration

<img width="1111" height="746" alt="robot_arm" src="https://github.com/user-attachments/assets/b86fb73d-68b0-44fb-af50-13115b5908bb" />

Forward Kinematics – Animation

<!-- Add FK GIF here -->

<img width="1075" height="645" alt="robot_arm_animation" src="https://github.com/user-attachments/assets/2e1e0cae-4bd7-4913-9f52-c6b66109a3a3" />





Robot Arm

<img width="1442" height="1484" alt="Three_Link_Robot_IK" src="https://github.com/user-attachments/assets/3545787f-7015-4f19-98dc-e5e129f2b623" />


Animation
<img width="1075" height="645" alt="Three_Link_Robot_IK_Animation" src="https://github.com/user-attachments/assets/86ac0689-f436-4afc-a83d-0e1be1b89a9e" />


