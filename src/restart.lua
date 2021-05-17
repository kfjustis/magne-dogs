local restart = {}

function restart:enter()
end

function restart:draw()
   love.graphics.setBackgroundColor(0,0,0,1)
   love.graphics.push()
   love.graphics.setColor(1,1,1,1)
   love.graphics.print("YOU SAVED THE DOGS!", 100, 100, 0, 3, 3, 0, 0, 0, 0)
   love.graphics.print("ENTER TO RESTART", 100, 400, 0, 2, 2, 0, 0, 0, 0)
   love.graphics.pop()
end

return restart