local t = Def.ActorFrame{};
	t[#t+1] = Def.Quad{
		InitCommand=function(self)
			self:FullScreen():diffuse(color("1,0,0,0")):blend("weightedmultiply")
		end;
		OnCommand=function(self)
			self:smooth(1):diffuse(color("0.75,0,0,0.75")):decelerate(2):diffuse(color("0,0,0,1"))
		end;
	};
	t[#t+1] = Def.Quad{
		InitCommand=function(self)
			self:FullScreen():diffuse(color("1,1,1,1")):diffusealpha(0)
		end;
		OnCommand=function(self)
			self:finishtweening():diffusealpha(1):decelerate(1.25):diffuse(color("1,0,0,0"))
		end;
	};
	t[#t+1] = LoadActor(THEME:GetPathS( Var "LoadingScreen", "failed" ) ) .. {
		StartTransitioningCommand=function(self) self:play() end;
	};

return t;
