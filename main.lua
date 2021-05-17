Gamestate = require 'external.hump.gamestate'

local Input = require 'external.boipushy.Input'
local Timer = require 'external.hump.timer'

--states
GS_MENU = require 'src.menu'
GS_GAME = require 'src.game'
GS_RESTART = require 'src.restart'

function love.load()
   love.graphics.setDefaultFilter("nearest", "nearest", 1)

   input = Input()
   input:bind('return', function() startGame() end)
   input:bind('kpenter', function() startGame() end)

   Gamestate.registerEvents()
   Gamestate.switch(GS_MENU)
end