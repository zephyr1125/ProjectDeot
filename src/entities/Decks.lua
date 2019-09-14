local function drawDeck(cards, x, y, drawTopDeck)
    if #cards > 0 and drawTopDeck ~= nil then
        drawTopDeck(cards[#cards], x, y)
    end

    --card count
    setColor(white)
    love.graphics.printf(tostring(#cards), x, y+48, cardWidth, 'center')
end

local function refillDeck(self)
    for _, card in pairs(self.discardCards) do
        card.isShowAction = true
        table.insert(self.cards, random(2, #self.cards), card)
    end
    table.clean(self.discardCards)
    print('refilled deck')
end

local function discardCard(self, card)
    table.add(self.discardCards, card)
end

-- if amount == 1 return 1 card, else return table of cards
local function pickCards(self, amount)
    if #self.cards == 0 then
        refillDeck(self)
    end
    local picked = {}
    for _ = 1, amount do
        local card = table.remove(self.cards, #self.cards)
        if amount == 1 then
            return card
        else
            table.add(picked, card)
        end
    end
    return picked
end

local Decks = class {
    PublicDeck = {
        size = 40,
        scoreRange = {3,10},
        discardCards = {},
        x = 4,
        y = 4,
        draw = function(self)
            drawDeck(self.cards, self.x, self.y, drawCardAsSpace)
            -- drawFirstDiscardCards
        end,
        pickCards = function(self, amount)
            return pickCards(self, amount)
        end,
        discardCard = function(self, card)
            discardCard(self, card)
        end
    },
    PlayerDeck = {
        size = 12,
        scoreRange = {2,2},
        discardCards = {},
        x = 276,
        y = 160,
        draw = function(self)
            --draw the latest dicard card
            local card = self.discardCards[#self.discardCards]
            if card~=nil and not floatequal(card.x, self.x, 0.1) then
                card:draw()
            end
            
            drawDeck(self.cards, self.x, self.y, drawCardAsAction)
        end,
        pickCards = function(self, amount)
            return pickCards(self, amount)
        end,
        discardCard = function(self, card)
            discardCard(self, card)
            -- start card tween
            card:moveTo(self.x, self.y, 0.3)
        end
    },
    BansheeDeck = {
        size = 9,
        scoreRange = {2,3},
        discardCards = {},
        x = (screenWidth - cardWidth)/2,
        y = - cardHeight,
        draw = function(self, x, y)
            drawDeck(self.cards, x, y)
        end,
        pickCards = function(self, amount)
            return pickCards(self, amount)
        end,
        discardCard = function(self, card)
            discardCard(self, card)
        end
    },
    GhostDeck = {
        size = 9,
        scoreRange = {3,4},
        discardCards = {},
        x = (screenWidth - cardWidth)/2,
        y = - cardHeight,
        draw = function(self, x, y)
            drawDeck(self.cards, x, y)
        end,
        pickCards = function(self, amount)
            return pickCards(self, amount)
        end,
        discardCard = function(self, card)
            discardCard(self, card)
        end
    },
    TrollDeck = {
        size = 9,
        scoreRange = {3,4},
        discardCards = {},
        x = (screenWidth - cardWidth)/2,
        y = - cardHeight,
        draw = function(self, x, y)
            drawDeck(self.cards, x, y)
        end,
        pickCards = function(self, amount)
            return pickCards(self, amount)
        end,
        discardCard = function(self, card)
            discardCard(self, card)
        end
    }
}

return Decks