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

local grade_area_offset = 16
local fade_out_speed = 0.3
local fade_out_pause = 0.08

-- And a function to make even better use out of the table.
local function GetJLineValue(line, pl)
	if line == "Held" then
		return STATSMAN:GetAccumPlayedStageStats():GetPlayerStageStats(pl):GetHoldNoteScores("HoldNoteScore_Held")
	elseif line == "MaxCombo" then
		return STATSMAN:GetAccumPlayedStageStats():GetPlayerStageStats(pl):MaxCombo()
	else
		return STATSMAN:GetAccumPlayedStageStats():GetPlayerStageStats(pl):GetTapNoteScores("TapNoteScore_" .. line)
	end
	return "???"
end

-- You know what, we'll deal with getting the overall scores with a function too.
local function GetPlScore(pl, scoretype)
	local primary_score = STATSMAN:GetAccumPlayedStageStats():GetPlayerStageStats(pl):GetScore()
	local secondary_score = FormatPercentScore(STATSMAN:GetAccumPlayedStageStats():GetPlayerStageStats(pl):GetPercentDancePoints())

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


-- #################################################
-- Time to deal with all of the player stats. ALL OF THEM.

local eval_parts = Def.ActorFrame {}

for ip, p in ipairs(GAMESTATE:GetHumanPlayers()) do
	-- Some things to help positioning
	local step_count_offs = string.find(p, "P1") and -340 or 340
	local grade_parts_offs = string.find(p, "P1") and -100 or 100
	local p_grade = STATSMAN:GetAccumPlayedStageStats():GetPlayerStageStats(p):GetGrade()

	-- Step counts.
	for i, v in ipairs(eval_lines) do
		local spacing = 34*i
		local cur_line = "JudgmentLine_" .. v

		eval_parts[#eval_parts+1] = Def.ActorFrame {
		InitCommand=function(self) 	self:x(_screen.cx + step_count_offs):y((_screen.cy/1.45)+(spacing)) end;
		OffCommand=function(self)
			self:sleep(fade_out_pause * i):decelerate(fade_out_speed):diffusealpha(0)
		end;
			-- BG
			Def.Quad {
				InitCommand=function(self) self:zoomto(220,32):diffuse(BoostColor(ColorMidTone(JudgmentLineToColor(cur_line)),0.6)) end;
				OnCommand=function(self)
					self:diffusealpha(0):sleep(0.1 * i):decelerate(0.6):diffusealpha(0.9)
				end;
			};
			-- Item name
			Def.BitmapText {
				Font = "_open sans condensed 24px",
				InitCommand=function(self) self:x(-104):zoom(1):skewx(-0.1):diffuse(ColorLightTone(JudgmentLineToColor(cur_line))):settext(string.upper(JudgmentLineToLocalizedString(cur_line))):horizalign(left) end;
				OnCommand=function(self)
					self:diffusealpha(0):sleep(0.1 * i):decelerate(0.6):diffusealpha(0.86)
				end;
			};
			-- Numbers numbers numbers!
			Def.BitmapText {
				Font = "Common Condensed",
				InitCommand=function(self)
					self:diffuse(BoostColor(ColorMidTone(PlayerColor(p)),2.7)):strokecolor(PlayerColor(p))
					self:zoom(1):diffusealpha(1.0):shadowlength(1):maxwidth(120):horizalign(right):x(104)
				end;
				OnCommand=function(self)
					self:settext(GetJLineValue(v, p))
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
			    self:zoomto(190,192):vertalign(top):addy(-60):diffuse(ColorDarkTone(PlayerColor(p))):diffusebottomedge(PlayerColor(p))
			end,
			OnCommand=function(self)
			    self:diffusealpha(0):decelerate(0.4):diffusealpha(0.5)
			end,			
			OffCommand=function(self)
			    self:decelerate(0.3):diffusealpha(0)
			end,
		},

		Def.Quad {
			InitCommand=function(self)
				self:vertalign(top):y(60+grade_area_offset-20):zoomto(190,76):diffuse(color("#000000"))
			end,
			OnCommand=function(self)
			    self:diffusealpha(0):decelerate(0.4):diffusealpha(0.3)
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
			end;
			OffCommand=function(self)
			    self:decelerate(0.3):diffusealpha(0)
			end;
		},
	}


	-- Primary score.
	eval_parts[#eval_parts+1] = Def.BitmapText {
		Font = "_noto sans 36px",
		InitCommand=function(self)
			self:horizalign(center):x(_screen.cx + (grade_parts_offs)):y((_screen.cy+80-20-30)+grade_area_offset)
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
			self:horizalign(center):x(_screen.cx + (grade_parts_offs)):y((_screen.cy+78-20-30)+grade_area_offset+35)
			self:diffuse(ColorLightTone(PlayerColor(p))):zoom(1):shadowlength(1):maxwidth(180)
		end;
		OnCommand=function(self)
			self:settext(GetPlScore(p, "secondary")):diffusealpha(0):sleep(0.55):decelerate(0.3):diffusealpha(1)
		end;
		OffCommand=function(self)
			self:sleep(0.1):decelerate(0.3):diffusealpha(0)
		end;
	}

end

t[#t+1] = eval_parts;

return t;