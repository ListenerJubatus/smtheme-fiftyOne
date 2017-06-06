-- You know what, I guess the "fancy UI background" theme option can be put to use.
if ThemePrefs.Get("FancyUIBG") then
	return Def.ActorFrame {
		LoadActor(THEME:GetPathG("common bg", "base")) .. {
			InitCommand=cmd(Center;zoomto,SCREEN_WIDTH,SCREEN_HEIGHT)
		},
		LoadActor("_maze") .. {
			OnCommand=cmd(Center;diffuse,color("#f6784922");effectperiod,10;spin;effectmagnitude,0,0,2.2)
		},
		--
		Def.ActorFrame {
		InitCommand=cmd(x,SCREEN_CENTER_X-40;y,SCREEN_CENTER_Y;rotationx,20;rotationy,12;diffusealpha,0.15);
		OnCommand=cmd(queuecommand,"Animate");
		AnimateCommand=cmd(rotationx,20;rotationy,12;smooth,20;rotationx,50;rotationy,36;smooth,20;rotationx,20;rotationy,12;queuecommand,"Animate");
			LoadActor("_mask") .. {
				InitCommand=cmd(blend,"BlendMode_NoEffect";zwrite,true;clearzbuffer,true);
			};
			
			LoadActor("_mist") .. {
				InitCommand=cmd(ztest,5;zoomto,1200,1200;blend,'BlendMode_Add');
				OnCommand=cmd(customtexturerect,0,0,1,1;texcoordvelocity,0.11,0.11);
			};
		},
	}
else
	return 	LoadActor(THEME:GetPathG("common bg", "base")) .. {
		InitCommand=cmd(Center;zoomto,SCREEN_WIDTH,SCREEN_HEIGHT)
	}
end