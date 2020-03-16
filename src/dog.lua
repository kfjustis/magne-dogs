local class = require 'external.middleclass.middleclass'

local Dog = class('Dog')

function Dog:initialize()
   self.x = love.math.random(0, 800)
   self.y = love.math.random(0, 600)
   self.size = love.math.random(20, 100)
   self.r = love.math.random()
   self.g = love.math.random()
   self.b = love.math.random()
end

function Dog:update(dt)
end

function Dog:draw()
   love.graphics.push()
   love.graphics.setColor(self.r, self.g, self.b, 1)
   love.graphics.rectangle("fill", self.x, self.y, self.size, self.size)
   love.graphics.pop()
end

return Dog
