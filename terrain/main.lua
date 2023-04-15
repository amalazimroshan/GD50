-- function love.load()
--     love.window.setTitle("Endless 1D Terrain")
--     love.window.setMode(800, 600)

--     terrain = {}
--     inc = 0.005
--     start = 0

--     for i = 1, 800 do
--         terrain[i] = love.math.noise(start) * 300
--         start = start + inc
--     end
-- end

-- function love.draw()
--     love.graphics.setColor(1, 1, 1)
--     love.graphics.setLineWidth(2)
--     love.graphics.line(0, 600, 0, 600 - terrain[1])

--     for i = 2, 800 do
--         love.graphics.line(i - 1, 600 - terrain[i - 1], i, 600 - terrain[i])
--     end
-- end

-- function love.update(dt)
--     table.remove(terrain, 1)
--     terrain[800] = love.math.noise(start) * 300
--     start = start + inc
-- end


-- function love.load()
--     love.physics.setMeter(64)
--     world = love.physics.newWorld(0, 9.81*64, true)
--     terrainVertices = {}
--     for i = 0, love.graphics.getWidth() do
--       local y = love.math.noise(i/50)*love.graphics.getHeight()
--       table.insert(terrainVertices, i)
--       table.insert(terrainVertices, y)
--     end
--     terrainBody = love.physics.newBody(world, 0, 0, "static")
--     terrainShape = love.physics.newChainShape(false, terrainVertices)
--     terrainFixture = love.physics.newFixture(terrainBody, terrainShape)
    
--     playerBody = love.physics.newBody(world, 50, 50, "dynamic")
--     playerShape = love.physics.newRectangleShape(20, 20)
--     playerFixture = love.physics.newFixture(playerBody, playerShape)
--   end
  
--   function love.update(dt)
--     world:update(dt)
--   end
  
--   function love.draw()
--     love.graphics.line(terrainVertices)
--     love.graphics.polygon("line", playerBody:getWorldPoints(playerShape:getPoints()))
--   end
  


-- function love.load()
--     -- Initialize the physics world
--     love.physics.setMeter(64)
--     world = love.physics.newWorld(0, 9.81 * 64, true)
   
--     -- Create the ground body
--     terrainVertices = {}
--     for i = 0, love.graphics.getWidth() do
--       local y = love.math.noise(i/50)*love.graphics.getHeight()
--       table.insert(terrainVertices, i)
--       table.insert(terrainVertices, y)
--     end
--     ground = {}
--     ground.body = love.physics.newBody(world, love.graphics.getWidth() / 2, love.graphics.getHeight() / 2 + 50, "static")
--     ground.shape = love.physics.newChainShape(true, terrainVertices)
--     ground.fixture = love.physics.newFixture(ground.body, ground.shape)
   
--     -- Create the player rectangle
--     player = {}
--     player.body = love.physics.newBody(world, love.graphics.getWidth() / 2, love.graphics.getHeight() / 2, "dynamic")
--     player.shape = love.physics.newRectangleShape(50, 50)
--     player.fixture = love.physics.newFixture(player.body, player.shape)
--   end
  
--   function love.update(dt)
--     -- Move the player with the arrow keys
--     local vx, vy = player.body:getLinearVelocity()
--     if love.keyboard.isDown("left") then
--       player.body:setLinearVelocity(-200, vy)
--     elseif love.keyboard.isDown("right") then
--       player.body:setLinearVelocity(200, vy)
--     else
--       player.body:setLinearVelocity(0, vy)
--     end
   
--     -- Update the physics world
--     world:update(dt)
   
--     -- Check if the terrain needs to be regenerated
--     if ground.shape:getVertexCount() * 2 < love.graphics.getWidth() then
--       -- Remove the old terrain fixture
--       ground.fixture:destroy()
   
--       -- Shift the terrain vertices to the left
--       for i = 2, #terrainVertices, 2 do
--         terrainVertices[i - 1] = terrainVertices[i]
--         terrainVertices[i] = terrainVertices[i] + segmentLength
--       end
   
--       -- Add a new segment to the right
--       local x = terrainVertices[#terrainVertices]
--       for i = 1, numSegments do
--         local noiseValue = love.math.noise(x / 100, 0)
--         local y = (noiseValue + 1) * (love.graphics.getHeight() / 2)
--         table.insert(terrainVertices, x)
--         table.insert(terrainVertices, y)
--         x = x + segmentLength
--       end
   
--       -- Create a new fixture for the terrain
--       ground.shape = love.physics.newChainShape(true, terrainVertices)
--       ground.fixture = love.physics.newFixture(ground.body, ground.shape)
--     end
--   end
  
--   function love.draw()
--     -- Draw the terrain
--     love.graphics.setColor(255, 255, 255)
--     love.graphics.line(terrainVertices)
   
--     -- Draw the player
--     love.graphics.setColor(255, 0, 0)
--     love.graphics.polygon("fill", player.body:getWorldPoints(player.shape:getPoints()))
--   end
  


local grid = {}

local function generateNoiseGrid()
	-- Fill each tile in our grid with noise.
	local baseX = 10000 * love.math.random()
	local baseY = 10000 * love.math.random()
	for y = 1, 60 do
		grid[y] = {}
		for x = 1, 60 do
			grid[y][x] = love.math.noise(baseX+.1*x, baseY+.2*y)
		end
	end
end

function love.load()
	generateNoiseGrid()
end
function love.keypressed()
	generateNoiseGrid()
end

function love.draw()
	local tileSize = 8
	for y = 1, #grid do
		for x = 1, #grid[y] do
			love.graphics.setColor(1, 1, 1, grid[y][x])
			love.graphics.rectangle("fill", x*tileSize, y*tileSize, tileSize-1, tileSize-1)
		end
	end
end