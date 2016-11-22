return Def.ActorFrame {
	LoadActor(THEME:GetPathG("common bg", "base")) .. {
		InitCommand=cmd(Center;zoomto,SCREEN_WIDTH,SCREEN_HEIGHT)
	};
	LoadActor("_maze") .. {
		OnCommand=cmd(Center;diffuse,color("#f6784922");effectperiod,10;spin;effectmagnitude,0,0,2.2)
	};
	LoadActor("_particleLoader") .. {
	};
}
