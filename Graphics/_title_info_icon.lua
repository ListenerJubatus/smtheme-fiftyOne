-- This is used for the life/timing difficulty displays on the title menu,
-- as well as the current gametype.
local params = ...
return Def.ActorFrame {
	-- Base
	-- todo; make getting the base's image less stupid
	LoadActor(THEME:GetPathG("","ScreenSelectPlayMode Icon/_background base")) .. {
		InitCommand=function(self) self:zoomto(70,70):diffuse(params.base_color):diffusebottomedge(ColorMidTone(params.base_color)) end;
	},
	-- The wanted value
	LoadFont("_open sans semibold 24px") .. {
		InitCommand=function(self) self:diffuse(Color.White):diffusealpha(0.85) end;
		OnCommand=function(self)
			self:settext( params.value_text )
			self:zoom(string.len(params.value_text) > 3 and 0.6 or 1.5)
		end
	},
	-- Label
	LoadFont("_open sans condensed 24px") .. {
		InitCommand=function(self) self:x(50):zoom(0.75):diffuse(color("#FFFFFF")):strokecolor(color("0,0,0,0.75")):horizalign(left):uppercase(true):maxwidth(320) end;
		OnCommand= function(self)
			self:shadowlength(0):settext(params.label_text)
		end,
	}
}
