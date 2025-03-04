-------------------------------------------------------------------------------------------
--
-- Book.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

local timeAttack

function scene:create( event )
	local sceneGroup = self.view

	audio.pause(backgroundMusicChannel)
	backgroundMusic = audio.loadStream("music/bgm/minigame.mp3")
	backgroundMusicChannel = audio.play(backgroundMusic, {loops = -1})
	audio.setVolume(0.3) ----------볼륨 0~1	

	local bg = display.newImage("image/study/study_bg.png")
	bg.x, bg.y = display.contentWidth/2, display.contentHeight/2

	local random = {}
	local arr = {1,2,3,4,5}
	for i = 5, 2, -1 do
    	local j = math.random(i)  -- 1부터 i 사이의 랜덤한 인덱스 선택
    	arr[i], arr[j] = arr[j], arr[i]  -- 두 요소의 위치 교환
	end

	local bookGroup = display.newGroup()
	
	local book = {}
	book[1] = display.newImage("image/study/5pcs_236px/piece_1.png")
	book[2] = display.newImage("image/study/5pcs_236px/piece_2.png")
	book[3] = display.newImage("image/study/5pcs_236px/piece_3.png")
	book[4] = display.newImage("image/study/5pcs_236px/piece_4.png")
	book[5] = display.newImage("image/study/5pcs_236px/piece_5.png")

	for i = 1, #book do
		bookGroup:insert(book[i])
   end

	for i=1,5 do
		if(arr[i] == 1) then
			book[i].x = display.contentWidth/2-470
		elseif(arr[i] == 2) then
			book[i].x = display.contentWidth/2-235
		elseif(arr[i] == 3) then
			book[i].x = display.contentWidth/2
		elseif(arr[i] == 4) then
			book[i].x = display.contentWidth/2+235
		elseif(arr[i] == 5) then
			book[i].x = display.contentWidth/2+470
		end
		book[i].y = display.contentHeight/2+80
	end

	local time = display.newText(10, display.contentWidth * 0.9, display.contentHeight * 0.15)
	time.size = 100
	time:setFillColor(0)

---------책을 탭하면 올라가고, 다시 탭하면 내려가게끔-------------
	local function tapBook(event)

		if(book[1].x-50 < event.target.x and event.target.x < book[1].x+50) then
			if(book[1].y == display.contentHeight/2+30) then
				book[1].y = book[1].y + 50
			else
				book[1].y = book[1].y - 50
			end
		end

		if(book[2].x-50 < event.target.x and event.target.x < book[2].x+50) then
			if(book[2].y == display.contentHeight/2+30) then
				book[2].y = book[2].y + 50
			else
				book[2].y = book[2].y - 50
			end
		end

		if(book[3].x-50 < event.target.x and event.target.x < book[3].x+50) then
			if(book[3].y == display.contentHeight/2+30) then
				book[3].y = book[3].y + 50
			else
				book[3].y = book[3].y - 50
			end
		end

		if(book[4].x-50 < event.target.x and event.target.x < book[4].x+50) then
			if(book[4].y == display.contentHeight/2+30) then
				book[4].y = book[4].y + 50
			else
				book[4].y = book[4].y - 50
			end
		end

		if(book[5].x-50 < event.target.x and event.target.x < book[5].x+50) then
			if(book[5].y == display.contentHeight/2+30) then
				book[5].y = book[5].y + 50
			else
				book[5].y = book[5].y - 50
			end
		end
	end

	local function switchBook(event)
		local temp = 0
		for i=1,4 do
			for j=i+1,5 do
				if(book[i].y == display.contentHeight/2+30 and book[j].y == display.contentHeight/2+30) then
					temp = book[i].x
					book[i].x = book[j].x
					book[j].x = temp
					book[i].y = display.contentHeight/2+80
					book[j].y = display.contentHeight/2+80
				end
			end
		end
	end

	local function check(event)
	local score = 0
		if(display.contentWidth/2-470 == book[1].x) then
			score = score + 1
		end

		if(display.contentWidth/2-235 == book[2].x) then
			score = score + 1
		end

		if(display.contentWidth/2 == book[3].x) then
			score = score + 1
		end

		if(display.contentWidth/2+235 == book[4].x) then
			score = score + 1
		end

		if(display.contentWidth/2+470 == book[5].x) then
			score = score + 1
		end

		-- 성공 시 처리
	if score == 5 then
		    -- 게임 실행시 카운트
			 local gameCount = composer.getVariable( "gameCount" ) or 0
			 gameCount = gameCount + 1
			 composer.setVariable( "gameCount", gameCount )
		
			 print("게임 실행 횟수 : "..gameCount)
		-- 모든 이벤트 제거
		for i = 1, 5 do
			book[i]:removeEventListener("tap", tapBook)
			book[i]:removeEventListener("tap", switchBook)
			book[i]:removeEventListener("tap", check)
		end

		-- bookGroup 내 모든 책 제거
		if bookGroup then
			bookGroup:removeSelf()
			bookGroup = nil
		end

		-- 타이머 중지 (실패 씬으로 이동 방지)
		if timeAttack then
			timer.cancel(timeAttack)
			timeAttack = nil
		end

		-- 성공 이미지 표시
		local complete = display.newImage("image/study/study_puzzle_completed_no_eyes.png")
		complete.x, complete.y = display.contentWidth/2, display.contentHeight/2+80

		

		-- 성공 횟수 증가
		local success = composer.getVariable("success") or 0
		success = success + 1
		composer.setVariable("success", success)
		print("성공횟수 : " .. success)

		-- 3초 후 눈 이미지 표시 후 다음 씬 이동
		timer.performWithDelay(3000, function()
			local eye = display.newImage("image/study/study_puzzle_completed.png")
			eye.x = display.contentWidth/2
			eye.y = display.contentHeight/2+80

			timer.performWithDelay(3000, function()
				local bullet = display.newImage("image/UI/bullets/bullets_empty.png")
				bullet.x, bullet.y = display.contentWidth * 0.5, display.contentHeight * 0.6

				local function onTouch(event)
					if event.phase == "ended" then
						bullet:removeSelf()
						bullet = display.newImage("image/UI/bullets/bullets_filled.png")
						bullet.x, bullet.y = display.contentWidth * 0.5, display.contentHeight * 0.6
					end

					--  1초 뒤 씬 이동
					timer.performWithDelay(1000, function()
						display.remove( eye )
						display.remove( complete )
						display.remove( bullet )
						composer.gotoScene("choice_minigame", { effect = "fade", time = 400 })
					end)
				end

				bullet:addEventListener("touch", onTouch)
			end)
		end)


			time.alpha = 0
		end
	end

	--------------------책 누를때 소리 mp3파일은 너무 짧아서 solar2D가 인식을 못해서 wav 파일로 변환해서 넣어두었습니다!
	local clickSound = audio.loadSound("music/effect/미니게임 클릭음(파이프, 책장).wav")
	local function playClickSound(event)
		if event.phase=="began" then
			audio.play(clickSound)
		end
		return true
	end

	for i=1,5 do
		book[i]:addEventListener("tap", tapBook) --책 선택하면 책이 조금 올라가게끔
		book[i]:addEventListener("tap", switchBook) --선택한 두 권 위치 바꾸기
		book[i]:addEventListener("tap", check) --5점 이상이면 게임 완료
		book[i]:addEventListener("touch", playClickSound)
	end

	------------------------타임어택 구현--------------------------
	local function counter(event)
		local currentTime = tonumber(time.text) or 0  -- 문자열을 숫자로 변환
  
		currentTime = currentTime - 1
		time.text = tostring(currentTime)  -- 다시 문자열로 변환 후 적용
  
		-- 5초 남았을 때 빨간색으로 변경
		if currentTime == 5 then
			 time:setFillColor(1, 0, 0)
		end
  
		-- 시간이 다 되면 처리
		if currentTime == -1 then
			 time.alpha = 0
			if check and check ~= 5 then
				    -- 게임 실행시 카운트
					 local gameCount = composer.getVariable( "gameCount" ) or 0
					 gameCount = gameCount + 1
					 composer.setVariable( "gameCount", gameCount )
				
					 print("게임 실행 횟수 : "..gameCount)
				-- 실패했을 경우 카운트
				local failCount = composer.getVariable("failCount") or 0
				composer.setVariable("failCount", failCount + 1)
            composer.gotoScene("game_wrong")
        	end
  
			 -- 책에서 이벤트 제거
			 for i = 1, 5 do
				  if book[i] then
						book[i]:removeEventListener("tap", tapBook)
						book[i]:removeEventListener("tap", switchBook)
						book[i]:removeEventListener("tap", check)
				  end
			 end
		end
  end
  
  -- 타이머 실행 (초기값 포함 12번 실행)
  timeAttack = timer.performWithDelay(1000, counter, 12)
  sceneGroup:insert(bg)
  sceneGroup:insert(bookGroup)

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
		composer.removeScene( "bookGame" )
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
