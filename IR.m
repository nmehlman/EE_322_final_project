classdef IR
    %DESCRIPTION: Class to hold IR data
    
    properties
        distance;
        room_ID;
        trial;
        tau;
        energy_ratio;
        sample;
    end
    
    methods
        
        function obj = IR(d,r,tr,t,e,s)
            obj.distance = d;
            obj.room_ID = r;
            obj.trial = tr;
            obj.tau = t;
            obj.energy_ratio = e;
            obj.sample = s;
        end
        
        function print(obj)
            disp("ROOM: " + obj.room_ID + ", DIST: " + obj.distance + "ft, RATIO: " + obj.energy_ratio + " dB");
        end
        
    end
end

