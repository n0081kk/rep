include("roblib.jl")
STEP = 0
function mark_frame_perimetr!(r::Robot)
    num_steps=[]
    while isborder(r,Sud)==false || isborder(r,West) == false
        push!(num_steps, moves!(r, West))
        push!(num_steps, moves!(r, Sud))
    end
    
    for side in (Nord,Ost,Sud,West)
        putmarkers!(r, side) 
    end 
    
    for (i,n) in enumerate(num_steps)
        side = isodd(i) ? Ost : Nord
        movements!(r,side,n)
    end
end
    
    function moves!(r::Robot,side::HorizonSide)
        num_steps=0
        while isborder(r,side)==false
            move!(r,side)
            num_steps+=1
        end
        return num_steps
    end
    
    function moves!(r::Robot,side::HorizonSide,num_steps::Int)
        for _ in 1:num_steps
            move!(r,side)
        end
    end
    
    function putmarkers!(r::Robot, side::HorizonSide)
        putmarker!(r)
        while isborder(r,side)==false
            move!(r,side)
            putmarker!(r)
        end
    end