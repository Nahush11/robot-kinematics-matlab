Robotics Kinematics with MATLAB

Forward and Inverse Kinematics of a 3-Link Planar Robot Arm

This project focuses on understanding and implementing the kinematics of a 3-link planar robotic arm using MATLAB. I implemented both Forward Kinematics (FK) and Inverse Kinematics (IK), starting with the mathematical equations and then translating them into MATLAB for calculation, visualization, and animation.

The main objective was to understand how the joint angles of a robotic arm determine the end-effector position and, conversely, how the required joint angles can be calculated from a desired end-effector position and orientation.

1. Forward Kinematics (FK)

Objective

Forward Kinematics determines the position and orientation of the robot's end effector when the link lengths and joint angles are already known.

I started by considering a planar robotic arm consisting of three rigid links connected by three revolute joints. Each joint rotates in the 2D plane, and the angle of each link is measured relative to the previous link.

Robot Parameters

Parameter

Value

Link 1 (L1)

2.0 m

Link 2 (L2)

1.5 m

Link 3 (L3)

1.0 m

Joint angle 1

30°

Joint angle 2

40°

Joint angle 3

-20°

Mathematical Approach

Step 1: Understanding the joint angles

Since the robot has three revolute joints, each link has an orientation relative to the previous link.

The absolute orientation of each link with respect to the global X-axis is:

Link 1: (\theta_1)

Link 2: (\theta_1+\theta_2)

Link 3: (\theta_1+\theta_2+\theta_3)

This is important because the second and third joint angles are relative rotations, not absolute angles measured from the global X-axis.

Step 2: Converting degrees into radians

Trigonometric calculations in MATLAB use radians, so I converted the joint angles before calculating their Cartesian coordinates.

[
\theta_{\text{rad}}=\theta_{\text{deg}}\times\frac{\pi}{180}
]

Step 3: Calculating the position of Joint 1

The first link starts at the robot base (origin) and has length (L_1).

Using basic trigonometry:

[
x_1=L_1\cos(\theta_1)
]

[
y_1=L_1\sin(\theta_1)
]

These equations calculate the horizontal and vertical coordinates of the first joint.

Step 4: Calculating the position of Joint 2

The second link starts at the endpoint of the first link.

Its absolute orientation is the sum of the first and second joint angles.

[
x_2=x_1+L_2\cos(\theta_1+\theta_2)
]

[
y_2=y_1+L_2\sin(\theta_1+\theta_2)
]

The coordinates of the first joint are added to the second link's horizontal and vertical components to obtain the position of Joint 2.

Step 5: Calculating the end-effector position

The third link starts at the endpoint of the second link.

Its absolute orientation is:

[
\theta_1+\theta_2+\theta_3
]

Therefore:

[
x_3=x_2+L_3\cos(\theta_1+\theta_2+\theta_3)
]

[
y_3=y_2+L_3\sin(\theta_1+\theta_2+\theta_3)
]

The resulting coordinates ((x_3,y_3)) represent the end-effector position.

Step 6: Complete Forward Kinematics equations

By combining the three link equations, the complete end-effector position can be expressed directly as:

[
\boxed{
x=L_1\cos\theta_1+
L_2\cos(\theta_1+\theta_2)+
L_3\cos(\theta_1+\theta_2+\theta_3)
}
]

[
\boxed{
y=L_1\sin\theta_1+
L_2\sin(\theta_1+\theta_2)+
L_3\sin(\theta_1+\theta_2+\theta_3)
}
]

The final orientation of the end effector is:

[
\boxed{\phi=\theta_1+\theta_2+\theta_3}
]

These equations form the mathematical foundation of the Forward Kinematics model.

Visualization and Animation

After calculating the coordinates of each joint, I used MATLAB plotting functions to represent the robot arm in a 2D Cartesian coordinate system.

I then implemented an animation using a for loop. During each iteration, the joint angles were updated, the new joint positions were calculated, and the existing robot drawing was updated.

This allowed me to observe how changing the joint angles affects the overall configuration and end-effector position.

Forward Kinematics – Robot Configuration

<img width="1111" height="746" alt="robot_arm" src="https://github.com/user-attachments/assets/b86fb73d-68b0-44fb-af50-13115b5908bb" />

Forward Kinematics – Animation

<!-- Add FK GIF here -->

<img width="1075" height="645" alt="robot_arm_animation" src="https://github.com/user-attachments/assets/2e1e0cae-4bd7-4913-9f52-c6b66109a3a3" />





Robot Arm

<img width="1442" height="1484" alt="Three_Link_Robot_IK" src="https://github.com/user-attachments/assets/3545787f-7015-4f19-98dc-e5e129f2b623" />


Animation
<img width="1075" height="645" alt="Three_Link_Robot_IK_Animation" src="https://github.com/user-attachments/assets/86ac0689-f436-4afc-a83d-0e1be1b89a9e" />


