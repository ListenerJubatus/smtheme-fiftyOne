local t = Def.ActorFrame {};
	-- Bar
	t[#t+1] = LoadActor(THEME:GetPathG("LifeMeter", "p2 bar")) .. {
	};
	
	-- Difficulty
	t[#t+1] = LoadActor(THEME:GetPathG("LifeMeter", "p2 shad")) .. {
	};

	t[#t+1] = LoadActor(THEME:GetPathG("LifeMeter", "p2 diff")) .. {
		OnCommand=cmd(playcommand,"Set";);
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"Set";); 
		SetCommand=function(self)
			stepsP2 = GAMESTATE:GetCurrentSteps(PLAYER_2)
			local song = GAMESTATE:GetCurrentSong();
			if song then 
				if stepsP1 ~= nil then
					local st = stepsP2:GetStepsType();
					local diff = stepsP2:GetDifficulty();
					local cd = GetCustomDifficulty(st, diff);
					self:diffuse(CustomDifficultyToColor(cd));
				end
			end	
          end;
	};
	
	t[#t+1] = Def.ActorFrame {
		InitCommand=cmd(visible,GAMESTATE:IsHumanPlayer(PLAYER_2);x,206;y,-8;);
		LoadFont("StepsDisplay description") .. { 
			  InitCommand=cmd(zoom,0.75);
			  OnCommand=cmd(playcommand,"Set";);
			  CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"Set";); 
			  ChangedLanguageDisplayMessageCommand=cmd(playcommand,"Set"); 
			  SetCommand=function(self)
				stepsP2 = GAMESTATE:GetCurrentSteps(PLAYER_2)
				local song = GAMESTATE:GetCurrentSong();
				if song then 
					if stepsP1 ~= nil then
						local st = stepsP2:GetStepsType();
						local diff = stepsP2:GetDifficulty();
						local cd = GetCustomDifficulty(st, diff);
						self:settext(stepsP2:GetMeter())
						self:diffuse(ColorDarkTone(CustomDifficultyToColor(cd)));
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