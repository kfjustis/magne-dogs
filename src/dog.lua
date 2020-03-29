local class = require 'external.middleclass.middleclass'

local Dog = class('Dog')

function Dog:initialize()
   self.x = love.math.random(0, 800)
   self.y = love.math.random(0, 600)
   self.size = love.math.random(20, 100)
   self.image_size = love.math.random(0.5, 0.6)
   self.rotation = love.math.random(0, 6.28)
   self.r = love.math.random()
   self.g = love.math.random()
   self.b = love.math.random()
   self.image = love.graphics.newImage("res/sprites/lilly.png")
end

function Dog:update(dt)
end

function Dog:draw()
   love.graphics.push()
   --love.graphics.setColor(self.r, self.g, self.b, 1)
   --love.graphics.rectangle("fill", self.x, self.y, self.size, self.size)
   love.graphics.draw(self.image, self.x, self.y, self.rotation, self.image_size, self.image_size)
   love.graphics.pop()
end

return Dog
