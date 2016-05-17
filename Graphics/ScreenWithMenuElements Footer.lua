local t = Def.ActorFrame {};

t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(diffusealpha,0.8);
Def.Quad {
	InitCommand=cmd(vertalign,bottom;zoomto,SCREEN_WIDTH,55;diffuse,color("#61490E");diffusetopedge,color("#271A01"););
};
};

return t;
