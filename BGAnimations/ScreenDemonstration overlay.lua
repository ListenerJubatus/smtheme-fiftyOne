return Def.ActorFrame{
	-- "header"
	Def.Quad {
		InitCommand=function(self) self:vertalign(top):x(_screen.cx):zoomto(_screen.w,80) end;
		OnCommand=function(self)
			self:diffuse(color("#000000")):diffusetopedge(ColorDarkTone(ScreenColor("Default"))):diffusealpha(0.9)
		end;
	},
	-- The "header's" "shadow"
	Def.Quad {
		InitCommand=function(self) self:vertalign(top):xy(_screen.cx,80):zoomto(_screen.w,80) end;
		OnCommand=function(self) self:diffuse(color("#000000")):fadebottom(1):diffusealpha(0.6) end;
	},
	-- "footer"
	Def.Quad {
		InitCommand=function(self) self:vertalign(bottom):xy(_screen.cx,_screen.h):zoomto(_screen.w,96) end;
		OnCommand=function(self)
			self:diffuse(color("#000000")):diffusebottomedge(ColorDarkTone(ScreenColor("Default"))):diffusealpha(0.9)
		end;
	},
	-- The "footer's" "shadow"
	Def.Quad {
		InitCommand=function(self) self:vertalign(bottom):xy(_screen.cx,_screen.h-96):zoomto(_screen.w,8) end;
		OnCommand=function(self) self:diffuse(color("#000000")):fadetop(1):diffusealpha(0.6) end;
	},
	
	-- A temporary frame for the jacket.
	Def.Quad {
		InitCommand=function(self) 
			self:horizalign(right):vertalign(bottom):xy(_screen.w-39,_screen.h-14):zoomto(192,192):diffuse(ColorDarkTone(ScreenColor("Default"))):diffusealpha(0.9) 
		end;
	},
	-- Jacket (real or not) of the currently playing song.
	-- todo: make getting the jacket a bit more of a... global function?
	Def.Sprite {
		InitCommand=function(self) self:horizalign(right):vertalign(bottom):xy(_screen.w-49,_screen.h-24) end;
		OnCommand=function(self)
			local song = GAMESTATE:GetCurrentSong()
			if song and song:HasJacket() then
				-- ...The jacket on ScreenEditMenu overlay uses LoadBanner instead of just Load.
				-- Will it make any difference? ... I mean, probably not, but we'll see.
				self:LoadBanner(song:GetJacketPath())
			elseif song and song:HasBackground() then
				self:LoadBanner(song:GetBackgroundPath())
			else
				self:LoadBanner(THEME:GetPathG("Common","fallback background"))
			end
			self:scaletoclipped(172,172)
		end
	},
	-- Song title.
	Def.BitmapText {
		Font = "Common Fallback Font",
		InitCommand=function(self) self:horizalign(right):xy(_screen.w-250,_screen.h-64):strokecolor(color("#42292E")) end;
		OnCommand=function(self)
			local song = GAMESTATE:GetCurrentSong()
			if song then
				self:settext(song:GetDisplayFullTitle())
			else
				self:settext("")
			end
		end
	},
	-- Song artist.
	Def.BitmapText {
		Font = "Common Fallback Font",
		InitCommand=function(self) self:horizalign(right):xy(_screen.w-250,_screen.h-40):zoom(0.7):strokecolor(color("#42292E")) end;
		OnCommand=function(self)
			local song = GAMESTATE:GetCurrentSong()
			if song then
				self:settext(song:GetDisplayArtist())
			else
				self:settext("")
			end
		end
	},
}