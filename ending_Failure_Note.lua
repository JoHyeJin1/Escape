local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	audio.pause(backgroundMusicChannel)
	backgroundMusic = audio.loadStream("music/bgm/scene10_11.mp3")
	backgroundMusicChannel = audio.play(backgroundMusic, {loops=-1})
	explosionSound = audio.loadSound("music/effect/미니게임실패환청(짧아서 반복 필요).wav")
	explosionChannel = audio.play(explosionSound, {loops=-1})
	audio.setVolume(0.1, {channel=explosionChannel})
	
	-- BACKGROUND
	local bg = display.newImage("Image/cutscene/black.png")
	bg.x = display.contentCenterX
	bg.y = display.contentCenterY
	
	-- local dialogueBox = display.newImage("Image/UI/dialogue/dialogue_blood.png")
    -- dialogueBox.x = display.contentCenterX  
    -- dialogueBox.y = display.contentHeight - 130
    -- dialogueBox:scale(1, 0.65)


	-- DIALOG
	local dialog = display.newGroup()

	local content = display.newText({
        text = "", 
        x = display.contentWidth * 0.5 + 15, 
        y = display.contentHeight - 200,
        width = display.contentWidth - 120,
        height = 200,
        fontSize = 35,
        align = "center"
    })
	content:setFillColor(1,0,0)
	content.size = 30
	content.alpha = 0.7


	-- 
	local Data = jsonParse("json/ending_Failure_Note.json")
	if(Data) then
		print(Data[1].dialogue)
	end

	-- json에서 읽은 정보 적용하기
	local index = 0

	local function nextScript( event )
		index = index + 1

		if (index > #Data) then
			composer.gotoScene("ending_Failure_diag")
			--composer.removeScene("diag_table")
			return
		end

		bg.fill = {
			type = "image",
			filename = Data[index].bg
		}
		content.text = Data[index].text
	end
	
	bg:addEventListener("tap", nextScript)


	sceneGroup:insert(bg)
	--sceneGroup:insert(dialogueBox)
	sceneGroup:insert(dialog)
	sceneGroup:insert(content)
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
		--composer.removeScene("intro")
	end
end

function scene:destroy( event )
	local sceneGroup = self.view

	composer.gotoScene("horror_diag_livingroom")
	
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