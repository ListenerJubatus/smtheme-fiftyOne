local t = Def.ActorFrame {};
	--P1
	if GAMESTATE:GetPlayMode() ~= 'PlayMode_Rave' then
		if GAMESTATE:IsHumanPlayer(PLAYER_1) == true then
		t[#t+1] = LoadActor("_lifep1") .. {
			InitCommand=cmd(visible,GAMESTATE:IsHumanPlayer(PLAYER_1);x,SCREEN_LEFT+40;y,SCREEN_CENTER_Y;rotationz,-90;);
			OnCommand=cmd(addx,-100;sleep,1;decelerate,0.9;addx,100;);
			OffCommand=cmd(sleep,1;decelerate,0.9;addx,-100;);
		};
		end;

		if GAMESTATE:IsHumanPlayer(PLAYER_2) == true then
		t[#t+1] = LoadActor("_lifep2") .. {
			InitCommand=cmd(visible,GAMESTATE:IsHumanPlayer(PLAYER_2);x,SCREEN_RIGHT-40;y,SCREEN_CENTER_Y;rotationz,-90;);
			OnCommand=cmd(addx,100;sleep,1;decelerate,0.9;addx,-100;);
			OffCommand=cmd(sleep,1;decelerate,0.9;addx,100;);
		};
		end;
	end;
	
	-- Move diamonds on battle
	if GAMESTATE:GetPlayMode() == 'PlayMode_Rave' then
	-- P1
	t[#t+1] = Def.ActorFrame {
		InitCommand=cmd(x,SCREEN_CENTER_X-110;y,SCREEN_BOTTOM-55;);
		LoadActor("_diffdia") .. {
		OnCommand=cmd(playcommand,"Set";);
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Set";);
		SetCommand=function(self)
			stepsP1 = GAMESTATE:GetCurrentSteps(PLAYER_1)
			local song = GAMESTATE:GetCurrentSong();
			if song then
				if stepsP1 ~= nil then
					local st = stepsP1:GetStepsType();
					local diff = stepsP1:GetDifficulty();
					local cd = GetCustomDifficulty(st, diff);
					self:diffuse(CustomDifficultyToColor(cd));
				end
			end
		end;
		};
		LoadFont("StepsDisplay description") .. {
			  InitCommand=cmd(zoom,0.75;horizalign,center;);
			  OnCommand=cmd(playcommand,"Set";);
			  CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Set";);
			  ChangedLanguageDisplayMessageCommand=cmd(playcommand,"Set");
			  SetCommand=function(self)
				stepsP1 = GAMESTATE:GetCurrentSteps(PLAYER_1)
				local song = GAMESTATE:GetCurrentSong();
				if song then
					if stepsP1 ~= nil then
						local st = stepsP1:GetStepsType();
						local diff = stepsP1:GetDifficulty();
						local cd = GetCustomDifficulty(st, diff);
						self:settext(stepsP1:GetMeter()):diffuse(color("#000000")):diffusealpha(0.8);
					else
						self:settext("")
					end
				else
					self:settext("")
				end
			  end
		};
	};
	-- P2
		t[#t+1] = Def.ActorFrame {
		InitCommand=cmd(x,SCREEN_CENTER_X+110;y,SCREEN_BOTTOM-55;);
		LoadActor("_diffdia") .. {
		OnCommand=cmd(playcommand,"Set";);
		CurrentstepsP2ChangedMessageCommand=cmd(playcommand,"Set";);
		SetCommand=function(self)
			stepsP2 = GAMESTATE:GetCurrentSteps(PLAYER_2)
			local song = GAMESTATE:GetCurrentSong();
			if song then
				if stepsP2 ~= nil then
					local st = stepsP2:GetStepsType();
					local diff = stepsP2:GetDifficulty();
					local cd = GetCustomDifficulty(st, diff);
					self:diffuse(CustomDifficultyToColor(cd));
				end
			end
		end;
		};
		LoadFont("StepsDisplay description") .. {
			  InitCommand=cmd(zoom,0.75;horizalign,center);
			  OnCommand=cmd(playcommand,"Set";);
			  CurrentstepsP2ChangedMessageCommand=cmd(playcommand,"Set";);
			  ChangedLanguageDisplayMessageCommand=cmd(playcommand,"Set");
			  SetCommand=function(self)
				stepsP2 = GAMESTATE:GetCurrentSteps(PLAYER_2)
				local song = GAMESTATE:GetCurrentSong();
				if song then
					if stepsP2 ~= nil then
						local st = stepsP2:GetStepsType();
						local diff = stepsP2:GetDifficulty();
						local cd = GetCustomDifficulty(st, diff);
						self:settext(stepsP2:GetMeter()):diffuse(color("#000000")):diffusealpha(0.8);					
						else
						self:settext("")
					end
				else
					self:settext("")
				end
			  end
		};
	};
	end;
	

	t[#t+1] = StandardDecorationFromFileOptional("StageDisplay","StageDisplay");
	t[#t+1]= LoadActor(THEME:GetPathG("", "pause_menu"))
return t
