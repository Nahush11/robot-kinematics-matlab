clc;
clear;
close all;

%%1. Robot Link Length(in meters(m))
L1 = 2;
L2 = 1.5;
L3 = 1.0;

%% 2. Desired End Effector Configuration

x_des = 2;
y_des =1.5;
phi_des = 45; %Desired end-effector orientation angle measured from the global X-axis (degrees)
phi_des_rad = deg2rad(45);

T_des = [cosd(phi_des), -sind(phi_des), x_des;
         sind(phi_des), cosd(phi_des), y_des;
         0,              0,      1];
    

disp('Desired Configuration Matrix:');
disp(T_des);

%%3. Forward Kinematics Transformation Matrices

syms theta1 theta2 theta3 

% Transformation Matrix from base to Link1

T01 = [cos(theta1), -sin(theta1), L1*cos(theta1);
    sin(theta1),  cos(theta1), L1*sin(theta1);
         0,             0,           1];
    
% Transformation Matrix from Link1 to Link2

T12 = [cos(theta2), -sin(theta2), L2*cos(theta2);
       sin(theta2), cos(theta2), L2*sin(theta2);
       0,             0,           1];
% Transformation Matrix from Link2 to Link3

T23 = [cos(theta3), -sin(theta3), L3*cos(theta3);
        sin(theta3), cos(theta3), L3*sin(theta3);
        0,           0,          1];

%% Complete Forward Kinematics Model

T03 = simplify(T01 * T12 * T23);

disp('Forward Kinematics Matrix:');
disp(T03);

%% Inverse Kinematics Equations
eq_matrix = T03 == T_des;

eq1 = T03(1,3) == T_des(1,3);
eq2 = T03(2,3) == T_des(2,3);
eq3 = theta1+theta2+theta3 == phi_des_rad;

disp(eq1)
disp(eq2)
disp(eq3)


eq1_sub = subs(eq1, theta3, pi/4 - theta1 - theta2);
disp('X equation after substitution:');
disp(simplify(eq1_sub));

eq2_sub = subs(eq2, theta3, pi/4 - theta1 - theta2);
disp('Y equation after substitution:');
disp(simplify(eq2_sub));

%% Solve for theta1 and theta2

sol = solve([eq1_sub, eq2_sub], [theta1, theta2]);

disp('Theta 1 solutions in radians:');
disp(double(sol.theta1));

disp('Theta 2 solutions in radians:');
disp(double(sol.theta2));

%% Calcualte all three joint angles

theta1_num = double(sol.theta1);

theta2_num = double(sol.theta2);

theta3_num = pi/4 - theta1_num -theta2_num;

% Convert radians to degrees
theta1_deg = rad2deg(theta1_num);
theta2_deg = rad2deg(theta2_num);
theta3_deg = rad2deg(theta3_num);


%%7. Visulaize the Robot Arm
figure;
grid on;
hold on;
axis equal;

xlim([-5,5]);
ylim([-5, 5]);

xlabel('X Position (m)');
ylabel('Y Position (m)');
title('3-Link Robot Arm');

% Initial joint positions
x0 = 0;
x1 = L1;
x2 = L1 + L2;
x3 = L1 + L2 + L3;

y0 = 0;
y1 = 0;
y2 = 0;
y3 = 0;

% Draw the robot
plot([x0 x1 x2 x3], [y0 y1 y2 y3], '-o', ...
     'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'r','LineWidth', 5);

%%8. Calculate joint positions using IK angles

% Select first IK solution
t1 = theta1_num(1);
t2 = theta2_num(1);
t3 = theta3_num(1);

% Base Position

x0 = 0;
y0 = 0;

%End of Link1 

x1 = L1*cos(t1);
y1 = L1*sin(t1);

%End of Link2

x2 = x1+L2*cos(t1+t2);
y2 = y1+L2*sin(t1+t2);

%End of Link3 

x3 = x2+L3*cos(t1+t2+t3);
y3 = y2+L3*sin(t1+t2+t3);

plot([x0 x1 x2 x3], [y0 y1 y2 y3], '-o', ...
     'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'r','LineWidth', 5);
% Mark desired position
plot(x_des, y_des, 'rx', 'MarkerSize', 12, 'LineWidth', 3);

%% 7. Animate the 3-Link Robot Arm

% Select the first IK solution
t1 = theta1_num(1);
t2 = theta2_num(1);
t3 = theta3_num(1);

% Create figure
figure;
hold on;
grid on;
axis equal;

xlim([-5 5]);
ylim([-5 5]);

xlabel('X Position (m)');
ylabel('Y Position (m)');
title('3-Link Robot - Inverse Kinematics Animation');

% Mark the desired end-effector position
plot(x_des, y_des, 'rx', 'MarkerSize', 12, 'LineWidth', 3);

% Draw initial robot position (all angles = 0)
robot = plot([0 L1 L1+L2 L1+L2+L3], ...
             [0 0 0 0], '-o', ...
             'Color', [0.1 0.3 0.7], ...
             'MarkerFaceColor','r', ...
             'MarkerEdgeColor', 'k', ...
             'LineWidth', 3, ...
             'MarkerSize', 8);
% Animation loop
for k = 0:100

    % Animation progress (0 to 1)
    s = k/100;

    % Gradually change the joint angles
    q1 = s*t1;
    q2 = s*t2;
    q3 = s*t3;

    % Calculate joint positions
    x0 = 0;
    y0 = 0;

    x1 = L1*cos(q1);
    y1 = L1*sin(q1);

    x2 = x1 + L2*cos(q1+q2);
    y2 = y1 + L2*sin(q1+q2);

    x3 = x2 + L3*cos(q1+q2+q3);
    y3 = y2 + L3*sin(q1+q2+q3);

    % Update robot position
    set(robot, 'XData', [x0 x1 x2 x3], ...
               'YData', [y0 y1 y2 y3]);

    % Refresh animation
    drawnow;
    pause(0.02);

end