local class = require 'external.middleclass.middleclass'

local Dog = class('Dog')

function Dog:initialize()
   self.x = love.math.random(0, 450)
   self.y = love.math.random(0, 500)
   self.rotation = 0
   self.r = love.math.random()
   self.g = love.math.random()
   self.b = love.math.random()
   self.image = love.graphics.newImage("res/sprites/lilly.png")
   self.scale = 1
   self.vac_speed = 5
   self.can_remove = false

   --hitbox detection
   self.min_x = self.x
   self.max_x = self.x + self.image:getWidth()

   self.min_y = self.y
   self.max_y = self.y + self.image:getHeight()

   self.hovered_over = false
   self.is_clicked = false

   --set origin data (center of sprite)
   self.origin_x = self.max_x - ((self.max_x - self.min_x) / 2)
   self.origin_y = self.max_y - ((self.max_y - self.min_y) / 2)

   --debug
   self.debug = false
end

function Dog:update(dt)
   --update dog origin
   self.min_x = self.x
   self.max_x = self.x + self.image:getWidth()

   self.min_y = self.y
   self.max_y = self.y + self.image:getHeight()

   self.origin_x = self.max_x - ((self.max_x - self.min_x) / 2)
   self.origin_y = self.max_y - ((self.max_y - self.min_y) / 2)

   --update mouse
   mouse_x, mouse_y = love.mouse.getPosition()

   --check if dog is hovered over
   if (mouse_x > self.min_x and mouse_x < self.max_x) and
         (mouse_y > self.min_y and mouse_y < self.max_y) then
      self.hovered_over = true
   else
      self.hovered_over = false
   end

   --check if dog is being clicked
   if self.hovered_over and love.mouse.isDown(1) then
      self.is_clicked = true
   end

   if not love.mouse.isDown(1) then
      self.is_clicked = false
   end
end

function Dog:draw()
   love.graphics.push()

   if self.debug then
      love.graphics.rectangle("fill", self.min_x,
                                      self.min_y,
                                      self.max_x - self.min_x,
                                      self.max_y - self.min_y)
   end

   love.graphics.draw(self.image,
                      self.x, self.y,
                      self.rotation,
                      self.scale, self.scale,
                      0, 0,
                      0, 0)

   love.graphics.pop()
end

function Dog:isClicked()
   return self.is_clicked
end

function Dog:moveDogTowards(target)
   local buffer = 10
   local tox, toy = target:getOriginPosition()
   local t_min_x = tox - buffer
   local t_max_x = tox + buffer
   local t_min_y = toy - buffer
   local t_max_y = toy + buffer
   local x_in_range = false
   local y_in_range = false

   if self.origin_x > t_min_x and self.origin_x < t_max_x then
      x_in_range = true
   end

   if self.origin_y > t_min_y and self.origin_y < t_max_y then
      y_in_range = true
   end

   if x_in_range and y_in_range then
      self.can_remove = true
   end

   if not self.can_remove then
      if self.origin_x > tox then
         self.x = self.x - self.vac_speed
      elseif self.origin_x < tox then
         self.x = self.x + self.vac_speed
      end

      if self.origin_y > toy then
         self.y = self.y - self.vac_speed
      elseif self.origin_y < toy then
         self.y = self.y + self.vac_speed
      end
   end
end

function Dog:canRemove()
   return self.can_remove
end

return Dog
