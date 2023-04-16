push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

local background = love.graphics.newImage('background.png')
local ground = love.graphics.newImage('ground.png')

function love.load()
    love.graphics.setDefaultFilter('nearest','nearest')
    love.window.setTitle('flappy bird')
    push:setupScreen(VIRTUAL_WIDTH,VIRTUAL_HEIGHT,WINDOW_WIDTH,WINDOW_HEIGHT,{
        vsync = true,
        fullscreen = false,
        resizable = true
    })
    x = 0
    y = 0
end

function love.resize(w,h)
    push:resize(w,h)
end
function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end
function love.update(dt)
    if love.keyboard.isDown('down') then
        y = math.min(VIRTUAL_HEIGHT - 100, y + 1)
    end
    if love.keyboard.isDown('up') then
        y = math.max(0,y - 1)
    end
    if love.keyboard.isDown('left') then
        x = math.max(0, x - 1)
    end
    if love.keyboard.isDown('right') then
        x = math.min(VIRTUAL_WIDTH - 100,x + 1)
    end
end
function love.draw()
    push:start()
    love.graphics.draw(background,0,0)
    love.graphics.draw(ground,0,VIRTUAL_HEIGHT - 16)
    love.graphics.rectangle('fill',x,y,100,100)

    push:finish()
end