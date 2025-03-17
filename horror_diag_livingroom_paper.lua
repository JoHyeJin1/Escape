local composer = require("composer")
local ui = require("ui")                --ui.lua 파일 불러오기기

local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view

    -- sound effect ---------------------------------------------------------------------------------
    local typingSound = audio.loadSound("music/effect/Keyboard Typing Fast.wav")
	
	-- BACKGROUND
	local bg = display.newImage("Image/cutscene/black.png")
	bg.x = display.contentCenterX
	bg.y = display.contentCenterY
	sceneGroup:insert(bg)

	
	-- 📜 종이 이미지 (배경)
	local paperImage = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth * 0.6, display.contentHeight * 0.6)
	paperImage:setFillColor(1, 1, 1) -- 흰색 배경
	paperImage.alpha = 0.8 -- 투명도 조절
	sceneGroup:insert(paperImage)


    -- 📜 종이 위의 텍스트
    local paperText = display.newText({
        text = "당신을 도울 세 친구!\n총알 세 발이 당신을 안내할 것입니다.",
        x = display.contentCenterX,
        y = display.contentCenterY,
        width = display.contentWidth * 0.6,
		paperImage:setFillColor(1, 1, 1), -- 흰색 배경
        fontSize = 40,
        align = "center"
    })
    paperText:setFillColor(0) -- 검은색
    sceneGroup:insert(paperText)
	
    -- 💬 대화창
    local dialogueBox = display.newImage("Image/UI/dialogue/dialogue_blood.png") -- 대화창 이미지
    dialogueBox.x = display.contentCenterX  
    dialogueBox.y = display.contentHeight - 130
    dialogueBox:scale(1, 0.65)
    dialogueBox.isVisible = false -- 초반에 숨김
    sceneGroup:insert(dialogueBox)
	
    -- 💬 대화 텍스트
    local content = display.newText({
		text = "", 
        x = display.contentWidth * 0.5 + 15, 
        y = display.contentHeight - 105,
        width = display.contentWidth - 120,
        height = 200,
        fontSize = 40,
        align = "left"
    })
    content:setFillColor(1) -- 흰색 글씨
    content.isVisible = false -- 초반에 숨김
    sceneGroup:insert(content)
	
	-- 📜 종이를 터치하면 사라지는 이벤트
	local function hidePaper()
		paperImage.isVisible = false
		paperText.isVisible = false
		dialogueBox.isVisible = true
		content.isVisible = true
		paperImage:removeEventListener("tap", hidePaper)
		
		-- 목숨(총알) 생성
		bulletGroup, bullets = ui.createBullets(sceneGroup)
		sceneGroup:insert(bulletGroup)
		
		for i = 1, 3 do
    	    bullets[i].x = display.contentWidth/2 + 200 - (i * 100)
			bullets[i].y = display.contentCenterY - 100
			bullets[i].alpha = 1 
		end
		
	end
	paperImage:addEventListener("tap", hidePaper)
	
    -- 💬 대사 데이터
    local Data = {
		"총알 세 발? 내 머리에 박고 죽으라는 건가?",
        "...일단 총알을 찾아보자. 찾아둬서 나쁘진 않을 거야.",
        "어딜 먼저 가지?"
    }

    local index = 0

    -- 💬 대사 진행 함수
    local function nextScript()
        index = index + 1
        if index > #Data then
            composer.gotoScene("choice_minigame") -- 선택지 씬으로 이동
            return
        end
        content.text = Data[index]
        
    	-- 타이핑 효과음 n초 재생 ---------------------------------------------------------------------------------
		local typingChannel = audio.play(typingSound) 
        audio.setVolume(0.3, {channel = typingChannel}) -- 볼륨 30% 설정
		timer.performWithDelay(3300, function() 
			audio.stop(typingChannel) 
		end)

    end

    -- 💬 대화창 터치 시 대사 출력
    dialogueBox:addEventListener("tap", nextScript)

    sceneGroup:insert(dialogueBox)
    sceneGroup:insert(content)
end

scene:addEventListener("create", scene)
return scene
