module ShessMark
    using HorizonSideRobots
    import Main.moves!, Main.inverse
    export mark_chess

    FLAG_MARK = nothing

    function mark_chess(r)
        global FLAG_MARK 
        num_hor = moves!(r,West)
        num_vert = move!(r,Sud)
        FLAG_MARK = odd(num_hor+num_vert) ? true : false
        side = Ost
        mark_chess(r,side)
        while isborder(Nord)==false
            move!(r,Nord); FLAG_MARK = !FLAG_MARK
            side = inverse(side)
            mark_chess(r,side)
        end
        for side in (West,Sud) moves!(r,side) end
        move!(r,Ost,num_hor)
        move!(r,Nord,num_vert)
    end
    function mark_chess(r,side)
        global FLAG_MARK
        while isborder(r,side)==false
            if FLAG_MARK == true
                putmarker(r)
            end
            move!(r,side); FLAG_MARK = !FLAG_MARK
        end
    end
end