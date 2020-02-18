local curScreen = Var "LoadingScreen";
local curStageIndex = GAMESTATE:GetCurrentStageIndex();
local t = Def.ActorFrame {};

t[#t+1] = Def.ActorFrame {
	LoadActor(THEME:GetPathG("", "_sortFrame"))  .. {
	    InitCommand=function(self) self:diffusealpha(0.9):zoom(1.5) end;
		BeginCommand=function(self)
			local top = SCREENMAN:GetTopScreen()
			if top then
				if not string.find(top:GetName(),"ScreenEvaluation") then
					curStageIndex = curStageIndex + 1
				end
			end
			self:playcommand("Set")
		end;
		SetCommand=function(self)
			local curStage = GAMESTATE:GetCurrentStage();
			self:diffuse(StageToColor(curStage));
		end
	};
	LoadFont("_open sans condensed 24px") .. {
		InitCommand=function(self) self:y(-1):zoom(1):shadowlength(1):skewx(-0.1):uppercase(true) end;
		BeginCommand=function(self)
			local top = SCREENMAN:GetTopScreen()
			if top then
				if not string.find(top:GetName(),"ScreenEvaluation") then
					curStageIndex = curStageIndex + 1
				end
			end
			self:playcommand("Set")
		end;
		CurrentSongChangedMessageCommand=function(self) self:playcommand("Set") end;
		SetCommand=function(self)
			local curStage = GAMESTATE:GetCurrentStage();
			if GAMESTATE:GetCurrentCourse() then
				self:settext( curStageIndex+1 .. " / " .. GAMESTATE:GetCurrentCourse():GetEstimatedNumStages() );
			elseif GAMESTATE:IsEventMode() then
				self:settextf("Stage %s", curStageIndex);
			else
				local thed_stage= thified_curstage_index(curScreen:find("Evaluation"))
				if THEME:GetMetric(curScreen,"StageDisplayUseShortString") then
					self:settext(thed_stage)
					self:zoom(0.75);
				else
					self:settextf("%s Stage", thed_stage);
					self:zoom(1);
				end;
			end;
			-- StepMania is being stupid so we have to do this here;
			self:diffuse(color("#FFFFFF")):diffusetopedge(ColorLightTone(StageToColor(curStage)));
			self:diffusealpha(0):smooth(0.3):diffusealpha(1);
		end;
	};
};
return t