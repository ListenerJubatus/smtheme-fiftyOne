local t = Def.ActorFrame {};
	--P1
	if GAMESTATE:IsHumanPlayer(PLAYER_1) == true then
	t[#t+1] = LoadActor("_lifep1") .. {
		InitCommand=cmd(visible,GAMESTATE:IsHumanPlayer(PLAYER_1);x,SCREEN_LEFT+40;y,SCREEN_CENTER_Y;rotationz,-90;);
	};
	end;

	if GAMESTATE:IsHumanPlayer(PLAYER_2) == true then
	t[#t+1] = LoadActor("_lifep2") .. {
		InitCommand=cmd(visible,GAMESTATE:IsHumanPlayer(PLAYER_2);x,SCREEN_RIGHT-40;y,SCREEN_CENTER_Y;rotationz,-90;);
	};
	end;

	t[#t+1] = StandardDecorationFromFileOptional("StageDisplay","StageDisplay");
	t[#t+1]= LoadActor(THEME:GetPathG("", "pause_menu"))
return t
