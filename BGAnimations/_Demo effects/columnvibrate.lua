-- Return the index of the column to apply the effect to, based on button pressed...
-- ...however, since I can't seem to figure out a better way to do this without a big ol' function,
-- this only works on Dance Single for now.
local function ColumnToAffect( button )
	local buttons = {
		["Left"] = 1,
		["Down"] = 2,
		["Up"] = 3,
		["Right"] = 4,
	}
	if not buttons[button] then
		return math.random(1,4)
	else
		return buttons[button]
	end
end

local function InputHandler( event )
	for i, pn in ipairs(GAMESTATE:GetEnabledPlayers()) do
		-- A little verbose, but let's dig a little deeper this time.
		local target = SCREENMAN:GetTopScreen():GetChild("Player" .. ToEnumShortString(pn)):GetChild("NoteField")
		-- Oh sorry did I say a "little" deeper?
		local subtargets = target:GetColumnActors()
		
		if not string.find(event.button, "Menu") and event.PlayerNumber then
			if event.type == "InputEventType_FirstPress" then
				subtargets[ColumnToAffect(event.button)]:vibrate()
			elseif event.type == "InputEventType_Release" then
				subtargets[ColumnToAffect(event.button)]:stopeffect()
			end
		end
	end
end

local t = Def.ActorFrame{
	OnCommand = function(self)
		SCREENMAN:GetTopScreen():AddInputCallback( InputHandler )
	end
}

return t