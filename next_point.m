function my_next = next_point( in,out )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

switch in.theta
    case 0
        if (out == 1)
            my_next.x = in.x;
            my_next.y = in.y + 1;
        elseif (out == 0)
            my_next.x = in.x + 1;
            my_next.y = in.y;
        else
            my_next.x = in.x;
            my_next.y = in.y - 1;
        end
    case 90
        if (out == 1)
            my_next.x = in.x - 1;
            my_next.y = in.y ;
        elseif (out == 0)
            my_next.x = in.x;
            my_next.y = in.y + 1;
        else
            my_next.x = in.x + 1;
            my_next.y = in.y;
        end
        
    case 180
        if (out == 1)
            my_next.x = in.x;
            my_next.y = in.y - 1;
        elseif (out == 0)
            my_next.x = in.x - 1;
            my_next.y = in.y;
        else
            my_next.x = in.x;
            my_next.y = in.y + 1;
        end
        
    case 270
        if (out == 1)
            my_next.x = in.x + 1;
            my_next.y = in.y;
        elseif (out == 0)
            my_next.x = in.x;
            my_next.y = in.y - 1;
        else
            my_next.x = in.x - 1;
            my_next.y = in.y;
        end
end
end

