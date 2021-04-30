using HorizonSideRobots
function mark_innerrectangle_perimetr!(r::Robot)
    num_steps=fill(0,3)
    for (i,side) in enumerate((Nord,Ost,Nord))
        num_steps[i]=moves!(r,side)
    end
    
    side = find_border!(r,Ost,side)
    mark_innerrectangle_perimetr!(r,side)
    moves!(r,Sud)
    moves!(r,West)
    for (i,side) in enumerate((Sud,West,Sud))
        moves!(r,side, num_steps[i])
    end
    
end

function mark_innerrectangle_perimetr!(r::Robot, side::HorizonSide)
    direction_of_movement, direction_to_border = get_directions(side)
    for i ∈ 1:4   
        putmarkers!(r, direction_of_movement[i], direction_to_border[i]) 
    end
end

get_directions(side::HorizonSide) = 
    if side == Nord  
          
        return (Nord,Ost,Sud, West), (Ost,Sud,West,Nord)
    else 
        return (Sud,Ost,Nord,West), (Ost,Nord,West,Sud) 
    end