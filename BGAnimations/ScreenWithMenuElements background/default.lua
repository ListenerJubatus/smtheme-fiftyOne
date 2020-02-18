return Def.ActorFrame {
	Def.Quad {
		InitCommand=function(self)
			self:zoomto(SCREEN_WIDTH,SCREEN_HEIGHT):Center():diffuse(color("#DF9515")):diffusebottomedge(color("#EDC039"))
		end;	
	};
	
	Def.Sprite {
		Condition = LoadModule("Config.Load.lua")("FancyUIBG","Save/OutFoxPrefs.ini");
		Texture = THEME:GetPathG("_bg", "hex2 grid");
		InitCommand=function(self)
			self:diffusealpha(0.085):blend('add'):zoomto(SCREEN_WIDTH+100,SCREEN_HEIGHT+190):customtexturerect(0,0,SCREEN_WIDTH*4/512,SCREEN_HEIGHT*4/512):xy(SCREEN_CENTER_X,SCREEN_CENTER_Y)
		end;
		OnCommand=function(self)
			self:texcoordvelocity(0,0.26)
		end;
	};
	
	Def.ActorFrame {
		InitCommand=function(self) self:diffusealpha(0.1) end;
		Def.Sprite {
			Texture="_tunnel1";
			Condition=LoadModule("Config.Load.lua")("FancyUIBG","Save/OutFoxPrefs.ini");		
			InitCommand=function(self) self:xy(SCREEN_LEFT+160,SCREEN_CENTER_Y):rotationz(-10):blend("Add") end;
			OnCommand=function(self) self:zoom(1):spin():effectmagnitude(0,0,-11) end;
		};
	};
};