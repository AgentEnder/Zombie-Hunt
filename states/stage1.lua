
--Tile Loader
local map = ATL.Loader.load("level1.tmx") 
local tx, ty = 0, 0

--Table
stage1 = {}
--New
function stage1:new()
	local gs = {}

	gs = setmetatable(gs, self)
	self.__index = self
	_gs = gs
	
	return gs
end

--Collisions

function colliding(x, y)
	local collision = false
	if x==0 then
	end
	if x > 928 and x < 1088 then
		if y < 96 and y > 80 then
			collision = true
		end
	end
end

function b1(x, y)
	if insideBox(x, y, 928, 80, 144+16, 192+16) then
		return true
	else
		return false
	end
end
--Load
function stage1:load()
	vingette = love.graphics.newImage("/textures/Vingette.png")
	require("entities")
	ents.Startup()
	
	for i = 0, 25, 1 do
		ents.Create("zombie", love.math.random(16,1200-16), love.math.random(16,1200-16))
	end
	
	player = {}
	hud = {}
	light = {}
	light.alpha = 0
	day = true
	hitAlpha = 0
end

--Close
function stage1:close()
end

--Enable
function stage1:enable()
	ents.Create("player", 400, 300)
end

--Disable
function stage1:disable()	
	player.x = 0
	player.y = 0
end

--Update
function stage1:update(dt)
	if P1collidingL == false and P1collidingR == false and P1collidingT == false and P1collidingB ==false  then
		if love.keyboard.isDown("w") and PinArena then ty = ty + 256*dt end
		if love.keyboard.isDown("s") and PinArena then ty = ty - 256*dt end
		if love.keyboard.isDown("a") and PinArena then tx = tx + 256*dt end
		if love.keyboard.isDown("d") and PinArena then tx = tx - 256*dt end
	end
	ents:update(dt)
	hud.x = player.x
	hud.y = player.y
	dn(dt)
	if hitAlpha<= 0 then hitFade(dt) end
end

function rs()
	ty = 0
	tx = 0
end

function hitFade(dt)
	hitAlpha = hitAlpha - 10
end

function DrawHit()
	hitAlpha = 255
	love.graphics.setColor(255,255,255,hitAlpha)
	love.graphics.print("Hit :D",player.x, player.y)
end

--Day/Night
function dn(dt)
	if day == true then
		light.alpha = light.alpha - 5*dt
	elseif day == false then
		light.alpha = light.alpha + 5*dt
	end
	if light.alpha <= 0 then day = false end
	if light.alpha >= 155 then day = true end
end

--Draw
function stage1:draw()
	love.graphics.setColor(255,255,255,255)
	 love.graphics.translate( math.floor(tx), math.floor(ty) )
	 map:autoDrawRange( math.floor(tx), math.floor(ty), 1, pad)
	 map:draw()
	 ents:draw()
	 love.graphics.print("Health :" .. player.health .. "/" .. player.maxhealth, hud.x - 386, hud.y - 286)
	 love.graphics.print("Score :" .. player.score, hud.x - 372, hud.y - 272)
	 love.graphics.setColor(0,0,0,light.alpha)
	 love.graphics.rectangle("fill",0,0,1200,1200)
end

--KeyPressed
function stage1:keypressed(key, unicode)
	if key == "escape" then love.event.quit() end
	if key == "z" then
		if P1collidingL then print ("P1collidingL") end
		if P1collidingT then print ("P1collidingT") end
		if P1collidingB then print ("P1collidingB") end
		if P1collidingR then print ("P1collidingR") end
	end
	if key == " " and player then
		player.attack()
	end
	if key=="=" then player.health = 0 end
end

--KeyReleased
function stage1:keyreleased(key, unicode)
end

--MousePressed
function stage1:mousepressed(x, y, button)
end

--MouseReleased
function stage1:mousereleased(x, y, button)
end

--Bounding Box
function insideBox( px, py, x, y, wx, wy )
	if px > x and px < x + wx then
		if py > y and py < y + wy then
			return true
		end
	end
	return false
end