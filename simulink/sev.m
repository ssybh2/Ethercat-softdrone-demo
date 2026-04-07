%% ====================== MATLAB 启动自动设置 ROS2 环境 ======================
disp('=== 自动加载 ROS2 环境变量 ===');

% 1. 设置核心环境变量
setenv('ROS_DOMAIN_ID', '24');
setenv('ROS_LOCALHOST_ONLY', '0');
setenv('ROS_AUTOMATIC_DISCOVERY_RANGE', '');
setenv('RMW_IMPLEMENTATION', 'rmw_fastrtps_cpp');

disp(['ROS_DOMAIN_ID = ', getenv('ROS_DOMAIN_ID')]);
disp(['ROS_LOCALHOST_ONLY = ', getenv('ROS_LOCALHOST_ONLY')]);

% 2. 安全重启 ROS2 客户端（带保护）
try
    ros2('shutdown');
    pause(0.5);
catch
    % 如果还没初始化，就忽略错误
end

try
    ros2('init');
    disp('ROS2 客户端已成功初始化！');
catch ME
    disp(['ROS2 初始化失败（可忽略）: ', ME.message]);
end

disp('==========================================');
disp('ROS2 环境自动加载完成！');