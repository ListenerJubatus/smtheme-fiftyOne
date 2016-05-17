local t = Def.ActorFrame {};

-- Header color based on screen name
function HeaderColor(screen)
    local colors = {
        ["ScreenSelectStyle"] = color("#81468B"), 
        ["ScreenSelectPlayMode"] = color("#478e6f"), 
        ["ScreenSelectMusic"] = color("#1268aa"), 
        ["ScreenSelectCourse"] = color("#1268aa"), --is this a thing? LOL
        ["ScreenPlayerOptions"] = color("#544abe"),
        ["ScreenNestyPlayerOptions"] = color("#544abe"),
        ["ScreenOptionsService"] = color("#1C1C1B"),
        ["ScreenEvaluationNormal"] = color("#806635"), 
        ["ScreenEvaluationSummary"] = color("#B38D47"), --is this also a thing?
        ["Default"] = color("#1C1C1B"),
    }
    if colors[screen] then 
        return colors[screen];
    else
        return colors["Default"];
    end;
end;

-- Base bar diffuse,color("#1C1C1B");diffusebottomedge,color("#333230");
t[#t+1] = Def.Quad {
	InitCommand=cmd(vertalign,top;zoomto,SCREEN_WIDTH,96;);
	OnCommand=function(self)
		self:diffuse(HeaderColor(SCREENMAN:GetTopScreen():GetName())):diffusetopedge(ColorDarkTone(HeaderColor(SCREENMAN:GetTopScreen():GetName()))):diffusealpha(0.8)
		self:addy(-96):decelerate(0.5):addy(96);
	end;
	OffCommand=cmd(sleep,0.3;decelerate,0.4;addy,-96;);
};

-- Diamond (todo: Migrate mode colors to global vars)
t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(x,-SCREEN_CENTER_X+76;y,SCREEN_TOP+30;);
	OnCommand=cmd(addx,-110;sleep,0.3;decelerate,0.7;addx,110;);
	OffCommand=cmd(decelerate,0.3;addx,-110;);

	-- Diamond BG
	Def.Quad {
		InitCommand=cmd(vertalign,top;zoomto,54,54;rotationz,45;);
		OnCommand=function(self)
			self:diffuse(ColorLightTone(HeaderColor(SCREENMAN:GetTopScreen():GetName())))
		end;
	},
	-- Symbol selector
	Def.Sprite {
		Name="HeaderDiamondIcon";
		InitCommand=cmd(horizalign,center;y,18;x,-20;diffusealpha,0.8);
		OnCommand=function(self)
			local screen = SCREENMAN:GetTopScreen():GetName();
			if FILEMAN:DoesFileExist("Themes/"..THEME:GetCurThemeName().."/Graphics/ScreenWithMenuElements header/"..screen.." icon.png") then
				self:Load(THEME:GetPathG("","ScreenWithMenuElements header/"..screen.." icon"));
			else
				print("iconerror: file does not exist")
				self:Load(THEME:GetPathG("","ScreenWithMenuElements header/Generic icon"));
			end;
		end;
	},
};

-- Text
t[#t+1] = LoadFont("Common Header") .. {
	Name="HeaderTitle";
	Text=Screen.String("HeaderText");
	InitCommand=cmd(zoom,0.8;x,-SCREEN_CENTER_X+110;y,40;horizalign,left;diffuse,color("#fcb62c"););
	OnCommand=cmd(diffusealpha,0;sleep,0.5;smooth,0.3;diffusealpha,1;);
	UpdateScreenHeaderMessageCommand=function(self,param)
		self:settext(param.Header);
	end;
	OffCommand=cmd(smooth,0.3;diffusealpha,0;);
};

t[#t+1] = LoadFont("Common Condensed") .. {
	Name="HeaderSubTitle";
	Text=Screen.String("HeaderSubText");
	InitCommand=cmd(zoom,0.8;x,-SCREEN_CENTER_X+110;y,70;horizalign,left;diffuse,color("#f9b06d"););
	OnCommand=cmd(diffusealpha,0;sleep,0.55;smooth,0.3;diffusealpha,1;);
	UpdateScreenHeaderMessageCommand=function(self,param)
		self:settext(param.Header);
	end;
	OffCommand=cmd(smooth,0.3;diffusealpha,0;);
};

return t;