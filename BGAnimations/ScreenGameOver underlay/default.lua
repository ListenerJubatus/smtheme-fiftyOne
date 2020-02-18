local timer_seconds = THEME:GetMetric(Var "LoadingScreen","TimerSeconds");

return Def.ActorFrame {
	InitCommand=function(self) self:Center() end;
	-- Fade
	Def.Quad {
		InitCommand=function(self) self:scaletoclipped(SCREEN_WIDTH,SCREEN_HEIGHT) end;
		OnCommand=function(self) 
			self:diffuse(Color.Black):diffusealpha(0):linear(0.5):diffusealpha(0.25):sleep(timer_seconds/2):linear(timer_seconds/2-0.5):diffusealpha(0.8)
		end;
	},
	
	Def.Quad {
		InitCommand=function(self) self:zoomto(SCREEN_WIDTH,SCREEN_HEIGHT) end;
		OnCommand=function(self) self:diffuse(Color.Black) end;
	},	
	
	LoadActor("_diamond") .. {
		InitCommand=function(self) self:diffusealpha(0):zoom(1):rotationz(0) end;
		OnCommand=function(self) self:sleep(1):diffusealpha(1):linear(3):zoom(2):diffusealpha(0) end;
	};
	
	LoadActor("_sound") .. {
		OnCommand=function(self) self:queuecommand("Sound") end;
		SoundCommand=function(self) self:play() end;
	};	
	
	LoadActor(THEME:GetPathG("ScreenGameOver","gameover"))..{
		OnCommand=function(self) self:zoomx(1.1):diffusealpha(0):sleep(1):decelerate(0.6):diffusealpha(1):zoomx(1) end;
	},
	
	LoadFont("Common Condensed")..{
		Text=ScreenString("Play again soon!");
		InitCommand=function(self) self:y(68):shadowlength(2) end;
		OnCommand=function(self) self:diffusealpha(0):sleep(3):linear(0.3):diffusealpha(1) end;
	},
}
