local class = require 'external.middleclass.middleclass'

local Player = class('Player')

function Player:initialize(input)
   --Init player variables.
   self.x = 400
   self.y = 300
   self.speed = 3
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
   input:bind('lshift', 'sprint')
end

function Player:update(dt)
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
   if input:pressed('sprint') then
      self.speed = self.speed * 3
   end
   if input:released('sprint') then
      self.speed = 3
   end
end

function Player:draw()
   love.graphics.setColor(201/255, 81/255, 120/255, 1)
   love.graphics.rectangle("fill", self.x, self.y, self.size, self.size)
end

return Player
