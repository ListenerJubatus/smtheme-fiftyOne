-- With somewhat unwieldy tables, return how much the target in InputHandler should be rotated.
local function RotateIt( button, axis )
	local buttons_X = {
		["Left"] = 0,
		["Right"] = 0,
		["Up"] = -22.5,
		["Down"] = 22.5,
		["UpLeft"] = -22.5,
		["UpRight"] = -22.5,
		["DownLeft"] = 22.5,
		["DownRight"] =-22.5
	}
	local buttons_Y = {
		["Left"] = 22.5,
		["Right"] = -22.5,
		["Up"] = 0,
		["Down"] = 0,
		["UpLeft"] = 22.5,
		["UpRight"] = -22.5,
		["DownLeft"] = 22.5,
		["DownRight"] = -22.5
	}
	if not buttons_X[button] or not buttons_Y[button] then
		return 0
	else
		if axis == "x" then
			return buttons_X[button]
		else
		-- assume axis is Y
			return buttons_Y[button]
		end
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
				target:decelerate(1.5):addrotationz(360)
			else
				target:linear(0.1):addrotationx( RotateIt(event.button, "x") ):addrotationy( RotateIt(event.button, "y") )
			end
		-- Return the rotation to normal... usually. If a button is held during a screen transition,
		-- then let go after the screen loads, the Player actors will remain rotated some way or another!
		elseif event.type == "InputEventType_Release" then
			target:linear(0.1):addrotationx( -RotateIt(event.button, "x") ):addrotationy( -RotateIt(event.button, "y") )
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