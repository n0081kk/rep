include("roblib.jl")
function mark_cross!(r::Robot)
    for side in(Nord,West,Sud,Ost)
        putmarkers!(r,side)
        side_inv=invers(side)
        move_by_marker!(r,side_inv)
    end
putmarker!(r)
end

function putmarkers!(r::Robot,side::HorizonSide)
    while isborder(r,side)==false
        move!(r,side)
        putmarker!(r)
    end
end

function move_by_marker!(r::Robot,side::HorizonSide)
    while ismarker(r)==true
        move!(r,side)
    end
end