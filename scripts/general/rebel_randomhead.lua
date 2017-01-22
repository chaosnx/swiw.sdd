RANDOMHEAD = false
N_RANDOMHEAD = 3


function ChooseRandomHead()
    RANDOMHEAD = true
    randHead = math.random(1, N_RANDOMHEAD)
    Hide(head)
    Hide(head2)
    Hide(head3)
    if HEADEXTRAS1 ~= nil then
        HEADEXTRAS1()
    end

    if randHead == 1 or randHead < 1 or randHead > 3 then
        Show(head)
        randHead = 1
    elseif randHead == 2 then
        Show(head2)
    elseif randHead == 3 then
        if HEADEXTRAS2 ~= nil then
            HEADEXTRAS2()
        end
        Show(head3)
    end
end