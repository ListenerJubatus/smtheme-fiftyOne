return Def.ActorFrame {
  	Def.Quad {
		InitCommand=function(self) self:zoomto(SCREEN_WIDTH,SCREEN_HEIGHT):Center() end;
		OnCommand=function(self) self:diffuse(color("#947B7E")):diffusebottomedge(color("#D698A0")) end;
	};  

	Def.Sprite {
		Condition = LoadModule("Config.Load.lua")("FancyUIBG","Save/OutFoxPrefs.ini");
		Texture = THEME:GetPathG("_bg", "hex2 grid");
		InitCommand=function(self)
			self:diffusealpha(0.035):blend('add'):zoomto(SCREEN_WIDTH+100,SCREEN_HEIGHT+190):customtexturerect(0,0,SCREEN_WIDTH*4/512,SCREEN_HEIGHT*4/512):xy(SCREEN_CENTER_X,SCREEN_CENTER_Y)
		end;
		OnCommand=function(self)
			self:texcoordvelocity(0,0.15)
		end;
	};
	
	Def.Quad {
		InitCommand=function(self) self:zoomto(SCREEN_WIDTH,SCREEN_HEIGHT*0.70):x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y+20) end;
		OnCommand=function(self) self:diffuse(color("#61414B")):diffusealpha(0.75) end;
	};
};