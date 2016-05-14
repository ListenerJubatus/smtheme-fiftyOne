local t = Def.ActorFrame {};
local p1grade = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetGrade()
local p2grade = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetGrade()

-- Evaluation levels
t[#t+1] = Def.ActorFrame {
  InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y-80;);
	OnCommand=cmd(zoomx,0;decelerate,0.8;zoomx,1;);
	OffCommand=cmd(decelerate,0.6;zoomx,0;diffusealpha,0;);
    Def.ActorFrame {
		OnCommand=cmd(diffusealpha,0;sleep,0.1;smooth,0.2;diffusealpha,1;);
		Def.Quad {
			InitCommand=cmd(zoomto,200,36;diffuse,JudgmentLineToColor("JudgmentLine_W1");diffusealpha,0.6;);
		};
		LoadFont("_overpass 36px") .. {
			InitCommand=cmd(diffuse,Color("Black");zoom,0.75;diffusealpha,0.6;settext,string.upper(JudgmentLineToLocalizedString('JudgmentLine_W1')););
		};
	};
	Def.ActorFrame {
		InitCommand=cmd(addy,40;);
		OnCommand=cmd(diffusealpha,0;sleep,0.2;smooth,0.2;diffusealpha,1;);
		Def.Quad {
			InitCommand=cmd(zoomto,200,36;diffuse,JudgmentLineToColor("JudgmentLine_W2");diffusealpha,0.6;);
		};
		LoadFont("_overpass 36px") .. {
			InitCommand=cmd(diffuse,Color("Black");zoom,0.75;diffusealpha,0.6;settext,string.upper(JudgmentLineToLocalizedString('JudgmentLine_W2')););
		};
	};
	Def.ActorFrame {
		InitCommand=cmd(addy,40*2;);
		OnCommand=cmd(diffusealpha,0;sleep,0.3;smooth,0.2;diffusealpha,1;);
		Def.Quad {
			InitCommand=cmd(zoomto,200,36;diffuse,JudgmentLineToColor("JudgmentLine_W3");diffusealpha,0.6;);
		};
		LoadFont("_overpass 36px") .. {
			InitCommand=cmd(diffuse,Color("Black");zoom,0.75;diffusealpha,0.6;settext,string.upper(JudgmentLineToLocalizedString('JudgmentLine_W3')););
		};
	};
	Def.ActorFrame {
		InitCommand=cmd(addy,40*3;);
		OnCommand=cmd(diffusealpha,0;sleep,0.4;smooth,0.2;diffusealpha,1;);
		Def.Quad {
			InitCommand=cmd(zoomto,200,36;diffuse,JudgmentLineToColor("JudgmentLine_W4");diffusealpha,0.6;);
		};
		LoadFont("_overpass 36px") .. {
			InitCommand=cmd(diffuse,Color("Black");zoom,0.75;diffusealpha,0.6;settext,string.upper(JudgmentLineToLocalizedString('JudgmentLine_W4')););
		};
	};
	Def.ActorFrame {
		InitCommand=cmd(addy,40*4;);
		OnCommand=cmd(diffusealpha,0;sleep,0.5;smooth,0.2;diffusealpha,1;);
		Def.Quad {
			InitCommand=cmd(zoomto,200,36;diffuse,JudgmentLineToColor("JudgmentLine_W5");diffusealpha,0.6;);
		};
		LoadFont("_overpass 36px") .. {
			InitCommand=cmd(diffuse,Color("Black");zoom,0.75;diffusealpha,0.6;settext,string.upper(JudgmentLineToLocalizedString('JudgmentLine_W5')););
		};
	};
	Def.ActorFrame {
		InitCommand=cmd(addy,40*5;);
		OnCommand=cmd(diffusealpha,0;sleep,0.6;smooth,0.2;diffusealpha,1;);
		Def.Quad {
			InitCommand=cmd(zoomto,200,36;diffuse,JudgmentLineToColor("JudgmentLine_Miss");diffusealpha,0.6;);
		};
		LoadFont("_overpass 36px") .. {
			InitCommand=cmd(diffuse,Color("Black");zoom,0.75;diffusealpha,0.6;settext,string.upper(JudgmentLineToLocalizedString('JudgmentLine_Miss')););
		};
	};
	Def.ActorFrame {
		InitCommand=cmd(addy,40*6;);
		OnCommand=cmd(diffusealpha,0;sleep,0.7;smooth,0.2;diffusealpha,1;);
		Def.Quad {
			InitCommand=cmd(zoomto,200,36;diffuse,JudgmentLineToColor("JudgmentLine_Held");diffusealpha,0.6;);
		};
		LoadFont("_overpass 36px") .. {
			InitCommand=cmd(diffuse,Color("Black");zoom,0.75;diffusealpha,0.6;settext,string.upper(JudgmentLineToLocalizedString('JudgmentLine_Held')););
		};
	};
	Def.ActorFrame {
		InitCommand=cmd(addy,40*7;);
		OnCommand=cmd(diffusealpha,0;sleep,0.8;smooth,0.2;diffusealpha,1;);
		Def.Quad {
			InitCommand=cmd(zoomto,200,36;diffuse,JudgmentLineToColor("JudgmentLine_MaxCombo");diffusealpha,0.6;);
		};
		LoadFont("_overpass 36px") .. {
			InitCommand=cmd(diffuse,Color("Black");zoom,0.75;diffusealpha,0.6;settext,string.upper(JudgmentLineToLocalizedString('JudgmentLine_MaxCombo')););
		};
	};
};

-- P1 Values
t[#t+1] = Def.ActorFrame {
    InitCommand=cmd(x,SCREEN_CENTER_X-130;y,SCREEN_CENTER_Y-80;visible,GAMESTATE:IsHumanPlayer(PLAYER_1););
    OffCommand=cmd(decelerate,0.3;diffusealpha,0;);
    Def.ActorFrame {
  		OnCommand=cmd(diffusealpha,0;sleep,0.1;smooth,0.2;diffusealpha,1;);
  		LoadFont("_overpass 36px") .. {
  			InitCommand=cmd(diffuse,ColorDarkTone(PlayerColor(PLAYER_1));zoom,0.75;diffusealpha,1.0;horizalign,right;);
        OnCommand=cmd(playcommand,"Set");
        SetCommand=function(self)
          self:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetTapNoteScores("TapNoteScore_W1"))
        end;
  		};
	};
	Def.ActorFrame {
		InitCommand=cmd(addy,40;);
		OnCommand=cmd(diffusealpha,0;sleep,0.2;smooth,0.2;diffusealpha,1;);
    LoadFont("_overpass 36px") .. {
      InitCommand=cmd(diffuse,ColorDarkTone(PlayerColor(PLAYER_1));zoom,0.75;diffusealpha,1.0;horizalign,right;);
      OnCommand=cmd(playcommand,"Set");
      SetCommand=function(self)
        self:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetTapNoteScores("TapNoteScore_W2"))
      end;
    };
	};
	Def.ActorFrame {
		InitCommand=cmd(addy,40*2;);
		OnCommand=cmd(diffusealpha,0;sleep,0.3;smooth,0.2;diffusealpha,1;);
    LoadFont("_overpass 36px") .. {
      InitCommand=cmd(diffuse,ColorDarkTone(PlayerColor(PLAYER_1));;zoom,0.75;diffusealpha,1.0;horizalign,right;);
      OnCommand=cmd(playcommand,"Set");
      SetCommand=function(self)
        self:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetTapNoteScores("TapNoteScore_W3"))
      end;
    };
	};
	Def.ActorFrame {
		InitCommand=cmd(addy,40*3;);
		OnCommand=cmd(diffusealpha,0;sleep,0.4;smooth,0.2;diffusealpha,1;);
    LoadFont("_overpass 36px") .. {
      InitCommand=cmd(diffuse,ColorDarkTone(PlayerColor(PLAYER_1));;zoom,0.75;diffusealpha,1.0;horizalign,right;);
      OnCommand=cmd(playcommand,"Set");
      SetCommand=function(self)
        self:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetTapNoteScores("TapNoteScore_W4"))
      end;
    };
	};
	Def.ActorFrame {
		InitCommand=cmd(addy,40*4;);
		OnCommand=cmd(diffusealpha,0;sleep,0.5;smooth,0.2;diffusealpha,1;);
    LoadFont("_overpass 36px") .. {
      InitCommand=cmd(diffuse,ColorDarkTone(PlayerColor(PLAYER_1));;zoom,0.75;diffusealpha,1.0;horizalign,right;);
      OnCommand=cmd(playcommand,"Set");
      SetCommand=function(self)
        self:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetTapNoteScores("TapNoteScore_W5"))
      end;
    };
	};
	Def.ActorFrame {
		InitCommand=cmd(addy,40*5;);
		OnCommand=cmd(diffusealpha,0;sleep,0.6;smooth,0.2;diffusealpha,1;);
    LoadFont("_overpass 36px") .. {
      InitCommand=cmd(diffuse,ColorDarkTone(PlayerColor(PLAYER_1));zoom,0.75;diffusealpha,1.0;horizalign,right;);
      OnCommand=cmd(playcommand,"Set");
      SetCommand=function(self)
        self:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetTapNoteScores("TapNoteScore_Miss"))
      end;
    };
	};
	Def.ActorFrame {
		InitCommand=cmd(addy,40*6;);
		OnCommand=cmd(diffusealpha,0;sleep,0.7;smooth,0.2;diffusealpha,1;);
    LoadFont("_overpass 36px") .. {
      InitCommand=cmd(diffuse,ColorDarkTone(PlayerColor(PLAYER_1));zoom,0.75;diffusealpha,1.0;horizalign,right;);
      OnCommand=cmd(playcommand,"Set");
      SetCommand=function(self)
        self:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetHoldNoteScores("HoldNoteScore_Held"))
      end;
    };
	};
	Def.ActorFrame {
		InitCommand=cmd(addy,40*7;);
		OnCommand=cmd(diffusealpha,0;sleep,0.8;smooth,0.2;diffusealpha,1;);
    LoadFont("_overpass 36px") .. {
      InitCommand=cmd(diffuse,ColorDarkTone(PlayerColor(PLAYER_1));zoom,0.75;diffusealpha,1.0;horizalign,right;);
      OnCommand=cmd(playcommand,"Set");
      SetCommand=function(self)
        self:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):MaxCombo())
      end;
    };
	};
  Def.ActorFrame {
    InitCommand=cmd(addy,40*8+4;);
    OnCommand=cmd(diffusealpha,0;sleep,0.8;smooth,0.2;diffusealpha,1;);
    LoadFont("_overpass 36px") .. {
      InitCommand=cmd(diffuse,ColorDarkTone(PlayerColor(PLAYER_1));zoom,1;diffusealpha,1;horizalign,right;);
      OnCommand=cmd(playcommand,"Set");
      SetCommand=function(self)
        self:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetScore())
      end;
    };
    LoadFont("_overpass 36px") .. {
      InitCommand=cmd(diffuse,ColorDarkTone(PlayerColor(PLAYER_1));zoom,0.75;diffusealpha,1;horizalign,right;addy,29);
      OnCommand=cmd(playcommand,"Set");
      SetCommand=function(self)
        local p1percent = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetPercentDancePoints()
        self:settext(FormatPercentScore(p1percent))
      end;
    };
  };
};

-- P2 Values
t[#t+1] = Def.ActorFrame {
    InitCommand=cmd(x,SCREEN_CENTER_X+130;y,SCREEN_CENTER_Y-80;visible,GAMESTATE:IsHumanPlayer(PLAYER_2););
    OffCommand=cmd(decelerate,0.3;diffusealpha,0;);
    Def.ActorFrame {
  		OnCommand=cmd(diffusealpha,0;sleep,0.1;smooth,0.2;diffusealpha,1;);
  		LoadFont("_overpass 36px") .. {
  			InitCommand=cmd(diffuse,ColorDarkTone(PlayerColor(PLAYER_2));zoom,0.75;diffusealpha,1.0;horizalign,left;);
        OnCommand=cmd(playcommand,"Set");
        SetCommand=function(self)
          self:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetTapNoteScores("TapNoteScore_W1"))
        end;
  		};
	};
	Def.ActorFrame {
		InitCommand=cmd(addy,40;);
		OnCommand=cmd(diffusealpha,0;sleep,0.2;smooth,0.2;diffusealpha,1;);
    LoadFont("_overpass 36px") .. {
      InitCommand=cmd(diffuse,ColorDarkTone(PlayerColor(PLAYER_2));zoom,0.75;diffusealpha,1.0;horizalign,left;);
      OnCommand=cmd(playcommand,"Set");
      SetCommand=function(self)
        self:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetTapNoteScores("TapNoteScore_W2"))
      end;
    };
	};
	Def.ActorFrame {
		InitCommand=cmd(addy,40*2;);
		OnCommand=cmd(diffusealpha,0;sleep,0.3;smooth,0.2;diffusealpha,1;);
    LoadFont("_overpass 36px") .. {
      InitCommand=cmd(diffuse,ColorDarkTone(PlayerColor(PLAYER_2));zoom,0.75;diffusealpha,1.0;horizalign,left;);
      OnCommand=cmd(playcommand,"Set");
      SetCommand=function(self)
        self:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetTapNoteScores("TapNoteScore_W3"))
      end;
    };
	};
	Def.ActorFrame {
		InitCommand=cmd(addy,40*3;);
		OnCommand=cmd(diffusealpha,0;sleep,0.4;smooth,0.2;diffusealpha,1;);
    LoadFont("_overpass 36px") .. {
      InitCommand=cmd(diffuse,ColorDarkTone(PlayerColor(PLAYER_2));zoom,0.75;diffusealpha,1.0;horizalign,left;);
      OnCommand=cmd(playcommand,"Set");
      SetCommand=function(self)
        self:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetTapNoteScores("TapNoteScore_W4"))
      end;
    };
	};
	Def.ActorFrame {
		InitCommand=cmd(addy,40*4;);
		OnCommand=cmd(diffusealpha,0;sleep,0.5;smooth,0.2;diffusealpha,1;);
    LoadFont("_overpass 36px") .. {
      InitCommand=cmd(diffuse,ColorDarkTone(PlayerColor(PLAYER_2));zoom,0.75;diffusealpha,1.0;horizalign,left;);
      OnCommand=cmd(playcommand,"Set");
      SetCommand=function(self)
        self:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetTapNoteScores("TapNoteScore_W5"))
      end;
    };
	};
	Def.ActorFrame {
		InitCommand=cmd(addy,40*5;);
		OnCommand=cmd(diffusealpha,0;sleep,0.6;smooth,0.2;diffusealpha,1;);
    LoadFont("_overpass 36px") .. {
      InitCommand=cmd(diffuse,ColorDarkTone(PlayerColor(PLAYER_2));zoom,0.75;diffusealpha,1.0;horizalign,left;);
      OnCommand=cmd(playcommand,"Set");
      SetCommand=function(self)
        self:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetTapNoteScores("TapNoteScore_Miss"))
      end;
    };
	};
	Def.ActorFrame {
		InitCommand=cmd(addy,40*6;);
		OnCommand=cmd(diffusealpha,0;sleep,0.7;smooth,0.2;diffusealpha,1;);
    LoadFont("_overpass 36px") .. {
      InitCommand=cmd(diffuse,ColorDarkTone(PlayerColor(PLAYER_2));zoom,0.75;diffusealpha,1.0;horizalign,left;);
      OnCommand=cmd(playcommand,"Set");
      SetCommand=function(self)
        self:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetHoldNoteScores("HoldNoteScore_Held"))
      end;
    };
	};
	Def.ActorFrame {
		InitCommand=cmd(addy,40*7;);
		OnCommand=cmd(diffusealpha,0;sleep,0.8;smooth,0.2;diffusealpha,1;);
    LoadFont("_overpass 36px") .. {
      InitCommand=cmd(diffuse,ColorDarkTone(PlayerColor(PLAYER_2));zoom,0.75;diffusealpha,1.0;horizalign,left;);
      OnCommand=cmd(playcommand,"Set");
      SetCommand=function(self)
        self:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):MaxCombo())
      end;
    };
	};
  Def.ActorFrame {
    InitCommand=cmd(addy,40*8+4;);
    OnCommand=cmd(diffusealpha,0;sleep,0.8;smooth,0.2;diffusealpha,1;);
    LoadFont("_overpass 36px") .. {
      InitCommand=cmd(diffuse,ColorDarkTone(PlayerColor(PLAYER_2));zoom,1;diffusealpha,1;horizalign,right;);
      OnCommand=cmd(playcommand,"Set");
      SetCommand=function(self)
        self:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetScore())
      end;
    };
    LoadFont("_overpass 36px") .. {
      InitCommand=cmd(diffuse,ColorDarkTone(PlayerColor(PLAYER_2));zoom,0.75;diffusealpha,1;horizalign,right;addy,29);
      OnCommand=cmd(playcommand,"Set");
      SetCommand=function(self)
        local p1percent = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetPercentDancePoints()
        self:settext(FormatPercentScore(p1percent))
      end;
    };
  };
};

if GAMESTATE:IsHumanPlayer(PLAYER_1) == true then
-- Grade display
t[#t+1] = Def.ActorFrame {
  InitCommand=cmd(zoom,1;diffusealpha,1;horizalign,left;x,SCREEN_CENTER_X-320;y,SCREEN_CENTER_Y-170);
  OffCommand=cmd(decelerate,0.4;diffusealpha,0;);
  Def.Quad {
          InitCommand=cmd(zoomto,220,130;diffuse,color("#fce1a1"););
          OnCommand=cmd(diffusealpha,0;sleep,0.6;decelerate,0.4;diffusealpha,0.4;)
  };
  LoadActor(THEME:GetPathG("GradeDisplay", "Grade " .. p1grade)) .. {
      InitCommand=cmd(zoom,0.8;addy,-16;);
      OnCommand=function(self)
        if STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetStageAward() then
          self:addy(0);
        else
          self:addy(16);
        end;
        self:diffusealpha(0):zoom(0.5):sleep(0.63):decelerate(0.4):zoom(0.8):diffusealpha(1);
      end;
  };
  LoadFont("_roboto condensed Bold italic 24px") .. {
    InitCommand=cmd(diffuse,color("#826216");zoom,1.0;addy,40;maxwidth,200;uppercase,true;);
    OnCommand=cmd(playcommand,"Set");
    SetCommand=function(self)
      if STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetStageAward() then
        self:settext(THEME:GetString( "StageAward", ToEnumShortString(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetStageAward())) );
        self:diffusealpha(0):zoomx(0.5):sleep(0.63):decelerate(0.4):zoomx(1):diffusealpha(1);
      end
    end;
  };
};

-- Difficulty banner
t[#t+1] = Def.ActorFrame {
  InitCommand=cmd(x,SCREEN_CENTER_X-180;y,SCREEN_CENTER_Y-170;zoom,0.6;visible,not GAMESTATE:IsCourseMode(););
  OnCommand=cmd(zoomx,0.3;diffusealpha,0;decelerate,0.4;zoomx,0.6;diffusealpha,1;);
  OffCommand=cmd(decelerate,0.4;diffusealpha,0;);
    LoadActor(THEME:GetPathG("StepsDisplayListRow", "frame")) .. {
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

    LoadFont("_overpass 36px") .. {
        InitCommand=cmd(addy,26;zoom,1;);
        OnCommand=cmd(playcommand,"Set";);
        CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Set";);
        ChangedLanguageDisplayMessageCommand=cmd(playcommand,"Set";);
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

end;


if GAMESTATE:IsHumanPlayer(PLAYER_2) == true then
-- Grade display
t[#t+1] = Def.ActorFrame {
  InitCommand=cmd(zoom,1;diffusealpha,1;horizalign,right;x,SCREEN_CENTER_X+320;y,SCREEN_CENTER_Y-170);
  OffCommand=cmd(decelerate,0.4;diffusealpha,0;);
  Def.Quad {
          InitCommand=cmd(zoomto,220,130;diffuse,color("#fce1a1"););
          OnCommand=cmd(diffusealpha,0;sleep,0.6;decelerate,0.4;diffusealpha,0.4;)
  };
  LoadActor(THEME:GetPathG("GradeDisplay", "Grade " .. p2grade)) .. {
      InitCommand=cmd(zoom,0.8;addy,-16;);
      OnCommand=function(self)
        if STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetStageAward() then
          self:addy(0);
        else
          self:addy(16);
        end;
        self:diffusealpha(0):zoom(0.5):sleep(0.63):decelerate(0.4):zoom(0.8):diffusealpha(1);
      end;
  };
  LoadFont("_roboto condensed Bold italic 24px") .. {
    InitCommand=cmd(diffuse,color("#826216");zoom,1.0;addy,40;maxwidth,200;uppercase,true;);
    OnCommand=cmd(playcommand,"Set");
    SetCommand=function(self)
      if STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetStageAward() then
        self:settext(THEME:GetString( "StageAward", ToEnumShortString(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetStageAward())) );
        self:diffusealpha(0):zoomx(0.5):sleep(0.63):decelerate(0.4):zoomx(1):diffusealpha(1);
      end;
    end;
  };
};

-- Difficulty banner
t[#t+1] = Def.ActorFrame {
  InitCommand=cmd(x,SCREEN_CENTER_X-180;y,SCREEN_CENTER_Y-170;zoom,0.6;visible,not GAMESTATE:IsCourseMode(););
  OnCommand=cmd(zoomx,0.3;diffusealpha,0;decelerate,0.4;zoomx,0.6;diffusealpha,1;);
  OffCommand=cmd(decelerate,0.4;diffusealpha,0;);
    LoadActor(THEME:GetPathG("StepsDisplayListRow", "frame")) .. {
      OnCommand=cmd(playcommand,"Set";);
      CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Set";);
      SetCommand=function(self)
        stepsP1 = GAMESTATE:GetCurrentSteps(PLAYER_2)
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

    LoadFont("_overpass 36px") .. {
        InitCommand=cmd(addy,26;zoom,1;);
        OnCommand=cmd(playcommand,"Set";);
        CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Set";);
        ChangedLanguageDisplayMessageCommand=cmd(playcommand,"Set";);
        SetCommand=function(self)
        stepsP1 = GAMESTATE:GetCurrentSteps(PLAYER_2)
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

end;

if not GAMESTATE:IsCourseMode() then
t[#t+1] = Def.ActorFrame {
  InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y-170-18;);
  OnCommand=cmd(zoomx,0.8;diffusealpha,0;decelerate,0.4;zoomx,1;diffusealpha,1;);
  OffCommand=cmd(decelerate,0.4;diffusealpha,0;);
  Def.Quad {
          InitCommand=cmd(zoomto,300,130;diffuse,color("#fce1a1");addy,18;diffusealpha,0.4;);
  };
  Def.Sprite {
  		name="SongBanner";
      InitCommand=cmd(playcommand,"Set";);
          SetCommand=function(self)
          local song = GAMESTATE:GetCurrentSong();
    			if song then
              if song:HasBanner() then
                  self:Load(song:GetBannerPath())
                  self:scaletoclipped(300,94)
              else
                self:Load(THEME:GetPathG("Common fallback", "banner"))
              end
  			  else
  				self:diffusealpha(0)
              end
          end;
  		};
  };
end;

if GAMESTATE:IsCourseMode() then
t[#t+1] = Def.ActorFrame {
  InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y-170-18;);
  OnCommand=cmd(zoomx,0.8;diffusealpha,0;decelerate,0.4;zoomx,1;diffusealpha,1;);
  OffCommand=cmd(decelerate,0.4;diffusealpha,0;);
  Def.Quad {
          InitCommand=cmd(zoomto,300,130;diffuse,color("#fce1a1");addy,18;diffusealpha,0.4;);
  };
  Def.Sprite {
  		name="CourseBanner";
      InitCommand=cmd(playcommand,"Set";);
          SetCommand=function(self)
          local course = GAMESTATE:GetCurrentCourse();
    			if course then
              if course:HasBanner() then
                  self:Load(course:GetBannerPath())
                  self:scaletoclipped(300,94)
              else
                self:Load(THEME:GetPathG("Common fallback", "banner"))
              end
  			  else
  				self:diffusealpha(0)
              end
          end;
  		};
  };
end;

t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y-122;);
	OnCommand=cmd(zoomx,0.8;diffusealpha,0;decelerate,0.4;zoomx,1;diffusealpha,1;);
	OffCommand=cmd(decelerate,0.4;diffusealpha,0;);
	LoadActor(THEME:GetPathG("ScreenWithMenuElements", "StageDisplay")) .. {
		OnCommand=cmd(diffuse,color("#9d324e"));
	};
};

t[#t+1] = StandardDecorationFromFileOptional("LifeDifficulty","LifeDifficulty");
t[#t+1] = StandardDecorationFromFileOptional("TimingDifficulty","TimingDifficulty");

return t;
