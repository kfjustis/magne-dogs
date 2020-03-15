local Input = require 'external.boipushy.Input'
local Background = require 'src.background'
local Player = require 'src.player'

function love.load()
   input = Input()
   player = Player:new(input)
   background = Background:new(camera)
end

function love.update(dt)
   background:update(dt)
   player:update(dt)
end

function love.draw()
   --Set intial bg layer color.
   love.graphics.setColor(1,1,1,1)
   love.graphics.setBackgroundColor(102/255, 232/255, 137/255, 1)
   background:draw()
   player:draw()
end
