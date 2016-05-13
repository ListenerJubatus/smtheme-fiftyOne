local t = Def.ActorFrame {};
	--P1
	t[#t+1] = LoadActor("_lifep1") .. {
		InitCommand=cmd(visible,GAMESTATE:IsHumanPlayer(PLAYER_1);x,Center1Player() and SCREEN_CENTER_X or THEME:GetMetric(Var "LoadingScreen","PlayerP1OnePlayerOneSideX");y,SCREEN_TOP-40);
		OnCommand=cmd(addy,90);
		OffCommand=cmd(sleep,0.6;decelerate,0.5;addy,-90);
	};

	t[#t+1] = LoadActor("_lifep2") .. {
		InitCommand=cmd(visible,GAMESTATE:IsHumanPlayer(PLAYER_2);x,Center1Player() and SCREEN_CENTER_X or THEME:GetMetric(Var "LoadingScreen","PlayerP2OnePlayerOneSideX");y,SCREEN_TOP-40);
		OnCommand=cmd(addy,90);
		OffCommand=cmd(sleep,0.6;decelerate,0.5;addy,-90);
	};

return t
