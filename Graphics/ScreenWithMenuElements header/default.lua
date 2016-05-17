local t = Def.ActorFrame {};

function HeaderColor(screen)

    local colors = {
        ["ScreenSelectStyle"] = color("#be4a8c"), 
        ["ScreenSelectPlayMode"] = color("#478e6f"), 
        ["ScreenSelectMusic"] = color("#3298aa"), 
        ["ScreenSelectCourse"] = color("#be784a"), --is this a thing? LOL
        ["ScreenPlayerOptions"] = color("#544abe"),
        ["ScreenNestyPlayerOptions"] = color("#544abe"),
        ["ScreenOptionsService"] = color("#333333"),
        ["ScreenEvaluation"] = color("#e8a120"), 
        ["ScreenEvaluationSummary"] = color("#e8a120"), --is this also a thing?
        ["Default"] = color("#666666"),
    }

    if colors[screen] then 
        return colors[screen];
    else
        return colors["Default"];
    end;

end;


-- Base bar
t[#t+1] = Def.Quad {
    InitCommand=cmd(vertalign,top;zoomto,SCREEN_WIDTH,96;diffuse,color("#1C1C1B");diffusebottomedge,color("#333230");diffusealpha,0.9;);
    OnCommand=function(self)
    self:addy(-96):decelerate(0.5):addy(96)
        end;
    OffCommand=cmd(sleep,0.3;decelerate,0.4;addy,-96;);
};

-- Diamond (todo: Symbol system)
t[#t+1] = Def.ActorFrame {
    InitCommand=cmd(x,-SCREEN_CENTER_X+76;y,SCREEN_TOP+30;);
    OnCommand=cmd(addx,-110;sleep,0.3;decelerate,0.7;addx,110;);
    OffCommand=cmd(decelerate,0.3;addx,-110;);
        Def.Quad {
            InitCommand=cmd(vertalign,top;zoomto,54,54;rotationz,45;);
			OnCommand=function(self)
				self:diffuse(HeaderColor(screen))
			end;
        };
        Def.Sprite {
            Name="HeaderDiamondIcon";
            InitCommand=cmd(horizalign,center;y,18;x,-20;);
            OnCommand=function(self)
                local screen = SCREENMAN:GetTopScreen():GetName();
                local icon =  screen.." icon"
                if FILEMAN:DoesFileExist("Themes/"..THEME:GetCurThemeName().."/Graphics/ScreenWithMenuElements header/"..icon) then
                    self:Load(THEME:GetPathG("","ScreenWithMenuElements header/"..icon))
                else
                    print("iconerror: file does not exist");
                    self:Load(THEME:GetPathG("Generic", "icon"))
                end;
            end;
        };
    };

-- Text
t[#t+1] = LoadFont("Common Header") .. {
    Name="HeaderShadow";
    Text=Screen.String("HeaderText");
    InitCommand=cmd(zoom,0.8;x,-SCREEN_CENTER_X+110;y,40;horizalign,left;diffuse,color("#fcb62c"););
    OnCommand=cmd(diffusealpha,0;sleep,0.5;smooth,0.3;diffusealpha,1;);
    UpdateScreenHeaderMessageCommand=function(self,param)
        self:settext(param.Header);
    end;
    OffCommand=cmd(smooth,0.3;diffusealpha,0;);
};

t[#t+1] = LoadFont("Common Condensed") .. {
    Name="HeaderShadow";
    Text=Screen.String("HeaderSubText");
    InitCommand=cmd(zoom,0.8;x,-SCREEN_CENTER_X+110;y,70;horizalign,left;diffuse,color("#f9b06d"));
    OnCommand=cmd(diffusealpha,0;sleep,0.55;smooth,0.3;diffusealpha,1;);
    UpdateScreenHeaderMessageCommand=function(self,param)
        self:settext(param.Header);
    end;
    OffCommand=cmd(smooth,0.3;diffusealpha,0;);
};

return t;