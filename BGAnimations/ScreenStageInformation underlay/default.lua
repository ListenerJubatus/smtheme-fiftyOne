local playMode = GAMESTATE:GetPlayMode()

local sStage = ""
sStage = GAMESTATE:GetCurrentStage()

if playMode ~= 'PlayMode_Regular' and playMode ~= 'PlayMode_Rave' and playMode ~= 'PlayMode_Battle' then
  sStage = playMode;
end;

local t = Def.ActorFrame {};
t[#t+1] = Def.Quad {
	InitCommand=cmd(Center;zoomto,SCREEN_WIDTH,SCREEN_HEIGHT;diffuse,Color("Black"));
};
if GAMESTATE:IsCourseMode() then
	t[#t+1] = LoadActor("CourseDisplay");
else
	t[#t+1] = Def.Sprite {
		InitCommand=cmd(Center;diffusealpha,0);
		BeginCommand=cmd(LoadFromCurrentSongBackground);
		OnCommand=function(self)
			self:scale_or_crop_background()
			self:sleep(0.5):decelerate(0.50):diffusealpha(1):sleep(3)
		end;
	};
end

local stage_num_actor= THEME:GetPathG("ScreenStageInformation", "Stage " .. ToEnumShortString(sStage), true)
if stage_num_actor ~= "" and FILEMAN:DoesFileExist(stage_num_actor) then
	stage_num_actor= LoadActor(stage_num_actor)
else
	-- Midiman:  We need a "Stage Next" actor or something for stages after
	-- the 6th. -Kyz
	local curStage = GAMESTATE:GetCurrentStage();
	stage_num_actor= Def.BitmapText{
		Font= "Common Normal",  Text= thified_curstage_index(false) .. " Stage",
		InitCommand= function(self)
			self:zoom(1.5)
			self:strokecolor(Color.Black)
			self:diffuse(StageToColor(curStage));
			self:diffusetopedge(ColorLightTone(StageToColor(curStage)));
		end
	}
end

t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
	Def.Quad {
		InitCommand=cmd(zoomto,SCREEN_WIDTH,110;diffuse,color("#000000");diffusealpha,0.8;fadeleft,0.6;faderight,0.6);
		OnCommand=cmd(sleep,4;decelerate,0.7;diffusealpha,0);
	};
	
	stage_num_actor .. {
		OnCommand=cmd(zoom,1;diffusealpha,1;sleep,4;decelerate,0.7;zoom,0.75;diffusealpha,0);
	};
};

-- BG for credits
t[#t+1] = Def.ActorFrame {
	OnCommand=cmd(sleep,4;decelerate,0.7;diffusealpha,0);
	-- Behind P1 credit
	Def.Quad {
		InitCommand=cmd(horizalign,center;x,SCREEN_LEFT;y,SCREEN_BOTTOM-68;zoomto,SCREEN_WIDTH*0.4,55;diffuse,color("#000000");diffusealpha,0.75;faderight,0.6);
		OnCommand=function(self)
			stepsP1 = GAMESTATE:GetCurrentSteps(PLAYER_1)
			local song = GAMESTATE:GetCurrentSong();
			if song then
				if stepsP1 ~= nil then
					self:visible(true)
				else
					self:visible(false)
				end
			else
				self:visible(false)
			end
          end
	};
	-- Behind P2 credit
	Def.Quad {
		InitCommand=cmd(horizalign,right;x,SCREEN_RIGHT;y,SCREEN_BOTTOM-68;zoomto,SCREEN_WIDTH*0.4,55;diffuse,color("#000000");diffusealpha,0.75;faderight,0.6);
		OnCommand=function(self)
			stepsP2 = GAMESTATE:GetCurrentSteps(PLAYER_2)
			local song = GAMESTATE:GetCurrentSong();
			if song then
				if stepsP2 ~= nil then
					self:visible(true)
				else
					self:visible(false)
				end
			else
				self:visible(false)
			end
          end
	};
	Def.Quad {
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-68;zoomto,SCREEN_WIDTH*0.5,55;diffuse,color("#000000");diffusealpha,0.9;fadeleft,0.8;faderight,0.8);
	};
};

-- Step author credits
	if GAMESTATE:IsHumanPlayer(PLAYER_1) == true then
	t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(y,SCREEN_BOTTOM-80;x,SCREEN_LEFT+40;);
	OnCommand=cmd(sleep,4;decelerate,0.7;diffusealpha,0);
		LoadFont("Common Italic Condensed") .. {
		  OnCommand=cmd(playcommand,"Set";horizalign,left;diffuse,color("#FFFFFF");strokecolor,color("#000000"););
          SetCommand=function(self)
			stepsP1 = GAMESTATE:GetCurrentSteps(PLAYER_1)
			local song = GAMESTATE:GetCurrentSong();
			if song then
				if stepsP1:GetAuthorCredit() ~= "" then
					self:settext(string.upper(THEME:GetString("OptionTitles","Step Author")) .. ":");
				else
					self:settext("")
				end
			else
				self:settext("")
			end
         end
		};
		LoadFont("Common Fallback Font") .. {
		  InitCommand=cmd(addy,22);
		  OnCommand=cmd(playcommand,"Set";horizalign,left;zoom,0.75;diffuse,color("#FFFFFF");strokecolor,color("#000000"););
          SetCommand=function(self)
			stepsP1 = GAMESTATE:GetCurrentSteps(PLAYER_1)
			local song = GAMESTATE:GetCurrentSong();
			if song then
				if stepsP1 ~= nil then
					self:settext(stepsP1:GetAuthorCredit())
				else
					self:settext("")
				end
			else
				self:settext("")
			end
         end
		};
	};
	end
	
	if GAMESTATE:IsHumanPlayer(PLAYER_2) == true then
	t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(y,SCREEN_BOTTOM-80;x,SCREEN_RIGHT-40;);
	OnCommand=cmd(sleep,4;decelerate,0.7;diffusealpha,0);
	LoadFont("Common Italic Condensed") .. {
		  OnCommand=cmd(playcommand,"Set";horizalign,right;diffuse,color("#FFFFFF");strokecolor,color("#000000"););
          SetCommand=function(self)
			stepsP2 = GAMESTATE:GetCurrentSteps(PLAYER_2)
			local song = GAMESTATE:GetCurrentSong();
			if song then
				local diff = stepsP2:GetDifficulty();
				if stepsP2:GetAuthorCredit() ~= "" then
					self:settext(string.upper(THEME:GetString("OptionTitles","Step Author")) .. ":");
				else
					self:settext("")
				end
			else
				self:settext("")
			end
         end
		};

	LoadFont("Common Fallback Font") .. {
		  InitCommand=cmd(addy,22);
		  OnCommand=cmd(playcommand,"Set";horizalign,right;zoom,0.75;diffuse,color("#FFFFFF");strokecolor,color("#000000"););
          SetCommand=function(self)
			stepsP2 = GAMESTATE:GetCurrentSteps(PLAYER_2)
			local song = GAMESTATE:GetCurrentSong();
			if song then
				if stepsP2 ~= nil then
					self:settext(stepsP2:GetAuthorCredit())
				else
					self:settext("")
				end
			else
				self:settext("")
			end
          end
	};
	};
	end

-- Song title and artist
t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-80);
	OnCommand=cmd(sleep,4;decelerate,0.7;diffusealpha,0);
	LoadFont("Common Fallback Font") .. {
		Text=GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse():GetDisplayFullTitle() or GAMESTATE:GetCurrentSong():GetDisplayFullTitle();
		InitCommand=cmd(diffuse,color("#FFFFFF");strokecolor,color("#000000");maxwidth,SCREEN_WIDTH*0.78);
		OnCommand=cmd(zoom,1;);
	};
	LoadFont("Common Fallback Font") .. {
		Text=GAMESTATE:IsCourseMode() and ToEnumShortString( GAMESTATE:GetCurrentCourse():GetCourseType() ) or GAMESTATE:GetCurrentSong():GetDisplayArtist();
		InitCommand=cmd(diffuse,color("#FFFFFF");strokecolor,color("#000000");maxwidth,SCREEN_WIDTH*0.78);
		OnCommand=cmd(zoom,0.75;addy,24;);
	};
};

t[#t+1] = Def.ActorFrame {

	LoadActor(THEME:GetPathG("", "_pt1")) .. {
		InitCommand=cmd(zoomto,SCREEN_WIDTH,SCREEN_HEIGHT;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffuse,color("#000000"););
		OnCommand=cmd(diffusealpha,1;sleep,1.1;sleep,0.1;linear,0.2;diffusealpha,0;);
	};
	
	LoadActor(THEME:GetPathG("", "_pt2")) .. {
	InitCommand=cmd(zoomto,SCREEN_WIDTH,SCREEN_HEIGHT;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffuse,color("#000000"););
	OnCommand=cmd(diffusealpha,1;sleep,1.1;sleep,0.2;linear,0.2;diffusealpha,0;);
	};

	LoadActor(THEME:GetPathG("", "_pt3")) .. {
	InitCommand=cmd(zoomto,SCREEN_WIDTH,SCREEN_HEIGHT;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffuse,color("#000000"););
	OnCommand=cmd(diffusealpha,1;sleep,1.1;sleep,0.3;linear,0.2;diffusealpha,0;);
	};
	
	LoadActor(THEME:GetPathG("", "_pt4")) .. {
	InitCommand=cmd(zoomto,SCREEN_WIDTH,SCREEN_HEIGHT;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffuse,color("#000000"););	
	OnCommand=cmd(diffusealpha,1;sleep,1.1;sleep,0.4;linear,0.2;diffusealpha,0;);
	};
	
	LoadActor(THEME:GetPathG("", "_pt5")) .. {
	InitCommand=cmd(zoomto,SCREEN_WIDTH,SCREEN_HEIGHT;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffuse,color("#000000"););	
	OnCommand=cmd(diffusealpha,1;sleep,1.1;sleep,0.5;linear,0.2;diffusealpha,0;);
	};
	
	LoadActor(THEME:GetPathG("", "_pt6")) .. {
	InitCommand=cmd(zoomto,SCREEN_WIDTH,SCREEN_HEIGHT;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffuse,color("#000000"););	
	OnCommand=cmd(diffusealpha,1;sleep,1.1;sleep,0.6;linear,0.2;diffusealpha,0;);
	};
	
};

return t
