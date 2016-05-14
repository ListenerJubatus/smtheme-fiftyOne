local t = Def.ActorFrame {};

t[#t+1] = Def.ActorFrame {
	OnCommand=cmd(diffusealpha,0;sleep,0.7;decelerate,3;diffusealpha,0.2;);
	OffCommand=cmd(stoptweening;linear,0.1;diffusealpha,0;);
	Def.Sprite {
		Condition=not GAMESTATE:IsCourseMode();
		InitCommand=cmd(Center);
		OnCommand=function(self)
			if GAMESTATE:GetCurrentSong() then
				local song = GAMESTATE:GetCurrentSong();
				if song:HasBackground() then
					self:LoadBackground(song:GetBackgroundPath());
				end;
				self:scale_or_crop_background();
				(cmd(fadebottom,0.25;fadetop,0.25;croptop,48/480;cropbottom,48/480))(self);
			else
				self:visible(false);
			end
		end;
	};
};
return t
