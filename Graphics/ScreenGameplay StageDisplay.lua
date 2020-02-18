local curScreen = Var "LoadingScreen";
local curStageIndex = GAMESTATE:GetCurrentStageIndex() + 1;
local playMode = GAMESTATE:GetPlayMode();

local t = Def.ActorFrame {
	LoadActor(		THEME:GetPathG("ScreenGameplay", "progress"))  .. {
		OnCommand=function(self) self:playcommand("Set") end;
		CurrentSongChangedMessageCommand=function(self) self:playcommand("Set") end;
		CurrentCourseChangedMessageCommand=function(self) self:playcommand("Set") end;
		CurrentStepsP1ChangedMessageCommand=function(self) self:playcommand("Set") end;
		CurrentStepsP2ChangedMessageCommand=function(self) self:playcommand("Set") end;
		CurrentTraiP1ChangedMessageCommand=function(self) self:playcommand("Set") end;
		CurrentTraiP2ChangedMessageCommand=function(self) self:playcommand("Set") end;
		SetCommand=function(self)
		local curStage = GAMESTATE:GetCurrentStage();
			self:diffuse(ColorMidTone(StageToColor(curStage)))
		end
	};
	LoadFont("_open sans condensed 24px") .. {
		InitCommand=function(self) self:xy(-143,-1):uppercase(true):horizalign(center):maxwidth(170):skewx(-0.1):playcommand("Set") end;
		CurrentSongChangedMessageCommand=function(self) self:playcommand("Set") end;
		CurrentCourseChangedMessageCommand=function(self) self:playcommand("Set") end;
		CurrentStepsP1ChangedMessageCommand=function(self) self:playcommand("Set") end;
		CurrentStepsP2ChangedMessageCommand=function(self) self:playcommand("Set") end;
		CurrentTraiP1ChangedMessageCommand=function(self) self:playcommand("Set") end;
		CurrentTraiP2ChangedMessageCommand=function(self) self:playcommand("Set") end;
		SetCommand=function(self)
			local curStage = GAMESTATE:GetCurrentStage();
			if GAMESTATE:IsCourseMode() then
				local stats = STATSMAN:GetCurStageStats()
				if not stats then
					return
				end
				local mpStats = stats:GetPlayerStageStats( GAMESTATE:GetMasterPlayerNumber() )
				local songsPlayed = mpStats:GetSongsPassed() + 1
				self:settextf("%i / %i", songsPlayed, GAMESTATE:GetCurrentCourse():GetEstimatedNumStages());
			else
				if GAMESTATE:IsEventMode() then
					self:settextf("Stage %s", curStageIndex);
				else
					local thed_stage= thified_curstage_index(false)
					if THEME:GetMetric(curScreen,"StageDisplayUseShortString") then
						self:settextf(thed_stage)
					else
						self:settextf("%s Stage", thed_stage)
					end
				end
			end;
			self:zoom(1);
			self:diffuse(color("#FFFFFF")):diffusetopedge(ColorLightTone(StageToColor(curStage)));
		end;
	};
};
return t