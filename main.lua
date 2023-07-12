-- Débogueur Visual Studio Code tomblind.local-lua-debugger-vscode
if pcall(require, "lldebugger") then
    require("lldebugger").start()
end

-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf("no")

-- stream = charger au fur et mesure, static = charger en totalite
sndJump = love.audio.newSource("sons/sfx_movement_jump13.wav", "static")
musicCool = love.audio.newSource("sons/cool.mp3", "stream")
musicTechno = love.audio.newSource("sons/techno.mp3", "stream")

-- loop le son
--sndJump:setLooping(true)
musicCool:setLooping(true)

--change l octave du son en le ralentissant ou augmentant la vitesse
--sndJump:setPitch(0.5)
--sndJump:setPitch(2)

screenWidht = love.graphics.getWidth()
screenHeight = love.graphics.getHeight()
midScreen = {}
midScreen.x = screenWidht / 2
midScreen.Y = screenHeight / 2

hero = {}
hero.x = 50
hero.y = screenHeight - 100
hero.movespeed = 5
hero.image = love.graphics.newImage("images/FR_Adventurer_Run_003.png")

function love.load()
end

function love.update(dt)
    oldHeroY = hero.y
    if love.keyboard.isDown("right") then
        hero.x = hero.x + hero.movespeed
    elseif love.keyboard.isDown("left") then
        hero.x = hero.x - hero.movespeed
    end

    if hero.x < midScreen.x then
        musicCool:play()
        musicTechno:stop()
    else
        musicCool:stop()
        musicTechno:play()
    end
end

function love.draw()
    love.graphics.draw(hero.image, hero.x, hero.y)
    love.graphics.line(midScreen.x, 0, midScreen.x, screenHeight)
end

function love.keypressed(key)
    if key == "space" then
        sndJump:play()
    end
    -- stop = arrete la music pause = fait une pause pour reprendre avec resume
    if key == "s" then
        musicCool:stop()
    end
    if key == "r" then
        musicCool:play()
    end
    if key == "p" then
        musicCool:pause()
    end
end
