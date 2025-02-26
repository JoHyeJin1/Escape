local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	local text = display.newText("당신을 도울 세 친구! 총알 세 발이 당신을 안내할 것입니다.", display.contentWidth/2, display.contentHeight*0.45)
	
	-- paper
	local paper = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth/2, display.contentHeight*0.75)
	bg.x = display.contentCenterX
	bg.y = display.contentCenterY

	function title:tap( event )
 		composer.hideOverlay('horror_diag_livingroom_paper')
 	end
 	paper:addEventListener("tap", paper)

 	sceneGroup:insert(paper)
 	sceneGroup:insert(text)
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