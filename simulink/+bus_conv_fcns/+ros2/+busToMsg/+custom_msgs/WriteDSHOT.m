function rosmsgOut = WriteDSHOT(slBusIn, rosmsgOut)
%#codegen
%   Copyright 2021 The MathWorks, Inc.
    rosmsgOut.channel1 = uint16(slBusIn.channel1);
    rosmsgOut.channel2 = uint16(slBusIn.channel2);
    rosmsgOut.channel3 = uint16(slBusIn.channel3);
    rosmsgOut.channel4 = uint16(slBusIn.channel4);
end
