local composer = require( "composer" )
local scene = composer.newScene()

local choice = {}			-- scene hide 에서도 쓸 거라 전역 선언

function scene:create( event )
	local sceneGroup = self.view
	local explosionSound = audio.loadSound("music/effect/GunShots.wav")
	audio.play(explosionSound)
	
	-- BACKGROUND
	local bg = display.newImage("Image/cutscene/black.png")
	bg.x = display.contentCenterX
	bg.y = display.contentCenterY
	
	local dialogueBox = display.newImage("Image/UI/dialogue/dialogue_blood.png")
    dialogueBox.x = display.contentCenterX  
    dialogueBox.y = display.contentHeight - 130
    dialogueBox:scale(1, 0.65)
	dialogueBox.isHitTestable = true 			-- 기본적으로 터치 이벤트를 받을 수 있도록 설정

	-- DIALOG Text
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


	
	-- json에서 대사 데이터 불러오기  	 #10 - #11 산장 밖
	
	local Data = jsonParse("json/horror_diag_livingroom.json")

	if(Data) then
		print(Data[1].dialogue)
	end
	
	local index = 0

	local function nextScript( event )
		
		index = index + 1
		if (index > 3) then
			composer.gotoScene("horror_diag_livingroom_paper")
			return
		end
		bg.fill = {
			type = "image",
			filename = Data[index].bg
		}
		content.text = Data[index].dialogue
	end

	dialogueBox:addEventListener("tap", nextScript)

	sceneGroup:insert(bg)
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

	elseif phase == "did" then
		-- Called when the scene is now off screen
		--composer.removeScene("intro")
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