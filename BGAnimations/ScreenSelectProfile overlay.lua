function GetLocalProfiles()
	local t = {};

	function GetSongsPlayedString(numSongs)
		return numSongs == 1 and Screen.String("SingularSongPlayed") or Screen.String("SeveralSongsPlayed")
	end

	for p = 0,PROFILEMAN:GetNumLocalProfiles()-1 do
		local profile=PROFILEMAN:GetLocalProfileFromIndex(p);
		local ProfileCard = Def.ActorFrame {
			LoadFont("Common Fallback") .. {
				Text=profile:GetDisplayName();
				InitCommand=function(self) self:shadowlength(1):y(-12):zoom(1):strokecolor(Color.Black):ztest(true) end;
			};
			LoadFont("Common Condensed") .. {
				InitCommand=function(self) self:shadowlength(1):y(10):zoom(0.7):vertspacing(-8):ztest(true) end;
				BeginCommand=function(self)
					local numSongsPlayed = profile:GetNumTotalSongsPlayed();
					self:settext( string.format( GetSongsPlayedString( numSongsPlayed ), numSongsPlayed ) )
				end;
			};
		};
		t[#t+1]=ProfileCard;
	end;

	return t;
end;

function LoadCard(cColor)
	local t = Def.ActorFrame {
		LoadActor( THEME:GetPathG("ScreenSelectProfile","CardBackground") ) .. {
			InitCommand=function(self) self:diffuse(ColorMidTone(cColor)) end;
		};
	};
	return t
end
function LoadPlayerStuff(Player)
	local t = {};

	local pn = (Player == PLAYER_1) and 1 or 2;

--[[ 	local t = LoadActor(THEME:GetPathB('', '_frame 3x3'), 'metal', 200, 230) .. {
		Name = 'BigFrame';
	}; --]]
	t[#t+1] = Def.ActorFrame {
		Name = 'JoinFrame';
		LoadCard(color('#882D47'));
		LoadFont("_open sans condensed 24px") .. {
			Text="Press &START; to join";
			InitCommand=function(self) self:shadowlength(1):zoom(1.25):skewx(-0.1) end;
			OnCommand=function(self) self:diffuseshift():effectcolor1(Color('White')):effectcolor2(color("0.5,0.5,0.5")):strokecolor(color("#4A1110")) end;
		};
	};
	
	t[#t+1] = Def.ActorFrame {
		Name = 'BigFrame';
		LoadCard(PlayerColor(Player));
	};
	t[#t+1] = Def.ActorFrame {
		Name = 'SmallFrame';
		InitCommand=function(self) self:y(-2) end;
		Def.Quad {
			InitCommand=function(self) self:zoomto(270,48) end;
			OnCommand=function(self) self:diffuse(PlayerDarkColor(Player)):fadeleft(0.1):faderight(0.1) end;
		};
	};

	t[#t+1] = Def.ActorScroller{
		Name = 'Scroller';
		NumItemsToDraw=6;
		OnCommand=function(self) self:y(1):SetFastCatchup(true):SetMask(200,58):SetSecondsPerItem(0.15) end;
		OffCommand=function(self) self:decelerate(0.5):diffusealpha(0) end;
		TransformFunction=function(self, offset, itemIndex, numItems)
			local focus = scale(math.abs(offset),0,2,1,0);
			self:visible(false);
			self:y(math.floor( offset*48 ));
-- 			self:zoomy( focus );
-- 			self:z(-math.abs(offset));
-- 			self:zoom(focus);
		end;
		children = GetLocalProfiles();
	};
	
	t[#t+1] = Def.ActorFrame {
		Name = "EffectFrame";
	};
	t[#t+1] = LoadFont("Common Fallback") .. {
		Name = 'SelectedProfileText';
		InitCommand=function(self) self:y(160):diffuse(Color.White):strokecolor(ColorDarkTone(PlayerColor(Player))):diffusebottomedge(Color.White):zoom(1.25) end;
	};

	return t;
end;

function UpdateInternal3(self, Player)
	local pn = (Player == PLAYER_1) and 1 or 2;
	local frame = self:GetChild(string.format('P%uFrame', pn));
	local scroller = frame:GetChild('Scroller');
	local seltext = frame:GetChild('SelectedProfileText');
	local joinframe = frame:GetChild('JoinFrame');
	local smallframe = frame:GetChild('SmallFrame');
	local bigframe = frame:GetChild('BigFrame');

	if GAMESTATE:IsHumanPlayer(Player) then
		frame:visible(true);
		if MEMCARDMAN:GetCardState(Player) == 'MemoryCardState_none' then
			--using profile if any
			joinframe:visible(false);
			smallframe:visible(true);
			bigframe:visible(true);
			seltext:visible(true);
			scroller:visible(true);
			local ind = SCREENMAN:GetTopScreen():GetProfileIndex(Player);
			if ind > 0 then
				scroller:SetDestinationItem(ind-1);
				seltext:settext(PROFILEMAN:GetLocalProfileFromIndex(ind-1):GetDisplayName());
			else
				if SCREENMAN:GetTopScreen():SetProfileIndex(Player, 1) then
					scroller:SetDestinationItem(0);
					self:queuecommand('UpdateInternal2');
				else
					joinframe:visible(true);
					smallframe:visible(false);
					bigframe:visible(false);
					scroller:visible(false);
					seltext:settext('No profile');
				end;
			end;
		else
			--using card
			smallframe:visible(false);
			scroller:visible(false);
			seltext:settext('CARD');
			SCREENMAN:GetTopScreen():SetProfileIndex(Player, 0);
		end;
	else
		joinframe:visible(true);
		scroller:visible(false);
		seltext:visible(false);
		smallframe:visible(false);
		bigframe:visible(false);
	end;
end;

-- here's a (messy) fix for one player's selection ending the screen,
-- at least until this whole thing is rewritten to be... Not this
local ready = {}
local function AllPlayersReady()
	for i, pn in ipairs(GAMESTATE:GetHumanPlayers()) do
		if not ready[pn] then
			return false
		end
	end
	-- if it hasn't returned false by now, surely it must be true, right? RIGHT???
	return true
end

local t = Def.ActorFrame {

	StorageDevicesChangedMessageCommand=function(self, params)
		self:queuecommand('UpdateInternal2');
	end;

	CodeMessageCommand = function(self, params)
		if params.Name == 'Start' or params.Name == 'Center' then
			MESSAGEMAN:Broadcast("StartButton");
			if not GAMESTATE:IsHumanPlayer(params.PlayerNumber) then
				SCREENMAN:GetTopScreen():SetProfileIndex(params.PlayerNumber, -1);
			else
				ready[params.PlayerNumber] = true
				if AllPlayersReady() then
					SCREENMAN:GetTopScreen():Finish();
				end
			end;
		end;
		if params.Name == 'Up' or params.Name == 'Up2' or params.Name == 'DownLeft' then
			-- Added a line to make sure the player can't fiddle around in the menu
			-- after they've already made a selection.
			if GAMESTATE:IsHumanPlayer(params.PlayerNumber) and not ready[params.PlayerNumber] then
				local ind = SCREENMAN:GetTopScreen():GetProfileIndex(params.PlayerNumber);
				if ind > 1 then
					if SCREENMAN:GetTopScreen():SetProfileIndex(params.PlayerNumber, ind - 1 ) then
						MESSAGEMAN:Broadcast("DirectionButton");
						self:queuecommand('UpdateInternal2');
					end;
				end;
			end;
		end;
		if params.Name == 'Down' or params.Name == 'Down2' or params.Name == 'DownRight' then
			if GAMESTATE:IsHumanPlayer(params.PlayerNumber) and not ready[params.PlayerNumber] then
				local ind = SCREENMAN:GetTopScreen():GetProfileIndex(params.PlayerNumber);
				if ind > 0 then
					if SCREENMAN:GetTopScreen():SetProfileIndex(params.PlayerNumber, ind + 1 ) then
						MESSAGEMAN:Broadcast("DirectionButton");
						self:queuecommand('UpdateInternal2');
					end;
				end;
			end;
		end;
		if params.Name == 'Back' then
			if GAMESTATE:GetNumPlayersEnabled()==0 then
				SCREENMAN:GetTopScreen():Cancel();
			else
				MESSAGEMAN:Broadcast("BackButton")
				-- Allow... erm... un-readying a player.
				if ready[params.PlayerNumber] then
					ready[params.PlayerNumber] = false
				else
					SCREENMAN:GetTopScreen():SetProfileIndex(params.PlayerNumber, -2);
				end
			end;
		end;
	end;

	PlayerJoinedMessageCommand=function(self, params)
		self:queuecommand('UpdateInternal2');
	end;

	PlayerUnjoinedMessageCommand=function(self, params)
		self:queuecommand('UpdateInternal2');
	end;

	OnCommand=function(self, params)
		self:queuecommand('UpdateInternal2');
	end;

	UpdateInternal2Command=function(self)
		UpdateInternal3(self, PLAYER_1);
		UpdateInternal3(self, PLAYER_2);
	end;

	children = {
		Def.ActorFrame {
			Name = 'P1Frame';
			InitCommand=function(self) self:xy(SCREEN_CENTER_X-160,SCREEN_CENTER_Y) end;
			OffCommand=function(self) self:decelerate(0.3):diffusealpha(0) end;
			children = LoadPlayerStuff(PLAYER_1);
		};
		Def.ActorFrame {
			Name = 'P2Frame';
			InitCommand=function(self) self:xy(SCREEN_CENTER_X+160,SCREEN_CENTER_Y) end;
			OffCommand=function(self) self:decelerate(0.3):diffusealpha(0) end;
			children = LoadPlayerStuff(PLAYER_2);
		};
		-- sounds
		LoadActor( THEME:GetPathS("Common","start") )..{
			StartButtonMessageCommand=function(self) self:play() end;
		};
		LoadActor( THEME:GetPathS("Common","cancel") )..{
			BackButtonMessageCommand=function(self) self:play() end;
		};
		LoadActor( THEME:GetPathS("Common","value") )..{
			DirectionButtonMessageCommand=function(self) self:play() end;
		};
	};
};

return t;
