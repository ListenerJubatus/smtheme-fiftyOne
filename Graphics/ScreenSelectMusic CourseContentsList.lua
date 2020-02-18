-- Man, I hate this thing. I tried to do what I could with it, though.

-- I'm not really sure why this needs to be separate from the main CourseContentsList creation...
local transform = function(self,offsetFromCenter,itemIndex,numItems)
	self:y( offsetFromCenter * 62 )
	-- First condition is for making sure the items disappear before going past the banner.
	-- Second condition is to make their transition from the bottom of the screen look a little smoother.
	-- The exact numbers will likely need changing if "NumItemsToDraw" is changed.
	if offsetFromCenter < -1 or offsetFromCenter > 5 then
		self:diffusealpha(0)
	-- And this is just so the objects don't look quite as "THERE" underneath the info pane and footer.
	elseif offsetFromCenter < 0 or offsetFromCenter > 4 then
		self:diffusealpha(0.6)
	end
end

return Def.CourseContentsList {
	MaxSongs = 999,
    NumItemsToDraw = 12,
	ShowCommand=function(self) self:bouncebegin(0.3):zoomy(1) end;
	HideCommand=function(self) self:bounceend(0.3):zoomy(0) end;
	SetCommand=function(self)
		self:SetFromGameState()
		self:SetCurrentAndDestinationItem(0)
		self:SetPauseCountdownSeconds(1)
		self:SetSecondsPauseBetweenItems( 0.25 )
		self:SetTransformFromFunction(transform)
		--
		self:SetDestinationItem( math.max(0,self:GetNumItems() - 5) )
		self:SetLoop(false)
		self:SetMask(0,0)
	end,
	CurrentTrailP1ChangedMessageCommand=function(self) self:playcommand("Set") end;
	CurrentTrailP2ChangedMessageCommand=function(self) self:playcommand("Set") end;

	Display = Def.ActorFrame { 
		InitCommand=function(self) self:setsize(290,64) end;

		LoadActor(THEME:GetPathG("CourseEntryDisplay","bar")) .. {
			SetSongCommand=function(self, params)
				if params.Difficulty then
					self:diffuse(ColorLightTone(CustomDifficultyToColor(params.Difficulty)));
				else
					self:diffuse( color("#FFFFFF") );
				end
			end
		},

		Def.TextBanner {
			InitCommand=function(self) self:xy(-10,-1):Load("TextBannerCourse"):SetFromString("", "", "", "", "", "") end;
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
					self:diffuse(color("#000000"));
					self:diffusealpha(0.8);
-- 					self:glow("1,1,1,0.5");
				else
					self:SetFromString( "??????????", "??????????", "", "", "", "" );
					self:diffuse( color("#FFFFFF") );
-- 					self:glow("1,1,1,0");
				end
			end
		},

 		LoadFont("CourseEntryDisplay","difficulty") .. {
			Text="0",
			InitCommand=function(self) self:xy(210,0):zoom(0.75) end;
			SetSongCommand=function(self, params)
				if params.PlayerNumber ~= GAMESTATE:GetMasterPlayerNumber() then return end
				self:settext( params.Meter );
				self:diffuse(ColorDarkTone(CustomDifficultyToColor(params.Difficulty) ));
			end
		},
	}
}