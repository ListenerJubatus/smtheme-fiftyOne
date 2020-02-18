return Def.ActorFrame {
	LoadActor(THEME:GetPathG("common bg", "base")) .. {
		InitCommand=function(self) self:FullScreen():Center() end;
	};
}
