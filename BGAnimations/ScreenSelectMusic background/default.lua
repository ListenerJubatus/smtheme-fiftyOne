local t = Def.ActorFrame {};

t[#t+1] = Def.ActorFrame {
	Def.Quad {
		InitCommand=cmd(zoomto,SCREEN_WIDTH,SCREEN_HEIGHT;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffuse,color("#e23f12");diffusebottomedge,color("#ffc261"););
	};
	Def.ActorFrame {
		OnCommand=cmd(diffusealpha,1;diffuseshift;effectcolor1,color("1,1,1,0.1");effectcolor2,color("1,1,1,0.3");effectperiod,10);
		LoadActor("_maze") .. {
			InitCommand=cmd(rotationz,-20;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffuse,color("#ffedd1");blend,'BlendMode_Add';);
			OnCommand=cmd(spin;effectmagnitude,0,0,6;);
		};
	};
};

return t;
