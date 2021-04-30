module  StartBack
    using HorizonSideRobots
    export move_to_start!, move_to_back!
    NUM_STEPS=Int[]
    BACK_SIDE=(Nord,Ost)

    function move_to_start!(robot,start_side::Tuple)
        global NUM_STEPS, BACK_SIDE
        BACK_SIDE = invers(start_side)
        NUM_STEPS = [get_num_steps_movements!(robot,start_side[i]) for i in 1:2]
    end
    
    move_to_back!(robot) = for (i,num) in arange(NUM_STEPS) movements!(robot,BACK_SIDE[i],num) end
end

#инверсия направления
invers(side::HorizonSide) = HorizonSide(mod(Int(side) + 2,4))


invers(side::NTuple{2,HorizonSide}) = (invers(side[1]),invers(side[2]))

#возвращение на num_steps шагов
function movements!(r::Robot,side::HorizonSide,num_steps::Int)
    for _ in 1:num_steps
        move!(r,side)
    end
end


#запоминаем кол-во шагов в направлении side
function get_num_steps_movements!(r::Robot, side::HorizonSide)
    num_steps = 0
    while isborder(r, side) == false
        putmarker!(r)
        move!(r,side)
        num_steps += 1
    end
    if (isborder(r,side) == true)
        putmarker!(r)
    end
    return num_steps
end
#идем в направлении side до стенки
function movements!(r::Robot,side::HorizonSide)
    while isborder(r,side) == false
        move!(r,side)
    end
end

#идем в направлении side до стенки и запоминаем шаги
function moves!(r::Robot,side::HorizonSide)
    num_steps=0
    while isborder(r,side)==false
        move!(r,side)
        num_steps+=1
    end
    return num_steps
end

#дойти до стороны, двигаясь змейкой вверх-вниз и вернуть последнее перед остановкой направление
function find_border!(r::Robot, direction_to_border::HorizonSide, direction_of_movement::HorizonSide)::HorizonSide
    while isborder(r,direction_to_border)==false  
        if isborder(r,direction_of_movement)==false
            move!(r,direction_of_movement)
        else
            move!(r,direction_to_border)
            direction_of_movement=inverse(direction_of_movement)
        end
    end
    return direction_to_border
end

function movements!(r,sides,num_steps::Vector{Int})
    for (i,n) in enumerate(num_steps)
        movements!(r, sides[mod(i-1, length(sides))+1], n)
    end
end


#возвращает направление, следующее, если отсчитывать против часовой стредки, по отношению к заданному
left(side::HorizonSide) =  HorizonSide(mod(Int(side)+1, 4))


#Bозвращает направление, предыдущее, если отсчитывать против часовой стредки, по отношению к заданному
right(side::HorizonSide) = HorizonSide(mod(Int(side)-1, 4))