local gc = Var("GameCommand");

return Def.ActorFrame {
	LoadFont("_open sans semibold 48px") .. {
		Text=THEME:GetString("ScreenTitleMenu",gc:GetText());
		OnCommand=function(self) self:shadowlength(1) end;
		GainFocusCommand=function(self) self:stoptweening():linear(0.1):zoom(1):diffuse(color("#A3375C")) end;
		LoseFocusCommand=function(self) self:stoptweening():linear(0.1):zoom(0.75):diffuse(color("#512232")) end;
	};
};