local t = LoadFallbackB();

local StepsType = ToEnumShortString( GAMEMAN:GetFirstStepsTypeForGame(GAMESTATE:GetCurrentGame()) );
local stString = THEME:GetString("StepsType",StepsType);

local NumColumns = THEME:GetMetric(Var "LoadingScreen", "NumColumns");

t[#t+1] = Def.Quad {
	InitCommand=function(self) self:zoomto(SCREEN_WIDTH, 56):xy(SCREEN_CENTER_X,SCREEN_CENTER_Y-220) end;
	OnCommand=function(self)
		self:diffuse(ScreenColor(SCREENMAN:GetTopScreen():GetName())):diffusebottomedge(ColorDarkTone(ScreenColor(SCREENMAN:GetTopScreen():GetName()))):diffusealpha(0.9)
	end
};

for i=1,NumColumns do
	local st = THEME:GetMetric(Var "LoadingScreen","ColumnStepsType" .. i);	
	local dc = THEME:GetMetric(Var "LoadingScreen","ColumnDifficulty" .. i);
	local s = GetCustomDifficulty( st, dc );
	
	t[#t+1] = Def.ActorFrame {
		InitCommand=function(self) self:x(SCREEN_CENTER_X+32 + 84 * (i-1)):y(SCREEN_CENTER_Y-220) end;
		LoadActor(THEME:GetPathB("_frame","3x1"),"rounded light", 18) .. {
			OnCommand=function(self) self:diffuse(CustomDifficultyToLightColor(s)):diffusealpha(0.9) end;
		};
		LoadFont("StepsDisplayListRow description") .. {
			InitCommand=function(self) self:uppercase(true):settext(CustomDifficultyToLocalizedString(s)) end;
			OnCommand=function(self) self:zoom(0.675):maxwidth(80/0.675):diffuse(CustomDifficultyToDarkColor(s)) end;
		};
	};
end

t[#t+1] = LoadFont("_open sans semibold 24px") .. {
	InitCommand=function(self) self:settext(stString):x(SCREEN_CENTER_X-220):y(SCREEN_CENTER_Y-220) end;
	OnCommand=function(self) self:diffusebottomedge(color("0.75,0.75,0.75")):shadowlength(2) end;
};

t.OnCommand=function(self) self:draworder(105) end;

return t;
