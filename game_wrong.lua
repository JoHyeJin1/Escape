-----------------------------------------------------------------------------------------
--
-- game_wrong.lua
-- 게임실패 했을 경우
-----------------------------------------------------------------------------------------

local composer = require("composer")
local scene = composer.newScene()


function scene:create(event)
	local sceneGroup = self.view

	-- 배경 이미지
	local background = display.newImageRect("image/bedroom/bedroom_wrong.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth / 2, display.contentHeight / 2

	-- 대화 박스 이미지
	local dialogueBox = display.newImage("image/UI/dialogue/dialogue_default.png")
	dialogueBox.x = display.contentCenterX  
    dialogueBox.y = display.contentHeight - 130
    dialogueBox:scale(1, 0.65)

	local failCount = composer.getVariable( "failCount" ) or 0

	-- 실패 횟수 텍스트
	local failText = display.newText({
		text = "실패 횟수: " .. failCount,
		x = display.contentWidth * 0.15,
		y = display.contentHeight * 0.9,
		fontSize = 30,
		align = "center"
	})
	failText:setFillColor(0, 0, 0)

	-- 첫 번째 대사 텍스트
	-- local content = display.newText({
	-- 	text = "",  -- 초기에는 빈 텍스트
	-- 	x = display.contentWidth / 2,
	-- 	y = display.contentHeight * 0.7,
	-- 	width = display.contentWidth - 40,
	-- 	height = 200,
	-- 	fontSize = 30,
	-- 	align = "center"
	-- })
	-- content:setFillColor(0,0,0)
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


    -- 대사 변경 함수
local index = 0
local function changeDialog()
    -- 기존 content 객체 제거
    if content then
        display.remove(content)
		  display.remove(failText)
    end

	if failCount == 1 then 
		if index < 3 then
			-- 새로운 대사 텍스트 생성	
			if index == 0 then
				 content = display.newText({
					  text = "그래도 아직 총알 두 개가 남아있으니까",
					  x = display.contentWidth / 2,
					  y = display.contentHeight * 0.8,
					  width = display.contentWidth - 40,
					  height = 200,
					  fontSize = 30,
					  align = "center"
				 })
				 content:setFillColor(0, 0, 0)
			elseif index == 1 then
				 content = display.newText({
					  text = "어서 다른 장소를 찾아보자.",
					  x = display.contentWidth / 2,
					  y = display.contentHeight * 0.8,
					  width = display.contentWidth - 40,
					  height = 200,
					  fontSize = 30,
					  align = "center"
				 })
				 content:setFillColor(0, 0, 0)
			end
			index = index + 1
			else
				-- 초기 게임 선택지로 돌아가기
				composer.gotoScene('choice_minigame', { effect = "fade", time = 400 })
	  		end
	elseif failCount == 2 then
		if index < 3 then
			-- 새로운 대사 텍스트 생성
			if index == 0 then
				 content = display.newText({
					  text = "윽…! 이게 무슨 소리지? 이상한 소리가 날 리가 없어! 여기서는 모두가 즐거우니까!",
					--   x = display.contentWidth / 2,
					--   y = display.contentHeight * 0.8,
					--   width = display.contentWidth - 40,
					--   height = 200,
					--   fontSize = 30,
					--   align = "center"
					x = display.contentWidth * 0.5 + 15, 
					y = display.contentHeight - 105,
					width = display.contentWidth - 120,
					height = 200,
					fontSize = 40,
					align = "left"
				 })
				content:setFillColor(1)
				content.size = 30
				 --content:setFillColor(0, 0, 0)
			elseif index == 1 then
				content = display.newText({
					text = "헉, 아니야! 이런 스산한 공간이 뭐가 즐겁다고!",
					-- x = display.contentWidth / 2,
					-- y = display.contentHeight * 0.8,
					-- width = display.contentWidth - 40,
					-- height = 200,
					-- fontSize = 30,
					-- align = "center"
					x = display.contentWidth * 0.5 + 15, 
					y = display.contentHeight - 105,
					width = display.contentWidth - 120,
					height = 200,
					fontSize = 40,
					align = "left"
			  })
			  content:setFillColor(1)
				content.size = 30
			  --content:setFillColor(0, 0, 0)
			elseif index == 2 then
				 content = display.newText({
					  text = "이 소리에 귀 기울이면 이상해지는 것 같아…. 집에 가는 것만 생각하자",
					--   x = display.contentWidth / 2,
					--   y = display.contentHeight * 0.8,
					--   width = display.contentWidth - 40,
					--   height = 200,
					--   fontSize = 30,
					--   align = "center"
					x = display.contentWidth * 0.5 + 15, 
					y = display.contentHeight - 105,
					width = display.contentWidth - 120,
					height = 200,
					fontSize = 40,
					align = "left"
				 })
				 content:setFillColor(1)
				content.size = 30
				 --content:setFillColor(0, 0, 0)
			end
			index = index + 1
	  else
		-- 초기 게임 선택지로 돌아가기
		composer.gotoScene('choice_minigame', { effect = "fade", time = 400 })
	  end
	else
		-- 배드엔딩으로 위치 변경
		composer.gotoScene('ending_Bad_diag', { effect = "fade", time = 400 })

		content = display.newText({
			text = "게임 끝났다 난 망했어",
			-- x = display.contentWidth / 2,
			-- y = display.contentHeight * 0.8,
			-- width = display.contentWidth - 40,
			-- height = 200,
			-- fontSize = 30,
			-- align = "center"
			x = display.contentWidth * 0.5 + 15, 
			y = display.contentHeight - 105,
			width = display.contentWidth - 120,
			height = 200,
			fontSize = 40,
			align = "left"
	  })
	  content:setFillColor(1)
	  content.size = 30
	  --content:setFillColor(0, 0, 0)

	end
end
    -- 터치하면 changeDialog() 실행
    dialogueBox:addEventListener("tap", changeDialog)

    -- 화면에 추가
    sceneGroup:insert(background)
    sceneGroup:insert(dialogueBox)
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
		composer.removeScene( "game_wrong" )
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