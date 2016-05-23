local t = Def.ActorFrame {};
	--P1
	if GAMESTATE:IsHumanPlayer(PLAYER_1) == true then
	t[#t+1] = LoadActor("_lifep1") .. {
		InitCommand=cmd(visible,GAMESTATE:IsHumanPlayer(PLAYER_1);x,Center1Player() and SCREEN_CENTER_X or THEME:GetMetric(Var "LoadingScreen","PlayerP1OnePlayerOneSideX");y,SCREEN_TOP+59);
	};
	end;

	if GAMESTATE:IsHumanPlayer(PLAYER_2) == true then
	t[#t+1] = LoadActor("_lifep2") .. {
		InitCommand=cmd(visible,GAMESTATE:IsHumanPlayer(PLAYER_2);x,Center1Player() and SCREEN_CENTER_X or THEME:GetMetric(Var "LoadingScreen","PlayerP2OnePlayerOneSideX");y,SCREEN_TOP+59);
	};
	end;

return t
