local composer = require("composer")
local ui = require("ui")                --ui.lua 파일 불러오기기

local scene = composer.newScene()

-- 전역 선택지 테이블 선언
scene.choice = {}

-- 선택한 버튼을 저장할 변수 불러오기 (없으면 빈 테이블)
local disabledChoices = composer.getVariable("disabledChoices") or {}

function scene:create(event)
    local sceneGroup = self.view

    -- 배경 이미지 추가
    local bg = display.newImage("Image/cutscene/revolver_frame.png")
    bg.x = display.contentCenterX
    bg.y = display.contentCenterY
    sceneGroup:insert(bg)

    
    -- 버튼 클릭 이벤트 핸들러 ---------------------------------------------------------------------------------
    local function onButtonTap(event)
        local index = event.target.buttonIndex
        disabledChoices[index] = true -- 클릭한 버튼 저장
        composer.setVariable("disabledChoices", disabledChoices) -- 전역 변수로 저장
        event.target.isVisible = false -- 버튼 숨김
        composer.gotoScene(event.target.targetScene, { effect = "fade", time = 400 })
        return true
    end

    -- 버튼 생성 함수
    local function createChoiceButton(index, x, y, labelText, targetScene)
        local buttonGroup = display.newGroup()

        local button = display.newRect(buttonGroup, 0, 0, 300, 50)
        button:setFillColor(0.2, 0.4, 0.4)

        local buttonText = display.newText({
            parent = buttonGroup,
            text = labelText,
            x = 0,
            y = 0,
            fontSize = 40
        })
        buttonText:setFillColor(1, 1, 1)
        
        buttonGroup.x = x
        buttonGroup.y = y
        
        button.buttonIndex = index
        button.targetScene = targetScene
        button:addEventListener("tap", onButtonTap)
        
        -- 이전에 선택했던 버튼이면 숨기기
        if disabledChoices[index] then
            buttonGroup.isVisible = false
        end
        
        return buttonGroup
    end


    -- 선택지 버튼 생성 및 sceneGroup에 추가
    scene.choice[1] = createChoiceButton(1, display.contentCenterX, display.contentCenterY + 180, "서재", "beforeBookGame")
    scene.choice[2] = createChoiceButton(2, display.contentCenterX, display.contentCenterY + 240, "침실", "bedroom_puzzle")
    scene.choice[3] = createChoiceButton(3, display.contentCenterX, display.contentCenterY + 300, "화장실", "beforePipeGame")
    
    for i = 1, #scene.choice do
        if scene.choice[i] then
            sceneGroup:insert(scene.choice[i])
        end
    end
    
    
    -- 목숨(총알) 생성 -----------------------------------------------------------------------------------------

   

    -- 목숨(총알) 생성
    bulletGroup, bullets = ui.createBullets(sceneGroup)
    sceneGroup:insert(bulletGroup)

    -- -- 총알 아이콘 업데이트
    -- for i = 1, success do
        -- bullets[3].fill = { type = "image", filename = "image/UI/bullets/bullets_filled.png" }
    -- end

    

end

function scene:show(event)
    local phase = event.phase
    if phase == "did" then
        -- 선택되지 않은 버튼만 다시 보이도록 설정
        for i = 1, #scene.choice do
            if scene.choice[i] and not disabledChoices[i] then
                scene.choice[i].isVisible = true
            end
        end
        --------------------------------------------------------------------------------------------------
        local success = composer.getVariable("success") or 0  
        print("성공 횟수 미니초이스: " .. tostring(success))

        -- 총알 채우기기
        for i = 1, success do
            bullets[i].fill = { type = "image", filename = "image/UI/bullets/bullets_filled.png" }
        end

        -- 3번다 성공하면 해피
        if success >= 3 then
            composer.gotoScene("ending_Happy", { effect = "fade", time = 400 })
        end

        ---------------------------------------------------------------------------------------------------
        -- 게임 1 or 2회 실패시 엔딩
        local gameCount = composer.getVariable( "gameCount" ) or 0
        if gameCount == 3 and success ~= 3 then 
            composer.gotoScene('ending_Failure_Note', { effect = "fade", time = 400 })
        end
        
    end
end

function scene:hide(event)
    local phase = event.phase
    if phase == "will" then
        -- 선택했던 버튼 숨김
        -- if scene.choice then
        --     for i = 1, #scene.choice do
        --         if scene.choice[i] then
        --             scene.choice[i]:removeSelf()
        --             scene.choice[i] = nil
        --         end
        --     end
        -- end
        for i = 1, #scene.choice do
            if scene.choice[i] then
                scene.choice[i].isVisible = false
            end
        end
    end
end

function scene:destroy(event)
    local sceneGroup = self.view
end

-- Listener setup
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
