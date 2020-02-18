return Def.ActorFrame {
	Def.Quad {
		InitCommand=function(self) self:zoomto(SCREEN_WIDTH,SCREEN_HEIGHT):Center() end;
		OnCommand=function(self) self:diffuse(ColorMidTone(color("#451A20"))):diffusebottomedge(ColorMidTone(color("#5E2A30")))  end;
	};
	LoadActor(GetSongBackground()) .. {
		InitCommand=function(self) self:scaletoclipped(SCREEN_WIDTH,SCREEN_HEIGHT):diffusealpha(0.1):Center() end;
	};
};