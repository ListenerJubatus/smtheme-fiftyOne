local t = Def.ActorFrame {};
	-- Bar
	t[#t+1] = LoadActor(THEME:GetPathG("LifeMeter", "p1 bar")) .. {
	};

	-- Difficulty
	t[#t+1] = LoadActor(THEME:GetPathG("LifeMeter", "p1 shad")) .. {
	};

	t[#t+1] = LoadActor(THEME:GetPathG("LifeMeter", "p1 diff")) .. {
		OnCommand=cmd(playcommand,"Set";);
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Set";);
		SetCommand=function(self)
			stepsP1 = GAMESTATE:GetCurrentSteps(PLAYER_1)
			local song = GAMESTATE:GetCurrentSong();
			if song then
				if stepsP1 ~= nil then
					local st = stepsP1:GetStepsType();
					local diff = stepsP1:GetDifficulty();
					local courseType = GAMESTATE:IsCourseMode() and SongOrCourse:GetCourseType() or nil;
					local cd = GetCustomDifficulty(st, diff, courseType);
					self:diffuse(ColorLightTone(CustomDifficultyToColor(cd)));
				end
			end
    end;
	};

	t[#t+1] = Def.ActorFrame {
		InitCommand=cmd(visible,GAMESTATE:IsHumanPlayer(PLAYER_1);x,-206;y,-8;);
		LoadFont("StepsDisplay description") .. {
			  OnCommand=cmd(playcommand,"Set";);
			  CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Set";);
			  ChangedLanguageDisplayMessageCommand=cmd(playcommand,"Set");
			  OffCommand=cmd(sleep,0.6;decelerate,0.5;addy,-73;);
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
						self:diffuse(ColorLightTone(CustomDifficultyToColor(cd)));
					else
						self:settext("")
					end
				else
					self:settext("")
				end
			  end
		};
	};

return t;
