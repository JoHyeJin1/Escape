local ui = {}

-- 대화창 생성
function ui.createDialogueBox(sceneGroup)
    local dialogueBox = display.newImage("image/UI/dialogue/dialogue_default.png")
    dialogueBox.x = display.contentCenterX  
    dialogueBox.y = display.contentHeight - 130  
    dialogueBox:scale(1, 0.65)


    local text = display.newText({
        text = "", 
        x = display.contentWidth * 0.5 + 15, 
        y = display.contentHeight - 105,
        width = display.contentWidth - 120,
        height = 200,
        fontSize = 40,
        align = "left"
    })
    text:setFillColor(1, 1, 1)
    
    sceneGroup:insert(dialogueBox)              --- 얘네 ---
    sceneGroup:insert(text)

    return dialogueBox, text
end

-- 대화 텍스트 업데이트
function ui.updateDialogueText(dialogueText, newText)
    if dialogueText then
        dialogueText.text = newText
    end
end

-- 대화창 이미지 변경 함수
function ui.updateDialogueBoxImage(dialogueBox, newImagePath)   -- newImagePath에 "image/UI/dialogue/dialogue_blood.png" 혹은 "image/UI/dialogue/dialogue_default.png" 넣으면 됨
    if dialogueBox then
        dialogueBox.fill = { type = "image", filename = newImagePath }
    end
end


-- 총알 생성
function ui.createBullets(sceneGroup)
    local bulletGroup = display.newGroup()
    local bullets = {}
    
    for i = 1, 3 do
        bullets[i] = display.newImage("image/UI/bullets/bullets_empty.png")
        bullets[i].x = display.contentWidth - (i * 100) - 30
        bullets[i].y = 100
        bullets[i].alpha = 1 
        bulletGroup:insert(bullets[i])
        sceneGroup:insert(bullets[i])
    end
    
    return bulletGroup, bullets
end

-- 총알 아이콘 업데이트 함수
local gained_bullets = 0
function ui.updateBullets(bulletIcons)
    if gained_bullets < 3 and bulletIcons[gained_bullets + 1] then
        gained_bullets = gained_bullets + 1  
        bulletIcons[gained_bullets].alpha = 1  
        bulletIcons[gained_bullets].fill = { type = "image", filename = "image/UI/bullets/bullets_filled.png" }
    end
end

return ui