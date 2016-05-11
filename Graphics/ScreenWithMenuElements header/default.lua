local t = Def.ActorFrame {};

-- Base bar
t[#t+1] = Def.Quad {
	InitCommand=cmd(vertalign,top;zoomto,SCREEN_WIDTH,96;diffuse,color("#1C1C1B");diffusebottomedge,color("#333230");diffusealpha,0.9;);
	OnCommand=cmd(addy,-96;decelerate,0.5;addy,96;);
	OffCommand=cmd(sleep,0.3;decelerate,0.4;addy,-96;);
};

-- Diamond (todo: Symbol system)
t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(x,-SCREEN_CENTER_X+76;y,SCREEN_TOP+30;);
	OnCommand=cmd(addx,-110;sleep,0.3;decelerate,0.7;addx,110;);
	OffCommand=cmd(decelerate,0.3;addx,-110;);
		Def.Quad {
			InitCommand=cmd(vertalign,top;zoomto,54,54;diffuse,color("#3298aa");rotationz,45;);
		};
	};

-- Text
t[#t+1] = LoadFont("_open sans semibold 48px") .. {
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
