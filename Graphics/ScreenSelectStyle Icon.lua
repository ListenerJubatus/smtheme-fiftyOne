local gc = Var("GameCommand");

local string_name = gc:GetText();
local string_expl = THEME:GetString("StyleType", gc:GetStyle():GetStyleType());
local text_color = color("#FFCB05");
local unfocus_color = color("#172777");
local focus_color = color("#112aaa");

local t = Def.ActorFrame {};
t[#t+1] = Def.ActorFrame { 
	GainFocusCommand=THEME:GetMetric(Var "LoadingScreen","IconGainFocusCommand");
	LoseFocusCommand=THEME:GetMetric(Var "LoadingScreen","IconLoseFocusCommand");

	LoadActor(THEME:GetPathG("ScreenSelectPlayMode", "icon/_background base"))..{
		GainFocusCommand=function(self) self:diffuse(focus_color) end;
		LoseFocusCommand=function(self) self:diffuse(unfocus_color) end;
	};
	LoadFont("_noto sans 36px")..{
		Text=ToUpper(string_name);
		InitCommand=function(self) self:y(-12):maxwidth(232) end;
		OnCommand=function(self) self:diffuse(text_color) end;
	};
	LoadFont("_open sans condensed 24px")..{
		Text=ToUpper(string_expl);
		InitCommand=function(self) self:y(29.5):maxwidth(128):skewx(-0.1) end;
	};

	LoadActor(THEME:GetPathG("ScreenSelectPlayMode", "icon/_background base"))..{
		DisabledCommand=function(self) self:diffuse(color("0,0,0,0.5")) end;
		EnabledCommand=function(self) self:diffuse(color("1,1,1,0")) end;
	};
};
return t