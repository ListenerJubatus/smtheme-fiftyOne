local t = Def.ActorFrame {};
local tInfo = {
	{"EventMode","Stages"},
	{"LifeDifficulty","Life"},
	{"TimingDifficulty","Difficulty"},
};
local fSpacingX = 72;
local function MakeDisplayBar( fZoomX, fZoomY )
	return Def.ActorFrame {
		Def.Quad {
			InitCommand=function(self) self:vertalign(bottom):y(1):zoomto(fZoomX+2,fZoomY+2) end;
			OnCommand=function(self) self:diffuse(Color.Black) end;
		};
		Def.Quad {
			InitCommand=function(self) self:vertalign(bottom):y(1):zoomto(fZoomX,fZoomY) end;
			OnCommand=function(self) self:diffuse(Color("Orange")):diffusetopedge(Color("Yellow")) end;
		};
	};
end
local function MakeIcon( sTarget )
	local t = Def.ActorFrame {
		LoadActor(THEME:GetPathG("MenuTimer","Frame"));
		LoadFont("_open sans semibold 24px") .. {
			Text=sTarget[2];
			InitCommand=function(self) self:y(24+2):zoom(0.5):shadowlength(1) end;
		};
		--
		LoadFont("_open sans semibold 24px") .. {
			Text="0";
			OnCommand=function(self)
				self:settext(( PREFSMAN:GetPreference("EventMode") ) and "∞" or PREFSMAN:GetPreference("SongsPerPlay")) 
			end;
			Condition=sTarget[1] == "EventMode";
		};
		Def.ActorFrame {
			-- Life goes up to 1-5
			Def.ActorFrame {
				InitCommand=function(self) self:y(12) end;
				MakeDisplayBar( 6, 5 ) .. {
					InitCommand=function(self) self:x(-16):visible(( GetLifeDifficulty() >= 1 )) end;
				};
				MakeDisplayBar( 6, 9 ) .. {
					InitCommand=function(self) self:x(-8):visible(( GetLifeDifficulty() >= 2 )) end;
				};
				MakeDisplayBar( 6, 13 ) .. {
					InitCommand=function(self) self:x(0):visible(( GetLifeDifficulty() >= 3 )) end;
				};
				MakeDisplayBar( 6, 16 ) .. {
					InitCommand=function(self) self:x(8):visible(( GetLifeDifficulty() >= 4 )) end;
				};
				MakeDisplayBar( 6, 20 ) .. {
					InitCommand=function(self) self:x(16):visible(( GetLifeDifficulty() >= 5 )) end;
				};
			};
			Condition=sTarget[1] == "LifeDifficulty";
		};
		Def.ActorFrame {
			-- Timing goes up to 1-8
			Def.ActorFrame {
				InitCommand=function(self) self:y(12) end;
				MakeDisplayBar( 4, 5 ) .. {
					InitCommand=function(self) self:x(-20):visible(( GetTimingDifficulty() >= 1 )) end;
				};
				MakeDisplayBar( 4, 9 ) .. {
					InitCommand=function(self) self:x(-15):visible(( GetTimingDifficulty() >= 2 )) end;
				};
				MakeDisplayBar( 4, 13 ) .. {
					InitCommand=function(self) self:x(-10):visible(( GetTimingDifficulty() >= 3 )) end;
				};
				MakeDisplayBar( 4, 16 ) .. {
					InitCommand=function(self) self:x(-5):visible(( GetTimingDifficulty() >= 4 )) end;
				};
				MakeDisplayBar( 4, 20 ) .. {
					InitCommand=function(self) self:x(5):visible(( GetTimingDifficulty() >= 5 )) end;
				};
				MakeDisplayBar( 4, 20 ) .. {
					InitCommand=function(self) self:x(10):visible(( GetTimingDifficulty() >= 6 )) end;
				};
				MakeDisplayBar( 4, 20 ) .. {
					InitCommand=function(self) self:x(15):visible(( GetTimingDifficulty() >= 7 )) end;
				};
				MakeDisplayBar( 4, 20 ) .. {
					InitCommand=function(self) self:x(20):visible(( GetTimingDifficulty() >= 8 )) end;
				};
			};
			Condition=sTarget[1] == "TimingDifficulty";
		};
	};
	return t
end;

for i=1,#tInfo do
	t[#t+1] = MakeIcon( tInfo[i] ) .. {
		InitCommand=function(self) self:x((i-1)*fSpacingX) end;
	};
end

return t

