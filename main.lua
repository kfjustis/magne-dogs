local Input = require 'external.boipushy.Input'
local Timer = require 'external.hump.timer'
local Background = require 'src.background'
local Player = require 'src.player'
local Dog = require 'src.dog'

local NUM_DOGS = 30

local dogs_saved = 0
local dogs = {}

function love.load()
   love.graphics.setDefaultFilter("nearest", "nearest", 1)
   input = Input()
   player = Player:new(input)
   background = Background:new(camera)
   generate_dogs()
end

function love.update(dt)
   background:update(dt)
   player:update(dt)
   update_dogs()
end

function love.draw()
   --Set intial bg layer color.
   love.graphics.setColor(1,1,1,1)
   love.graphics.setBackgroundColor(102/255, 232/255, 137/255, 1)

   background:draw()
   draw_dogs()
   player:draw()

   love.graphics.setColor(0,0,0,1)
   love.graphics.print("Dogs saved: " .. dogs_saved, 10, 10, 0, 2, 2, 0, 0, 0, 0)
   love.graphics.setColor(1,1,1,1)
   love.graphics.print("Dogs saved: " .. dogs_saved, 9, 9, 0, 2, 2, 0, 0, 0, 0)
end

function generate_dogs()
   local i = 1
   while (i <= NUM_DOGS)
   do
      table.insert(dogs, Dog:new())
      i = i + 1
   end
end

function update_dogs()
   local i = 1
   while (i <= NUM_DOGS)
   do
      local dog = dogs[i]
      if dog then
         dog:update()
         if dog:isClicked() then
            dog:moveDogTowards(player)
         end
         if dog:canRemove() then
            table.remove(dogs, i)
            dog = nil
            dogs_saved = dogs_saved + 1
         end
      end
      i = i + 1
   end
end

function draw_dogs()
   local i = 1
   while (i <= NUM_DOGS)
   do
      local dog = dogs[i]
      if dog then
         dog:draw()
      end
      i = i + 1
   end
end
