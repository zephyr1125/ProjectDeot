UpkeepState = {}

function UpkeepState:enter()
    -- all spaces runs onUpkeep
    for slotId, slot in pairs(map.slots) do
        local resident = map:getSlotOccupied(slotId)
        local space = slot.card.space
        if resident ~= nil and space.onUpkeep ~= nil then
            space.onUpkeep(resident)
        end
    end
    
    GameState.switch(PickCardState)
end