local t = Def.ActorFrame {};
t[#t+1] = Def.Sprite {
	InitCommand=function(self) self:Center():diffusealpha(1) end;
	BeginCommand=function(self) self:LoadFromCurrentSongBackground() end;
	StartTransitioningCommand=function(self)
		if PREFSMAN:GetPreference("StretchBackgrounds") then
			self:SetSize(SCREEN_WIDTH,SCREEN_HEIGHT)
		else
			self:scale_or_crop_background()
		end
		self:linear(0.2)
		self:diffusealpha(0)
	end;
};

-- Pause menu
	t[#t+1]= LoadActor(THEME:GetPathG("", "pause_menu"))

return t;