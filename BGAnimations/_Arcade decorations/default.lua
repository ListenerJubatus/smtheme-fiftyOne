local t = Def.ActorFrame {};
t.InitCommand=function(self)
	self:name("ArcadeOverlay")
	ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
end;
t[#t+1] = Def.ActorFrame {
	Name="ArcadeOverlay.Text";
	InitCommand=function(self)
		ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
	end;
	LoadActor(THEME:GetPathB("_frame","3x1"),"rounded fill", 250-32) .. {
		OnCommand=function(self) self:diffuse(color("#6C1728")):diffusealpha(1) end;
	};
	LoadFont("_open sans condensed 24px") .. {
		InitCommand=function(self) 
			self:zoom(1):shadowlength(1):uppercase(true)
			:diffuse(color("#FF9347")):diffusetopedge(color("#FFB947"))
		end;
		Text="...";
		OnCommand=function(self) self:playcommand("Refresh") end;
		CoinInsertedMessageCommand=function(self) self:playcommand("Refresh") end;
		CoinModeChangedMessageCommand=function(self) self:playcommand("Refresh") end;
		RefreshCommand=function(self)
			local bCanPlay = GAMESTATE:EnoughCreditsToJoin();
			local bReady = GAMESTATE:GetNumSidesJoined() > 0;
			if bCanPlay or bReady then
				self:settext(THEME:GetString("ScreenTitleJoin","HelpTextJoin"));
			else
				self:settext(THEME:GetString("ScreenTitleJoin","HelpTextWait"));
			end
		end;
	};
};
return t