function [ flag ] = safetyMonitor( in1, in2 )

% in1, in2: Data Structure that stores information about the aircraft
%       (x, y): Current Location of the aircraft
%       (xd, yd): Destination of aircraft
%       theta: Current direction of motion
%       m: Message from neighbouring aircraft
%           - empty if aircraft not in neighbourhood
%           - (x, y, xd, yd, theta) of other aircraft if non-empty
%
% flag: true if the safety is violated and false otherwise.
global possible_to_collide;
flag_count = 0;

flag = false;

if (in1.x == in2.x && in1.y == in2.y)
    flag = true;
    flag_count = flag_count +1;
elseif (((in1.x == in1.xd && in1.y == in1.yd) || (in2.x == in2.xd && in2.y == in2.yd)) && possible_to_collide == 1)
    flag = true;
    flag_count = flag_count +1;
elseif (in1.xd == in2.xd && in1.yd == in2.yd)
    flag = true;
    flag_count = flag_count +1;
else
    flag = false;
end
end

