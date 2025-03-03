-----------------------------------------------------------------------------------------
--
-- view1.lua 였던 start
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	----------------bgm-----------------------------
	backgroundMusic = audio.loadStream("music/bgm/scene1-3.mp3")
	backgroundMusicChannel = audio.play(backgroundMusic, {loops = -1})
	audio.setVolume(0.1) ----------볼륨 0~1

	-----------앱 종료시 오디오 리소스 해제
	local function onAppExit()
		audio.stop(backgroundMusicChannel)
		audio.dispose(backgroundMusic)
		backgroundMusic = nil
	end

	--------시스템 이벤트 리스너 추가 (앱 종료 시 해제)
	Runtime:addEventListener("system", function(event)
   	 if event.type == "applicationExit" then
      	  onAppExit()
    	end
	end)
	--BackGround
	local bg = {}
	bg[1] = display.newImage("image/UI/main title/title_bg.png")
	bg[1].x, bg[1].y = display.contentWidth/2, display.contentHeight/2
	
	bg[2] = display.newImage("image/UI/main title/logo.png")
	bg[2].x, bg[2].y = display.contentWidth/2, display.contentHeight/2-60

	bg[3] = display.newImage("image/UI/main title/start_btn.png")
	bg[3].x, bg[3].y = display.contentWidth/2, display.contentHeight/2+160

	bg[4] = display.newImage("image/UI/main title/end_btn.png")
	bg[4].x, bg[4].y = display.contentWidth/2, display.contentHeight/2+240

	-- Event Listener
	local function onStartButtonTapped( event )
		composer.gotoScene("game")		-- 시작하기 버튼 클릭 시 game 씬(임시)으로
	end

	local function onEndButtonTapped( event )
		audio.pause(backgroundMusicChannel)
		composer.gotoScene("quit")		-- 나가기 버튼 클릭 시 quit 씬(임시시)으로
	end

	bg[3]:addEventListener("tap", onStartButtonTapped)
	bg[4]:addEventListener("tap", onEndButtonTapped)

    -- sceneGroup에 모든 객체 추가
	sceneGroup:insert(bg[1])
	sceneGroup:insert(bg[2])
	sceneGroup:insert(bg[3])
	sceneGroup:insert(bg[4])

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