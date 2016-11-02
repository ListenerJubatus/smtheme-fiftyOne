local t = Def.ActorFrame {};
	--P1
	if GAMESTATE:IsHumanPlayer(PLAYER_1) == true then
	t[#t+1] = LoadActor("_lifep1") .. {
		InitCommand=cmd(visible,GAMESTATE:IsHumanPlayer(PLAYER_1);x,SCREEN_LEFT+40;y,SCREEN_CENTER_Y;rotationz,-90;);
	};
	end;

	if GAMESTATE:IsHumanPlayer(PLAYER_2) == true then
	t[#t+1] = LoadActor("_lifep2") .. {
		InitCommand=cmd(visible,GAMESTATE:IsHumanPlayer(PLAYER_2);x,SCREEN_RIGHT-40;y,SCREEN_CENTER_Y;rotationz,-90;);
	};
	end;


	t[#t+1] = LoadFont("TextBanner text") .. {
			  InitCommand=cmd(zoom,1;shadowlength,1;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-55;maxwidth,350;strokecolor,color("#000000"););
			  OnCommand=cmd(diffusealpha,0;sleep,1.3;smooth,0.6;diffusealpha,1;);
			  OffCommand=cmd(sleep,1;decelerate,1.4;diffusealpha,0;);
			  CurrentSongChangedMessageCommand=cmd(finishtweening;playcommand,"Set");
			  CurrentCourseChangedMessageCommand=cmd(finishtweening;playcommand,"Set");
			  ChangedLanguageDisplayMessageCommand=cmd(finishtweening;playcommand,"Set");
			  SetCommand=function(self)
				   local song = GAMESTATE:GetCurrentSong();
				   if song then
						self:settext(song:GetDisplayFullTitle());
						self:playcommand("Refresh");
					else
						self:settext("");
						self:playcommand("Refresh");
				   end
			  end;
	};
	
	t[#t+1] = StandardDecorationFromFileOptional("StageDisplay","StageDisplay");
	t[#t+1]= LoadActor(THEME:GetPathG("", "pause_menu"))
return t
