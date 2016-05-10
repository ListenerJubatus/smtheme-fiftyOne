local t = Def.ActorFrame {};

t[#t+1] = Def.Quad {
	InitCommand=cmd(vertalign,top;zoomto,SCREEN_WIDTH,96;diffuse,color("#1C1C1B");diffusebottomedge,color("#333230");diffusealpha,0.9;);
};

t[#t+1] = LoadFont("_open sans semibold 48px") .. {
	Name="HeaderShadow";
	Text=Screen.String("HeaderText");
	InitCommand=cmd(zoom,0.8;x,-SCREEN_CENTER_X+100;y,40;horizalign,left;);
	OnCommand=cmd(diffuse,color("#fcb62c"););
	UpdateScreenHeaderMessageCommand=function(self,param)
		self:settext(param.Header);
	end;
};

t[#t+1] = LoadFont("Common Condensed") .. {
	Name="HeaderShadow";
	Text=Screen.String("HeaderSubText");
	InitCommand=cmd(zoom,0.8;x,-SCREEN_CENTER_X+100;y,70;horizalign,left;);
	OnCommand=cmd(diffuse,color("#f9b06d"););
	UpdateScreenHeaderMessageCommand=function(self,param)
		self:settext(param.Header);
	end;
};

return t;
