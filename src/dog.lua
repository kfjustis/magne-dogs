local class = require 'external.middleclass.middleclass'

local Dog = class('Dog')

function Dog:initialize()
   self.x = love.math.random(200, 600)
   self.y = love.math.random(100, 500)
   self.rotation = 0
   self.r = love.math.random()
   self.g = love.math.random()
   self.b = love.math.random()
   self.image = love.graphics.newImage("res/sprites/lilly.png")
   self.scale = 1
   self.vac_speed = 5

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
   mouse_x, mouse_y = love.mouse.getPosition()

   --update dog origin
   self.min_x = self.x
   self.max_x = self.x + self.image:getWidth()

   self.min_y = self.y
   self.max_y = self.y + self.image:getHeight()

   self.origin_x = self.max_x - ((self.max_x - self.min_x) / 2)
   self.origin_y = self.max_y - ((self.max_y - self.min_y) / 2)

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
   else
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

   if self.hovered_over then
      love.graphics.setColor(0, 0, 1, 1)
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
   tx, ty = target:getPosition()
   tox, toy = target:getOriginPosition()

   if tox == self.origin_x and 
       toy == self.origin_y then
      return
   end

   if tox < self.origin_x then
      self.x = self.x - self.vac_speed
   elseif tox > self.origin_x then
      self.x = self.x + self.vac_speed
   end

   if toy < self.origin_y then
      self.y = self.y - self.vac_speed
   elseif toy > self.origin_y then
      self.y = self.y + self.vac_speed
   end
end

return Dog
