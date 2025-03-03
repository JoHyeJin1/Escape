-----------------------------------------------------------------------------------------
--
-- bedroom_puzzle.lua
-- 게임이 진행되는 화면 입니다.
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	audio.pause(backgroundMusicChannel)
	backgroundMusic = audio.loadStream("music/bgm/minigame.mp3")
	backgroundMusicChannel = audio.play(backgroundMusic, {loops = -1})
	audio.setVolume(0.3) ----------볼륨 0~1	

	local background = display.newImageRect("image/bedroom/bedroom_puzzle_bg.png", display.contentWidth, display.contentHeight)
 	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	local frame_image = display.newImage("image/bedroom/클릭 부분/frame_falled.png")
	frame_image.x, frame_image.y = display.contentWidth*0.5, display.contentHeight*0.159

	local lamp_image = display.newImage("image/bedroom/클릭 부분/lamp_falled.png")
	lamp_image.x, lamp_image.y = display.contentWidth*0.84, display.contentHeight*0.44

	local pillow_image = display.newImage("image/bedroom/클릭 부분/pillow_falled.png")
	pillow_image.x, pillow_image.y = display.contentWidth*0.2, display.contentHeight*0.93


	local time = display.newText( 10, display.contentWidth*0.9, display.contentHeight*0.15)
	time.size = 100
	time:setFillColor(0)


	-- 램프 클릭해서 대칭맞추기
	local lampState = "failed"

	local function onTouch(event)
		if event.phase == "ended" then
			if lampState == "failed" then 
				lamp_image:removeSelf()
				lamp_image = display.newImage("image/bedroom/클릭 부분/lamp_completed.png")
				lamp_image.x, lamp_image.y = display.contentWidth*0.82, display.contentHeight*0.4
				sceneGroup:insert(lamp_image)
				lampState = "completed"
			elseif lampState == "completed" then
				lamp_image:removeSelf()
				lamp_image = display.newImage("image/bedroom/클릭 부분/lamp_falled.png")
				lamp_image.x, lamp_image.y = display.contentWidth*0.84, display.contentHeight*0.44
				sceneGroup:insert(lamp_image)
				lampState = "failed"
			end
			lamp_image:addEventListener("touch", onTouch)
	  	end
	end
	lamp_image:addEventListener("touch", onTouch)

	-- 액자자 클릭해서 대칭맞추기
	local frameState = "failed"

	local function onTouch(event)
		if event.phase == "ended" then
			if frameState == "failed" then 
				frame_image:removeSelf()
				frame_image = display.newImage("image/bedroom/클릭 부분/frame_completed.png")
				frame_image.x, frame_image.y = display.contentWidth*0.5, display.contentHeight*0.159
				sceneGroup:insert(frame_image)
				frameState = "completed"
			elseif frameState == "completed" then
				frame_image:removeSelf()
				frame_image = display.newImage("image/bedroom/클릭 부분/frame_falled.png")
				frame_image.x, frame_image.y = display.contentWidth*0.5, display.contentHeight*0.159
				sceneGroup:insert(frame_image)
				frameState = "failed"
			end
			frame_image:addEventListener("touch", onTouch)
	  	end
	end
	frame_image:addEventListener("touch", onTouch)

	-- 배개 클릭해서 대칭맞추기
	local pillowState = "failed"

	-- 배게 드래그 코드
	
	local function dragpillow( event )
		if (event.phase == "began") then
			display.getCurrentStage():setFocus(event.target)
			event.target.isFocus = true
		elseif(event.phase == "moved")then
			if(event.target.isFocus)then 
				event.target.x = event.xStart + event.xDelta
				event.target.y = event.yStart + event.yDelta
			end
		elseif(event.phase == "ended" or event.phase =="cancelled") then
			if(event.target.isFocus) then
				display.getCurrentStage():setFocus(nil)
				event.target.isFocus = false
				-- 배개 위치
				local tolerance = 20
				if math.abs(pillow_image.x - display.contentWidth*0.6) <= tolerance and math.abs(pillow_image.y - display.contentHeight*0.45) <= tolerance then 
					pillowState = "completed"
				end
			end
		end
	end

	pillow_image:addEventListener("touch", dragpillow)

	-- 타이머 10초 설정
	local function counter(event)
		time.text = time.text -1

		if (time.text == '5')then
			time:setFillColor(1,0,0)
		end

		if(time.text =='-1')then
			time.alpha = 0
			if lampState ~= "completed" or frameState ~= "completed" or pillowState ~= "completed" then 
				    -- 게임 실행시 카운트
					 local gameCount = composer.getVariable( "gameCount" ) or 0
					 gameCount = gameCount + 1
					 composer.setVariable( "gameCount", gameCount )
				
					 print("게임 실행 횟수 : "..gameCount)
				composer.gotoScene('bedroom_wrong')
			else
				    -- 게임 실행시 카운트
					 local gameCount = composer.getVariable( "gameCount" ) or 0
					 gameCount = gameCount + 1
					 composer.setVariable( "gameCount", gameCount )
				
					 print("게임 실행 횟수 : "..gameCount)
				composer.gotoScene( 'bedroom_completed')
			end
		end
	end

	timeAttack = timer.performWithDelay(1000, counter, 11)
	
	--- 레이어 정리
	sceneGroup:insert(background)
   sceneGroup:insert(time)
   sceneGroup:insert(lamp_image)
   sceneGroup:insert(frame_image)
   sceneGroup:insert(pillow_image)
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

		composer.removeScene('bedroom_puzzle')
		timer.cancel(timeAttack)
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