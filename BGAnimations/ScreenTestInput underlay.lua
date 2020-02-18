return Def.ActorFrame {
Def.ActorFrame {
	InitCommand=function(self) self:Center() end;
	Def.Quad {
		InitCommand=function(self) self:scaletoclipped(SCREEN_WIDTH,SCREEN_HEIGHT) end;
		OnCommand=function(self) self:diffuse(Color.Black):diffusealpha(0.6) end;
	};
};

	Def.DeviceList {
		Font="_open sans condensed 24px",
		InitCommand=function(self) self:xy(SCREEN_LEFT+20,SCREEN_TOP+130):zoom(0.8):halign(0):skewx(-0.1):diffuse(color("#FFFFFF")) end;
		OffCommand=function(self) self:stoptweening():decelerate(0.2):diffusealpha(0) end;
	};

	Def.InputList {
		Font="Common Condensed",
		InitCommand=function(self) self:xy(SCREEN_CENTER_X-250,SCREEN_CENTER_Y):zoom(1):halign(0):vertspacing(8):strokecolor(color("#000000")) end;
	};
};
