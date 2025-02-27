local composer = require("composer")
local scene = composer.newScene()

-- 전역 선택지 테이블 선언
scene.choice = {}

function scene:create(event)
    local sceneGroup = self.view

    --BackGround
    local bg = display.newImage("Image/cutscene/revolver_frame.png")
    bg.x = display.contentCenterX
    bg.y = display.contentCenterY
    sceneGroup:insert(bg) -- 배경 추가

    -- 버튼 클릭 이벤트 핸들러
    local function onButtonTap(event)
        composer.gotoScene(event.target.targetScene)
        return true -- 터치 이벤트 전파 방지
    end

    -- 버튼 생성 함수
    local function createChoiceButton(x, y, labelText, targetScene)
        local buttonGroup = display.newGroup()

        local button = display.newRect(buttonGroup, 0, 0, 300, 50)
        button:setFillColor(0.2, 0.4, 0.4)  -- 버튼 색 파랑

        local buttonText = display.newText({
            parent = buttonGroup,
            text = labelText,
            x = 0,
            y = 0,
            fontSize = 40
        })
        buttonText:setFillColor(0, 0, 0) -- 글씨 색 검정

        -- 버튼 위치 설정
        buttonGroup.x = x
        buttonGroup.y = y

        -- 버튼 클릭 이벤트 추가
        button.targetScene = targetScene
        button:addEventListener("tap", onButtonTap)

        return buttonGroup
    end

    -- 선택지 버튼 3개 생성 (전역 `scene.choice`에 저장)
    scene.choice[1] = createChoiceButton(display.contentCenterX, display.contentCenterY + 180, "서재", "beforeBookGame")
    scene.choice[2] = createChoiceButton(display.contentCenterX, display.contentCenterY + 240, "침실", "bedroom_puzzle")
    scene.choice[3] = createChoiceButton(display.contentCenterX, display.contentCenterY + 300, "화장실", "beforePipeGame")

    -- sceneGroup에 추가
    for i = 1, #scene.choice do
        sceneGroup:insert(scene.choice[i])
    end
end

function scene:show(event)
    local phase = event.phase
    if phase == "did" then
        -- 씬 활성화 시 실행할 코드
    end
end

function scene:hide(event)
    local phase = event.phase
    if phase == "will" then
        -- 선택지 버튼 제거
        if scene.choice then
            for i = 1, #scene.choice do
                if scene.choice[i] then
                    scene.choice[i]:removeSelf()
                    scene.choice[i] = nil
                end
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
