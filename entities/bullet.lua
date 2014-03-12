bullet = {}
bullets = {}
function bullet.spawn(x, y, angle)
	bullet.id = #bullets + 1
	table.insert(bullets, bullet.id)
	bullet.id.x = x
	bullet.id.y = y
	bullet.id.a = angle
	if bullet.id.a == 1 then
		bullet.id.img = love.graphics.newImage("/textures/bullet1.png")
	end
	if bullet.id.a == 2 then
		bullet.id.img = love.graphics.newImage("/textures/bullet2.png")
	end
	if bullet.id.a == 3 then
		bullet.id.img = love.graphics.newImage("/textures/bullet3.png")
	end
	if bullet.id.a == 4 then
		bullet.id.img = love.graphics.newImage("/textures/bullet4.png")
	end
end

function bullet.update(dt)

end

function bullet.draw()
	for k, ex in pairs (bullets) do
		love.graphics.draw(bullet.id.img, bullet.id.x, 0, 1, 1, 0, 0)
	end
end