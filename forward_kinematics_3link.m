clc;
clear;
close all;

%%1. Robot Link Lengths (meters)

L1 = 2;
L2 = 1.5;
L3 = 1;

%%2. Joint Anles (degrees)
theta1 = 30;
theta2 = 40;
theta3 = -20;

%%3. Degree to Radian(calculation)
Radian_Angle1  = deg2rad(theta1);
Radian_Angle2  = deg2rad(theta2);
Radian_Angle3  = deg2rad(theta3);

%%4. Calcualte the position of Joint 1 

% Calculate the X-coordinate of Joint 1 using cosine

x1 = L1*cos(Radian_Angle1);

% Calcualte the Y-coordinate of Joint 1 using sine

y1 = L1*sin(Radian_Angle1);

% Display the calculated position in the command window
fprintf('X1= %.3f m\n',x1);
fprintf('Y1= %.3f m\n',y1);

%%5. Calcualte the position of the Joint 2

% Calcualte the X-Coordinate of Joint 2 using cosine

x2= x1+L2*cos(Radian_Angle1+Radian_Angle2);

% Calcualte the Y-Coordinate of Joint 2 using cosine

y2 = y1+L2*sin(Radian_Angle1+Radian_Angle2);
% Display the calculated position in the command window
fprintf('X2=%.3f m\n',x2);
fprintf('Y1= %.3f m\n',y2);

%%6. Calculate the position of the Joint 3

% Calculate the X-coordinate of Joint 3 using cosine

x3 = x2+L3* cos(Radian_Angle1+Radian_Angle2+Radian_Angle3);

% Calcualte the Y-Coordinate of Joint 3 using cosine
y3 = y2+L3*sin(Radian_Angle1+Radian_Angle2+Radian_Angle3);

fprintf('X3=%.3f m\n',x3);
fprintf('Y3=%.3f m\n',y3);

%%7. Visulaize the Robot Arm
figure;
plot([0 x1 x2 x3],[0 y1 y2 y3],'-o','MarkerFaceColor', 'r')


title('Three-Link Robot Arm');
xlabel('X Position (m)');
ylabel('Y Positiom (m)');
grid on;
axis equal;