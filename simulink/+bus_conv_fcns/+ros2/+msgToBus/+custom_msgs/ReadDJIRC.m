function slBusOut = ReadDJIRC(msgIn, slBusOut, varargin)
%#codegen
%   Copyright 2021-2022 The MathWorks, Inc.
    currentlength = length(slBusOut.header);
    for iter=1:currentlength
        slBusOut.header(iter) = bus_conv_fcns.ros2.msgToBus.std_msgs.Header(msgIn.header(iter),slBusOut(1).header(iter),varargin{:});
    end
    slBusOut.header = bus_conv_fcns.ros2.msgToBus.std_msgs.Header(msgIn.header,slBusOut(1).header,varargin{:});
    slBusOut.online = uint8(msgIn.online);
    slBusOut.left_x = single(msgIn.left_x);
    slBusOut.left_y = single(msgIn.left_y);
    slBusOut.right_x = single(msgIn.right_x);
    slBusOut.right_y = single(msgIn.right_y);
    slBusOut.dial = single(msgIn.dial);
    slBusOut.left_switch = uint8(msgIn.left_switch);
    slBusOut.right_switch = uint8(msgIn.right_switch);
    slBusOut.w = uint8(msgIn.w);
    slBusOut.s = uint8(msgIn.s);
    slBusOut.a = uint8(msgIn.a);
    slBusOut.d = uint8(msgIn.d);
    slBusOut.q = uint8(msgIn.q);
    slBusOut.e = uint8(msgIn.e);
    slBusOut.r = uint8(msgIn.r);
    slBusOut.f = uint8(msgIn.f);
    slBusOut.g = uint8(msgIn.g);
    slBusOut.z = uint8(msgIn.z);
    slBusOut.x = uint8(msgIn.x);
    slBusOut.c = uint8(msgIn.c);
    slBusOut.v = uint8(msgIn.v);
    slBusOut.b = uint8(msgIn.b);
    slBusOut.shift = uint8(msgIn.shift);
    slBusOut.ctrl = uint8(msgIn.ctrl);
    slBusOut.mouse_x = int16(msgIn.mouse_x);
    slBusOut.mouse_y = int16(msgIn.mouse_y);
    slBusOut.mouse_left_clicked = uint8(msgIn.mouse_left_clicked);
    slBusOut.mouse_right_clicked = uint8(msgIn.mouse_right_clicked);
end
