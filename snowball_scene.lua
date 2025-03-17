-----------------------------------------------------------------------------------------
--
-- snowball_scene.lua
--
-----------------------------------------------------------------------------------------

--------------타이핑 소리 없애기----------
audio.stop(explosionChannel)

local composer = require( "composer" )
local ui = require("ui")                --ui.lua 파일 불러오기기

local scene = composer.newScene()
local fadeRect

-- bgm
explosionSound = audio.loadSound("music/effect/Keyboard Typing Fast.wav")
explosionChannel = audio.play(explosionSound, {loops=0})
audio.setVolume(0.5, {channel = explosionChannel})

-- 깜빡임 효과 함수
local function blinkEffect()
    transition.to(fadeRect, { time = 1000, alpha = 0.7, onComplete = function()
        transition.to(fadeRect, { time = 800, alpha = 0 })
    end })
end

-- 깜박이고 암전되는 함수
local function fadeToBlack()
    -- 첫 번째 깜빡임 실행
    blinkEffect()

    -- 2초 후 두 번째 깜빡임 실행
    timer.performWithDelay(2000, function()
        blinkEffect()
        audio.stop(explosionChannel)

        -- 두 번째 깜빡임이 끝난 후 암전 효과 실행 (1.8초 후)
        timer.performWithDelay(1800, function()
            transition.to(fadeRect, { time = 2000, alpha = 1, onComplete = function()
                -- 암전이 끝난 후 1.8초 유지 후 씬 전환
                timer.performWithDelay(1800, function()
                    composer.gotoScene("diag_livingroom") -- 원하는 씬으로 변경
                    composer.removeScene("snowball_scene")
                end)
            end })
        end)
    end)
end

function scene:create( event )
	local sceneGroup = self.view
    local no_more_text = 0             -- 대사 넘기려고 flag 변수수
    
    local function setBackground(imagePath)
        if bg then
            bg:removeSelf()  -- 기존 배경 삭제
            bg = nil
        end
        bg = display.newImage(imagePath)
        bg.x, bg.y = display.contentWidth/2, display.contentHeight/2
        sceneGroup:insert(bg)
        bg:toBack()
    end
	
    setBackground("image/cutscene/cutscene_1.png")
    sceneGroup:insert(bg)
    
    local dialogueBox, dialogueText = ui.createDialogueBox(sceneGroup)      --createDialogueBox 함수에 이미 씬그룹 인서트 있어서 여기에 둠
    ui.updateDialogueText(dialogueText, "이주임님이 여행 다녀왔다고 이 스노우볼 돌렸지... ")
    
    -- 깜빡임 효과를 위한 Rect
    fadeRect = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    fadeRect:setFillColor(0, 0, 0)
    fadeRect.alpha = 0
    sceneGroup:insert(fadeRect)    
    

    -- 스노우볼 흔들기
    timer.performWithDelay(500, function()
        setBackground("image/cutscene/cutscene_2.png")
 
        timer.performWithDelay(200, function()
            setBackground("image/cutscene/cutscene_3.png")            
        end)
    end)

    -- 1초 후 깜빡임 효과 시작
    timer.performWithDelay(1200, function()
        ui.updateDialogueText(dialogueText, "아... 나도 여행 가고 싶다...")

        fadeToBlack()
    end)


  --  2초 후 암전 시작
    timer.performWithDelay(2300, function()
        
        -- 암전 후 장면 전환

       -- fadeToBlack()  -- 화면을 서서히 어둡게 하고 씬 전환
    end)

end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then

    elseif phase == "did" then
		-- Called when the scene is now off screen
	end
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
