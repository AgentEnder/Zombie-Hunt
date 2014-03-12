--Example of a GameState file

--Table
MenuState = {}

--New
function MenuState:new()
	local gs = {}

	gs = setmetatable(gs, self)
	self.__index = self
	_gs = gs
	
	return gs
end

--Load
function MenuState:load()
	disableState("stage1")
end

--Close
function MenuState:close()
end

--Enable
function MenuState:enable()
	disableState("stage1")
end

--Disable
function MenuState:disable()
end

--Update
function MenuState:update(dt)
end

--Draw
function MenuState:draw()
	love.graphics.print("HI, press the Space Bar to go to the Game!", 64, 64)
	love.graphics.print("Press Escape to Quit !", 64, 96)
end

--KeyPressed
function MenuState:keypressed(key, unicode)
	if key == " " then
		enableState("stage1")
		disableState("menu")
	end
	if key == "escape" then
		love.event.quit()
	end
end

--KeyRelease
function MenuState:keyrelease(key, unicode)
end

--MousePressed
function MenuState:mousepressed(x, y, button)
end

--MouseReleased
function MenuState:mousereleased(x, y, button)
end

