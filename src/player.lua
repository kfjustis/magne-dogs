local class = require 'external.middleclass.middleclass'

local Player = class('Player')

function Player:initialize(input)
   --Init player variables.
   self.x = 400
   self.y = 300
   self.speed = 3
   self.size = 20
   self.origin_x = self.x + (self.size / 2)
   self.origin_y = self.y + (self.size / 2)
   self.mouse_x = 0
   self.mouse_y = 0

   self.item = love.graphics.newImage("/res/sprites/magnet.png")
   self.theta_magnet = 0

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
   input:bind('mouse1', 'shoot')
end

function Player:update(dt)
   -- Update player speed first.
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

   -- Update values for the center of the player.
   self.origin_x = self.x + (self.size / 2)
   self.origin_y = self.y + (self.size / 2)

   -- Update the magnet sprite angle based on
   -- the mouse position.
   self.mouse_x = love.mouse.getX()
   self.mouse_y = love.mouse.getY()
   local angle_x = self.mouse_x - self.x
   local angle_y = self.mouse_y - self.y
   self.theta_magnet = math.atan2(-angle_y, angle_x)
end

function Player:draw()
   love.graphics.setColor(201/255, 81/255, 120/255, 1)
   love.graphics.rectangle("fill", self.x, self.y, self.size, self.size)
   if input:down('shoot') then
      love.graphics.circle("line", self.origin_x, self.origin_y, 30)
      love.graphics.line(self.origin_x, self.origin_y, self.mouse_x, self.mouse_y)
   end

   love.graphics.draw(self.item,
      self.origin_x,
      self.origin_y,
      -self.theta_magnet,
      1,
      1,
      0,
      self.item:getHeight()/2)
end

return Player
