local menu = {}

function menu:init()
end

function menu:enter()
   print("entered menu state")
   input:bind('return', function() Gamestate.switch(GS_GAME) end)
   input:bind('kpenter', function() Gamestate.switch(GS_GAME) end)
end

function menu:update(dt)
end

function menu:draw()
   love.graphics.setBackgroundColor(0,0,0,1)
   love.graphics.push()
   love.graphics.setColor(1,1,1,1)
   love.graphics.print("Magne-Dogs!", 100, 100, 0, 4, 4, 0, 0, 0, 0)
   love.graphics.print("ENTER TO START", 100, 400, 0, 2, 2, 0, 0, 0, 0)
   love.graphics.pop()
end

return menu