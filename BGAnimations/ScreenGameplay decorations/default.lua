local t = Def.ActorFrame {};

-- LifeMeterBar
for i, pn in pairs(PlayerNumber) do
	if ShowStandardDecoration("LifeMeterBar" ..  ToEnumShortString(pn)) then
		local life_type = GAMESTATE:GetPlayerState(pn):get_player_options_no_defect("ModsLevel_Song"):LifeSetting()
		t[#t+1] = LoadActor(THEME:GetPathG(Var "LoadingScreen", "lifebar_" .. ToEnumShortString(life_type)), pn) .. {
			InitCommand=function(self)
				self:name("LifeMeterBar" .. ToEnumShortString(pn))
				ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
			end
		}
	end
end

t[#t+1] = LoadFont("TextBanner text") .. {
          InitCommand=cmd(x,SCREEN_CENTER_X;shadowlength,1;y,SCREEN_BOTTOM-60;maxwidth,360;);
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

t[#t+1] = LoadFont("TextBanner text") .. {
          InitCommand=cmd(zoom,0.75;shadowlength,1;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-36;maxwidth,350;);
		  OnCommand=cmd(diffusealpha,0;sleep,1.3;smooth,0.6;diffusealpha,1;);
		  OffCommand=cmd(sleep,1;decelerate,1.4;diffusealpha,0;);
          CurrentSongChangedMessageCommand=cmd(finishtweening;playcommand,"Set");
          CurrentCourseChangedMessageCommand=cmd(finishtweening;playcommand,"Set");
          ChangedLanguageDisplayMessageCommand=cmd(finishtweening;playcommand,"Set");
          SetCommand=function(self)
               local song = GAMESTATE:GetCurrentSong();
               if song then
                    self:settext(song:GetDisplayArtist());
                    self:playcommand("Refresh");
				else
					self:settext("");
					self:playcommand("Refresh");
               end
          end;
};


return t