local playMode = GAMESTATE:GetPlayMode()
local slideTime = 1.1;
local slideWait = 0.3;
local bottomSlide = 0.5;
local easeTime = 0.10;

local sStage = ""
sStage = GAMESTATE:GetCurrentStage()

if playMode ~= 'PlayMode_Regular' and playMode ~= 'PlayMode_Rave' and playMode ~= 'PlayMode_Battle' then
  sStage = playMode;
end;

local t = Def.ActorFrame {};
t[#t+1] = Def.Quad {
	InitCommand=function(self) self:Center():zoomto(SCREEN_WIDTH,SCREEN_HEIGHT):diffuse(Color("Black")) end;
};

if GAMESTATE:IsCourseMode() then
	t[#t+1] = LoadActor("CourseDisplay");
else
	t[#t+1] = Def.Sprite {
		InitCommand=function(self) self:Center():diffusealpha(0.26) end;
		BeginCommand=function(self) self:LoadFromCurrentSongBackground() end;
		OnCommand=function(self)
			self:scale_or_crop_background()
			self:addy(SCREEN_HEIGHT):sleep(slideWait):smooth(slideTime):addy(-SCREEN_HEIGHT):diffusealpha(1);
		end;
	};
end


-- BG for credits
t[#t+1] = Def.ActorFrame {
	OnCommand=function(self) 
		self:addy(SCREEN_HEIGHT):sleep(slideWait):smooth(slideTime+easeTime):addy(-SCREEN_HEIGHT)
		self:sleep(2-easeTime):smooth(bottomSlide):addy(240)
	end;
	-- Behind stage graphic
	Def.Quad {
		InitCommand=function(self)
			self:vertalign(bottom):xy(SCREEN_CENTER_X,SCREEN_BOTTOM-110):zoomto(SCREEN_WIDTH,120) 
		end;
		OnCommand=function(self)
			self:diffuse(color("#000000")):diffusealpha(0.8);
		end
	};
	-- Behind song
	Def.Quad {
		InitCommand=function(self)
			self:vertalign(bottom):xy(SCREEN_CENTER_X,SCREEN_BOTTOM):zoomto(SCREEN_WIDTH,110) 
		end;
		OnCommand=function(self)
			self:diffuse(color("#000000")):diffusealpha(0.9);
		end
	};
};


local stage_num_actor= THEME:GetPathG("ScreenStageInformation", "Stage " .. ToEnumShortString(sStage), true)
if stage_num_actor ~= "" and FILEMAN:DoesFileExist(stage_num_actor) then
	stage_num_actor= LoadActor(stage_num_actor)
else
	-- Midiman:  We need a "Stage Next" actor or something for stages after
	-- the 6th. -Kyz
	local curStage = GAMESTATE:GetCurrentStage();
	stage_num_actor= Def.BitmapText{
		Font= "_open sans semibold 24px",  Text= thified_curstage_index(false) .. " Stage",
		InitCommand= function(self)
			self:zoom(1.5)
			self:strokecolor(Color.Black)
			self:diffuse(StageToColor(curStage));
			self:diffusetopedge(ColorLightTone(StageToColor(curStage)));
		end
	}
end

t[#t+1] = Def.ActorFrame {
	InitCommand=function(self) self:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y+190) end;
	OnCommand=function(self) 
		self:addy(SCREEN_HEIGHT):sleep(slideWait):smooth(slideTime+easeTime):addy(-SCREEN_HEIGHT)
		self:sleep(2-easeTime):smooth(bottomSlide):addy(240)
	end;
	
	stage_num_actor .. {
		OnCommand=function(self) self:zoom(1):diffusealpha(1) end;
	};
};

-- Step author credits
for pn in ivalues(PlayerNumber) do
	t[#t+1] = Def.ActorFrame {
	Condition=GAMESTATE:IsHumanPlayer(pn);
	InitCommand=function(self)
		self:xy((pn == PLAYER_1 and SCREEN_LEFT+40) or SCREEN_RIGHT-40,SCREEN_BOTTOM-80)
	end;
	OnCommand=function(self) 
		self:addy(SCREEN_HEIGHT):sleep(slideWait):smooth(slideTime+easeTime):addy(-SCREEN_HEIGHT)
		self:sleep(2-easeTime):smooth(bottomSlide):addy(240)
	end;
		LoadFont("_open sans condensed 24px") .. {
		  OnCommand=function(self) self:playcommand("Set"):horizalign((pn == PLAYER_1 and left) or right):skewx(-0.1):diffuse(color("#FFFFFF")) end;
          SetCommand=function(self)
			local steps = GAMESTATE:GetCurrentSteps(pn)
			local song = GAMESTATE:GetCurrentSong();
			self:settext("")
			if song and steps:GetAuthorCredit() ~= "" then			
				self:settext(string.upper(THEME:GetString("OptionTitles","Step Author")) .. ":");
			end
         end
		};
		LoadFont("Common Fallback Font") .. {
		  InitCommand=function(self) self:addy(22) end;
		  OnCommand=function(self) self:playcommand("Set"):horizalign((pn == PLAYER_1 and left) or right):zoom(0.75):diffuse(color("#FFFFFF")) end;
          SetCommand=function(self)
			local steps = GAMESTATE:GetCurrentSteps(pn)
			local song = GAMESTATE:GetCurrentSong();
			self:settext("")
			if song and steps ~= nil then
				self:settext(steps:GetAuthorCredit())
			end
         end
		};
	};
end

-- Song title and artist
t[#t+1] = Def.ActorFrame {
	InitCommand=function(self) self:xy(SCREEN_CENTER_X,SCREEN_BOTTOM-80) end;
	OnCommand=function(self) 
		self:addy(SCREEN_HEIGHT):sleep(slideWait):smooth(slideTime+easeTime):addy(-SCREEN_HEIGHT)
		self:sleep(2-easeTime):smooth(bottomSlide):addy(240)
	end;
	LoadFont("Common Fallback Font") .. {
		Text=GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse():GetDisplayFullTitle() or GAMESTATE:GetCurrentSong():GetDisplayFullTitle();
		InitCommand=function(self) self:diffuse(Color.White):maxwidth(SCREEN_WIDTH*0.6) end;
		OnCommand=function(self) self:zoom(1) end;
	};
	LoadFont("Common Fallback Font") .. {
		Text=GAMESTATE:IsCourseMode() and ToEnumShortString( GAMESTATE:GetCurrentCourse():GetCourseType() ) or GAMESTATE:GetCurrentSong():GetDisplayArtist();
		InitCommand=function(self) self:diffuse(Color.White):maxwidth(SCREEN_WIDTH*0.6) end;
		OnCommand=function(self) self:zoom(0.75):addy(24) end;
	};
};

-- Stunt BG in case the BG accidentally overhangs
t[#t+1] = Def.Quad {
	InitCommand=function(self) self:Center():diffuse(Color.Black):zoomto(SCREEN_WIDTH,SCREEN_HEIGHT) end;
	OnCommand=function(self) self:sleep(slideWait):smooth(slideTime):addy(-SCREEN_HEIGHT):sleep(0.2):diffusealpha(0) end;
};

return t