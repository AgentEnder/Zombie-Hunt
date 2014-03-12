local ent = ents.Derive("base")

zombies = {}
zombiesDead = {}

function ent:load( x, y )
	self:setPos( x, y )
	self.image = love.graphics.newImage("/textures/zombie2.png")
	self.birth = love.timer.getTime()+math.random(0, 128)
	self.size = math.random(4, 6)
	self:newDirection()
	self.falling = false
	self.score5 = false
	self.health = 4
	self.speed = 128
	self.maxhealth = 4
	self.timer = love.math.random(1,5)
	self.x = x
	self.y = y
	self.health = 5
	self.maxhealth = 5
	table.insert(zombies, self)
end

function ent:newDirection(oldDirection, reason)
	self.direction = love.math.random(0,3)
	if self.oldDirection == self.direction then self.direction = self.direction + 1 end
	if reason == bounds then
		if oldDirection == 0  then self.direction = 2 end
		if oldDirection == 1  then self.direction = 3 end
		if oldDirection == 2  then self.direction = 0 end
		if oldDirection == 3  then self.direction = 1 end
	end
	if reason == timer then self.direction = love.math.random(0,3) end 
	self.oldDirection = self.direction
	self.angle = self.direction*0.5*math.pi
	if not reason==bounds then self.timer = 2 end 
end

function ent:chase()
	if player.x < self.x then
		self.x = self.x - 1.5
		self.direction = 1
		self.angle = self.direction*0.5*math.pi
	end

	if player.x > self.x then
		self.x = self.x + 1.5
		self.direction = 3
		self.angle = self.direction*0.5*math.pi
	end

	if player.y < self.y then
		self.direction = 2
		self.angle = self.direction*0.5*math.pi
		self.y = self.y - 1.5
	end

	if player.y > self.y then
		self.direction = 0
		self.angle = self.direction*0.5*math.pi
		self.y = self.y + 1.5
	end
	if player.y == self.y then
		if player.x < self.x then
			self.direction = 1
			self.angle = self.direction*0.5*math.pi
			
		elseif player.x > self.x then
			self.direction = 3
			self.angle = self.direction*0.5*math.pi
		end
	end
end

function ent:inArena()
	if insideBox(self.x, self.y,16,16,1200-32,1200-32) then self.bounds = true end
	if not insideBox(self.x, self.y,16,16,1200-32,1200-32) then self.bounds = false end
end

function ent:zombieAttack()
	print("attack")
	if player.invincible == false then
		player.health = player.health - 2
		player.invincibleTimer = 1
	end
end

function ent:moveZombie(dt)
  self.x = self.x + math.cos(self.angle)*self.speed*dt
  self.y = self.y + math.sin(self.angle)*self.speed*dt  
end

function ent:setPos(x,y)
	self.x=x
	self.y=y
	self.fixed_y=y
end

function ent:update(dt)
	ent:inArena()
	
	if insideBox(player.x - 8, player.y - 8, self.x-400, self.y-300, 800, 600) == true then
		ent:chase()
	else
		ent:newDirection()
		ent:moveZombie(dt)
	end
	self.timer = self.timer - dt
	if self.bounds == false then
		ent:newDirection(self.oldDirection, bounds)
	end
	if self.timer < 0 then
		ent:newDirection(self.oldDirection, timer)
		self.timer = 2
	end
	
	if insideBox(player.x - 8, player.y - 8, self.x-8, self.y-8, 16, 16) == true  or insideBox(player.x + 8, player.y - 8, self.x-8, self.y-8, 16, 16) == true or insideBox(player.x - 8, player.y + 8, self.x-8, self.y-8, 16, 16) == true or insideBox(player.x + 8, player.y + 8, self.x-8, self.y-8, 16, 16) == true then
		ent:zombieAttack()
	end
	if player.melee == true and insideBox(player.x - 8, player.y - 8, self.x-50, self.y-50, 100, 100) == true then
		self.health = self.health - love.math.random(2,3)
		player.melee = false
		DrawHit()
		if self.health <= 0 then
			player.score = player.score + 5
			ent:die(melee)
			player.hitTimer = 5
		end
	elseif player.melee == true and insideBox(player.x - 8, player.y + 8, self.x-50, self.y-50, 100, 100) == true then
		self.health = self.health - love.math.random(2,3)
		player.melee = false
		if self.health <= 0 then
			ent:die(melee)
			player.score = player.score + 5
			player.hitTimer = 5
		end
	elseif player.melee == true and insideBox(player.x + 8, player.y + 8, self.x-50, self.y-50, 100, 100) == true then
		self.health = self.health - love.math.random(2,3)
		player.melee = false
		if self.health <= 0 then
			player.score = player.score + 5
			ent:die(melee)
			player.hitTimer = 5
		end
	elseif player.melee == true and insideBox(player.x + 8, player.y - 8, self.x-50, self.y-50, 100, 100) == true then
		self.health = self.health - love.math.random(2,3)
		player.melee = false
		if self.health <= 0 then
			player.score = player.score + 5
			ent:die(melee)
			player.hitTimer = 5
		end
	end
	if self.x < 8 or self.x > 1200-8 or self.y < 8 or self.y > 1200-8 then
		ent:die(bounds)
	end
end

function ent:die(reason)
	if reason ==  bounds then 
		ents.Create("zombie", love.math.random(32,1200-32), 500+ love.math.random(32,1200-32))
	elseif reason == melee then 
		print ("melee")
		table.insert(zombiesDead, self)
		player.melee = false
	end
	ents.Destroy(self.id)
end

function ent:draw()
	love.graphics.setColor(255,255,255,255)
	love.graphics.draw(self.image, self.x, self.y, self.angle, 2, 2, 8, 8)
end

return ent;