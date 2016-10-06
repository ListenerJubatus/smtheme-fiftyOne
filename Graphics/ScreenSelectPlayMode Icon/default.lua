local gc = Var("GameCommand");

local string_name = gc:GetText()
local string_expl = THEME:GetString(Var "LoadingScreen", gc:GetName().."Explanation")
local icon_color = ModeIconColors[gc:GetName()];
local icon_size = 192

local t = Def.ActorFrame {};
t[#t+1] = Def.ActorFrame {
	GainFocusCommand=cmd(stoptweening;bob;effectmagnitude,0,0,3;decelerate,0.1;zoom,0.95);
	LoseFocusCommand=cmd(stoptweening;stopeffect;decelerate,0.1;zoom,0.9);

	Def.Quad {
		InitCommand=cmd(zoomto,icon_size,icon_size;rotationz,45);
		DisabledCommand=cmd(diffuse,ColorMidTone(icon_color);diffuselowerright,ColorDarkTone(icon_color));
		EnabledCommand=cmd(diffuse,icon_color;diffuselowerright,ColorMidTone(icon_color));
	};
	--LoadActor("_background effect");
	--LoadActor("_gloss");
	--LoadActor("_stroke");
	--LoadActor("_cutout");
	
	--Not in use yet!
	--LoadActor( gc:GetName() ) .. {}

	-- todo: generate a better font for these.
	LoadFont("Common Large")..{
		Text=string.upper(string_name);
		InitCommand=cmd(x,icon_size/3.4;y,icon_size/3.4;zoom,0.6;maxwidth,icon_size*1.4);
		OnCommand=cmd(rotationz,-45;diffuse,Color.White;strokecolor,Color.Outline);
	};
	-- LoadFont("Common Normal")..{
		-- Text=string.upper(string_expl);
		-- InitCommand=cmd(y,27.5;maxwidth,232);
	-- };
};
return t