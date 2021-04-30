include("lib.jl")
module NNChessMarker
    using HorizonSideRobots
    import Main.inverse

    export mark_chess

    X_COORDINATE=0
    Y_COORDINATE=0

    CELL_SIZE = 0 #размер "шахматной" клетки

    function mark_chess(r::Robot,n::Int)
        global CELL_SIZE
        CELL_SIZE = n 

        side=Ost
        mark_row(r,side)
        while isborder(r,Nord)==false
            move_decart!(r,Nord)
            side = invers(side)
            mark_row(r,side)
        end
    end

    function mark_row(r::Robot,side::HorizonSide)
        putmarker_chess!(r)
        while isborder(r,side)==false
            move_decart!(r,side)
            putmarker_chess!(r)
        end
    end

    function putmarker_chess!(r)
        if (mod(X_COORDINATE, 2*CELL_SIZE) in 1:CELL_SIZE-1) && (mod(Y_COORDINATE, 2*CELL_SIZE) in 1:CELL_SIZE-1)
            putmarker!(r)
        end
    end

    function move_decart!(r::Robot,side::HorizonSide)
        global X_COORDINATE,Y_COORDINATE
        if side==Nord
            Y_COORDINATE+=1
        elseif side==Sud
            Y_COORDINATE-=1
        elseif side==Ost
            X_COORDINATE+=1
        else
            X_COORDINATE-=1
        end
        move!(r,side)
    end
end