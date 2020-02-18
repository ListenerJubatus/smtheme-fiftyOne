return LoadFont("_open sans condensed 24px") .. {
	Text=GetLifeDifficulty();
	AltText="";
	BeginCommand=function(self)
		self:settextf(Screen.String("TimingName"), LoadModule("Config.Load.lua")("SmartTimings","Save/OutFoxPrefs.ini"));
		self:diffuse(color("#882D47")):zoom(0.8);
		self:diffusealpha(0):sleep(0.5):smooth(0.3):diffusealpha(1);
	end;
};
