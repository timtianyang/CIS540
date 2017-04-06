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
% if (isempty(state))
%     state.mode = 0;
% end
yield = 0;
possible_to_collide = 0;
my_prio = 1;
if ( length(in.m) ~= 0 )
    if ( abs(in.x - in.m.x) <= 2 && abs(in.y - in.m.y) <= 2 )
        possible_to_collide = 1;
        switch in.m.theta
            case 0
                other_plane(1).x = in.m.x + 1;
                other_plane(1).y = in.m.y;
                other_plane(2).y = in.m.y + 1;
                other_plane(2).x = in.m.x;
                other_plane(3).y = in.m.y - 1;
                other_plane(3).x = in.m.x;
            case 90
                other_plane(1).x = in.m.x + 1;
                other_plane(1).y = in.m.y;
                other_plane(2).y = in.m.y + 1;
                other_plane(2).x = in.m.x;
                other_plane(3).x = in.m.x - 1;
                other_plane(3).y = in.m.y;
                
            case 180
                other_plane(1).y = in.m.y - 1;
                other_plane(1).x = in.m.x;
                other_plane(2).y = in.m.y + 1;
                other_plane(2).x = in.m.x;
                other_plane(3).x = in.m.x - 1;
                other_plane(3).y = in.m.y;
                
            case 270
                other_plane(1).x = in.m.x + 1;
                other_plane(1).y = in.m.y;
                other_plane(2).y = in.m.y - 1;
                other_plane(2).x = in.m.x;
                other_plane(3).x = in.m.x - 1;
                other_plane(3).y = in.m.y;
        end
        
        if ( in.xd > in.m.xd )
            my_prio = 1;
        elseif ( in.xd < in.m.xd )
            my_prio = 0;
        elseif ( in.yd > in.m.yd )
            my_prio = 1;
        else
            my_prio = 0;
        end
        
    end
end


out.val = cal_direction(in);

if ( my_prio == 0 && possible_to_collide == 1 )
    my_next = next_point(in, out.val);
    
    for i = 1:3
        if (my_next.x == other_plane(i).x && my_next.y == other_plane(i).y)
            yield = 1;
        end
    end
    
end

if ( yield == 1 )
    test = [0 -1 1];
    for i = 1:3
        
        my_next = next_point(in, out.val);
        for j = 1:3
            if (my_next.x == other_plane(j).x && my_next.y == other_plane(j).y)
                out.val = test(i);
                return;
            end
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
