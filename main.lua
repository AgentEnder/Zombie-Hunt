--Libraries
ATL = require("/libraries/AdvTiledLoader") 
require("/libraries/stateManager")
require("/libraries/lovelyMoon")
ATL.Loader.path = 'maps/'
HC = require ('/libraries/hardoncollider')
--GameStates
require("/states/gameState")
require("/states/menuState")
require("/states/stage1")
require("/states/replay")

function love.load()
	Collider = HC(100, on_collision, collision_stop)
	--Add Gamestates Here
	addState(MenuState, "menu")
	addState(GameState, "game")
	addState(stage1, "stage1")
	addState(replay, "replay")
	--Remember to Enable your Gamestates!
	enableState("menu")
end

function love.update(dt)
	lovelyMoon.update(dt)
end

function love.draw()
	lovelyMoon.draw()
end

function love.keypressed(key, unicode)
	lovelyMoon.keypressed(key, unicode)
end

function love.keyreleased(key, unicode)
	lovelyMoon.keyreleased(key, unicode)
end

function love.mousepressed(x, y, button)
	lovelyMoon.mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
	lovelyMoon.mousereleased(x, y, button)
end