function slBusOut = ReadSBUSRC(msgIn, slBusOut, varargin)
%#codegen
%   Copyright 2021-2022 The MathWorks, Inc.
    currentlength = length(slBusOut.header);
    for iter=1:currentlength
        slBusOut.header(iter) = bus_conv_fcns.ros2.msgToBus.std_msgs.Header(msgIn.header(iter),slBusOut(1).header(iter),varargin{:});
    end
    slBusOut.header = bus_conv_fcns.ros2.msgToBus.std_msgs.Header(msgIn.header,slBusOut(1).header,varargin{:});
    slBusOut.online = uint8(msgIn.online);
    maxlength = length(slBusOut.channels);
    recvdlength = length(msgIn.channels);
    currentlength = min(maxlength, recvdlength);
    if (max(recvdlength) > maxlength) && ...
            isequal(varargin{1}{1},ros.slros.internal.bus.VarLenArrayTruncationAction.EmitWarning)
        diag = MSLDiagnostic([], ...
                             message('ros:slros:busconvert:TruncatedArray', ...
                                     'channels', msgIn.MessageType, maxlength, max(recvdlength), maxlength, varargin{2}));
        reportAsWarning(diag);
    end
    slBusOut.channels_SL_Info.ReceivedLength = uint32(recvdlength);
    slBusOut.channels_SL_Info.CurrentLength = uint32(currentlength);
    slBusOut.channels = uint16(msgIn.channels(1:slBusOut.channels_SL_Info.CurrentLength));
    if recvdlength < maxlength
    slBusOut.channels(recvdlength+1:maxlength) = 0;
    end
    slBusOut.ch17 = uint8(msgIn.ch17);
    slBusOut.ch18 = uint8(msgIn.ch18);
    slBusOut.fail_safe = uint8(msgIn.fail_safe);
    slBusOut.frame_lost = uint8(msgIn.frame_lost);
end
