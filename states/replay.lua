--Example of a GameState file

--Table
replay = {}

--New
function replay:new()
	local gs = {}

	gs = setmetatable(gs, self)
	self.__index = self
	_gs = gs
	
	return gs
end

--Load
function replay:load()
	disableState("stage1")
end

--Close
function replay:close()
end

--Enable
function replay:enable()
	disableState("stage1")
end

--Disable
function replay:disable()
end

--Update
function replay:update(dt)
end

--Draw
function replay:draw()
	love.graphics.setColor(255,255,255)
	love.graphics.print("Press Enter to Play Again!", 64, 64)
	love.graphics.print("Press Escape to Quit !", 64, 96)
end

--KeyPressed
function replay:keypressed(key, unicode)
	print(key)
	if key == "return" then
		enableState("stage1")
		disableState("replay")
	end
	if key == "escape" then
		love.event.quit()
	end
end

--KeyRelease
function replay:keyrelease(key, unicode)
end

--MousePressed
function replay:mousepressed(x, y, button)
end

--MouseReleased
function replay:mousereleased(x, y, button)
end

