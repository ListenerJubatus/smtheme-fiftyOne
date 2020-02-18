return function()
	local Maintain = {
		dance = "TapNoteScore_W3",
		pump = "TapNoteScore_W4",
		beat = "TapNoteScore_W3",
		kb7 = "TapNoteScore_W3",
		para = "TapNoteScore_W4"
	}
	if LoadModule("Config.Load.lua")("CustomComboMaintain","Save/OutFoxPrefs.ini") ~= "default" then
		return LoadModule("Config.Load.lua")("CustomComboMaintain","Save/OutFoxPrefs.ini")
	else
		return Maintain[GAMESTATE:GetCurrentGame():GetName()] or "TapNoteScore_W3"
	end
end