local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view
    -- 오디오 라이브러리
    local currentBGM = backgroundMusicChannel  -- 현재 재생 중인 BGM 저장 변수

    -- BGM 변경 함수
    local function changeBGM(newBGM)
        if currentBGM then
            audio.stop(backgroundMusicChannel)  -- 기존 BGM 정지
            audio.dispose(currentBGM)  -- 메모리 해제
            currentBGM = nil
        end

        if newBGM and newBGM ~= "" then
            currentBGM = audio.loadStream(newBGM)  -- 새 BGM 로드
            audio.play(currentBGM, { loops = -1 })  -- 무한 반복 재생
        end
    end
    -- BACKGROUND
    local bg = display.newImage("image/cutscene/cutscene_4.png")
    bg.x = display.contentCenterX
    bg.y = display.contentCenterY

    local dialogueBox = display.newImage("image/UI/dialogue/dialogue_default.png")
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

    -- JSON DATA
    local Data = jsonParse("json/after_diag_table.json")
    if (Data) then print(Data[1].dialogue) end

    local index = 0
    local horror = "change"
    local eat = "first"

    local choices = {}
    local buttons = {}

    local function removeChoices()
        for i = 1, 2 do
            if choices[i] then
                display.remove(choices[i])
                choices[i] = nil
            end
            if buttons[i] then
                display.remove(buttons[i])
                buttons[i] = nil
            end
        end
    end

    local function EatTapped()
        removeChoices()
		if bg then
			display.remove(bg)  -- 기존 배경 제거
		end
		bg = display.newImage("Image/cutscene/cutscene_7.png")  -- 새로운 배경 생성
		bg.x = display.contentCenterX  -- 배경의 x 좌표 설정
		bg.y = display.contentCenterY  -- 배경의 y 좌표 설정
		bg:toBack()  -- 배경을 뒤로 보이게 설정
	    content.text = "이건 칠면조 다리가 아니잖아 이건, \n이건............!"
		
		timer.performWithDelay(1800, function()
            composer.removeScene("after_diag_table")
			composer.gotoScene("diag_outside")
		end)	

    timer.performWithDelay(2000, function()
        -- 기존 bg가 있으면 삭제
        if bg then
            bg:removeSelf()
            bg = nil
        end

        -- 새로운 배경 생성
        bg = display.newImage("Image/cutscene/black.png")
        bg.x = display.contentCenterX  -- 배경의 x 좌표 설정
        bg.y = display.contentCenterY  -- 배경의 y 좌표 설정
        bg:toBack()  -- 배경을 뒤로 보이게 설정
    end)

    ---------------------칠면조 다리 아닌 것 알았을 때, bgm---------------
    if content.text == "이건 칠면조 다리가 아니잖아 이건, \n이건............!" then
        explosionSound = audio.loadSound("music/effect/칠면조 먹는 소리(길어서 잘라야 돼요!).wav")
        explosionChannel = audio.play(explosionSound, {loops=-1})
        audio.setVolume(0.1, {channel = explosionChannel})
        changeBGM("music/bgm/scene8-9.mp3")
    end

    end

    local function NotEatTapped(event)
        if choices[2] and event.target == choices[2] then
            choices[2].text = "먹는다."
            eat = "second"
            choices[2]:removeEventListener("tap", NotEatTapped)
            choices[2]:addEventListener("tap", EatTapped)
        end
    end

    function nextScript()
        index = index + 1
        if (index > #Data) then
            composer.removeScene("after_diag_table")
            composer.gotoScene("diag_outside")
            return
        end

        if (Data[index].eat == eat) then
            dialogueBox:removeEventListener("tap", nextScript)
            choices[1] = display.newText("먹는다.", display.contentCenterX * 1.15, display.contentCenterY + 180, 300, 50)
            choices[2] = display.newText("먹지 않는다.", display.contentCenterX * 1.15, display.contentCenterY + 230, 300, 50)
            for i = 1, 2 do
                choices[i]:setFillColor(1)
                choices[i].size = 30
            end

            buttons[1] = display.newRect(display.contentCenterX * 1.05 - 22, display.contentCenterY + 175, 165, 45)
            buttons[1]:setFillColor(0)
            buttons[1].alpha = 0.5
            buttons[2] = display.newRect(display.contentCenterX * 1.05 - 22, display.contentCenterY + 225, 165, 45)
            buttons[2]:setFillColor(0)
            buttons[2].alpha = 0.5

            choices[1]:addEventListener("tap", EatTapped)
            choices[2]:addEventListener("tap", NotEatTapped)
        elseif (eat == "second") then
            removeChoices()
        end

        content.text = Data[index].dialogue or ""
    end

    dialogueBox:addEventListener("tap", nextScript)

    sceneGroup:insert(bg)
    sceneGroup:insert(dialogueBox)
    sceneGroup:insert(dialog)
    sceneGroup:insert(content)
end

function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase
    if phase == "did" then
        -- Scene is now on screen
    end
end

function scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase
    if phase == "did" then
        -- Scene is now off screen
    end
end

function scene:destroy(event)
    composer.gotoScene("diag_outside")
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene