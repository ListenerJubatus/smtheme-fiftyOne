local curScreen = Var "LoadingScreen";
local curStage = GAMESTATE:GetCurrentStage();
local curStageIndex = GAMESTATE:GetCurrentStageIndex();
local t = Def.ActorFrame {};

t[#t+1] = Def.ActorFrame {
	LoadActor(THEME:GetPathG("", "_stageFrame"))  .. {
	    InitCommand=cmd(diffusealpha,0.85;zoom,1.25);
		OnCommand=function(self)
			self:diffuse(ColorMidTone(StageToColor(curStage)))
		end;
	};
	LoadFont("Common Italic Condensed") .. {
		InitCommand=cmd(y,-1;zoom,1.2;);
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
			if GAMESTATE:GetCurrentCourse() then
				self:settext( curStageIndex+1 .. " / " .. GAMESTATE:GetCurrentCourse():GetEstimatedNumStages() );
			elseif GAMESTATE:IsEventMode() then
				self:settextf("STAGE %s", curStageIndex);
			else
				if THEME:GetMetric(curScreen,"StageDisplayUseShortString") then
				  self:settextf("%s", ToEnumShortString(curStage));
				  self:zoom(1);
				else
				  self:settextf("%s STAGE", ToEnumShortString(curStage));
				  self:zoom(1);
				end;
			end;
			-- StepMania is being stupid so we have to do this here;
			self:diffuse(ColorLightTone(StageToColor(curStage))):diffusebottomedge(StageToColor(curStage));
			self:diffusealpha(0):smooth(0.3):diffusealpha(1);
		end;
	};
};
return t