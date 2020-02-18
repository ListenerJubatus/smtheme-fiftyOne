local curStage = GAMESTATE:GetCurrentStage();
local curStageIndex = GAMESTATE:GetCurrentStageIndex();
local t = LoadFallbackB();

local function PercentScore(pn)
	local t = LoadFont("_overpass Score")..{
		InitCommand=function(self) self:zoom(1):diffuse(Color("Black")):diffusealpha(0.75) end;
		BeginCommand=function(self) self:playcommand("Set") end;
		SetCommand=function(self)
			local SongOrCourse, StepsOrTrail;
			if GAMESTATE:IsCourseMode() then
				SongOrCourse = GAMESTATE:GetCurrentCourse();
				StepsOrTrail = GAMESTATE:GetCurrentTrail(pn);
			else
				SongOrCourse = GAMESTATE:GetCurrentSong();
				StepsOrTrail = GAMESTATE:GetCurrentSteps(pn);
			end;

			local profile, scorelist;
			local text = "";
			if SongOrCourse and StepsOrTrail then
				local st = StepsOrTrail:GetStepsType();
				local diff = StepsOrTrail:GetDifficulty();
				local courseType = GAMESTATE:IsCourseMode() and SongOrCourse:GetCourseType() or nil;
				local cd = GetCustomDifficulty(st, diff, courseType);

				if PROFILEMAN:IsPersistentProfile(pn) then
					-- player profile
					profile = PROFILEMAN:GetProfile(pn);
				else
					-- machine profile
					profile = PROFILEMAN:GetMachineProfile();
				end;

				scorelist = profile:GetHighScoreList(SongOrCourse,StepsOrTrail);
				assert(scorelist)
				local scores = scorelist:GetHighScores();
				local topscore = scores[1];
				if topscore then
					text = string.format("%.2f%%", topscore:GetPercentDP()*100.0);
					-- 100% hack
					if text == "100.00%" then
						text = "100%";
					end;
				else
					text = string.format("%.2f%%", 0);
				end;
			else
				text = "";
			end;
			self:settext(text);
		end;
		CurrentSongChangedMessageCommand=function(self) self:playcommand("Set") end;
		CurrentCourseChangedMessageCommand=function(self) self:playcommand("Set") end;
	};

	if pn == PLAYER_1 then
		t.CurrentStepsP1ChangedMessageCommand=function(self) self:playcommand("Set") end;
		t.CurrentTrailP1ChangedMessageCommand=function(self) self:playcommand("Set") end;
	else
		t.CurrentStepsP2ChangedMessageCommand=function(self) self:playcommand("Set") end;
		t.CurrentTrailP2ChangedMessageCommand=function(self) self:playcommand("Set") end;
	end

	return t;
end

-- Banner 

t[#t+1] = LoadActor(THEME:GetPathG("ScreenSelectMusic", "banner overlay")) .. {
		InitCommand=function(self) self:zoom(1):xy(SCREEN_CENTER_X-228,SCREEN_CENTER_Y-165-20):draworder(47) end;
		OnCommand=function(self)
			self:diffuse(StageToColor(curStage));
			self:zoomy(0):decelerate(0.3):zoomy(1);
		end;
		OffCommand=function(self) self:decelerate(0.15):zoomx(0) end;
	};


-- Info Pane
t[#t+1] = LoadActor(THEME:GetPathG("ScreenSelectMusic", "info pane")) .. {
		InitCommand=function(self) self:horizalign(center):xy(SCREEN_CENTER_X-228,SCREEN_CENTER_Y-75-6):zoom(1) end;
		OnCommand=function(self)
			self:diffuse(ColorMidTone(StageToColor(curStage)));
			self:zoomx(0):diffusealpha(0):decelerate(0.3):zoomx(1):diffusealpha(1);
		end;
		OffCommand=function(self)
			self:sleep(0.3):decelerate(0.15):zoomx(0):diffusealpha(0);
		end;
		};

t[#t+1] = Def.ActorFrame {
	InitCommand=function(self) self:x(SCREEN_CENTER_X-330+6-138):draworder(126) end;
	OnCommand=function(self) self:diffusealpha(0):smooth(0.3):diffusealpha(1) end;
	OffCommand=function(self) self:smooth(0.3):diffusealpha(0) end;
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
    	CurrentSongChangedMessageCommand=function(self) self:queuecommand("Set") end;
    	CurrentCourseChangedMessageCommand=function(self) self:queuecommand("Set") end;
    	CurrentTrailP1ChangedMessageCommand=function(self) self:queuecommand("Set") end;
    	CurrentTrailP2ChangedMessageCommand=function(self) self:queuecommand("Set") end;
    };
};

-- Course count and type
t[#t+1] = Def.ActorFrame {
	InitCommand=function(self) self:x(SCREEN_CENTER_X-200):draworder(126) end;
	OnCommand=function(self) self:diffusealpha(0):smooth(0.3):diffusealpha(1) end;
	OffCommand=function(self) self:smooth(0.3):diffusealpha(0) end;
	LoadFont("Common Condensed") .. { 
          InitCommand=function(self) self:horizalign(right):zoom(1):y(SCREEN_CENTER_Y-78+2-6):maxwidth(180):diffuse(color("#DFE2E9")):visible(GAMESTATE:IsCourseMode()) end;
          CurrentCourseChangedMessageCommand=function(self) self:queuecommand("Set") end; 
          ChangedLanguageDisplayMessageCommand=function(self) self:queuecommand("Set") end; 
          SetCommand=function(self) 
               local course = GAMESTATE:GetCurrentCourse(); 
               if course then
                    self:settext(course:GetEstimatedNumStages() .. " songs"); 
                    self:queuecommand("Refresh");
				else
					self:settext("");
					self:queuecommand("Refresh"); 	
               end 
          end; 
		};
};
t[#t+1] = Def.ActorFrame {
	InitCommand=function(self) self:x(SCREEN_CENTER_X+5):draworder(126) end;
	OnCommand=function(self) self:diffusealpha(0):smooth(0.3):diffusealpha(1) end;
	OffCommand=function(self) self:smooth(0.3):diffusealpha(0) end;
	LoadFont("Common Condensed") .. { 
	  InitCommand=function(self) self:horizalign(right):zoom(1):y(SCREEN_CENTER_Y-76-6):maxwidth(180):diffuse(color("#DFE2E9")):visible(GAMESTATE:IsCourseMode()) end;
	  CurrentCourseChangedMessageCommand=function(self) self:queuecommand("Set") end; 
	  ChangedLanguageDisplayMessageCommand=function(self) self:queuecommand("Set") end; 
	  SetCommand=function(self) 
		   local course = GAMESTATE:GetCurrentCourse(); 
		   if course then
				self:settext(CourseTypeToLocalizedString(course:GetCourseType())); 
				self:queuecommand("Refresh");
			else
				self:settext("");
				self:queuecommand("Refresh"); 	
		   end 
	  end; 
	};
};
t[#t+1] = StandardDecorationFromFileOptional("CourseContentsList","CourseContentsList");


if not GAMESTATE:IsCourseMode() then

-- Difficulty Panes
for player in ivalues(PlayerNumber) do
	t[#t+1] = Def.ActorFrame {
		InitCommand=function(self)
			self:visible(GAMESTATE:IsHumanPlayer(player))
			:horizalign(center):xy((player == PLAYER_1 and SCREEN_CENTER_X-210-32) or SCREEN_CENTER_X+210+32,SCREEN_CENTER_Y+230+10)
		end;
		OnCommand=function(self) self:zoomy(0.8):diffusealpha(0):smooth(0.4):diffusealpha(1):zoomy(1) end;

		PlayerJoinedMessageCommand=function(self,param)
			if param.Player == player then
				self:visible(true):diffusealpha(0):linear(0.3):diffusealpha(1)
			end;
		end;
		OffCommand=function(self) self:decelerate(0.3):diffusealpha(0) end;
		
		LoadActor(THEME:GetPathG("ScreenSelectMusic", "pane background")) .. {
			["CurrentSteps"..ToEnumShortString(player).."ChangedMessageCommand"]=function(self) self:playcommand("Set") end;
			InitCommand=function(self)
			self:zoomx( (player == PLAYER_2 and -1) or 1)
			end;
			PlayerJoinedMessageCommand=function(self) self:queuecommand("Set"):diffusealpha(0):decelerate(0.3):diffusealpha(1) end;
			ChangedLanguageDisplayMessageCommand=function(self) self:queuecommand("Set") end;
			SetCommand=function(self)
					local steps = GAMESTATE:GetCurrentSteps(player)
					local song = GAMESTATE:GetCurrentSong();
					if song then 
						if steps ~= nil then
							local st = steps:GetStepsType();
							local diff = steps:GetDifficulty();
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
		LoadFont("StepsDisplay meter") .. { 
			  InitCommand=function(self) self:zoom(1.25):diffuse(color("#000000")):addx((player == PLAYER_1 and -143) or 143 ):addy(13) end;
			  OnCommand=function(self) self:diffusealpha(0):smooth(0.2):diffusealpha(0.75) end;
			  OffCommand=function(self) self:linear(0.3):diffusealpha(0) end;
			  ["CurrentSteps"..ToEnumShortString(player).."ChangedMessageCommand"]=function(self) self:playcommand("Set") end;
			  PlayerJoinedMessageCommand=function(self) self:queuecommand("Set"):diffusealpha(0):linear(0.3):diffusealpha(0.75) end;
			  ChangedLanguageDisplayMessageCommand=function(self) self:queuecommand("Set") end;
			  SetCommand=function(self)
				local steps = GAMESTATE:GetCurrentSteps(player)
				local song = GAMESTATE:GetCurrentSong();
				if song then 
					if steps ~= nil then
						local st = steps:GetStepsType();
						local diff = steps:GetDifficulty();
						local courseType = GAMESTATE:IsCourseMode() and SongOrCourse:GetCourseType() or nil;
						local cd = GetCustomDifficulty(st, diff, courseType);
						self:settext(steps:GetMeter())
					else
						self:settext("")
					end
				else
					self:settext("")
				end
			  end
		};
		LoadFont("_open sans condensed 24px") .. { 
			  InitCommand=function(self) self:uppercase(true):zoom(1):addy(-40):skewx(-0.1):addx((player == PLAYER_1 and -143) or 143 ):diffuse(Color.Black):maxwidth(115) end;
			  OnCommand=function(self) self:diffusealpha(0):smooth(0.2):diffusealpha(0.75) end;
			  OffCommand=function(self) self:linear(0.3):diffusealpha(0) end;
			 ["CurrentSteps"..ToEnumShortString(player).."ChangedMessageCommand"]=function(self) self:playcommand("Set") end;
			  PlayerJoinedMessageCommand=function(self) self:queuecommand("Set"):diffusealpha(0):linear(0.3):diffusealpha(0.75) end; 
			  ChangedLanguageDisplayMessageCommand=function(self) self:queuecommand("Set") end;
			  SetCommand=function(self)
				local steps = GAMESTATE:GetCurrentSteps(player)
				local song = GAMESTATE:GetCurrentSong();
				if song then 
					if steps ~= nil then
						local st = steps:GetStepsType();
						local diff = steps:GetDifficulty();
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
		LoadFont("_open sans semibold 24px") .. { 
			  InitCommand=function(self) self:uppercase(true):zoom(0.75):addy(-20):addx((player == PLAYER_1 and -143) or 143 ):diffuse(color("#000000")):maxwidth(130) end;
			  OnCommand=function(self) self:diffusealpha(0):smooth(0.2):diffusealpha(0.75) end;
			  OffCommand=function(self) self:linear(0.3):diffusealpha(0) end;
			  ["CurrentSteps"..ToEnumShortString(player).."ChangedMessageCommand"]=function(self) self:playcommand("Set") end;
			  PlayerJoinedMessageCommand=function(self) self:queuecommand("Set"):diffusealpha(0):linear(0.3):diffusealpha(0.75) end; 
			  ChangedLanguageDisplayMessageCommand=function(self) self:queuecommand("Set") end;
			  SetCommand=function(self)
				local steps = GAMESTATE:GetCurrentSteps(player)
				local song = GAMESTATE:GetCurrentSong();
				if song then 
					if steps ~= nil then
						local st = steps:GetStepsType();
						local diff = steps:GetDifficulty();
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
end

t[#t+1] = StandardDecorationFromFileOptional("PaneDisplayTextP1","PaneDisplayTextP1");
t[#t+1] = StandardDecorationFromFileOptional("PaneDisplayTextP2","PaneDisplayTextP2");	

t[#t+1] = StandardDecorationFromTable("PercentScore"..ToEnumShortString(PLAYER_1), PercentScore(PLAYER_1));
t[#t+1] = StandardDecorationFromTable("PercentScore"..ToEnumShortString(PLAYER_2), PercentScore(PLAYER_2));

end;


if not GAMESTATE:IsCourseMode() then
-- CD title
	local function CDTitleUpdate(self)
		local song = GAMESTATE:GetCurrentSong();
		local cdtitle = self:GetChild("CDTitle");
		local height = cdtitle:GetHeight();
		if song then
			if song:HasCDTitle() then
				cdtitle:visible(true);
				cdtitle:Load(song:GetCDTitlePath());
			else
				cdtitle:visible(false);
			end;
		else
			cdtitle:visible(false);
		end;
		self:zoom(scale(height,32,240,1,32/240))
	end;
	t[#t+1] = Def.ActorFrame {
		OnCommand=function(self) self:draworder(49):xy(SCREEN_CENTER_X-420,SCREEN_CENTER_Y-147):diffusealpha(0):decelerate(0.25):diffusealpha(1):SetUpdateFunction(CDTitleUpdate) end;
		OffCommand=function(self) self:decelerate(0.3):diffusealpha(0) end;
		Def.Sprite {
			Name="CDTitle";
			OnCommand=function(self) self:draworder(49):zoom(0.75):diffusealpha(1):zoom(0):bounceend(0.35):zoom(0.75) end;
			BackCullCommand=function(self) self:diffuse(color("0.5,0.5,0.5,1")) end;
			OffCommand=function(self) self:decelerate(0.3):diffusealpha(0) end;
		};	
	};
end;

-- BPMDisplay
t[#t+1] = Def.ActorFrame {
    InitCommand=function(self) self:draworder(126):visible(not GAMESTATE:IsCourseMode()) end;
    OnCommand=function(self) self:diffusealpha(0):smooth(0.3):diffusealpha(1) end;
    OffCommand=function(self) self:linear(0.3):diffusealpha(0) end;
    LoadFont("Common Condensed") .. {
          InitCommand=function(self) self:horizalign(right):x(SCREEN_CENTER_X-198+69-66):y(SCREEN_CENTER_Y-76-6):diffuse(color("#512232")):horizalign(right):visible(not GAMESTATE:IsCourseMode()) end;
          OnCommand=function(self) self:queuecommand("Set") end;
          ChangedLanguageDisplayMessageCommand=function(self) self:queuecommand("Set") end;
          SetCommand=function(self)
              self:settext("BPM"):diffuse(ColorLightTone(StageToColor(curStage)));
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
		InitCommand=function(self) self:draworder(160):FullScreen():diffuse(color("0,0,0,1")):diffusealpha(0) end;
		ShowPressStartForOptionsCommand=function(self) self:sleep(0.2):decelerate(0.5):diffusealpha(1) end;
	};
};

t[#t+1] = StandardDecorationFromFileOptional("AlternateHelpDisplay","AlternateHelpDisplay");


t[#t+1] = Def.ActorFrame {
    OffCommand=function(self) self:sleep(0.1):linear(0.2):diffusealpha(0) end;
    InitCommand=function(self) self:x(SCREEN_CENTER_X-84):visible(not GAMESTATE:IsCourseMode()) end;

	StandardDecorationFromFileOptional("StageDisplay","StageDisplay") .. {
		InitCommand=function(self) self:zoom(1) end;
	};
};

return t;