return Def.ActorFrame {
	StartTransitioningCommand=function(self) self:sleep(0.7) end;
	Def.Quad {
		InitCommand=function(self) self:Center():zoomto(SCREEN_WIDTH+1,SCREEN_HEIGHT):draworder(10000) end;
		StartTransitioningCommand=function(self) self:diffusealpha(0):diffuse(color("0,0,0,0")):sleep(0.6):linear(0.15):diffusealpha(0) end;
	};
};
