local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
	-- BACKGROUND
	local bg = display.newImage("image/cutscene_4.png")
	bg.x = display.contentCenterX
	bg.y = display.contentCenterY
	
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


	-- #6 산장 식탁 앞
	local Data = jsonParse("json/diag_table.json")
	if(Data) then
		print(Data[1].dialogue)
	end

	-- json에서 읽은 정보 적용하기
	local index = 0
	local horror = "change"

	local function nextScript( event )
		index = index + 1

		if (index > #Data) then
			composer.gotoScene("diag_outside")
			composer.removeScene("diag_table")
			return
		end

		if (Data[index].scene == horror) then

    		bg = display.newImage("image/cutscene_5.png")
			bg.x = display.contentCenterX
			bg.y = display.contentCenterY

			content.text = Data[index].dialogue

			sceneGroup:insert(bg)
			sceneGroup:insert(dialogueBox)
			sceneGroup:insert(content)
		else
			content.text = Data[index].dialogue
		end

	end
	
	dialogueBox:addEventListener("tap", nextScript)

	------ 먹는다 / 안먹는다 버튼 활성화 하기

	-- local btn = {}

	-- for i = 1, 3 do
	-- 	btn[i] = display.newImage("image/button0"..i..".png")
	-- 	btn[i]:scale(1.5, 1.5)
	-- 	btn[i].x, btn[i].y = display.contentWidth*0.2+i*200, display.contentHeight*0.6

	-- 	btn[i].title = display.newText("", btn[i].x, btn[i].y + 100)
	-- 	btn[i].title:setFillColor(0)
	-- 	btn[i].title.size = 40
	-- end

	-- btn[1].title.text = "파크 소개"
	-- btn[2].title.text = "컨셉 소개"
	-- btn[3].title.text = "캐릭터 소개"

	-- btn[1].scene = "intro"
	-- btn[2].scene = "concept"
	-- btn[3].scene = "character_info"

	-- -- EVENT
	-- function btnTap( event )
	-- 	composer.gotoScene(event.target.scene)
	-- end

	-- for i = 1, 3 do
	-- 	btn[i]:addEventListener("tap", btnTap)
	-- end

	-- -- 정렬
	-- for i = 1, 3 do 
	-- 	sceneGroup:insert(bg[i])
	-- end

	-- for i = 1, 3 do 
	-- 	sceneGroup:insert(btn[i])
	-- 	sceneGroup:insert(btn[i].title)
	-- end




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
	
	composer.gotoScene("diag_outside")
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
