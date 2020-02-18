return Def.ActorFrame {
	LoadFont("Common Condensed") .. {
		Text=string.format("%s %s", ProductFamily(), ProductVersion());
		AltText="StepMania";
		InitCommand=function(self) self:zoom(1):horizalign(right):diffuse(color("#FFFFFF")):strokecolor(color("0,0,0,0.75")) end;
	};
	LoadFont("_noto sans 36px") .. {
		Text=string.format("%s", VersionDate());
		AltText="Unknown Version";
		InitCommand=function(self) self:zoom(0.5):y(21):horizalign(right):diffuse(color("#FFFFFF")):strokecolor(color("0,0,0,0.75")) end;
	};
};