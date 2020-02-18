local t = Def.ActorFrame {};

-- Fade
t[#t+1] = Def.Quad {
	InitCommand=function(self) self:Center():zoomto(SCREEN_WIDTH,SCREEN_HEIGHT):diffuse(Color.Black):diffusealpha(0.6) end;
};
-- Emblem
t[#t+1] = Def.ActorFrame {
	InitCommand=function(self) self:Center():diffusealpha(0.5) end;
	LoadActor("_warning bg") .. {
	};
};

-- Text
t[#t+1] = Def.ActorFrame {
	InitCommand=function(self) self:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y-120) end;
	OnCommand=function(self) self:diffusealpha(0):linear(0.2):diffusealpha(1) end;
	LoadFont("_open sans semibold 48px") .. {
		Text=Screen.String("Caution");
		OnCommand=function(self) self:diffuse(color("#E6BF7C")):diffusebottomedge(color("#FFB682")):strokecolor(color("#594420")) end;
	};
	LoadFont("Common Normal") .. {
		Text=Screen.String("CautionText");
		InitCommand=function(self) self:y(128) end;
		OnCommand=function(self) self:strokecolor(color("0,0,0,0.5")):shadowlength(1):wrapwidthpixels(SCREEN_WIDTH/0.5) end;
	};
};
--
return t
