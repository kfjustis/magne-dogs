local Input = require 'external.boipushy.Input'
local Player = require 'src.player'
local Camera = require 'external.hump.camera'

function love.load()
   input = Input()
   player = Player:new(input)
   camera = Camera(player.x, player.y)
end

function love.update()
   player:update()
   local dx,dy = player.x - camera.x, player.y - camera.y
   camera:move(dx/2, dy/2)
end

function love.draw()
   --Set intial bg layer color.
   love.graphics.setBackgroundColor(102/255, 232/255, 137/255, 1)
   camera:attach()
   player:draw()
   camera:detach()
end
