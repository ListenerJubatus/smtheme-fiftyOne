return Def.ActorFrame {
	Def.Quad {
		InitCommand=function(self)
			self:zoomto(SCREEN_WIDTH,SCREEN_HEIGHT):Center():diffuse(color("#DF9515")):diffusetopedge(color("#EDC039"))
		end;	
	};
};