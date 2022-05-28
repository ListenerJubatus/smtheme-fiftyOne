local t = Def.ActorFrame {};

-- A very useful table...
local eval_lines = {
	"W1",
	"W2",
	"W3",
	"W4",
	"W5",
	"Miss",
	"MaxCombo"
}

local eval_radar = {
	Types = { 'Holds', 'Rolls', 'Hands', 'Mines', 'Lifts' },
}

local grade_area_offset = 16
local fade_out_speed = 0.3
local fade_out_pause = 0.08
local CurPrefTiming = LoadModule("Config.Load.lua")("SmartTimings","Save/OutFoxPrefs.ini")
local SelJudg = {2,4,5}

-- And a function to make even better use out of the table.
local function GetJLineValue(line, pl)
	if line == "Held" then
		return STATSMAN:GetCurStageStats():GetPlayerStageStats(pl):GetHoldNoteScores("HoldNoteScore_Held")
	elseif line == "MaxCombo" then
		return STATSMAN:GetCurStageStats():GetPlayerStageStats(pl):MaxCombo()
	else
		return STATSMAN:GetCurStageStats():GetPlayerStageStats(pl):GetTapNoteScores("TapNoteScore_" .. line)
	end
	return "???"
end

-- You know what, we'll deal with getting the overall scores with a function too.
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

-- #################################################
-- That's enough functions; let's get this done.

-- Shared portion.
local mid_pane = Def.ActorFrame {
	OnCommand=function(self) self:diffusealpha(0):sleep(0.3):decelerate(0.4):diffusealpha(1) end;
	OffCommand=function(self) self:decelerate(0.3):diffusealpha(0) end;
	-- Song/course banner.
	Def.ActorFrame {
	InitCommand=function(self) self:xy(_screen.cx,_screen.cy-200) end;
	Def.Sprite {
		InitCommand=function(self)
			local target = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()
			if target and target:HasBanner() then
				self:Load(target:GetBannerPath())
			else
				self:Load(THEME:GetPathG("Common fallback", "banner"))
			end
			self:scaletoclipped(468,146):y(-1):zoom(0.8)
		end
	},
	-- Banner frame.
	LoadActor("_bannerframe") .. {
		InitCommand=function(self) self:zoom(0.8) end;
	}
}
}

-- Song or Course Title
if not GAMESTATE:IsCourseMode() then
	mid_pane[#mid_pane+1] = Def.BitmapText {
		Font="_open sans semibold 24px",
		InitCommand=function(self)
			self:x(_screen.cx):y(_screen.cy-125):diffuse(color("#882D47")):shadowlength(1):zoom(0.75):maxwidth(500)
		end;
		OnCommand=function(self)
			local song = GAMESTATE:GetCurrentSong();
			if song then
				self:settext(song:GetDisplayMainTitle());
				if song:GetDisplaySubTitle() == "" then
					self:addy(10)
				end
			else
				self:settext("");
			end;
			self:diffusealpha(0):sleep(1.0):decelerate(0.4):diffusealpha(1)
		end;
		OffCommand=function(self) self:decelerate(0.4):diffusealpha(0) end;
	}
	mid_pane[#mid_pane+1] = Def.BitmapText {
		Font="_open sans condensed 24px",
		InitCommand=function(self)
			self:x(_screen.cx):y(_screen.cy-125+20):diffuse(color("#882D47")):shadowlength(1):zoom(0.6):maxwidth(500)
		end;
		OnCommand=function(self)
			local song = GAMESTATE:GetCurrentSong();
			if song then
				self:settext(song:GetDisplaySubTitle());
			else
				self:settext("");
			end;
			self:diffusealpha(0):sleep(1.1):decelerate(0.4):diffusealpha(1)
		end,
		OffCommand=function(self) self:decelerate(0.4):diffusealpha(0) end;
	}
else
	mid_pane[#mid_pane+1] = Def.BitmapText {
		Font="_open sans semibold 24px",
		InitCommand=function(self)
			self:x(_screen.cx):y(_screen.cy+188-6):diffuse(color("#882D47")):shadowlength(1):zoom(0.75):maxwidth(500)
		end;
		OnCommand=function(self)
			local course = GAMESTATE:GetCurrentCourse()
			self:settext(course:GetDisplayFullTitle())
			self:diffusealpha(0):sleep(1.3):decelerate(0.4):diffusealpha(1)
		end,
		OffCommand=function(self) self:decelerate(0.4):diffusealpha(0) end;
	}
end

t[#t+1] = mid_pane

-- #################################################
-- Time to deal with all of the player stats. ALL OF THEM.

local eval_parts = Def.ActorFrame {}

for ip, p in ipairs(GAMESTATE:GetHumanPlayers()) do
	-- Some things to help positioning
	local step_count_offs = string.find(p, "P1") and -340 or 340
	local grade_parts_offs = string.find(p, "P1") and -100 or 100
	local p_grade = STATSMAN:GetCurStageStats():GetPlayerStageStats(p):GetGrade()

	-- Step counts.
	local Name,Length = LoadModule("Options.SmartTapNoteScore.lua")()
	table.sort(Name)
	Name[#Name+1] = "Miss"
	Name[#Name+1] = "MaxCombo"
	for i,v in ipairs( Name ) do
		local spacing = 32*i
		local cur_line = "JudgmentLine_" .. v

		eval_parts[#eval_parts+1] = Def.ActorFrame {
		InitCommand=function(self) 	self:x(_screen.cx + step_count_offs):y((_screen.cy/4.3)+(spacing)) end;
		OffCommand=function(self)
			self:sleep(fade_out_pause * i):decelerate(fade_out_speed):diffusealpha(0)
		end;
			-- BG
			Def.Quad {
				InitCommand=function(self) self:zoomto(220,30):diffuse(JudgmentLineToColor(cur_line)) end;
				OnCommand=function(self)
					self:diffusealpha(0):sleep(0.1 * i):decelerate(0.6):diffusealpha(0.9)
				end;
			};
			-- Item name
			Def.BitmapText {
				Font = "_open sans condensed 24px",
				InitCommand=function(self) self:x(-104):zoom(0.8):skewx(-0.1):diffuse(ColorDarkTone(PlayerColor(p))):horizalign(left) end;
				Text=ToUpper(THEME:GetString( CurPrefTiming or "Original" , "Judgment"..v )),
				OnCommand=function(self)
					self:diffusealpha(0):sleep(0.1 * i):decelerate(0.6):diffusealpha(1)
				end;
			};
			-- Numbers numbers numbers!
			Def.BitmapText {
				Font = "_open sans semibold 24px",
				InitCommand=function(self)
					self:diffuse(ColorDarkTone(PlayerColor(p)))
					self:zoom(0.8):diffusealpha(1.0):shadowlength(1):maxwidth(120):horizalign(right):x(104)
				end;
				Text=GetJLineValue(v, p),
				OnCommand=function(self)
					self:diffusealpha(0):sleep(0.1 * i):decelerate(0.6):diffusealpha(1)
				end;
			};
		};
	end
	

	-- Letter grade and associated parts.
	eval_parts[#eval_parts+1] = Def.ActorFrame{
		InitCommand=function(self) self:xy(_screen.cx + grade_parts_offs,_screen.cy/1.1) end;

		--Containers
		Def.Quad {
			InitCommand=function(self)
			    self:zoomto(190,394):vertalign(top):addy(-60):diffuse(PlayerColor(p)):diffusetopedge(ColorMidTone(PlayerColor(p)))
			end,
			OnCommand=function(self)
			    self:diffusealpha(0):decelerate(0.4):diffusealpha(0.8)
			end,			
			OffCommand=function(self)
			    self:decelerate(0.8):diffusealpha(0)
			end,
		},

		Def.Quad {
			InitCommand=function(self)
				self:vertalign(top):y(60+grade_area_offset-20):zoomto(190,130):diffuse(ColorDarkTone(PlayerColor(p)))
			end,
			OnCommand=function(self)
			    self:diffusealpha(0):decelerate(0.4):diffusealpha(0.8)
			end,			
			OffCommand=function(self)
			    self:decelerate(0.3):diffusealpha(0)
			end,
		},

		LoadActor(THEME:GetPathG("GradeDisplay", "Grade " .. p_grade)) .. {
			InitCommand=function(self)
			    self:zoom(0.75)
			end;
			OnCommand=function(self)
			        self:diffusealpha(0):zoom(1):sleep(0.63):decelerate(0.4):zoom(0.75):diffusealpha(1)
					if STATSMAN:GetCurStageStats():GetPlayerStageStats(p):GetStageAward() then
					  self:sleep(0.1):decelerate(0.4):addy(-12);
					else
					  self:addy(0);
					end;
			end;
			OffCommand=function(self)
			    self:decelerate(0.3):diffusealpha(0)
			end;
		},

		Def.BitmapText {
			Font = "Common Condensed",
			InitCommand=function(self)
				self:diffuse(BoostColor(ColorMidTone(PlayerColor(p)),2.7)):zoom(1):addy(38):maxwidth(160):uppercase(true):shadowlength(1)
			end;
			OnCommand=function(self)
				if STATSMAN:GetCurStageStats():GetPlayerStageStats(p):GetStageAward() then
					self:settext(THEME:GetString( "StageAward", ToEnumShortString(STATSMAN:GetCurStageStats():GetPlayerStageStats(p):GetStageAward()) ))
					self:diffusealpha(0):zoomx(0.5):sleep(1):decelerate(0.4):zoomx(1):diffusealpha(1)
				end;
			end;
			OffCommand=function(self)
			    self:decelerate(0.3):diffusealpha(0)
			end;		
			}
	}


	-- Primary score.
	eval_parts[#eval_parts+1] = Def.BitmapText {
		Font = "_noto sans 36px",
		InitCommand=function(self)
			self:horizalign(center):x(_screen.cx + (grade_parts_offs)):y((_screen.cy+80-20)+grade_area_offset)
			self:diffuse(BoostColor(PlayerColor(p),1.64)):zoom(1):shadowlength(1):maxwidth(180)
		end;
		OnCommand=function(self)
			self:settext(GetPlScore(p, "primary")):diffusealpha(0):sleep(0.5):decelerate(0.3):diffusealpha(1)
		end;
		OffCommand=function(self)
			self:decelerate(0.3):diffusealpha(0)
		end;
	}
	-- Secondary score.
	eval_parts[#eval_parts+1] = Def.BitmapText {
		Font = "Common Condensed",
		InitCommand=function(self)
			self:horizalign(center):x(_screen.cx + (grade_parts_offs)):y((_screen.cy+78-20)+grade_area_offset+35)
			self:diffuse(ColorLightTone(PlayerColor(p))):zoom(1):shadowlength(1):maxwidth(180)
		end;
		OnCommand=function(self)
			self:settext(GetPlScore(p, "secondary")):diffusealpha(0):sleep(0.55):decelerate(0.3):diffusealpha(1)
		end;
		OffCommand=function(self)
			self:sleep(0.1):decelerate(0.3):diffusealpha(0)
		end;
	}

	eval_parts[#eval_parts+1] = Def.BitmapText {
		Font = "_open sans condensed 24px",
		InitCommand=function(self)
			self:horizalign(center):x(_screen.cx + (grade_parts_offs)):y((_screen.cy+64)+grade_area_offset+56):uppercase(true)
			self:diffuse(BoostColor(ColorMidTone(PlayerColor(p)),2.7)):zoom(0.75):shadowlength(1):maxwidth(220)
		end;
		OnCommand=function(self)
			local record = STATSMAN:GetCurStageStats():GetPlayerStageStats(p):GetPersonalHighScoreIndex()
			local hasPersonalRecord = record ~= -1
			self:visible(hasPersonalRecord);
			local text = string.format(THEME:GetString("ScreenEvaluation", "PersonalRecord"), record+1)
			self:settext(text)
			self:diffusealpha(0):sleep(0.6):decelerate(0.3):diffusealpha(0.9)
		end;
		OffCommand=function(self)
			self:sleep(0.1):decelerate(0.3):diffusealpha(0)
		end;
	}

	-- Other stats (holds, mines, etc.)
	for i, rc_type in ipairs(eval_radar.Types) do
		local performance = STATSMAN:GetCurStageStats():GetPlayerStageStats(p):GetRadarActual():GetValue( "RadarCategory_"..rc_type )
		local possible = STATSMAN:GetCurStageStats():GetPlayerStageStats(p):GetRadarPossible():GetValue( "RadarCategory_"..rc_type )
		local label = THEME:GetString("RadarCategory", rc_type)
		local spacing = 28*i

		eval_parts[#eval_parts+1] = Def.ActorFrame {
			InitCommand=function(self) 	self:x(_screen.cx + step_count_offs):y((_screen.cy*1.34)+(spacing)) end;
			OnCommand=function(self)
				self:diffusealpha(0):sleep(0.1 * i):decelerate(0.5):diffusealpha(1)
			end;
			OffCommand=function(self)
				self:sleep(0.13 * i):decelerate(0.6):diffusealpha(0)
			end;
				Def.Quad {
					InitCommand=function(self)
						self:zoomto(220,24):diffuse(ColorLightTone((PlayerColor(p)))):diffusealpha(0.8)
					end;
				};
				-- Item name
				Def.BitmapText {
					Font = "_open sans condensed 24px",
					InitCommand=function(self)
						self:zoom(0.75):x(-104):horizalign(left):diffuse(ColorDarkTone((PlayerColor(p)))):uppercase(true)
					end;
					BeginCommand=function(self)
						self:settext(label)
					end;
				};
				-- Value
				Def.BitmapText {
				Font = "Common Condensed",
				InitCommand=function(self)
					self:diffuse(ColorDarkTone((PlayerColor(p))))
					self:zoom(0.75):diffusealpha(1.0):maxwidth(120):horizalign(right):x(104)
				end;
				BeginCommand=function(self)
					self:settext(performance .. "/" .. possible)
				end
				};
		};
	end;

	-- Options
	eval_parts[#eval_parts+1] = Def.BitmapText {
		Font = "Common Condensed",
		InitCommand=function(self)
			self:horizalign(center):vertalign(bottom):x(_screen.cx + (grade_parts_offs)):y(_screen.cy+196+92):wrapwidthpixels(240)
			:diffuse(ColorDarkTone(PlayerColor(p))):zoom(0.75)
		end;
		OnCommand=function(self)
			self:settext(GAMESTATE:GetPlayerState(p):GetPlayerOptionsString(0))
			self:diffusealpha(0):sleep(0.8):decelerate(0.6):diffusealpha(1)
			end;
		OffCommand=function(self)
			self:sleep(0.1):decelerate(0.3):diffusealpha(0)
		end;
		};
end

t[#t+1] = eval_parts;

	if GAMESTATE:IsCourseMode() == false then
		for ip, p in ipairs(GAMESTATE:GetHumanPlayers()) do
			-- Some things to help positioning
			local step_count_offs = string.find(p, "P1") and -340 or 340
			local grade_parts_offs = string.find(p, "P1") and -100 or 100
			t[#t+1] = Def.ActorFrame {
			InitCommand=function(self)
				self:horizalign(center):x(_screen.cx + grade_parts_offs):y(_screen.cy+44+grade_area_offset-20):visible(not GAMESTATE:IsCourseMode())
			end;
			OnCommand=function(self) self:zoomx(0.3):diffusealpha(0):sleep(0.5):decelerate(0.4):zoomx(1):diffusealpha(1) end;
			OffCommand=function(self) self:decelerate(0.4):diffusealpha(0) end;
			["CurrentSteps"..ToEnumShortString(p).."ChangedMessageCommand"]=function(self) MESSAGEMAN:Broadcast("Set") end;
			ChangedLanguageDisplayMessageCommand=function(self) MESSAGEMAN:Broadcast("Set") end;

			  Def.Quad {
			  	InitCommand=function(self) self:zoomto(190,32):horizalign(center) end;
				OnCommand=function(self) self:playcommand("Set") end;
				["CurrentSteps"..ToEnumShortString(p).."ChangedMessageCommand"]=function(self) self:playcommand("Set") end;
				ChangedLanguageDisplayMessageCommand=function(self) self:playcommand("Set") end;
				SetCommand=function(self)
				local steps_data = GAMESTATE:GetCurrentSteps(p)
				local song = GAMESTATE:GetCurrentSong();
				  if song then
					if steps_data ~= nil then
					  local st = steps_data:GetStepsType();
					  local diff = steps_data:GetDifficulty();
					  local courseType = GAMESTATE:IsCourseMode() and SongOrCourse:GetCourseType() or nil;
					  local cd = GetCustomDifficulty(st, diff, courseType);
					  self:diffuse(ColorDarkTone(CustomDifficultyToColor(cd)));
					else
					  self:settext("")
					end
				  else
					self:settext("")
				  end
				end
			  };
			  LoadFont("Common Fallback") .. {
					InitCommand=function(self) self:zoom(1):horizalign(center):shadowlength(1) end;
					OnCommand=function(self) self:playcommand("Set") end;
					["CurrentSteps"..ToEnumShortString(p).."ChangedMessageCommand"]=function(self) self:playcommand("Set") end;
					ChangedLanguageDisplayMessageCommand=function(self) self:playcommand("Set") end;
					SetCommand=function(self)
					local steps_data = GAMESTATE:GetCurrentSteps(p)
					local song = GAMESTATE:GetCurrentSong();
					  if song then
						if steps_data ~= nil then
						  local st = steps_data:GetStepsType();
						  local diff = steps_data:GetDifficulty();
						  local courseType = GAMESTATE:IsCourseMode() and SongOrCourse:GetCourseType() or nil;
						  local cd = GetCustomDifficulty(st, diff, courseType);
						  self:settext(ToUpper(THEME:GetString("CustomDifficulty",ToEnumShortString(diff))) .. "  " .. steps_data:GetMeter());
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
		end;
	end;

t[#t+1] = StandardDecorationFromFileOptional("LifeDifficulty","LifeDifficulty");
t[#t+1] = StandardDecorationFromFileOptional("TimingDifficulty","TimingDifficulty");

if gameplay_pause_count > 0 then
	t[#t+1]= Def.ActorFrame {
		InitCommand=function(self) self:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y-166) end;
		OnCommand=function(self)
			self:diffusealpha(0):sleep(0.5):smooth(0.3):diffusealpha(1)
		end;
		OffCommand=function(self) self:decelerate(0.3):diffusealpha(0) end;
		Def.Quad {
			InitCommand=function(self) 
				self:zoomto(150,36):diffuse(color("#a50909"))
			end;
		};
		Def.BitmapText{
			Font= "_open sans condensed 24px",
			Text= THEME:GetString("PauseMenu", "pause_count") .. ": " .. gameplay_pause_count,
			InitCommand=function(self) 
				self:shadowlength(1):maxwidth(140)
				self:diffuse(Color.White):zoom(0.8)
			end;
		}
	}
end

return t;
