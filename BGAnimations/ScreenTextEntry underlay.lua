return Def.ActorFrame {
	Def.Quad{
		InitCommand=function(self) self:scaletocover(-SCREEN_WIDTH*2,SCREEN_TOP,SCREEN_WIDTH*2,SCREEN_BOTTOM):diffuse(color("0,0,0,0.5")) end;
		OnCommand=function(self) self:diffusealpha(0):smooth(0.2):diffusealpha(0.5) end;
		OffCommand=function(self) self:smooth(0.2):diffusealpha(0) end;
	};
};