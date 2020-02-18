local raveChildren
return Def.ActorFrame{
	Def.Quad {
		InitCommand=function(self) self:FullScreen():diffuse(color("0,0,0,0")) end;
		StartTransitioningCommand=function(self) self:sleep(0.8):linear(3):diffusealpha(1) end;
	};

	Def.ActorFrame {
		Name="RaveMessages";
		InitCommand=function(self)
			raveChildren = self:GetChildren()
			self:visible(GAMESTATE:GetPlayMode() == 'PlayMode_Rave')

			raveChildren.P1Win:visible(false)
			raveChildren.P2Win:visible(false)
			raveChildren.Draw:visible(false)
		end;
		OffCommand=function(self)
			local p1Win = GAMESTATE:IsWinner(PLAYER_1)
			local p2Win = GAMESTATE:IsWinner(PLAYER_2)

			if GAMESTATE:IsWinner(PLAYER_1) then
				raveChildren.P1Win:visible(true)
			elseif GAMESTATE:IsWinner(PLAYER_2) then
				raveChildren.P2Win:visible(true)
			else
				raveChildren.Draw:visible(true)
			end
		end;

		LoadActor(THEME:GetPathG("_rave result","P1"))..{
			Name="P1Win";
			InitCommand=function(self) self:Center():cropbottom(1):fadebottom(1) end;
			StartTransitioningCommand=function(self) self:sleep(1.8):linear(0.5):cropbottom(0):fadebottom(0):sleep(1.75):linear(0.25):diffusealpha(0) end;
		};
		LoadActor(THEME:GetPathG("_rave result","P2"))..{
			Name="P2Win";
			InitCommand=function(self) self:Center():cropbottom(1):fadebottom(1) end;
			StartTransitioningCommand=function(self) self:sleep(1.8):linear(0.5):cropbottom(0):fadebottom(0):sleep(1.75):linear(0.25):diffusealpha(0) end;
		};
		LoadActor(THEME:GetPathG("_rave result","draw"))..{
			Name="Draw";
			InitCommand=function(self) self:Center():cropbottom(1):fadebottom(1) end;
			StartTransitioningCommand=function(self) self:sleep(1.8):linear(0.5):cropbottom(0):fadebottom(0):sleep(1.75):linear(0.25):diffusealpha(0) end;
		};
	};
};