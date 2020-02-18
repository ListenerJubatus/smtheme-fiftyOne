return Def.ActorFrame {
	Def.Quad {
		InitCommand=function(self) self:Center():zoomto(SCREEN_WIDTH+1,SCREEN_HEIGHT) end;
		StartTransitioningCommand=function(self) self:diffuse(color("0,0,0,0.5")):sleep(5/60):diffusealpha(1):sleep(5/60) end;
	};
	LoadActor(THEME:GetPathS("_Screen","cancel")) .. {
		IsAction= true,
		StartTransitioningCommand=function(self) self:play() end;
	};
};