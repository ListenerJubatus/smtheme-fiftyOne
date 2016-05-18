local t = Def.ActorFrame {};

t[#t+1] = Def.ActorFrame {
	Def.Quad {
		InitCommand=cmd(vertalign,bottom;zoomto,SCREEN_WIDTH,5;addy,-50;diffuse,Color("Black");fadetop,1;diffusealpha,0.8);
	};
};

t[#t+1] = Def.ActorFrame {
	Def.Quad {
		InitCommand=cmd(vertalign,bottom;zoomto,SCREEN_WIDTH,50;diffuse,color("#25201A");diffusetopedge,color("#000000"););
	};
};

return t;
