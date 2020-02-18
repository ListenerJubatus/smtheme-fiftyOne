local t = Def.ActorFrame{
	InitCommand=function(self) self:fov(70) end;
	Def.ActorFrame {
		InitCommand=function(self) self:zoom(0.75) end;
		OnCommand=function(self) self:diffusealpha(0):zoom(0.4):decelerate(0.7):diffusealpha(1):zoom(0.75) end;
			LoadActor("_text");
		};
	};

return t;
