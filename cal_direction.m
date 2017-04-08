function [ out ] = cal_direction( in )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
out = 0;
if ( in.x ~= in.xd)
    if ( in.x > in.xd )
        switch in.theta
            case 90
                out = 1;
            case 180
                out = 0;
            case 270
                out = -1;
            case 360
                a = rand(1)-0.5 ;
                if( a > 0)
                    out = 1;
                else
                    out = -1;
                end
            case 0 %non-det
                a = rand(1)-0.5 ;
                if( a > 0)
                    out = 1;
                else
                    out = -1;
                end
        end
    elseif ( in.x < in.xd )
        switch in.theta
            case 90
                out = -1;
            case 180 %non-det
                a = rand(1)-0.5 ;
                if( a > 0)
                    out = 1;
                else
                    out = -1;
                end
            case 270
                out = 1;
            case 0
                out = 0;
            case 360
                out = 0;
        end
        
        
    end
    
else
    if ( in.y > in.yd )
        switch in.theta
            case 90 %non-det
                a = rand(1)-0.5 ;
                if( a > 0)
                    out = 1;
                else
                    out = -1;
                end
            case 180
                out = 1;
            case 270
                out = 0;
            case 0
                out = -1;
        end
    elseif ( in.y < in.yd )
        switch in.theta
            case 90
                out = 0;
            case 180
                out = -1;
            case 270 %non-det
                a = rand(1)-0.5 ;
                if( a > 0)
                    out = 1;
                else
                    out = -1;
                end
            case 0
                out = 1;
        end
        
        
    end
    
    
end


end

