-----------------------------------------------------------------------------------------
--
-- bedroom_completed.lua
-- bedroom_puzzle 에서 게임을 성공했을 경우 이동 화면
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local ui = require("ui")
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local background = display.newImageRect("image/bedroom/bedroom_completed.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	local textBg = display.newRect(display.contentWidth/2, display.contentHeight*0.41, 500, 120 )
	textBg:setFillColor(0, 0, 0)

	local completedText = display.newText( "completed", display.contentWidth/2, display.contentHeight*0.4)
	completedText.size = 100
	completedText:setFillColor(1,0,0)
	

	local bullet_image
	
	timer.performWithDelay( 3000, function()
		completedText:removeSelf()
		completedText = nil
		
		textBg:removeSelf()
		textBg = nil

		bullet_image = display.newImage("image/UI/bullets/bullets_empty.png")
		bullet_image.x, bullet_image.y = display.contentWidth*0.5, display.contentHeight*0.6
		sceneGroup:insert(bullet_image)

	-- 총알 이미지 클릭해서 획득
	local function onTouch( event )
		if event.phase == "ended" then 
			bullet_image:removeSelf()
			bullet_image = display.newImage("image/UI/bullets/bullets_filled.png")
			bullet_image.x, bullet_image.y = display.contentWidth*0.5, display.contentHeight*0.6
			sceneGroup:insert(bullet_image)
		end
	end

	bullet_image:addEventListener("touch", onTouch)

	end)

	local function onMiniGameSuccess()
		ui.updateDialogueText(dialogueText, "미니게임 성공! 총알을 획득했습니다.")
		ui.updateBullets(bullets) -- 총알 UI 업데이트
   end

	local bulletGroup, bullets = ui.createBullets(sceneGroup)
   
   
	
	sceneGroup:insert(background)
	sceneGroup:insert(textBg)
	sceneGroup:insert(completedText)
	sceneGroup:insert(bulletGroup)

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