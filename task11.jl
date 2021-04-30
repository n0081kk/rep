include("roblib.jl")
NUM_HOR = 0 
    NUM_VERT = 0

function mark_angles(r)
    num_steps=[]
    while isborder(r,Sud)==false || isborder(r,West)==false
        push!(num_steps, moves!(r, West))
        push!(num_steps, moves!(r, Sud))
    end

    for side in (Nord,Ost,Sud,West)
        (side == Nord || side == Sud) ? moves!(r,NUM_VERT,side) : moves!(r,NUM_HOR,side)
    end

    for (i,n) in enumerate(num_steps)
        side = isodd(i) ? Nord : Ost
        movements!(r,side,n)
    end
end

function moves!(r::Robot,side::HorizonSide)
    global NUM_HOR
    global NUM_VERT
    steps = 0
    while isborder(r,side)==false
        if (side == West)
            NUM_HOR+=1
        else
            NUM_VERT+=1
        end
        move!(r,side)
        steps+=1
    end
    return steps
end

function moves!(r::Robot, pos::Int, side::HorizonSide)
    while (pos != 0)
        move!(r, side)
        pos -=1
    end
    putmarker!(r)
    while isborder(r, side) == false
        move!(r, side)
        pos +=1
    end
    return pos
end

function movements!(r::Robot,side::HorizonSide,num_steps::Int)
    for _ in 1:num_steps
        move!(r,side)
    end
end