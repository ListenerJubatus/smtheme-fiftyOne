local t = Def.ActorFrame {};
local function UpdateTime(self)
	local c = self:GetChildren();
	for pn in ivalues(PlayerNumber) do
		local vStats = STATSMAN:GetCurStageStats():GetPlayerStageStats( pn );
		local vTime;
		local obj = self:GetChild( string.format("RemainingTime" .. PlayerNumberToString(pn) ) );
		if vStats and obj then
			local vTime = vStats:GetLifeRemainingSeconds()
			obj:settext( SecondsToMMSSMsMs( vTime ) );
		end;
	end;
end
local function songMeterScale(val) return scale(val,0,1,-380/2,380/2) end
local function GetPlScore(pl, scoretype)
	local primary_score = STATSMAN:GetCurStageStats():GetPlayerStageStats(pl):GetScore()
	local secondary_score = FormatPercentScore(STATSMAN:GetCurStageStats():GetPlayerStageStats(pl):GetPercentDancePoints())

	if PREFSMAN:GetPreference("PercentageScoring") then
		primary_score, secondary_score = secondary_score, primary_score
	end

	if scoretype == "primary" then
		return primary_score
	else
		return secondary_score
	end
end

if LoadModule("Config.Load.lua")("GameplayBPM","Save/OutFoxPrefs.ini") then
	t[#t+1] = LoadActor("bpmDisplay.lua");
end;

if GAMESTATE:GetCurrentCourse() then
	if GAMESTATE:GetCurrentCourse():GetCourseType() == "CourseType_Survival" then
		-- RemainingTime
		for pn in ivalues(PlayerNumber) do
			local MetricsName = "RemainingTime" .. PlayerNumberToString(pn);
			t[#t+1] = LoadActor( THEME:GetPathG( Var "LoadingScreen", "RemainingTime"), pn ) .. {
				InitCommand=function(self)
					self:player(pn);
					self:name(MetricsName);
					ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen");
				end;
			};
		end
		for pn in ivalues(PlayerNumber) do
			local MetricsName = "DeltaSeconds" .. PlayerNumberToString(pn);
			t[#t+1] = LoadActor( THEME:GetPathG( Var "LoadingScreen", "DeltaSeconds"), pn ) .. {
				InitCommand=function(self)
					self:player(pn);
					self:name(MetricsName);
					ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen");
				end;
			};
		end
	end;
end;
t.InitCommand=function(self) self:SetUpdateFunction(UpdateTime) end;

	if GAMESTATE:GetPlayMode() ~= 'PlayMode_Rave' then
		for ip, pn in ipairs(GAMESTATE:GetEnabledPlayers()) do
			if ShowStandardDecoration("LifeMeterBar" ..  ToEnumShortString(pn)) then
				local life_type = GAMESTATE:GetPlayerState(pn):GetPlayerOptions("ModsLevel_Song"):LifeSetting()
				t[#t+1] = LoadActor(THEME:GetPathG(Var "LoadingScreen", "lifebar_" .. ToEnumShortString(life_type)), pn) .. {
					InitCommand=function(self)
						self:name("LifeMeterBar" .. ToEnumShortString(pn))
						ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
					end
				}
			end
		end;

		for ip, pn in ipairs(GAMESTATE:GetEnabledPlayers()) do
				local life_x_position = string.find(pn, "P1") and SCREEN_LEFT+34 or SCREEN_RIGHT-34
				local life_tween = string.find(pn, "P1") and -1 or 1
				local second_tween = string.find(pn, "P1") and 1 or -1
				t[#t+1] = Def.ActorFrame {
					InitCommand=function(self) self:xy(life_x_position,SCREEN_CENTER_Y):rotationz(-90) end;
					OnCommand=function(self) self:addx(100*life_tween):sleep(0.25):decelerate(0.9):addx(100*second_tween) end;
					OffCommand=function(self) self:sleep(1):decelerate(0.9):addx(100*life_tween) end;
					Def.Sprite {
						Texture=THEME:GetPathG("LifeMeter", "bar frame");
					};
					Def.ActorFrame {
						InitCommand=function(self) self:xy(-207,0) end;
					Def.Sprite {
						Texture="_diffdia";
						OnCommand=function(self) self:playcommand("Set") end;
						["CurrentSteps"..ToEnumShortString(pn).."ChangedMessageCommand"]=function(self) self:playcommand("Set") end;
						SetCommand=function(self)
							local steps_data = GAMESTATE:GetCurrentSteps(pn)
							local song = GAMESTATE:GetCurrentSong();
							if song then
								if steps_data ~= nil then
									local st = steps_data:GetStepsType();
									local diff = steps_data:GetDifficulty();
									local cd = GetCustomDifficulty(st, diff);
									self:diffuse(CustomDifficultyToColor(cd));
								end
							end
						end;
						};
						LoadFont("StepsDisplay description") .. {
							  InitCommand=function(self) self:zoom(0.75):horizalign(center):rotationz(90) end;
							  OnCommand=function(self) self:playcommand("Set") end;
							  ["CurrentSteps"..ToEnumShortString(pn).."ChangedMessageCommand"]=function(self) self:playcommand("Set") end;
							  ChangedLanguageDisplayMessageCommand=function(self) self:playcommand("Set") end;
							  SetCommand=function(self)
								local steps_data = GAMESTATE:GetCurrentSteps(pn)
								local song = GAMESTATE:GetCurrentSong();
								if song then
									if steps_data ~= nil then
										local st = steps_data:GetStepsType();
										local diff = steps_data:GetDifficulty();
										local cd = GetCustomDifficulty(st, diff);
										self:settext(steps_data:GetMeter()):diffuse(color("#000000")):diffusealpha(0.8);
									else
										self:settext("")
									end
								else
									self:settext("")
								end
							  end
						};
					};
				};
		end;
	end;

	-- Move diamonds on battle
	if GAMESTATE:GetPlayMode() == 'PlayMode_Rave' then
		for ip, pn in ipairs(GAMESTATE:GetEnabledPlayers()) do
		local x_position = string.find(pn, "P1") and SCREEN_CENTER_X-110 or SCREEN_CENTER_X+110
			t[#t+1] = Def.ActorFrame {
				InitCommand=function(self) self:xy(x_position,SCREEN_BOTTOM-55) end;
				
				LoadActor("_diffdia") .. {
				OnCommand=function(self) self:playcommand("Set") end;
				["CurrentSteps"..ToEnumShortString(pn).."ChangedMessageCommand"]=function(self) self:playcommand("Set") end;
				SetCommand=function(self)
					local steps_data = GAMESTATE:GetCurrentSteps(pn)
					local song = GAMESTATE:GetCurrentSong();
					if song then
						if steps_data ~= nil then
							local st = steps_data:GetStepsType();
							local diff = steps_data:GetDifficulty();
							local cd = GetCustomDifficulty(st, diff);
							self:diffuse(CustomDifficultyToColor(cd));
						end
					end
				end;
				};
		
				LoadFont("StepsDisplay description") .. {
				  InitCommand=function(self) self:zoom(0.75):horizalign(center) end;
				  OnCommand=function(self) self:playcommand("Set") end;
				  ["CurrentSteps"..ToEnumShortString(pn).."ChangedMessageCommand"]=function(self) self:playcommand("Set") end;
				  ChangedLanguageDisplayMessageCommand=function(self) self:playcommand("Set") end;
				  SetCommand=function(self)
					local steps_data = GAMESTATE:GetCurrentSteps(pn)
					local song = GAMESTATE:GetCurrentSong();
					if song then
						if steps_data ~= nil then
							local st = steps_data:GetStepsType();
							local diff = steps_data:GetDifficulty();
							local cd = GetCustomDifficulty(st, diff);
							self:settext(steps_data:GetMeter()):diffuse(color("#000000")):diffusealpha(0.8);
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
	end;

	t[#t+1] = StandardDecorationFromFileOptional("StageDisplay","StageDisplay");
	t[#t+1] = Def.ActorFrame {
		InitCommand=function(self) self:xy(SCREEN_CENTER_X+103,SCREEN_BOTTOM-25) end;
		OnCommand=function(self) self:draworder(DrawOrder.Screen):addy(100):sleep(0.5):decelerate(0.7):addy(-100) end;
		OffCommand=function(self) self:sleep(1):decelerate(0.9):addy(100) end;
		Def.Quad {
			InitCommand=function(self) self:zoomto(264,12) end;
			OnCommand=function(self) self:diffuse(Color.Black):diffusealpha(0.3):fadeleft(0.05):faderight(0.05) end;
		};
		Def.Quad {
			InitCommand=function(self) self:zoomto(2,8) end;
			OnCommand=function(self) self:x(songMeterScale(0.25)):diffuse(PlayerColor(pn)):diffusealpha(0.5) end;
		};
		Def.Quad {
			InitCommand=function(self) self:zoomto(2,8) end;
			OnCommand=function(self) self:x(songMeterScale(0.5)):diffuse(PlayerColor(pn)):diffusealpha(0.5) end;
		};
		Def.Quad {
			InitCommand=function(self) self:zoomto(2,8) end;
			OnCommand=function(self) self:x(songMeterScale(0.75)):diffuse(PlayerColor(pn)):diffusealpha(0.5) end;
		};
		Def.SongMeterDisplay {
			StreamWidth=260;
			Stream=LoadActor( THEME:GetPathG( 'SongMeterDisplay', 'stream') )..{
				InitCommand=function(self) self:diffuse(Color.White):diffusealpha(0.4):blend("Add") end;
			};
			Tip=LoadActor( THEME:GetPathG( 'SongMeterDisplay', 'tip')) .. {
			InitCommand=function(self) self:visible(false) end;
			};
		};
	};
	
	-- SM stock score display can't do this. Gotta do it ourselves
	for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
		local score_x_position = string.find(pn, "P1") and "PlayerP1MiscX" or "PlayerP2MiscX";
		t[#t+1] = Def.ActorFrame {
		InitCommand=function(self)
			self:visible(LoadModule("Config.Load.lua")("GameplayShowScore","Save/OutFoxPrefs.ini"))
			self:x(Center1Player() and SCREEN_CENTER_X or THEME:GetMetric(Var "LoadingScreen",score_x_position)):y(SCREEN_TOP+32)
		end;
		OnCommand=function(self)
			self:addy(-100):sleep(0.5):decelerate(0.7):addy(100)
		end;
		OffCommand=function(self) self:sleep(1):decelerate(0.9):addy(-100) end;
		Def.Sprite {
			Texture=THEME:GetPathG( 'ScoreDisplayNormal', 'frame');
			InitCommand=function(self)
				self:zoom(0.7):diffuse(ColorLightTone(PlayerColor(pn)))
			end,
		},
		Def.BitmapText {
			Font="_overpass Score",
			InitCommand=function(self)
				self:zoom(0.7)
				:diffuse(ColorLightTone(PlayerColor(pn))):diffusebottomedge(PlayerColor(pn)):horizalign(center):maxwidth(SCREEN_WIDTH*0.2234375)
				if PREFSMAN:GetPreference("PercentageScoring") then
					self:settext("0.00%")
				else
					self:settext("0")
				end
			end,
			OnCommand=function(self)
				if GAMESTATE:GetPlayMode() == "PlayMode_Endless" then
					self:queuecommand("UpdateTimer")
				end
			end;
			JudgmentMessageCommand=function(self)
				if GAMESTATE:GetPlayMode() == "PlayMode_Endless" then
					self:queuecommand("UpdateTimer")
				else
					self:queuecommand("RedrawScore")
				end
			end,
			UpdateTimerCommand=function(self)
				self:finishtweening():settext( SecondsToMMSSMsMs( vStats:GetAliveSeconds() ) )
				:sleep(1/60):queuecommand("UpdateTimer")
			end;
            RedrawScoreCommand=function(self)
				self:settext(GetPlScore(pn, "primary"))
			end;
		};
		};
	end;
		
	for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
		t[#t+1] = LoadActor("_fcsplash", pn) .. {
		};
	end;
	
return t
