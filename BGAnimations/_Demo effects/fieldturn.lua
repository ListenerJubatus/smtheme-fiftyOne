-- Return which way the target in InputHandler should rotate, based on button pressed.
local function RotateIt( button )
	local buttons = {
		["Left"] = -90,
		["Right"] = 90,
		["Up"] = 0,
		["Down"] = 180,
		["UpLeft"] = -45,
		["UpRight"] = 45,
		["DownLeft"] = -135,
		["DownRight"] = 135
	}
	if not buttons[button] then
		return 0
	else
		return buttons[button]
	end
end

local function InputHandler( event )
	-- Make sure we target *both* players with a loop.
	for i, pn in ipairs(GAMESTATE:GetEnabledPlayers()) do
		-- I can promise you this is the actual way to get the Player actors. ._.
		local target = SCREENMAN:GetTopScreen():GetChild("Player" .. ToEnumShortString(pn))
		-- A little excessive, but makes sure the code ignores unintentional input and button releases.
		if not string.find(event.button, "Menu") and event.type == "InputEventType_FirstPress"
		and event.PlayerNumber then
			if event.button == "Center" or event.button == "Select" then
				-- Play around a bit.
				target:decelerate(1.5):addrotationy(180)
			else
				target:linear(0.5):rotationz( RotateIt(event.button) )
			end
		end
	end
end

-- This frame only exists to make the input handler usable.
local t = Def.ActorFrame{
	OnCommand = function(self)
		SCREENMAN:GetTopScreen():AddInputCallback( InputHandler )
	end
}

return t