ents = {}
ents.objects = {}
ents.objpath = "/entities/"
local register = {}
local id = 0

function ents.Startup()
	register["player"] = love.filesystem.load( ents.objpath .. "player.lua" )
	register["zombie"] = love.filesystem.load( ents.objpath .. "Basic-Zombie.lua" )
end

function ents.Derive(name)
	return love.filesystem.load( ents.objpath .. name .. ".lua" )()
end

function ents.Create(name, x, y, BG)
	if not x then
		x = 0
	end
	
	if not y then
		y = 0
	end
	
	if not BG then
		BG = false
	end
	
	if register[name] then
		id = id + 1
		local ent = register[name]()
		ent:load(x, y)
		ent.type = name
		ent.id = id
		ent.BG = BG
		ents.objects[id] = ent
		return ents.objects[id]
	else
		print("Error: Entity " .. name .. " does not exist! Snap!")
		return false;
	end
end

function ents.Destroy( id )
	if ents.objects[id] then
		if ents.objects[id].Die then
			ents.objects[id]:Die()
		end
		ents.objects[id] = nil
	end
end

function ents:update(dt)
	for i, ent in pairs(ents.objects) do
		if ent.update then
			ent:update(dt)
		end
		if ent.Collisions then
			ent:Collisions()
		end
	end
end

function ents:draw()
	for i, ent in pairs(ents.objects) do
		if not ent.BG then
			if ent.draw then
				ent:draw()
			end
		end
	end
end

function ents:drawBG()
	for i, ent in pairs(ents.objects) do
		if ent.BG then
			if ent.draw then
				ent:draw()
			end
		end
	end
end