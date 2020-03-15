local Input = require 'external.boipushy.Input'
local Player = require 'src.player'

function love.load()
   input = Input()
   player = Player:new(input)
end

function love.update()
   player:update()
end

function love.draw()
   player:draw()
end
