function [ out, state ] = controller( in, state )
% Takes flight parameters of an aircraft and outputs the direction control

% in: Data Structure that stores input information for the aircraft
% controller.
%       (in.x, in.y): Current Location of the aircraft
%       (in.xd, in.yd): Destination of aircraft
%       in.theta: Current direction of motion
%       in.m: Message from neighbouring aircraft
%           - empty if aircraft not in neighbourhood
%           - (x, y, xd, yd, theta) of other aircraft if non-empty
%           - To access data (say x) from in.m, use in.m.x
%
% out : Data Structure that stores the output information from the aircraft
%       out.val: +1, 0, -1 ( +1 - turn left, 0 - go straight, -1 - turn right)
%
% state:
%       any state used by the controller


% Initialize state
if (isempty(state))
    state.mode = 0;
end

if ( in.x ~= in.xd)
    
    if ( in.x > in.xd )
        switch in.theta
            case 90
                out.val = 1;
            case 180
                out.val = 0;
            case 270
                out.val = -1;
            case 0 %non-det
                if(rand(1)-0.5 > 0)
                    out.val = 1;
                else
                    out.val = -1;
                end
        end
    else ( in.x < in.xd )
        switch in.theta
            case 90
                out.val = -1;
            case 180 %non-det
                if(rand(1)-0.5 > 0)
                    out.val = 1;
                else
                    out.val = -1;
                end
            case 270
                out.val = 1;
            case 0
                out.val = 0;
        end
        
        
    end
    
else
    if ( in.y > in.yd )
        switch in.theta
            case 90 %non-det
                if(rand(1)-0.5 > 0)
                    out.val = 1;
                else
                    out.val = -1;
                end
            case 180
                out.val = 1;
            case 270
                out.val = 0;
            case 0
                out.val = -1;
        end
    else ( in.y < in.yd )
        switch in.theta
            case 90
                out.val = 0;
            case 180
                out.val = -1;
            case 270 %non-det
                if(rand(1)-0.5 > 0)
                    out.val = 1;
                else
                    out.val = -1;
                end
            case 0
                out.val = 1;
        end
        
        
    end
    
    
end
% Code to generate controller output
%if (state.mode == 0)
%    out.val = +1;
%    state.mode = 1;
%elseif (state.mode == 1)
%    out.val = 0;
%    state.mode = 0;
%end