-----------------------------------------------------------------------------------------
--
-- BeforeBookGame.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local ui = require("ui")                --ui.lua 파일 불러오기기

-- sound effect ---------------------------------------------------------------------------------
local typingSound = audio.loadSound("music/effect/Keyboard Typing Fast.wav")
	
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	local bg = display.newImage("Image/study/study.png")
	bg.x, bg.y = display.contentWidth/2, display.contentHeight/2
	sceneGroup:insert(bg)

	-- 대화창 & 텍스트
    local dialogueBox, dialogueText = ui.createDialogueBox(sceneGroup)
    ui.updateDialogueText(dialogueText, "한 칸만 조금 다른게 들어있네. 살펴보자")

    -- 타이핑 효과음 n초 재생 ---------------------------------------------------------------------------------
	local typingChannel = audio.play(typingSound) 
    audio.setVolume(0.3, {channel = typingChannel}) -- 볼륨 30% 설정
	timer.performWithDelay(3000, function() 
	audio.stop(typingChannel) 
	end)
	
    -- 대화창 클릭 이벤트 리스너
	local function onDialogueBoxTap(event)
		if no_more_text == 1 then
			composer.gotoScene("bookGame")
		elseif event.phase == "ended" then    
			ui.updateDialogueText(dialogueText, "자세히 살펴보자.")
			-- 타이핑 효과음 n초 재생 ---------------------------------------------------------------------------------
			local typingChannel = audio.play(typingSound) 
			audio.setVolume(0.3, {channel = typingChannel}) -- 볼륨 30% 설정
			timer.performWithDelay(2000, function() 
				audio.stop(typingChannel) 
			end)
			no_more_text = 1
		end
		return true  -- 이벤트 전파 방지
	end
    
    dialogueBox:addEventListener("touch", onDialogueBoxTap)
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
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
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
