-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- json parsing
local json = require "json"
local bgm = require "audio"

-- json parsing
function jsonParse(src)
   local filename = system.pathForFile(src)

   local data, pos, msg = json.decodeFile(filename)

   if(data) then
	   return data
   else
	   print("WARNING: "..pos, msg)
	   return nil
   end
end

-- -- bgm loading
-- local function load_sound(filename)
--   return bgm.newSource(filename, "stream")
-- end

-- -- bgm playing
-- local function play_sound(sound)
--   if sound then
--     sound:play()
--   end
-- end
-- -- 

local composer = require "composer"

local function onFirstView( event )
   composer.gotoScene( "choice_minigame" )
end

onFirstView()