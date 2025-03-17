-----------------------------------------------------------------------------------------
--
-- game.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local ui = require("ui")                --ui.lua 파일 불러오기기

local scene = composer.newScene()

-- 미니게임 성공 시 대화&총알 업데이트 함수
function onMiniGameSuccess()
    ui.updateDialogueText(dialogueText, "미니게임 성공! 총알을 획득했습니다.")
    ui.updateBullets(bullets) -- 총알 UI 업데이트
end
-- 실패 시 대화 업데이트 함수
function onMiniGameFailure()
    ui.updateDialogueText(dialogueText, "미니게임 실패! 총알을 얻지 못했습니다.")
    ui.updateDialogueBoxImage(dialogueBox, "image/UI/dialogue/dialogue_default.png")
end

-- 대화창 클릭 이벤트 리스너
local function onDialogueBoxTap(event)
    if event.phase == "ended" then    
        onMiniGameSuccess()
    end
    return true  -- 이벤트 전파 방지
end

function scene:create(event)
    local sceneGroup = self.view
    

    -- #1 회사 씬으로 이동 ---------------------------------------------------------------------------------
    timer.performWithDelay(10, function()
    	composer.removeScene("game")
        composer.gotoScene("company_scene")
    end)

    -- 대화창 & 텍스트 생성
    dialogueBox, dialogueText = ui.createDialogueBox(sceneGroup)

    -- 목숨(총알) 생성
    bulletGroup, bullets = ui.createBullets(sceneGroup)
    sceneGroup:insert(bulletGroup)

    -- 첫 번째 대화 표시
    ui.updateDialogueText(dialogueText, "게임을 시작합니다!")
    
    
    
    -- 대화창에 터치 이벤트 리스너 연결결
    dialogueBox:addEventListener("touch", onDialogueBoxTap)

    -- 이것저것. 스토리 진행 & 미니 게임들진행 --
	
-- 여기까지 정상 작동 ---------------------------------------------------------------------------------
-- 여기부턴 큰 틀만 작성성

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
