local Input = require 'external.boipushy.Input'
local Gamestate = require 'external.hump.gamestate'
local Timer = require 'external.hump.timer'
local Background = require 'src.background'
local Player = require 'src.player'
local Dog = require 'src.dog'

local NUM_DOGS = 30

local dogs_saved = 0
local dogs = {}

--states
local menu = {}
local game = {}
local restart = {}

function love.load()
   love.graphics.setDefaultFilter("nearest", "nearest", 1)

   input = Input()
   input:bind('return', function() switchStates() end)
   input:bind('kpenter', function() switchStates() end)

   Gamestate.registerEvents()
   Gamestate.switch(menu)   
end

function menu:init()
end

function menu:enter()
   print("entered menu state")
end

function menu:draw()
   love.graphics.setBackgroundColor(0,0,0,1)
   love.graphics.push()
   love.graphics.setColor(1,1,1,1)
   love.graphics.print("Magne-Dogs!", 100, 100, 0, 4, 4, 0, 0, 0, 0)
   love.graphics.print("ENTER TO START", 100, 400, 0, 2, 2, 0, 0, 0, 0)
   love.graphics.pop()
end

function menu:update(dt)
end

function game:enter()
   dogs_saved = 0
   print("entered game state")
   player = Player:new(input)
   background = Background:new(camera)
   generate_dogs()
end

function game:exit()
end

function game:update(dt)
   background:update(dt)
   player:update(dt)
   update_dogs()

   if dogs_saved == NUM_DOGS then
      Gamestate.switch(restart)
   end
end

function game:draw()
   --Set intial bg layer color.
   love.graphics.setColor(1,1,1,1)

   background:draw()
   draw_dogs()
   player:draw()

   love.graphics.setColor(0,0,0,1)
   love.graphics.print("Dogs saved: " .. dogs_saved, 10, 10, 0, 2, 2, 0, 0, 0, 0)
   love.graphics.setColor(1,1,1,1)
   love.graphics.print("Dogs saved: " .. dogs_saved, 9, 9, 0, 2, 2, 0, 0, 0, 0)
end

function restart:enter()
   print("entered restart state")
end

function restart:draw()
   love.graphics.setBackgroundColor(0,0,0,1)
   love.graphics.push()
   love.graphics.setColor(1,1,1,1)
   love.graphics.print("YOU SAVED THE DOGS!", 100, 100, 0, 3, 3, 0, 0, 0, 0)
   love.graphics.print("ENTER TO RESTART", 100, 400, 0, 2, 2, 0, 0, 0, 0)
   love.graphics.pop()
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

function switchStates()
   if Gamestate.current() == menu then
      Gamestate.switch(game)
   elseif Gamestate.current() == restart then
      Gamestate.switch(menu)
   end
end
