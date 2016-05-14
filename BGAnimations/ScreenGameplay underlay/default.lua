local t = Def.ActorFrame {};
	
	t[#t+1] = LoadActor(THEME:GetPathG("LifeMeter", "p1 under")) .. {
		InitCommand=cmd(visible,GAMESTATE:IsHumanPlayer(PLAYER_1);x,Center1Player() and SCREEN_CENTER_X or THEME:GetMetric(Var "LoadingScreen","PlayerP1OnePlayerOneSideX");y,SCREEN_TOP-40);
		OnCommand=cmd(addy,90+15);
	};

	t[#t+1] = LoadActor(THEME:GetPathG("LifeMeter", "p2 under")) .. {
		InitCommand=cmd(visible,GAMESTATE:IsHumanPlayer(PLAYER_2);x,Center1Player() and SCREEN_CENTER_X or THEME:GetMetric(Var "LoadingScreen","PlayerP2OnePlayerOneSideX");y,SCREEN_TOP-40);
		OnCommand=cmd(addy,90+15);
	};
	
	t[#t+1]= use_newfield_actor()

return t