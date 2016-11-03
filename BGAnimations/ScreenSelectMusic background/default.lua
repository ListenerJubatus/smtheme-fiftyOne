local t = Def.ActorFrame {};

t[#t+1] = Def.ActorFrame {
	Def.Quad {
		InitCommand=cmd(zoomto,SCREEN_WIDTH,SCREEN_HEIGHT;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffuse,color("#e23f12");diffusebottomedge,color("#ffc261"););
	};
	Def.ActorFrame {
		OnCommand=cmd(diffusealpha,1;diffuseshift;effectcolor1,color("1,1,1,0.1");effectcolor2,color("1,1,1,0.3");effectperiod,10);
	};
	LoadActor("_tunnel1") .. {
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;blend,'BlendMode_Add';rotationz,-20);
		OnCommand=cmd(zoom,1.75;diffusealpha,0.25;spin;effectmagnitude,0,0,23;);
	};		
	LoadActor("_tunnel1") .. {
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;blend,'BlendMode_Add';rotationz,-10);
		OnCommand=cmd(zoom,1.0;diffusealpha,0.20;spin;effectmagnitude,0,0,-23;);
	};
	LoadActor("_tunnel1") .. {
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;blend,'BlendMode_Add';rotationz,0);
		OnCommand=cmd(zoom,0.5;diffusealpha,0.15;spin;effectmagnitude,0,0,23;);
	};		
	LoadActor("_tunnel1") .. {
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;blend,'BlendMode_Add';rotationz,-10);
		OnCommand=cmd(zoom,0.2;diffusealpha,0.10;spin;effectmagnitude,0,0,-23;);
	};		
};

return t;
