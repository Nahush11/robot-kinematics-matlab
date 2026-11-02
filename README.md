Robotics Kinematics with MATLAB

Forward and Inverse Kinematics of a 3-Link Planar Robot Arm

This project focuses on the mathematical modelling, implementation, and visualization of a three-link planar robotic arm using MATLAB.

Both Forward Kinematics (FK) and Inverse Kinematics (IK) are implemented to understand the relationship between joint angles, link lengths, and the end-effector pose.

The project starts with deriving the mathematical equations, followed by implementing them in MATLAB, calculating joint positions, and visualizing the robot through 2D plots and animations.

1. Forward Kinematics (FK)

Objective

Forward Kinematics determines the position and orientation of a robot's end effector when the link lengths and joint angles are known.

The robot consists of three rigid links connected by three revolute joints. Each joint provides rotational motion in the XY plane. The joint angles are defined relative to the preceding link, rather than independently with respect to the global coordinate frame.

Robot Configuration

The robot is defined using the following parameters:

Link 1: (L_1 = 2.0,m)

Link 2: (L_2 = 1.5,m)

Link 3: (L_3 = 1.0,m)

For the initial Forward Kinematics implementation, the joint angles are:

First joint: $$\theta_1 = 30^\circ$$

Second joint: $$\theta_2 = 40^\circ$$

Third joint: $$\theta_3 = -20^\circ$$

Mathematical Derivation

1. Understanding the Link Orientations

Since each joint angle represents a relative rotation, the absolute orientation of each link is calculated by adding the preceding joint angles.

The orientation of each link with respect to the global X-axis is:

Link 1: $$\theta_1$$

Link 2: $$\theta_1+\theta_2$$

Link 3: $$\theta_1+\theta_2+\theta_3$$

This cumulative relationship is essential for calculating the Cartesian position of each joint.

2. Converting Degrees into Radians

MATLAB's trigonometric functions use radians. Therefore, the joint angles are converted before performing the calculations.

[
\theta_{\text{rad}} = \theta_{\text{deg}}\times\frac{\pi}{180}
]

3. Calculating the Position of Joint 1

The first link starts at the robot base, which is considered the origin of the coordinate system:

[
P_0=(0,0)
]

Using basic trigonometry, the position of the first joint is:

[
x_1=L_1\cos(\theta_1)
]

[
y_1=L_1\sin(\theta_1)
]

These equations resolve the first link into its horizontal and vertical components.

4. Calculating the Position of Joint 2

The second link starts at the endpoint of the first link. Its orientation is the sum of the first and second joint angles.

[
x_2=x_1+L_2\cos(\theta_1+\theta_2)
]

[
y_2=y_1+L_2\sin(\theta_1+\theta_2)
]

The position of Joint 1 is added to the second link's Cartesian components to obtain the position of Joint 2.

5. Calculating the End-Effector Position

The third link starts at the endpoint of the second link. Its absolute orientation is:

[
\theta_1+\theta_2+\theta_3
]

Therefore, the end-effector coordinates are:

[
x_3=x_2+L_3\cos(\theta_1+\theta_2+\theta_3)
]

[
y_3=y_2+L_3\sin(\theta_1+\theta_2+\theta_3)
]

The resulting point (P_3=(x_3,y_3)) represents the position of the robot's end effector.

6. Complete Forward Kinematics Equations

By combining the individual link equations, the complete end-effector position can be expressed directly in terms of the three joint angles:

End-effector X-coordinate

[
\boxed{
x=L_1\cos\theta_1+
L_2\cos(\theta_1+\theta_2)+
L_3\cos(\theta_1+\theta_2+\theta_3)
}
]

End-effector Y-coordinate

[
\boxed{
y=L_1\sin\theta_1+
L_2\sin(\theta_1+\theta_2)+
L_3\sin(\theta_1+\theta_2+\theta_3)
}
]

End-effector orientation

[
\boxed{\phi=\theta_1+\theta_2+\theta_3}
]

These equations form the mathematical model used to calculate the robot's end-effector pose.

MATLAB Implementation

The mathematical equations were implemented in MATLAB using sine and cosine functions.

The Cartesian coordinates of each joint were calculated sequentially, starting from the base and moving towards the end effector. The calculated coordinates were then used to construct the complete robot configuration.

Visualization and Animation

The robot arm was visualized in a 2D Cartesian coordinate system using MATLAB plotting functions.

An animation was also implemented using a for loop. The joint angles were gradually updated, and the corresponding joint positions were recalculated at each iteration.

The existing robot plot was updated continuously to demonstrate how changes in joint angles affect the robot's configuration and end-effector position.

Forward Kinematics Results

Robot Configuration



Robot Animation



2. Inverse Kinematics (IK)

Objective

Inverse Kinematics determines the joint angles required to achieve a specified end-effector position and orientation.

Unlike Forward Kinematics, where the joint angles are known and the end-effector pose is calculated, Inverse Kinematics starts with the desired end-effector pose and works backwards to determine the required joint angles.

For this implementation, MATLAB's Symbolic Math Toolbox was used to formulate and solve the inverse kinematics equations.

Robot Configuration and Target Pose

The same three-link planar robot was used:

Link 1: (L_1 = 2.0,m)

Link 2: (L_2 = 1.5,m)

Link 3: (L_3 = 1.0,m)

The desired end-effector configuration was defined as:

Desired X-coordinate: (x_{\text{des}}=2.0,m)

Desired Y-coordinate: (y_{\text{des}}=1.5,m)

Desired orientation: (\phi_{\text{des}}=45^\circ)

The objective is to find the three joint angles that satisfy this desired configuration.

Mathematical Derivation

1. Defining the Desired End-Effector Configuration

The desired end-effector pose consists of its position and orientation relative to the global coordinate frame.

To represent this configuration, a homogeneous transformation matrix was constructed:

[
T_{\text{des}}=
\begin{bmatrix}
\cos\phi_{\text{des}} & -\sin\phi_{\text{des}} & x_{\text{des}}\
\sin\phi_{\text{des}} & \cos\phi_{\text{des}} & y_{\text{des}}\
0 & 0 & 1
\end{bmatrix}
]

This matrix combines the rotation and translation of the desired end-effector pose into a single representation.

2. Defining the Unknown Joint Angles

Since the joint angles were unknown, three symbolic variables were introduced:

[
\theta_1,\quad\theta_2,\quad\theta_3
]

These variables represent the unknown rotations of the three revolute joints.

Symbolic variables allow MATLAB to work with the mathematical expressions without requiring numerical joint-angle values in advance.

3. Constructing the Individual Transformation Matrices

Each robot link was represented using a homogeneous transformation matrix.

For the transformation from the base to Link 1:

[
T_{01}=
\begin{bmatrix}
\cos\theta_1 & -\sin\theta_1 & L_1\cos\theta_1\
\sin\theta_1 & \cos\theta_1 & L_1\sin\theta_1\
0 & 0 & 1
\end{bmatrix}
]

For the transformation from Link 1 to Link 2:

[
T_{12}=
\begin{bmatrix}
\cos\theta_2 & -\sin\theta_2 & L_2\cos\theta_2\
\sin\theta_2 & \cos\theta_2 & L_2\sin\theta_2\
0 & 0 & 1
\end{bmatrix}
]

For the transformation from Link 2 to Link 3:

[
T_{23}=
\begin{bmatrix}
\cos\theta_3 & -\sin\theta_3 & L_3\cos\theta_3\
\sin\theta_3 & \cos\theta_3 & L_3\sin\theta_3\
0 & 0 & 1
\end{bmatrix}
]

Each matrix represents the rotation and translation contributed by an individual link relative to its preceding coordinate frame.

4. Deriving the Complete Transformation Matrix

To obtain the transformation from the robot base to the end effector, the three individual transformation matrices were multiplied:

[
\boxed{T_{03}=T_{01}T_{12}T_{23}}
]

After symbolic multiplication and simplification, the complete transformation matrix becomes:

[
T_{03}=
\begin{bmatrix}
\cos(\theta_1+\theta_2+\theta_3) &
-\sin(\theta_1+\theta_2+\theta_3) &
x\
\sin(\theta_1+\theta_2+\theta_3) &
\cos(\theta_1+\theta_2+\theta_3) &
y\
0 & 0 & 1
\end{bmatrix}
]

Here, (x) and (y) represent the end-effector position obtained from the Forward Kinematics equations.

This transformation matrix describes the complete end-effector pose as a function of the three unknown joint angles.

5. Formulating the Inverse Kinematics Equations

The goal is to make the calculated transformation equal to the desired transformation:

[
\boxed{T_{03}=T_{\text{des}}}
]

By comparing the corresponding matrix elements, three equations are obtained.

X-position constraint

[
L_1\cos\theta_1+
L_2\cos(\theta_1+\theta_2)+
L_3\cos(\theta_1+\theta_2+\theta_3)
=x_{\text{des}}
]

Y-position constraint

[
L_1\sin\theta_1+
L_2\sin(\theta_1+\theta_2)+
L_3\sin(\theta_1+\theta_2+\theta_3)
=y_{\text{des}}
]

Orientation constraint

[
\boxed{\theta_1+\theta_2+\theta_3=45^\circ}
]

These three constraints must be satisfied simultaneously to reach the desired end-effector pose.

6. Reducing the Number of Unknowns

The desired orientation is already known. Therefore, the orientation equation can be rearranged to express the third joint angle in terms of the first two:

[
\theta_1+\theta_2+\theta_3=45^\circ
]

Rearranging:

[
\boxed{\theta_3=45^\circ-\theta_1-\theta_2}
]

This expression was substituted into the X-position and Y-position equations.

Since the total orientation is fixed at (45^\circ), the third-link contribution becomes constant:

[
L_3\cos(45^\circ)
]

for the X-coordinate, and:

[
L_3\sin(45^\circ)
]

for the Y-coordinate.

Substituting the robot dimensions and target coordinates gives the following reduced equations.

Reduced X-position equation

[
\boxed{
2=2\cos\theta_1+
1.5\cos(\theta_1+\theta_2)+
\cos45^\circ
}
]

Reduced Y-position equation

[
\boxed{
1.5=2\sin\theta_1+
1.5\sin(\theta_1+\theta_2)+
\sin45^\circ
}
]

The original problem with three unknown joint angles has now been reduced to two nonlinear equations with two unknowns: (\theta_1) and (\theta_2).

7. Solving for the Joint Angles

The two reduced equations were solved simultaneously using MATLAB's symbolic solve() function.

The solver determines the possible values of:

[
\theta_1,\quad\theta_2
]

Once these values are obtained, the third joint angle is calculated using the orientation constraint:

[
\boxed{\theta_3=45^\circ-\theta_1-\theta_2}
]

The symbolic results were converted into numerical values using double(), and the joint angles were converted from radians into degrees for easier interpretation.

Depending on the target pose, more than one valid joint configuration may exist. These different solutions represent alternative ways for the robot to reach the same end-effector pose.

8. Calculating the Joint Positions

After obtaining the joint angles, the Forward Kinematics position equations were used again to calculate the Cartesian coordinates of each joint.

The calculated angles determine the orientation of each link, allowing the complete robot configuration to be reconstructed.

The resulting robot configuration was plotted in MATLAB, with the desired end-effector position marked in the coordinate system.

9. Visualizing and Animating the IK Solution

To demonstrate the inverse kinematics result, an animation was created to show the transition from the initial robot configuration to the calculated IK configuration.

Initially, all three joint angles are set to zero, meaning that the links are aligned along the positive X-axis.

The joint angles are then gradually interpolated between their initial and final values. At each animation step, the Cartesian coordinates of all joints are recalculated and the robot drawing is updated.

This provides a visual representation of how the robot changes its configuration to reach the specified end-effector position and orientation.

Inverse Kinematics Results

Final Robot Configuration



Inverse Kinematics Animation
