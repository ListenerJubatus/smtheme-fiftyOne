local t = Def.ActorFrame {};

t[#t+1] = Def.ActorFrame {
	Def.Quad {
	InitCommand=function(self)
		self:vertalign(bottom):zoomto(SCREEN_WIDTH,5):addy(-50):diffuse(Color.Black):fadetop(1):diffusealpha(0.3) 
	end;
	};
};

t[#t+1] = Def.ActorFrame {
	Def.Quad {
		InitCommand=function(self)
			self:vertalign(bottom):zoomto(SCREEN_WIDTH,50)
		end;
		OnCommand=function(self)
			self:diffuse(ColorMidTone(ScreenColor(SCREENMAN:GetTopScreen():GetName())))
			self:diffusetopedge(ColorDarkTone(ScreenColor(SCREENMAN:GetTopScreen():GetName()))):diffusealpha(1)
		end;
	};
};

return t;
