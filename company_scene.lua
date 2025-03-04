-----------------------------------------------------------------------------------------
--
-- company_scene.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local ui = require("ui")                --ui.lua 파일 불러오기기

local scene = composer.newScene()


function scene:create( event )
	local sceneGroup = self.view

	explosionSound = audio.loadSound("music/effect/Keyboard Typing Fast.wav")
	explosionChannel = audio.play(explosionSound, {loops=-1})
	audio.setVolume(0.5, {channel = explosionChannel})
	
    -- BackGround
	local bg = display.newImage("image/cutscene/company.png")
    bg.x, bg.y = display.contentWidth/2, display.contentHeight/2
	sceneGroup:insert(bg)

    -- 대화창 & 텍스트
    local dialogueBox, dialogueText = ui.createDialogueBox(sceneGroup)
    ui.updateDialogueText(dialogueText, "지금 야근을 얼마나 하고 있는 거지...?")

    -- 대화창 클릭 이벤트 리스너
	local function onDialogueBoxTap(event)
		if no_more_text == 1 then
			composer.gotoScene("snowball_scene")
			composer.removeScene("company_scene")
		elseif event.phase == "ended" then    
			ui.updateDialogueText(dialogueText, "하... 집에 가고 싶다...")
			no_more_text = 1
		end
		return true  -- 이벤트 전파 방지
	end
    
    dialogueBox:addEventListener("touch", onDialogueBoxTap)

    --

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
