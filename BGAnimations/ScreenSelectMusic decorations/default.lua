reset_needs_defective_field_for_all_players()

local t = LoadFallbackB();

-- Banner underlay
-- t[#t+1] = Def.ActorFrame {
    -- InitCommand=cmd(x,SCREEN_CENTER_X-230;draworder,125);
    -- OffCommand=cmd(smooth,0.2;diffusealpha,0;);
    -- Def.Quad {
        -- InitCommand=cmd(zoomto,468,196;diffuse,color("#fce1a1");diffusealpha,0.4;vertalign,top;y,SCREEN_CENTER_Y-230;);
      -- };
-- };

-- Banner 

	t[#t+1] = LoadActor("_bannerframe") .. {
		 InitCommand=cmd(zoom,1;x,SCREEN_CENTER_X-228;y,SCREEN_CENTER_Y-165;draworder,47);
		 OnCommand=cmd(zoomy,0;decelerate,0.3;zoomy,1;);
		 OffCommand=cmd(decelerate,0.15;zoomx,0;);
	};


-- Sort and stage display tiles
t[#t+1] = Def.ActorFrame {
    InitCommand=cmd(x,SCREEN_CENTER_X+228+40;y,SCREEN_CENTER_Y-223;visible,not GAMESTATE:IsCourseMode(););
    OffCommand=cmd(linear,0.3;diffusealpha,0;);
	LoadActor(THEME:GetPathG("", "_stageFrame"))  .. {
	    InitCommand=cmd(diffusealpha,0.9;zoom,1.5);
	};

    LoadFont("Common Condensed") .. {
            InitCommand=cmd(zoom,1;diffuse,color("#FFFFFF");diffusealpha,0.75;horizalign,left;addx,-115;);
            OnCommand=cmd(queuecommand,"Set");
            ChangedLanguageDisplayMessageCommand=cmd(queuecommand,"Set");
            SetCommand=function(self)
                self:settext("SORT:");
                self:queuecommand("Refresh");
            end;
    };

    LoadFont("Common Normal") .. {
          InitCommand=cmd(zoom,1;maxwidth,SCREEN_WIDTH;addx,115;diffuse,color("#FFFFFF");uppercase,true;horizalign,right;);
          OnCommand=cmd(queuecommand,"Set");
          SortOrderChangedMessageCommand=cmd(queuecommand,"Set");
          ChangedLanguageDisplayMessageCommand=cmd(queuecommand,"Set");
          SetCommand=function(self)
               local sortorder = GAMESTATE:GetSortOrder();
               if sortorder then
					self:finishtweening();
					self:smooth(0.4);
					self:diffusealpha(0);
                    self:settext(SortOrderToLocalizedString(sortorder));
                    self:queuecommand("Refresh"):stoptweening():diffusealpha(0):smooth(0.3):diffusealpha(1)
				else
					self:settext("");
					self:queuecommand("Refresh");
               end
          end;
    };
};

-- Genre/Artist data
t[#t+1] = LoadActor("_bpmbg") .. {
		InitCommand=cmd(horizalign,center;x,SCREEN_CENTER_X-234;y,SCREEN_CENTER_Y-60;zoom,0.75;);
		OnCommand=function(self)
		self:zoomx(0):diffusealpha(0):decelerate(0.3):zoomx(0.75):diffusealpha(1);
		end;
		OffCommand=function(self)
		self:sleep(0.2):decelerate(0.3):zoomx(0):diffusealpha(0);
		end;
		};

t[#t+1] = Def.ActorFrame {
    InitCommand=cmd(x,SCREEN_CENTER_X-330+6;draworder,126);
    OnCommand=cmd(diffusealpha,0;smooth,0.3;diffusealpha,1;);
    OffCommand=cmd(smooth,0.3;diffusealpha,0;);
    -- Length
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

-- Course type
t[#t+1] = Def.ActorFrame {
    InitCommand=cmd(x,SCREEN_CENTER_X-456;draworder,126);
    OnCommand=cmd(diffusealpha,0;smooth,0.3;diffusealpha,1;);
    OffCommand=cmd(smooth,0.3;diffusealpha,0;);
    -- Genre
    LoadFont("Common Condensed") .. {
          InitCommand=cmd(horizalign,left;zoom,0.75;uppercase,true;y,SCREEN_CENTER_Y-60-16;diffuse,color("#512232");horizalign,left;visible,GAMESTATE:IsCourseMode(););
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


if not GAMESTATE:IsCourseMode() then

-- P1 Difficulty Pane
t[#t+1] = Def.ActorFrame {
		InitCommand=cmd(visible,GAMESTATE:IsHumanPlayer(PLAYER_1);horizalign,center;x,SCREEN_CENTER_X-237-168;y,SCREEN_CENTER_Y+100;);
		OnCommand=cmd(zoomy,0.8;diffusealpha,0;smooth,0.4;diffusealpha,1;zoomy,1);
		PlayerJoinedMessageCommand=function(self,param)
			if param.Player == PLAYER_1 then
				(cmd(visible,true;diffusealpha,0;linear,0.3;diffusealpha,1))(self);
			end;
		end;
		OffCommand=cmd(decelerate,0.3;zoomy,0.8;diffusealpha,0);
		LoadActor("_diffnum")..{
			CurrentStepsP1ChangedMessageCommand=cmd(queuecommand,"Set";); 
			PlayerJoinedMessageCommand=cmd(queuecommand,"Set";diffusealpha,0;decelerate,0.3;diffusealpha,1;);
			ChangedLanguageDisplayMessageCommand=cmd(queuecommand,"Set");
			SetCommand=function(self)
					stepsP1 = GAMESTATE:GetCurrentSteps(PLAYER_1)
					local song = GAMESTATE:GetCurrentSong();
					if song then 
						if stepsP1 ~= nil then
							local st = stepsP1:GetStepsType();
							local diff = stepsP1:GetDifficulty();
							local courseType = GAMESTATE:IsCourseMode() and SongOrCourse:GetCourseType() or nil;
							local cd = GetCustomDifficulty(st, diff, courseType);
							self:finishtweening():linear(0.2):diffuse(ColorLightTone(CustomDifficultyToColor(cd)));
						else
							self:diffuse(color("#666666"));
						end
					else
							self:diffuse(color("#666666"));
					end
				  end
		};
		LoadActor("_diffpane")..{
			CurrentStepsP1ChangedMessageCommand=cmd(queuecommand,"Set";); 
			PlayerJoinedMessageCommand=cmd(queuecommand,"Set";diffusealpha,0;decelerate,0.3;diffusealpha,1;);
			ChangedLanguageDisplayMessageCommand=cmd(queuecommand,"Set");
			SetCommand=function(self)
					stepsP1 = GAMESTATE:GetCurrentSteps(PLAYER_1)
					local song = GAMESTATE:GetCurrentSong();
					if song then 
						if stepsP1 ~= nil then
							local st = stepsP1:GetStepsType();
							local diff = stepsP1:GetDifficulty();
							local courseType = GAMESTATE:IsCourseMode() and SongOrCourse:GetCourseType() or nil;
							local cd = GetCustomDifficulty(st, diff, courseType);
							self:finishtweening():linear(0.2):diffuse(ColorMidTone(CustomDifficultyToColor(cd)));
						else
							self:diffuse(color("#666666"));
						end
					else
						self:diffuse(color("#666666"));
					end
				  end
		};
		LoadFont("StepsDisplay meter") .. { 
			  InitCommand=cmd(zoom,1;addy,-120;diffuse,color("#000000"););
			  OnCommand=cmd(diffusealpha,0;smooth,0.2;diffusealpha,0.75;);
			  OffCommand=cmd(linear,0.3;diffusealpha,0;);
			  CurrentStepsP1ChangedMessageCommand=cmd(queuecommand,"Set";); 
			  PlayerJoinedMessageCommand=cmd(queuecommand,"Set";diffusealpha,0;linear,0.3;diffusealpha,0.75;);
			  ChangedLanguageDisplayMessageCommand=cmd(queuecommand,"Set");
			  SetCommand=function(self)
				stepsP1 = GAMESTATE:GetCurrentSteps(PLAYER_1)
				local song = GAMESTATE:GetCurrentSong();
				if song then 
					if stepsP1 ~= nil then
						local st = stepsP1:GetStepsType();
						local diff = stepsP1:GetDifficulty();
						local courseType = GAMESTATE:IsCourseMode() and SongOrCourse:GetCourseType() or nil;
						local cd = GetCustomDifficulty(st, diff, courseType);
						self:settext(stepsP1:GetMeter())
					else
						self:settext("")
					end
				else
					self:settext("")
				end
			  end
		};
		LoadFont("Common Condensed") .. { 
			  InitCommand=cmd(uppercase,true;zoom,0.75;addy,-170;diffuse,color("#000000"););
			  OnCommand=cmd(diffusealpha,0;smooth,0.2;diffusealpha,0.75;);
			  OffCommand=cmd(linear,0.3;diffusealpha,0;);
			  CurrentStepsP1ChangedMessageCommand=cmd(queuecommand,"Set";); 
			  PlayerJoinedMessageCommand=cmd(queuecommand,"Set";diffusealpha,0;linear,0.3;diffusealpha,0.75;);
			  ChangedLanguageDisplayMessageCommand=cmd(queuecommand,"Set");
			  SetCommand=function(self)
				stepsP1 = GAMESTATE:GetCurrentSteps(PLAYER_1)
				local song = GAMESTATE:GetCurrentSong();
				if song then 
					if stepsP1 ~= nil then
						local st = stepsP1:GetStepsType();
						local diff = stepsP1:GetDifficulty();
						local courseType = GAMESTATE:IsCourseMode() and SongOrCourse:GetCourseType() or nil;
						local cd = GetCustomDifficulty(st, diff, courseType);
						self:settext(THEME:GetString("CustomDifficulty",ToEnumShortString(diff)));
					else
						self:settext("")
					end
				else
					self:settext("")
				end
			  end
		};
		LoadFont("Common Condensed") .. { 
			  InitCommand=cmd(uppercase,true;zoom,0.75;addy,-151;diffuse,color("#000000"););
			  OnCommand=cmd(diffusealpha,0;smooth,0.2;diffusealpha,0.75;);
			  OffCommand=cmd(linear,0.3;diffusealpha,0;);
			  CurrentStepsP1ChangedMessageCommand=cmd(queuecommand,"Set";); 
			  PlayerJoinedMessageCommand=cmd(queuecommand,"Set";diffusealpha,0;linear,0.3;diffusealpha,0.75;);
			  ChangedLanguageDisplayMessageCommand=cmd(queuecommand,"Set");
			  SetCommand=function(self)
				stepsP1 = GAMESTATE:GetCurrentSteps(PLAYER_1)
				local song = GAMESTATE:GetCurrentSong();
				if song then 
					if stepsP1 ~= nil then
						local st = stepsP1:GetStepsType();
						local diff = stepsP1:GetDifficulty();
						local courseType = GAMESTATE:IsCourseMode() and SongOrCourse:GetCourseType() or nil;
						local cd = GetCustomDifficulty(st, diff, courseType);
						self:settext(THEME:GetString("StepsType",ToEnumShortString(st)));
					else
						self:settext("")
					end
				else
					self:settext("")
				end
			  end
		};
	};
	
-- P2 Difficulty Pane	
t[#t+1] = Def.ActorFrame {
		InitCommand=cmd(visible,GAMESTATE:IsHumanPlayer(PLAYER_2);horizalign,center;x,SCREEN_CENTER_X-237+186;y,SCREEN_CENTER_Y+100;);
		OnCommand=cmd(zoomy,0.8;diffusealpha,0;smooth,0.4;diffusealpha,1;zoomy,1);
		PlayerJoinedMessageCommand=function(self,param)
			if param.Player == PLAYER_2 then
				(cmd(visible,true;diffusealpha,0;linear,0.3;diffusealpha,1))(self);
			end;
		end;
		OffCommand=cmd(decelerate,0.3;zoomy,0.8;diffusealpha,0);
		LoadActor("_diffnum")..{
			CurrentStepsP2ChangedMessageCommand=cmd(queuecommand,"Set";); 
			PlayerJoinedMessageCommand=cmd(queuecommand,"Set";diffusealpha,0;decelerate,0.3;diffusealpha,1;);
			ChangedLanguageDisplayMessageCommand=cmd(queuecommand,"Set");
			SetCommand=function(self)
					stepsP2 = GAMESTATE:GetCurrentSteps(PLAYER_2)
					local song = GAMESTATE:GetCurrentSong();
					if song then 
						if stepsP2 ~= nil then
							local st = stepsP2:GetStepsType();
							local diff = stepsP2:GetDifficulty();
							local courseType = GAMESTATE:IsCourseMode() and SongOrCourse:GetCourseType() or nil;
							local cd = GetCustomDifficulty(st, diff, courseType);
							self:finishtweening():linear(0.2):diffuse(ColorLightTone(CustomDifficultyToColor(cd)));
						else
							self:diffuse(color("#666666"));
						end
					else
						self:diffuse(color("#666666"));
					end
				  end
		};
		LoadActor("_diffpane")..{
			CurrentStepsP2ChangedMessageCommand=cmd(queuecommand,"Set";); 
			PlayerJoinedMessageCommand=cmd(queuecommand,"Set";diffusealpha,0;decelerate,0.3;diffusealpha,1;);
			ChangedLanguageDisplayMessageCommand=cmd(queuecommand,"Set");
			SetCommand=function(self)
					stepsP2 = GAMESTATE:GetCurrentSteps(PLAYER_2)
					local song = GAMESTATE:GetCurrentSong();
					if song then 
						if stepsP2 ~= nil then
							local st = stepsP2:GetStepsType();
							local diff = stepsP2:GetDifficulty();
							local courseType = GAMESTATE:IsCourseMode() and SongOrCourse:GetCourseType() or nil;
							local cd = GetCustomDifficulty(st, diff, courseType);
							self:finishtweening():linear(0.2):diffuse(ColorMidTone(CustomDifficultyToColor(cd)));
						else
							self:diffuse(color("#666666"));
						end
					else
						self:diffuse(color("#666666"));
					end
				  end
		};
				LoadFont("StepsDisplay meter") .. { 
			  InitCommand=cmd(zoom,1;addy,-120;diffuse,color("#000000"););
			  OnCommand=cmd(diffusealpha,0;smooth,0.2;diffusealpha,0.75;);
			  OffCommand=cmd(linear,0.3;diffusealpha,0;);
			  CurrentStepsP2ChangedMessageCommand=cmd(queuecommand,"Set";); 
			  PlayerJoinedMessageCommand=cmd(queuecommand,"Set";diffusealpha,0;linear,0.3;diffusealpha,0.75;);
			  ChangedLanguageDisplayMessageCommand=cmd(queuecommand,"Set");
			  SetCommand=function(self)
				stepsP2 = GAMESTATE:GetCurrentSteps(PLAYER_2)
				local song = GAMESTATE:GetCurrentSong();
				if song then 
					if stepsP2 ~= nil then
						local st = stepsP2:GetStepsType();
						local diff = stepsP2:GetDifficulty();
						local courseType = GAMESTATE:IsCourseMode() and SongOrCourse:GetCourseType() or nil;
						local cd = GetCustomDifficulty(st, diff, courseType);
						self:settext(stepsP2:GetMeter())
					else
						self:settext("")
					end
				else
					self:settext("")
				end
			  end
		};
		LoadFont("Common Condensed") .. { 
			  InitCommand=cmd(uppercase,true;zoom,0.75;addy,-170;diffuse,color("#000000"););
			  OnCommand=cmd(diffusealpha,0;smooth,0.2;diffusealpha,0.75;);
			  OffCommand=cmd(linear,0.3;diffusealpha,0;);
			  CurrentStepsP2ChangedMessageCommand=cmd(queuecommand,"Set";); 
			  PlayerJoinedMessageCommand=cmd(queuecommand,"Set";diffusealpha,0;linear,0.3;diffusealpha,0.75;);
			  ChangedLanguageDisplayMessageCommand=cmd(queuecommand,"Set");
			  SetCommand=function(self)
				stepsP2 = GAMESTATE:GetCurrentSteps(PLAYER_2)
				local song = GAMESTATE:GetCurrentSong();
				if song then 
					if stepsP2 ~= nil then
						local st = stepsP2:GetStepsType();
						local diff = stepsP2:GetDifficulty();
						local courseType = GAMESTATE:IsCourseMode() and SongOrCourse:GetCourseType() or nil;
						local cd = GetCustomDifficulty(st, diff, courseType);
						self:settext(THEME:GetString("CustomDifficulty",ToEnumShortString(diff)));
					else
						self:settext("")
					end
				else
					self:settext("")
				end
			  end
		};
		LoadFont("Common Condensed") .. { 
			  InitCommand=cmd(uppercase,true;zoom,0.75;addy,-151;diffuse,color("#000000"););
			  OnCommand=cmd(diffusealpha,0;smooth,0.2;diffusealpha,0.75;);
			  OffCommand=cmd(linear,0.3;diffusealpha,0;);
			  CurrentStepsP2ChangedMessageCommand=cmd(queuecommand,"Set";); 
			  PlayerJoinedMessageCommand=cmd(queuecommand,"Set";diffusealpha,0;linear,0.3;diffusealpha,0.75;);
			  ChangedLanguageDisplayMessageCommand=cmd(queuecommand,"Set");
			  SetCommand=function(self)
				stepsP2 = GAMESTATE:GetCurrentSteps(PLAYER_2)
				local song = GAMESTATE:GetCurrentSong();
				if song then 
					if stepsP2 ~= nil then
						local st = stepsP2:GetStepsType();
						local diff = stepsP2:GetDifficulty();
						local courseType = GAMESTATE:IsCourseMode() and SongOrCourse:GetCourseType() or nil;
						local cd = GetCustomDifficulty(st, diff, courseType);
						self:settext(THEME:GetString("StepsType",ToEnumShortString(st)));
					else
						self:settext("")
					end
				else
					self:settext("")
				end
			  end
		};
	};

t[#t+1] = StandardDecorationFromFileOptional("PaneDisplayTextP1","PaneDisplayTextP1");
t[#t+1] = StandardDecorationFromFileOptional("PaneDisplayTextP2","PaneDisplayTextP2");	

end;

-- BPMDisplay
t[#t+1] = Def.ActorFrame {
    InitCommand=cmd(draworder,126;visible,not GAMESTATE:IsCourseMode(););
    OnCommand=cmd(diffusealpha,0;smooth,0.3;diffusealpha,1;);
    OffCommand=cmd(linear,0.3;diffusealpha,0;);
    LoadFont("Common Condensed") .. {
          InitCommand=cmd(horizalign,right;x,SCREEN_CENTER_X-198+69;y,SCREEN_CENTER_Y-64+2;diffuse,color("#512232");horizalign,right;visible,not GAMESTATE:IsCourseMode(););
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
		InitCommand=cmd(draworder,160;FullScreen;diffuse,color("0,0,0,1");diffusealpha,0);
		ShowPressStartForOptionsCommand=cmd(sleep,0.2;decelerate,0.5;diffusealpha,1);
	};
};

t[#t+1] = StandardDecorationFromFileOptional("AlternateHelpDisplay","AlternateHelpDisplay");


t[#t+1] = Def.ActorFrame {
    OffCommand=cmd(sleep,0.1;linear,0.2;diffusealpha,0;);
    InitCommand=cmd(x,SCREEN_CENTER_X-228;visible,not GAMESTATE:IsCourseMode(););

	StandardDecorationFromFileOptional("StageDisplay","StageDisplay") .. {
		InitCommand=cmd(zoom,1);
	};
};

return t;
