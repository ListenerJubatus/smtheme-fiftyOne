local t = Def.ActorFrame {};

t[#t+1] = Def.Quad {
	InitCommand=cmd(vertalign,bottom;zoomto,SCREEN_WIDTH,55;diffuse,color("#351526"));
};

return t;
