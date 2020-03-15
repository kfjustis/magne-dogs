local class = require 'external.middleclass.middleclass'
local iffy = require 'external.iffy.iffy'

local Background = class('Background')

function Background:initialize(camera)
   iffy.newAtlas("/res/tile-sets/kenney_topdowntanksredux/Spritesheet/allSprites_default.png")
end

function Background:update(dt)
end

function Background:draw()
   local i = 0
   while (i < 800)
   do
      local j = 0
      while (j < 600)
      do
         iffy.drawSprite('tileGrass1.png', i, j)
         j = j + 32
      end
      i = i + 32
   end
end

return Background
