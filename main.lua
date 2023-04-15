push = require 'push'
-- https://www.chosic.com/free-music/games/
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 700

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200


function love.load()
    -- love.window.setMode(WINDOW_WIDTH,WINDOW_HEIGHT,{
    --     fullscreen = false,
    --     resizable = false;
    --     vsync = true
    -- })
    love.graphics.setDefaultFilter('nearest','nearest')
    smallFont = love.graphics.newFont('font.ttf', 8)
    scoreFont = love.graphics.newFont('font.ttf', 32)
    push:setupScreen(VIRTUAL_WIDTH,VIRTUAL_HEIGHT,WINDOW_WIDTH,WINDOW_HEIGHT,{
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    player1Score = 0
    player2Score = 0

    player1Y = 30
    player2Y = VIRTUAL_HEIGHT - 50

    fontPos = 10
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.draw()
    push:apply('start')

    love.graphics.clear(40/255, 45/255, 52/255, 255/255)

    love.graphics.setFont(smallFont)
    love.graphics.printf("hello pong!",0,20,VIRTUAL_WIDTH,'center')

    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(player1Score),VIRTUAL_WIDTH/2 - 50,VIRTUAL_HEIGHT/3)
    love.graphics.print(tostring(player2Score),VIRTUAL_WIDTH/2 + 30,VIRTUAL_HEIGHT/3)
    
    love.graphics.rectangle('fill',10,30,5,20)
    love.graphics.rectangle('fill',VIRTUAL_WIDTH-10,VIRTUAL_HEIGHT-50,5,20)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH/2-2, VIRTUAL_HEIGHT/2-2, 4, 4)
    -- love.graphics.printf(
    --     'Hello Pong!',
    --     0,
    --     VIRTUAL_HEIGHT/2 - 6,
    --     VIRTUAL_WIDTH,
    --     'center'
    -- )
    if love.keyboard.isDown('w') then
        love.graphics.print("W",VIRTUAL_WIDTH/2,fontPos)
        fontPos = fontPos + 10
    end
    push:apply('end')
end