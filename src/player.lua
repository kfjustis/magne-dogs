local class = require 'external.middleclass.middleclass'

local Player = class('Player')

function Player:initialize(input)
   --Init player variables.
   self.x = 200
   self.y = 200
   self.speed = 5
   self.size = 15

   --Bind player inputs.
   input:bind('w', 'up')
   input:bind('up', 'up')
   input:bind('s', 'down')
   input:bind('down', 'down')
   input:bind('a', 'left')
   input:bind('left', 'left')
   input:bind('d', 'right')
   input:bind('right', 'right')
end

function Player:update()
   if input:down('up') then
      self.y = self.y - self.speed
   end
   if input:down('down') then
      self.y = self.y + self.speed
   end
   if input:down('left') then
      self.x = self.x - self.speed
   end
   if input:down('right') then
      self.x = self.x + self.speed
   end
end

function Player:draw()
   love.graphics.setColor(0, 1, 0, 1)
   love.graphics.rectangle("fill", self.x, self.y, self.size, self.size)
   love.graphics.setColor(0, 0, 0, 1)
end

return Player
