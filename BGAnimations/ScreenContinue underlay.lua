local timer_seconds = THEME:GetMetric(Var "LoadingScreen","TimerSeconds");
local t = Def.ActorFrame {};

-- Fade
t[#t+1] = Def.ActorFrame {
	InitCommand=function(self) self:Center() end;	
	Def.Quad {
		InitCommand=function(self) self:scaletoclipped(SCREEN_WIDTH,SCREEN_HEIGHT) end;
		OnCommand=function(self)
			self:diffuse(Color.Black):diffusealpha(0):linear(0.5):diffusealpha(0.25):sleep(timer_seconds/2):linear(timer_seconds/2-0.5):diffusealpha(1)
		end;
		OffCommand=function(self) 
			self:stoptweening():sleep(0.4):decelerate(0.5):diffusealpha(1)
		end;
	};
	-- Warning Fade
	Def.Quad {
		InitCommand=function(self) self:y(16):scaletoclipped(SCREEN_WIDTH,250) end;
		OnCommand=function(self)
			self:diffuse(Color.Black):diffusealpha(0.5):linear(timer_seconds):zoomtoheight(180)
		end;
		OffCommand=function(self) self:stoptweening() end;
	}
};
--
t[#t+1] = Def.ActorFrame {
	InitCommand=function(self) self:Center():y(SCREEN_CENTER_Y-56):zoom(1.5) end;
	LoadFont("Common Fallback Font") .. {
		Text="Continue?";
		OnCommand=function(self) self:diffuse(color("#FF8312")):diffusebottomedge(color("#FFD75B")):shadowlength(1):strokecolor(color("#472211")) end;
	};
};
--
return t