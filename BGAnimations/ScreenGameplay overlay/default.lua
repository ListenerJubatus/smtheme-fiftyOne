local t = Def.ActorFrame {};
	--P1
	if GAMESTATE:IsHumanPlayer(PLAYER_1) == true then
	t[#t+1] = LoadActor("_lifep1") .. {
		InitCommand=cmd(visible,GAMESTATE:IsHumanPlayer(PLAYER_1);x,SCREEN_LEFT+40;y,SCREEN_CENTER_Y;rotationz,-90;);
		OnCommand=cmd(addx,-100;sleep,1;decelerate,0.9;addx,100;);
		OffCommand=cmd(sleep,1;decelerate,0.9;addx,-100;);
	};
	end;

	if GAMESTATE:IsHumanPlayer(PLAYER_2) == true then
	t[#t+1] = LoadActor("_lifep2") .. {
		InitCommand=cmd(visible,GAMESTATE:IsHumanPlayer(PLAYER_2);x,SCREEN_RIGHT-40;y,SCREEN_CENTER_Y;rotationz,-90;);
		OnCommand=cmd(addx,100;sleep,1;decelerate,0.9;addx,-100;);
		OffCommand=cmd(sleep,1;decelerate,0.9;addx,100;);
	};
	end;

	t[#t+1] = StandardDecorationFromFileOptional("StageDisplay","StageDisplay");
	t[#t+1]= LoadActor(THEME:GetPathG("", "pause_menu"))
return t
