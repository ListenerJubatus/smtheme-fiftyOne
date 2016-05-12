local t = Def.ActorFrame {};

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
  			InitCommand=cmd(diffuse,Color("Black");zoom,0.75;diffusealpha,0.8;horizalign,right;);
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
      InitCommand=cmd(diffuse,Color("Black");zoom,0.75;diffusealpha,0.8;horizalign,right;);
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
      InitCommand=cmd(diffuse,Color("Black");zoom,0.75;diffusealpha,0.8;horizalign,right;);
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
      InitCommand=cmd(diffuse,Color("Black");zoom,0.75;diffusealpha,0.8;horizalign,right;);
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
      InitCommand=cmd(diffuse,Color("Black");zoom,0.75;diffusealpha,0.8;horizalign,right;);
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
      InitCommand=cmd(diffuse,Color("Black");zoom,0.75;diffusealpha,0.8;horizalign,right;);
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
      InitCommand=cmd(diffuse,Color("Black");zoom,0.75;diffusealpha,0.8;horizalign,right;);
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
      InitCommand=cmd(diffuse,Color("Black");zoom,0.75;diffusealpha,0.8;horizalign,right;);
      OnCommand=cmd(playcommand,"Set");
      SetCommand=function(self)
        self:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):MaxCombo())
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
  			InitCommand=cmd(diffuse,Color("Black");zoom,0.75;diffusealpha,0.8;horizalign,left;);
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
      InitCommand=cmd(diffuse,Color("Black");zoom,0.75;diffusealpha,0.8;horizalign,left;);
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
      InitCommand=cmd(diffuse,Color("Black");zoom,0.75;diffusealpha,0.8;horizalign,left;);
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
      InitCommand=cmd(diffuse,Color("Black");zoom,0.75;diffusealpha,0.8;horizalign,left;);
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
      InitCommand=cmd(diffuse,Color("Black");zoom,0.75;diffusealpha,0.8;horizalign,left;);
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
      InitCommand=cmd(diffuse,Color("Black");zoom,0.75;diffusealpha,0.8;horizalign,left;);
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
      InitCommand=cmd(diffuse,Color("Black");zoom,0.75;diffusealpha,0.8;horizalign,left;);
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
      InitCommand=cmd(diffuse,Color("Black");zoom,0.75;diffusealpha,0.8;horizalign,left;);
      OnCommand=cmd(playcommand,"Set");
      SetCommand=function(self)
        self:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):MaxCombo())
      end;
    };
	};
};

return t;
