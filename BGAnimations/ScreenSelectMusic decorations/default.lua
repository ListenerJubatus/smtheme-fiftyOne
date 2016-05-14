local t = LoadFallbackB();

-- Banner underlay
t[#t+1] = Def.ActorFrame {
    InitCommand=cmd(x,SCREEN_CENTER_X-230;draworder,125);
    OffCommand=cmd(smooth,0.2;diffusealpha,0;);
    Def.Quad {
        InitCommand=cmd(zoomto,468,196;diffuse,color("#fce1a1");diffusealpha,0.4;y,SCREEN_CENTER_Y-94+25;);
      };
};

-- Sort and stage display tiles
t[#t+1] = Def.ActorFrame {
    InitCommand=cmd(x,SCREEN_CENTER_X-226;);
    OffCommand=cmd(smooth,0.2;diffusealpha,0;);
    Def.Quad {
        InitCommand=cmd(zoomto,150,60;diffuse,color("#fce1a1");diffusealpha,0.4;y,SCREEN_CENTER_Y-205;);
    };

    LoadFont("Common Normal") .. {
            InitCommand=cmd(zoom,0.6;y,SCREEN_CENTER_Y-223;diffuse,color("#000000");diffusealpha,0.5;visible,not GAMESTATE:IsCourseMode(););
            OnCommand=cmd(playcommand,"Set");
            ChangedLanguageDisplayMessageCommand=cmd(playcommand,"Set");
            SetCommand=function(self)
                self:settext("SORT");
                self:playcommand("Refresh");
            end;
    };

    LoadFont("Common Italic Condensed") .. {
          InitCommand=cmd(zoom,0.8;y,SCREEN_CENTER_Y-198;maxwidth,SCREEN_WIDTH;diffuse,color("#9d324e");uppercase,true;visible,not GAMESTATE:IsCourseMode(););
          OnCommand=cmd(playcommand,"Set");
          SortOrderChangedMessageCommand=cmd(playcommand,"Set");
          ChangedLanguageDisplayMessageCommand=cmd(playcommand,"Set");
          SetCommand=function(self)
               local sortorder = GAMESTATE:GetSortOrder();
               if sortorder then
					self:finishtweening();
					self:smooth(0.4);
					self:diffusealpha(0);
					self:addx(6);
                    self:settext(SortOrderToLocalizedString(sortorder));
                    self:playcommand("Refresh"):stoptweening():diffusealpha(0):smooth(0.3):diffusealpha(1)
				else
					self:settext("");
					self:playcommand("Refresh");
               end
          end;
    };
};

t[#t+1] = Def.ActorFrame {
    OffCommand=cmd(sleep,0.1;smooth,0.2;diffusealpha,0;);
    InitCommand=cmd(x,SCREEN_CENTER_X-71;);
    Def.Quad {
        InitCommand=cmd(zoomto,150,60;diffuse,color("#fce1a1");diffusealpha,0.4;y,SCREEN_CENTER_Y-205;);
    };

    LoadFont("Common Normal") .. {
          InitCommand=cmd(zoom,0.6;y,SCREEN_CENTER_Y-223;diffuse,color("#000000");diffusealpha,0.5;visible,not GAMESTATE:IsCourseMode(););
          OnCommand=cmd(playcommand,"Set");
          ChangedLanguageDisplayMessageCommand=cmd(playcommand,"Set");
          SetCommand=function(self)
              self:settext("STAGE");
              self:playcommand("Refresh");
          end;
    };
	StandardDecorationFromFileOptional("StageDisplay","StageDisplay") .. {
	
	};
};

-- Genre/Artist data
t[#t+1] = Def.ActorFrame {
    InitCommand=cmd(x,SCREEN_CENTER_X-250;draworder,126);
    OnCommand=cmd(diffusealpha,0;smooth,0.3;diffusealpha,1;);
    OffCommand=cmd(smooth,0.3;diffusealpha,0;);
    -- Genre
    LoadFont("Common Italic Condensed") .. {
          InitCommand=cmd(horizalign,left;zoom,0.6;uppercase,true;y,SCREEN_CENTER_Y-9;diffuse,color("#512232");horizalign,left;visible,not GAMESTATE:IsCourseMode(););
          OnCommand=cmd(playcommand,"Set");
          ChangedLanguageDisplayMessageCommand=cmd(playcommand,"Set");
          SetCommand=function(self)
              self:settext("LENGTH")
              end;
    };
    StandardDecorationFromFileOptional("SongTime","SongTime") .. {
    	SetCommand=function(self)
    		local curSelection = nil;
    		local length = 0.0;
    		if GAMESTATE:IsCourseMode() then
    			curSelection = GAMESTATE:GetCurrentCourse();
    			self:playcommand("Reset");
    			if curSelection then
    				self:settext("");
    			end;
    		else
    			curSelection = GAMESTATE:GetCurrentSong();
    			self:playcommand("Reset");
    			if curSelection then
    				length = curSelection:MusicLengthSeconds();
    				if curSelection:IsLong() then
    					self:playcommand("Long");
    				elseif curSelection:IsMarathon() then
    					self:playcommand("Marathon");
    				else
    					self:playcommand("Reset");
    				end
    			else
    				length = 0.0;
    				self:playcommand("Reset");
    			end;
    			self:settext( SecondsToMSS(length) );
    		end;
    	end;
    	CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
    	CurrentCourseChangedMessageCommand=cmd(playcommand,"Set");
    	CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"Set");
    	CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"Set");
    };
};

t[#t+1] = Def.ActorFrame {
    InitCommand=cmd(x,SCREEN_CENTER_X-450;draworder,126);
    OnCommand=cmd(diffusealpha,0;smooth,0.3;diffusealpha,1;);
    OffCommand=cmd(smooth,0.3;diffusealpha,0;);
    -- Genre
    LoadFont("Common Condensed") .. {
          InitCommand=cmd(horizalign,left;zoom,0.6;uppercase,true;y,SCREEN_CENTER_Y-9;diffuse,color("#512232");horizalign,left;visible,not GAMESTATE:IsCourseMode(););
          OnCommand=cmd(playcommand,"Set");
          ChangedLanguageDisplayMessageCommand=cmd(playcommand,"Set");
          SetCommand=function(self)
              self:settext("GENRE")
              end;
    };
    LoadFont("GenreDisplay genre") .. {
          InitCommand=cmd(horizalign,left;zoom,1.0;y,SCREEN_CENTER_Y+12;maxwidth,180;diffuse,color("#512232");visible,not GAMESTATE:IsCourseMode(););
          CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
          CurrentCourseChangedMessageCommand=cmd(playcommand,"Set");
          ChangedLanguageDisplayMessageCommand=cmd(playcommand,"Set");
          SetCommand=function(self)
            local song = GAMESTATE:GetCurrentSong();
               if song then
                      self:finishtweening():diffusealpha(0):settext(song:GetGenre()):playcommand("Refresh"):smooth(0.2):diffusealpha(1)
				       else
					            self:settext(""):playcommand("Refresh")
               end
          end;
    };
};

-- BPMDisplay
t[#t+1] = Def.ActorFrame {
    InitCommand=cmd(draworder,126);
    OnCommand=cmd(diffusealpha,0;smooth,0.3;diffusealpha,1;);
    OffCommand=cmd(smooth,0.3;diffusealpha,0;);
    -- Genre
    LoadFont("Common Condensed") .. {
          InitCommand=cmd(horizalign,right;x,SCREEN_CENTER_X-47;zoom,0.6;uppercase,true;y,SCREEN_CENTER_Y-9;diffuse,color("#512232");horizalign,left;visible,not GAMESTATE:IsCourseMode(););
          OnCommand=cmd(playcommand,"Set");
          ChangedLanguageDisplayMessageCommand=cmd(playcommand,"Set");
          SetCommand=function(self)
              self:settext("SPEED")
              end;
    };
    LoadFont("Common Normal") .. {
          InitCommand=cmd(horizalign,right;x,SCREEN_CENTER_X-8;y,SCREEN_CENTER_Y+13;diffuse,color("#512232");horizalign,right;visible,not GAMESTATE:IsCourseMode(););
          OnCommand=cmd(playcommand,"Set");
          ChangedLanguageDisplayMessageCommand=cmd(playcommand,"Set");
          SetCommand=function(self)
              self:settext("BPM")
              end;
    };
    StandardDecorationFromFileOptional("BPMDisplay","BPMDisplay");
};

t[#t+1] = StandardDecorationFromFileOptional("DifficultyList","DifficultyList");
t[#t+1] = StandardDecorationFromFileOptional("SongOptions","SongOptionsText") .. {
	ShowPressStartForOptionsCommand=THEME:GetMetric(Var "LoadingScreen","SongOptionsShowCommand");
	ShowEnteringOptionsCommand=THEME:GetMetric(Var "LoadingScreen","SongOptionsEnterCommand");
	HidePressStartForOptionsCommand=THEME:GetMetric(Var "LoadingScreen","SongOptionsHideCommand");
};

t[#t+1] = Def.ActorFrame{
	Def.Quad{
		InitCommand=cmd(draworder,99;FullScreen;diffuse,color("0,0,0,1");diffusealpha,0);
		ShowPressStartForOptionsCommand=cmd(linear,0.2;diffusealpha,1);
	};
};

return t;
