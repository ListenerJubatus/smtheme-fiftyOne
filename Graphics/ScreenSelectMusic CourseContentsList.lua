local transform = function(self,offsetFromCenter,itemIndex,numitems)
	self:y( offsetFromCenter * 62 );
end
return Def.CourseContentsList {
	MaxSongs = 10;
    NumItemsToDraw = 8;
	ShowCommand=cmd(bouncebegin,0.3;zoomy,1);
	HideCommand=cmd(linear,0.3;zoomy,0);
	SetCommand=function(self)
		self:SetFromGameState();
		self:SetCurrentAndDestinationItem(0);
		self:SetPauseCountdownSeconds(1);
		self:SetSecondsPauseBetweenItems( 0.25 );
		self:SetTransformFromFunction(transform);
		--
		self:SetDestinationItem( math.max(0,self:GetNumItems() - 4) );
		self:SetLoop(false);
		self:SetMask(0,0);
	end;
	CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"Set");
	CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"Set");

	Display = Def.ActorFrame { 
		InitCommand=cmd(setsize,290,64);

		LoadActor(THEME:GetPathG("CourseEntryDisplay","bar")) .. {
			SetSongCommand=function(self, params)
				if params.Difficulty then
					self:diffuse(ColorDarkTone(CustomDifficultyToColor(params.Difficulty)));
				else
					self:diffuse( color("#FFFFFF") );
				end
				(cmd(finishtweening;diffusealpha,0;sleep,0.125*params.Number;smooth,0.2;diffusealpha,1))(self);
			end;
		};
		
		LoadActor(THEME:GetPathG("CourseEntryDisplay","diamond")) .. {
			SetSongCommand=function(self, params)
				if params.Difficulty then
					self:diffuse( CustomDifficultyToColor(params.Difficulty) );
				else
					self:diffuse( color("#FFFFFF") );
				end

				(cmd(finishtweening;diffusealpha,0;sleep,0.125*params.Number;smooth,0.2;diffusealpha,1))(self);
			end;
		};

		Def.TextBanner {
			InitCommand=cmd(x,-10;y,-1;Load,"TextBanner";SetFromString,"", "", "", "", "", "");
			SetSongCommand=function(self, params)
				if params.Song then
					if GAMESTATE:GetCurrentCourse():GetDisplayFullTitle() == "Abomination" then
						-- abomination hack
						if PREFSMAN:GetPreference("EasterEggs") then
							if params.Number % 2 ~= 0 then
								-- turkey march
								local artist = params.Song:GetDisplayArtist();
								self:SetFromString( "Turkey", "", "", "", artist, "" );
							else
								self:SetFromSong( params.Song );
							end;
						else
							self:SetFromSong( params.Song );
						end;
					else
						self:SetFromSong( params.Song );
					end;
					self:diffuse(ColorLightTone(CustomDifficultyToColor(params.Difficulty) ));
-- 					self:glow("1,1,1,0.5");
				else
					self:SetFromString( "??????????", "??????????", "", "", "", "" );
					self:diffuse( color("#FFFFFF") );
-- 					self:glow("1,1,1,0");
				end
				
				(cmd(finishtweening;diffusealpha,0;sleep,0.125*params.Number;smooth,0.2;diffusealpha,1;))(self);
			end;
		};

 		LoadFont("CourseEntryDisplay","difficulty") .. {
			Text="0";
			InitCommand=cmd(x,205;y,0;zoom,0.75;);
			SetSongCommand=function(self, params)
				if params.PlayerNumber ~= GAMESTATE:GetMasterPlayerNumber() then return end
				self:settext( params.Meter );
				self:diffuse(ColorDarkTone(CustomDifficultyToColor(params.Difficulty) ));
				(cmd(finishtweening;zoomy,0;sleep,0.125*params.Number;linear,0.125;zoom,1.1;linear,0.05;zoom,1))(self);
			end;
		}; 
	};
};