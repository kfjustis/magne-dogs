local Input = require 'external.boipushy.Input'
local Timer = require 'external.hump.timer'
local Background = require 'src.background'
local Player = require 'src.player'
local Dog = require 'src.dog'

local NUM_DOGS = 1

local dogs_saved = 0
local dogs = {}

function generate_dogs()
   local i = 1
   while (i <= NUM_DOGS)
   do
      table.insert(dogs, Dog:new())
      i = i + 1
   end
end

function love.load()
   input = Input()
   player = Player:new(input)
   background = Background:new(camera)
   love.graphics.setDefaultFilter("nearest", "nearest", 1)
   generate_dogs()
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

   -- Draw the dogs.
   local i = 1
   while (i <= NUM_DOGS)
   do
      local dog = dogs[i]
      if dog then
         dog:draw()
      end
      i = i + 1
   end

   player:draw()

   love.graphics.setColor(0,0,0,1)
   love.graphics.print("Dogs saved: " .. dogs_saved, 10, 10, 0, 2, 2, 0, 0, 0, 0)
   love.graphics.setColor(1,1,1,1)
   love.graphics.print("Dogs saved: " .. dogs_saved, 9, 9, 0, 2, 2, 0, 0, 0, 0)
end
