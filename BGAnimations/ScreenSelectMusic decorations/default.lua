reset_needs_defective_field_for_all_players()

local t = LoadFallbackB();

-- Banner underlay
t[#t+1] = Def.ActorFrame {
    InitCommand=cmd(x,SCREEN_CENTER_X-230;draworder,125);
    OffCommand=cmd(smooth,0.2;diffusealpha,0;);
    Def.Quad {
        InitCommand=cmd(zoomto,468,196;diffuse,color("#fce1a1");diffusealpha,0.4;vertalign,top;y,SCREEN_CENTER_Y-230+47;);
      };
};

-- Sort and stage display tiles
t[#t+1] = Def.ActorFrame {
    InitCommand=cmd(x,SCREEN_CENTER_X-226;visible,not GAMESTATE:IsCourseMode(););
    OffCommand=cmd(smooth,0.2;diffusealpha,0;);
    Def.Quad {
        InitCommand=cmd(zoomto,150,60;diffuse,color("#fce1a1");diffusealpha,0.4;y,SCREEN_CENTER_Y-205-16;);
    };

    LoadFont("Common Normal") .. {
            InitCommand=cmd(zoom,0.75;y,SCREEN_CENTER_Y-223-16;diffuse,color("#000000");diffusealpha,0.5;);
            OnCommand=cmd(queuecommand,"Set");
            ChangedLanguageDisplayMessageCommand=cmd(queuecommand,"Set");
            SetCommand=function(self)
                self:settext("SORT");
                self:queuecommand("Refresh");
            end;
    };

    LoadFont("Common Italic Condensed") .. {
          InitCommand=cmd(zoom,0.75;y,SCREEN_CENTER_Y-198-16;maxwidth,SCREEN_WIDTH;diffuse,color("#9d324e");uppercase,true;);
          OnCommand=cmd(queuecommand,"Set");
          SortOrderChangedMessageCommand=cmd(queuecommand,"Set");
          ChangedLanguageDisplayMessageCommand=cmd(queuecommand,"Set");
          SetCommand=function(self)
               local sortorder = GAMESTATE:GetSortOrder();
               if sortorder then
					self:finishtweening();
					self:smooth(0.4);
					self:diffusealpha(0);
					self:addx(6);
                    self:settext(SortOrderToLocalizedString(sortorder));
                    self:queuecommand("Refresh"):stoptweening():diffusealpha(0):smooth(0.3):diffusealpha(1)
				else
					self:settext("");
					self:queuecommand("Refresh");
               end
          end;
    };
};

t[#t+1] = Def.ActorFrame {
    OffCommand=cmd(sleep,0.1;smooth,0.2;diffusealpha,0;);
    InitCommand=cmd(x,SCREEN_CENTER_X-71;visible,not GAMESTATE:IsCourseMode(););
    Def.Quad {
        InitCommand=cmd(zoomto,150,60;diffuse,color("#fce1a1");diffusealpha,0.4;y,SCREEN_CENTER_Y-205-16;);
    };

    LoadFont("Common Normal") .. {
          InitCommand=cmd(zoom,0.75;y,SCREEN_CENTER_Y-223-16;diffuse,color("#000000");diffusealpha,0.5;);
          OnCommand=cmd(queuecommand,"Set");
          ChangedLanguageDisplayMessageCommand=cmd(queuecommand,"Set");
          SetCommand=function(self)
              self:settext("STAGE");
              self:queuecommand("Refresh");
          end;
    };
	StandardDecorationFromFileOptional("StageDisplay","StageDisplay") .. {
		InitCommand=cmd(zoom,0.75);
	};
};

-- Genre/Artist data
t[#t+1] = Def.ActorFrame {
    InitCommand=cmd(x,SCREEN_CENTER_X-250;draworder,126);
    OnCommand=cmd(diffusealpha,0;smooth,0.3;diffusealpha,1;);
    OffCommand=cmd(smooth,0.3;diffusealpha,0;);
    -- Length
    LoadFont("Common Condensed") .. {
          InitCommand=cmd(horizalign,left;zoom,0.75;uppercase,true;y,SCREEN_CENTER_Y-9-16;diffuse,color("#512232");horizalign,left;);
          OnCommand=cmd(queuecommand,"Set");
          ChangedLanguageDisplayMessageCommand=cmd(queuecommand,"Set");
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
			self:queuecommand("Reset");
			if curSelection then
				local trail = GAMESTATE:GetCurrentTrail(GAMESTATE:GetMasterPlayerNumber());
				if trail then
					length = TrailUtil.GetTotalSeconds(trail);
				else
					length = 0.0;
				end;
			else
				length = 0.0;
			end;
		else
			curSelection = GAMESTATE:GetCurrentSong();
			self:queuecommand("Reset");
			if curSelection then
				length = curSelection:MusicLengthSeconds();
				if curSelection:IsLong() then
					self:queuecommand("Long");
				elseif curSelection:IsMarathon() then
					self:queuecommand("Marathon");
				else
					self:queuecommand("Reset");
				end
			else
				length = 0.0;
				self:queuecommand("Reset");
			end;
		end;
		self:settext( SecondsToMSS(length) );
	end;
    	CurrentSongChangedMessageCommand=cmd(queuecommand,"Set");
    	CurrentCourseChangedMessageCommand=cmd(queuecommand,"Set");
    	CurrentTrailP1ChangedMessageCommand=cmd(queuecommand,"Set");
    	CurrentTrailP2ChangedMessageCommand=cmd(queuecommand,"Set");
    };
};

t[#t+1] = Def.ActorFrame {
    InitCommand=cmd(x,SCREEN_CENTER_X-456;draworder,126);
    OnCommand=cmd(diffusealpha,0;smooth,0.3;diffusealpha,1;);
    OffCommand=cmd(smooth,0.3;diffusealpha,0;);
    -- Genre
    LoadFont("Common Condensed") .. {
          InitCommand=cmd(horizalign,left;zoom,0.75;uppercase,true;y,SCREEN_CENTER_Y-9-16;diffuse,color("#512232");horizalign,left;visible,not GAMESTATE:IsCourseMode(););
          OnCommand=cmd(queuecommand,"Set");
          ChangedLanguageDisplayMessageCommand=cmd(queuecommand,"Set");
          SetCommand=function(self)
              self:settext("GENRE")
              end;
    };
    LoadFont("GenreDisplay genre") .. {
          InitCommand=cmd(horizalign,left;zoom,1.0;y,SCREEN_CENTER_Y+12-16;maxwidth,180;diffuse,color("#512232");visible,not GAMESTATE:IsCourseMode(););
          CurrentSongChangedMessageCommand=cmd(queuecommand,"Set");
          CurrentCourseChangedMessageCommand=cmd(queuecommand,"Set");
          ChangedLanguageDisplayMessageCommand=cmd(queuecommand,"Set");
          SetCommand=function(self)
            local song = GAMESTATE:GetCurrentSong();
               if song then
                      self:finishtweening():diffusealpha(0):settext(song:GetGenre()):queuecommand("Refresh"):smooth(0.2):diffusealpha(1)
				       else
					  self:settext(""):queuecommand("Refresh")
               end
          end;
    };
};

-- Course type
t[#t+1] = Def.ActorFrame {
    InitCommand=cmd(x,SCREEN_CENTER_X-456;draworder,126);
    OnCommand=cmd(diffusealpha,0;smooth,0.3;diffusealpha,1;);
    OffCommand=cmd(smooth,0.3;diffusealpha,0;);
    -- Genre
    LoadFont("Common Condensed") .. {
          InitCommand=cmd(horizalign,left;zoom,0.75;uppercase,true;y,SCREEN_CENTER_Y-9-16;diffuse,color("#512232");horizalign,left;visible,GAMESTATE:IsCourseMode(););
          OnCommand=cmd(queuecommand,"Set");
          ChangedLanguageDisplayMessageCommand=cmd(queuecommand,"Set");
          SetCommand=function(self)
              self:settext("NUMBER OF SONGS")
              end;
    };
	LoadFont("GenreDisplay genre") .. { 
          InitCommand=cmd(horizalign,left;zoom,1.0;y,SCREEN_CENTER_Y+12-16;maxwidth,180;diffuse,color("#512232");visible,GAMESTATE:IsCourseMode(););
          CurrentCourseChangedMessageCommand=cmd(queuecommand,"Set"); 
          ChangedLanguageDisplayMessageCommand=cmd(queuecommand,"Set"); 
          SetCommand=function(self) 
               local course = GAMESTATE:GetCurrentCourse(); 
               if course then
					self:smooth(0.2)
					self:diffusealpha(0);
                    self:settext(course:GetEstimatedNumStages()); 
                    self:queuecommand("Refresh");
					(cmd(stoptweening;zoom,0.9;diffusealpha,0.0;smooth,0.2;diffusealpha,1;zoom,1;))(self)
				else
					self:settext("");
					self:queuecommand("Refresh"); 	
               end 
          end; 
		};
};
t[#t+1] = StandardDecorationFromFileOptional("CourseContentsList","CourseContentsList");

-- BPMDisplay
t[#t+1] = Def.ActorFrame {
    InitCommand=cmd(draworder,126;visible,not GAMESTATE:IsCourseMode(););
    OnCommand=cmd(diffusealpha,0;smooth,0.3;diffusealpha,1;);
    OffCommand=cmd(smooth,0.3;diffusealpha,0;);
    -- Genre
    LoadFont("Common Condensed") .. {
          InitCommand=cmd(horizalign,right;x,SCREEN_CENTER_X-48;zoom,0.75;uppercase,true;y,SCREEN_CENTER_Y-9-16;diffuse,color("#512232");horizalign,left;);
          OnCommand=cmd(queuecommand,"Set");
          ChangedLanguageDisplayMessageCommand=cmd(queuecommand,"Set");
          SetCommand=function(self)
              self:settext("SPEED")
              end;
    };
    LoadFont("Common Normal") .. {
          InitCommand=cmd(horizalign,right;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+13-16;diffuse,color("#512232");horizalign,right;visible,not GAMESTATE:IsCourseMode(););
          OnCommand=cmd(queuecommand,"Set");
          ChangedLanguageDisplayMessageCommand=cmd(queuecommand,"Set");
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
