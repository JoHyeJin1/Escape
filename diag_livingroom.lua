local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
	-- BACKGROUND
	local bg = {}
	
	local dialogueBox = display.newImage("image/dialogue_default.png")
    dialogueBox.x = display.contentCenterX  
    dialogueBox.y = display.contentHeight - 130
    dialogueBox:scale(1, 0.65)


	-- DIALOG
	local dialog = display.newGroup()

	local content = display.newText({
         text = "", 
        x = display.contentWidth * 0.5 + 15, 
        y = display.contentHeight - 105,
        width = display.contentWidth - 120,
        height = 200,
        fontSize = 40,
        align = "left"
    })
	content:setFillColor(1)
	content.size = 30

	-- BGM
	local bgm = {}


	-- #5 산장 거실 (낮)
	local Data = jsonParse("json/diag_livingroom.json")
	if(Data) then
		print(Data[1].dialogue)
	end

	-- json에서 읽은 정보 적용하기
	local index = 0

	local function nextScript( event )
		index = index + 1

		if (index > #Data) then
			composer.gotoScene("diag_table")
			composer.removeScene("diag_livingroom")
			return
		end

		content.text = Data[index].dialogue

	end
	dialogueBox:addEventListener("tap", nextScript)
	

	sceneGroup:insert(dialogueBox)
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
		--composer.removeScene("dialogue")
	
	elseif phase == "did" then
		-- Called when the scene is now off screen
	
	end
end

function scene:destroy( event )
	local sceneGroup = self.view
	composer.gotoScene("diag_table")
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
