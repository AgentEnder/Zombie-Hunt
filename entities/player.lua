local ent = ents.Derive("base")

function ent:load( x, y )
	self.image = love.graphics.newImage("textures/guy.png")
	self.birth = love.timer.getTime() + math.random( 0, 128 )
	self.size = 1
	self.angle = 0
	self.falling = false
	self.health = 10
	self.maxhealth = self.health
	self.x = x
	self.y = y
	player.x = self.x
	player.y = self.y
	self.shots = {}
	P1colliding = false
	player.health = 20
	player.maxhealth = 20
	player.invincible = false
	player.invincibleTimer = 0
	player.score = 0
	player.meleetimer = 0
end

function ent:setPos( x, y )
	self.fixed_y = y
end

function ent:Collisions(x, y, dt)
	if insideBox(self.x, self.y,16,16,1200-32,1200-32) then
		P1collidingL = false
		P1collidingT = false
		P1collidingR = false
		P1collidingB = false
		PinArena = true
	else
		PinArena = false
		if self.x < 16 then
			P1collidingL = true
		else
			if self.y < 16 then
				P1collidingT = true
			else	
				if self.y > 1200-32 then
					P1collidingB = true
				else
					if self.x > 1200-32 then
						P1collidingR = true
					end
				end
			end
		end
	end
	if PinArena then 
	end
end

function ent:update(dt)
	player.meleetimer = player.meleetimer - dt
	speed = 128*dt
	ent:Collisions(self.x,self.y, speed)
	if b1(self.x + 8, self.y + 8) then
		print("colliding")
	end
	if PinArena then
		if love.keyboard.isDown("w") then
			self.y = self.y - 256*dt
			self.angle = 0
		end
	
		if love.keyboard.isDown("s") then
			self.y = self.y + 256*dt
			self.angle = math.pi 
		end

		if love.keyboard.isDown("a") then
			self.x = self.x - 256*dt
			if love.keyboard.isDown("w") then
				self.angle = math.pi*1.75
			elseif love.keyboard.isDown("s") then 
				self.angle = math.pi *1.25
			else
				self.angle = math.pi * 1.5 
			end
		end
	
		if love.keyboard.isDown("d") then
			self.x = self.x + 256*dt
			if love.keyboard.isDown("w") then
				self.angle = math.pi/4
			elseif love.keyboard.isDown("s") then
				self.angle = math.pi*3/4
			else
				self.angle = math.pi/2
			end
		end
	end
	if P1collidingL == true then
		if love.keyboard.isDown("d") then
			self.x = self.x + 256*dt
			if love.keyboard.isDown("w") then
				self.angle = math.pi/4
			elseif love.keyboard.isDown("s") then
				self.angle = math.pi*3/4
			else
				self.angle = math.pi/2
			end
		end
	end
	if P1collidingR == true then
		if love.keyboard.isDown("a") then
			self.x = self.x - 256*dt
			if love.keyboard.isDown("w") then
				self.angle = math.pi*1.75
			elseif love.keyboard.isDown("s") then 
				self.angle = math.pi *1.25
			else
				self.angle = math.pi * 1.5 
			end
		end
	end
	if P1collidingT == true then
		if love.keyboard.isDown("s") then
			self.y = self.y + 256*dt
			self.angle = math.pi 
		end
	end
	if P1collidingB == true then
		if love.keyboard.isDown("w") then
			self.y = self.y - 256*dt
			self.angle = 0
		end
	end
	player.x = self.x
	player.y = self.y
	player.invincibleTimer = player.invincibleTimer - 2*dt
	if player.invincibleTimer <= 0 then
		player.invincible = false
	else
		player.invincible = true
	end
	if player.health <= 0 then
		player.health = 20
		print("death")
		ent:die()
		self.x = 400
		self.y = 300
	end
end

function ent:draw()
	love.graphics.setColor( 255, 255, 255, 255 )
	love.graphics.draw( self.image, self.x, self.y, self.angle, self.size*2, self.size*2, 8, 8 )
	Pready = true
end

function ent:die()
	ents.Destroy(self.id)
	rs()
	player.health = 20
	enableState("replay")
end

function player.attack()
	print("attack")
	player.melee = true
	player.meleetimer = .1
	if player.meleetimer <= 0 then player.melee = false end
end

return ent;
