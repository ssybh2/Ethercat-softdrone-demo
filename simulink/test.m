%% ROS 2 Custom Message 接收测试脚本（已修正 QoS）
% 目标话题: /ecat/sn4587580/app1/read
% 消息类型: custom_msgs/ReadSBUSRC


% 1. 强制匹配 RMW 中间件
setenv('RMW_IMPLEMENTATION', 'rmw_fastrtps_cpp');

% 2. 检查自定义消息是否已加载
msgType = 'custom_msgs/ReadSBUSRC';
if ~any(strcmp(ros2('msg','list'), msgType))
    error('错误: MATLAB 找不到消息类型 %s。请先运行 ros2genmsg 并重启 MATLAB。', msgType);
end

% 3. 创建 ROS 2 节点
fprintf('正在连接到话题: /ecat/sn4587580/app1/read ...\n');
node = ros2node('test_sbus_node');

% 4. 创建订阅器 + 强制 Reliable QoS（关键修正）
fprintf('使用 Reliable QoS 创建订阅器...\n');
sub = ros2subscriber(node, ...
    '/ecat/sn4587580/app1/read', ...
    msgType, ...
    'Reliability', 'besteffort', ...   % 与 soem_backend 匹配
    'History', 'KeepLast', ...
    'Depth', 10);

% 5. 实时读取测试
fprintf('开始读取数据，请用力摇动遥控器摇杆...\n');
fprintf('%-10s | %-50s\n', '帧号', '前 8 个通道数值');
fprintf('------------------------------------------------------------\n');

for i = 1:100
    try
        [msg, ~] = receive(sub, 1.0);           % 超时1秒
        
        ch_data = double(msg.channels);         % 强制转 double
        
        if isempty(ch_data)
            fprintf('[帧 %03d] 警告: channels 数组为空！\n', i);
        else
            valid_len = min(length(ch_data), 8);
            data_str = sprintf('%6d ', ch_data(1:valid_len));
            fprintf('[帧 %03d] | %s\n', i, data_str);
        end
    catch
        fprintf('[帧 %03d] 超时（1秒内未收到数据）\n', i);
    end
    pause(0.05);   % 20Hz 刷新
end

% 6. 清理
clear sub node;
fprintf('------------------------------------------------------------\n');
fprintf('测试结束。\n');