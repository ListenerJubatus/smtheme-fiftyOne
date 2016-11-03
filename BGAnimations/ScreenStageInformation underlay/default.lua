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
			self:sleep(0.5)
			self:decelerate(0.50)
			self:diffusealpha(1)
			self:sleep(3)
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
		InitCommand=cmd(zoomto,SCREEN_WIDTH,110;diffuse,color("#000000");diffusealpha,0.8;);
		OnCommand=cmd(sleep,4;decelerate,0.7;zoomy,0;diffusealpha,0);
	};
	
	stage_num_actor .. {
		OnCommand=cmd(zoom,1;diffusealpha,1;sleep,4;decelerate,0.7;zoomy,0;diffusealpha,0);
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
