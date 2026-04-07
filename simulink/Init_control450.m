% %%%  AttitudeControl_HIL
% clear
% path('./icon/',path);

%Constant value
RAD2DEG = 57.2957795;
DEG2RAD = 0.0174533;
%throttle when UAV is hovering
THR_HOVER = 0.609;

%% control parameter
% attitude PID parameters
Kp_ANGLE = 1.0;
Kp_PITCH_ANGLE = 0.032;
K_PITCH_AngleRate = 1.0;
Kp_PITCH_AngleRate = 0.122;
Ki_PITCH_AngleRate = 0.002;
Kd_PITCH_AngleRate = 0.003;

Kp_ROLL_ANGLE = 0.032;
K_ROLL_AngleRate = 1.0;
Kp_ROLL_AngleRate = 0.122;
Ki_ROLL_AngleRate = 0.002;
Kd_ROLL_AngleRate = 0.003;

Kp_YAW_ANGLE = 0.02;
K_YAW_AngleRate = 0.08;
Kp_YAW_AngleRate = 1.0;
Ki_YAW_AngleRate = 0.0;
Kd_YAW_AngleRate = 0.01;
% integral saturation
Saturation_I_RP_Max = 0.3;
Saturation_I_RP_Min = -0.3;
Saturation_I_Y_Max = 0.2;
Saturation_I_Y_Min = -0.2;
% throttle limitation
MAX_MAN_THR = 0.9;
MIN_MAN_THR = 0.05;
% max control angle, default 35 deg
MAX_CONTROL_ANGLE_ROLL = 35;
MAX_CONTROL_ANGLE_PITCH  = 35;
% max control angle rate, rad/s 
MAX_CONTROL_ANGLE_RATE_PITCH = 350;
MAX_CONTROL_ANGLE_RATE_ROLL = 350;
MAX_CONTROL_ANGLE_RATE_YAW = 250;

% First order time constant
TIME_Constant = 0.1;
%% run simulink model
% f450_simulation