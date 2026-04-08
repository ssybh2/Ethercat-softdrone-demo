# Ethercat-softdrone-demo 🛸

这是一个基于N355电脑集成了 **EtherCAT 实时驱动** 与 **MATLAB Simulink 姿态控制** 的全栈无人机控制系统。

---

## 📂 项目结构 (Project Structure)

* **`src/`**: 基于 SOEM 的 EtherCAT 主站驱动程序 (ROS 2 C++)。
    * `soem_wrapper`: 处理 PDO/SDO 通信的核心逻辑。
    * `custom_msgs`: 自定义 ROS 2 消息（SBUS、IMU 等）。
* **`simulink/`**: 姿态控制与仿真逻辑。
    * `softdrone_pid.slx`: 主控制模型。
    * `Init_control450.m`: 环境参数与总线定义初始化脚本。
    * `+bus_conv_fcns`: Simulink 自动生成的总线转换包。

---

## 🛠️ 测试环境 (Prerequisites)

* **系统**: Ubuntu 22.04 (Humble)
* **工具**: MATLAB R2025b (需安装 ROS Toolbox)
* **硬件**: 电脑需直连 EtherCAT 从站（如 H750 模块），且具备网卡 Root 权限。

---

## 🚀 快速上手 (Quick Start)

### 1. 配置Ethercat的具体教程：请参考 [EcatV2_Master 原始仓库](https://github.com/AIMEtherCAT/EcatV2_Master.git)

### 2. 配置终端环境变量

为了确保 Linux 驱动端与 MATLAB 控制模型能够“对上频道”，必须统一两端的 ROS 2 环境变量。

####  Linux 终端配置
在运行驱动程序的终端窗口中执行以下命令：
1. 配置Linux终端环境
```bash
export ROS_DOMAIN_ID=24
export RMW_IMPLEMENTATION=rmw_fastrtps_cpp
```

2. 验证设置是否生效
 ```bash
echo $ROS_DOMAIN_ID        预期返回: 24
echo $RMW_IMPLEMENTATION   预期返回：rmw_fastrtps_cpp
```
#### Matlab command window 配置 
（使用sudo su root 权限启动 matlab）
1. 设置与 Linux 端一致的环境变量
```bash   
setenv('ROS_DOMAIN_ID', '24');
setenv('RMW_IMPLEMENTATION', 'rmw_fastrtps_cpp');
```
```bash
2. 验证设置是否生效
getenv('ROS_DOMAIN_ID')       预期返回: '24'
getenv('RMW_IMPLEMENTATION')  预期返回: 'rmw_fastrtps_cpp'
```
3.编译自定义消息包
在matlab command window里面执行：

```bash
ros2genmsg('/home/hby/donglei_ws/src/EcatV2_Master/src')
```
具体路径视个人情况而定：


路径一定要指向包含 custom_msgs 文件夹的那个 src 目录（或者是包含所有自定义消息包的父目录）。MATLAB 会扫描该目录下所有的 ROS 2 消息定义。

4.tips

(1) 个体差异
1. 本Demo使用SBUS遥控协议，需要在ecat板子上面外接IMU。
2. Simulink遥控器通道映射以及IMU坐标系需要按照个人习惯或装机坐标系定义实现自定义。

(2) Simulink subscribe 模块 Qos 设置
1. 切换到 **QoS** 标签页。
2. **Reliability**：必须从 **Reliable** 改为 **Best effort**。
3. **History**：设为 **Keep last**。
4. **Depth**：设为 **1**。


## ⚠️ 常见报错处理 (Troubleshooting)

### 报错：`[soem_backend-1] sequence size exceeds remaining buffer`

如果在运行驱动或仿真时看到此报错，通常是由于 ROS 2 消息中的变长数组（Sequence）未正确初始化或 QoS 策略冲突导致的。请按照以下步骤修复：

---

#### 1. 修改 C++ 驱动代码 (显式初始化数组长度)
在 ROS 2 中，如果消息定义包含变长数组（如 `int32[] channels`），在发布前必须明确指定其长度，否则序列化时会溢出。

- **修改文件**：`src/soem_wrapper/src/soem_backend.cpp`
- **代码调整**：在给数组赋值前添加 `.resize()`。

```cpp
// 以 ReadSBUSRC 消息为例
auto msg = custom_msgs::msg::ReadSBUSRC();

// 【关键步骤】：必须显式设置数组长度（如 SBUS 为 16 通道）
msg.channels.resize(16); 

// 随后再进行赋值循环
for(int i = 0; i < 16; i++) {
    msg.channels[i] = raw_sbus_data[i];
}

// 发布消息
publisher_->publish(msg);
