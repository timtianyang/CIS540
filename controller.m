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

%logic flow:
%Check for message
%    check for possible collision range
%        predict where the next plane could be at
%        calculate my priority based on destination
%run normal alg for the next step for myself
%if possible to collide
%    pick a new next step for myself if I have lower priority

yield = 0;

global possible_to_collide;
possible_to_collide = 0;
global invert_direction;
invert_direction = 0;

last_heading = in.theta;

my_prio = 1;
if ( length(in.m) ~= 0 )
    if ( abs(in.x - in.m.x) <= 2 && abs(in.y - in.m.y) <= 2 && ( in.x ~= in.xd || in.y ~= in.yd ) && ( in.m.x ~= in.m.xd  ||  in.m.y ~= in.m.yd ))
        %fprintf('(%d,%d) dir:%d (%d,%d) dir:%d\n',in.x,in.y,in.theta,in.m.x,in.m.y,in.m.theta)
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
    %intersect my next point with all possible moves of the other plane
    for i = 1:3
        if (my_next.x == other_plane(i).x && my_next.y == other_plane(i).y)
            yield = 1;
            %fprintf('my_next(%d,%d), the other plane could be at (%d,%d) for the next move, possible to collide so yield\n',my_next.x,my_next.y,other_plane(i).x,other_plane(i).y);
            %possible to collide so need to yield and turn to another point
            break;
        end
    end
    
end

if ( yield == 1 )
    test = [1 -1 0];%going straight is the last so it won't follow the other plane.
    for i = 1:3
        %find a new move so that it won't intersect with all possible moves
        %of the other plane
        my_next = next_point(in, test(i));
        
        if (my_next.x ~= other_plane(1).x || my_next.y ~= other_plane(1).y) ...\
                && (my_next.x ~= other_plane(2).x || my_next.y ~= other_plane(2).y) ...\
                && (my_next.x ~= other_plane(3).x || my_next.y ~= other_plane(3).y)
            out.val = test(i);
            
            if last_heading + out.val * 90 == last_heading + 180
                invert_direction = 1;
            end
            possible_to_collide = 0;
            %fprintf('turning to %d\n',out.val);
            return;
        end
        
    end
    
end
if last_heading + out.val * 90 == last_heading + 180
    invert_direction = 1;
end
possible_to_collide = 0;

