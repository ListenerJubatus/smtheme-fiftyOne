local t = Def.ActorFrame {};

-- -- To do: This needs to be based on screen names and not variable language strings.
-- local headercolour = {
-- ["Select Style"] = "#be4a8c",
-- ["Select Mode"] = "#478e6f",
-- ["Select Music"] = "#3298aa",
-- ["Select Course"] = "#be784a",
-- ["Select Options"] = "#544abe",
-- ["Options"] = "#333333",
-- ["Your Results"] = "#e8a120",
-- ["Summary Result"] = "#e8a120",
-- }

-- local headcolour = headercolour[Screen.String("HeaderText")]
-- if headcolour == nil then headcolour = "#666666" end


-- Base bar
t[#t+1] = Def.Quad {
	InitCommand=cmd(vertalign,top;zoomto,SCREEN_WIDTH,96;diffuse,color("#1C1C1B");diffusebottomedge,color("#333230");diffusealpha,0.9;);
	OnCommand=function(self)
	self:addy(-96):decelerate(0.5):addy(96)
		end;
	OffCommand=cmd(sleep,0.3;decelerate,0.4;addy,-96;);
};

-- Diamond (todo: Migrate mode colors to global vars)
t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(x,-SCREEN_CENTER_X+76;y,SCREEN_TOP+30;);
	OnCommand=cmd(addx,-110;sleep,0.3;decelerate,0.7;addx,110;);
	OffCommand=cmd(decelerate,0.3;addx,-110;);
		-- Diamond BG
		Def.Quad {
			InitCommand=cmd(vertalign,top;zoomto,54,54;rotationz,45;diffuse,color("#3298aa"););
		};
		-- Symbol selector
		Def.Sprite {
			Name="HeaderDiamondIcon";
			InitCommand=cmd(horizalign,center;y,18;x,-20;);
			OnCommand=function(self)
				if FILEMAN:DoesFileExist("Themes/"..THEME:GetCurThemeName().."/Graphics/"..SCREENMAN:GetTopScreen():GetName().." icon.png") then
					print("iconerror: file does exist: "..SCREENMAN:GetTopScreen():GetName()..".png")
					self:Load(THEME:GetPathG(SCREENMAN:GetTopScreen():GetName(), "icon"))
				else
					print("iconerror: file does not exist")
					self:Load(THEME:GetPathG("Generic", "icon"))
				end;
			end;
		};
	};

-- Text
t[#t+1] = LoadFont("Common Header") .. {
	Name="HeaderShadow";
	Text=Screen.String("HeaderText");
	InitCommand=cmd(zoom,0.8;x,-SCREEN_CENTER_X+110;y,40;horizalign,left;diffuse,color("#fcb62c"););
	OnCommand=cmd(diffusealpha,0;sleep,0.5;smooth,0.3;diffusealpha,1;);
	UpdateScreenHeaderMessageCommand=function(self,param)
		self:settext(param.Header);
	end;
	OffCommand=cmd(smooth,0.3;diffusealpha,0;);
};

t[#t+1] = LoadFont("Common Condensed") .. {
	Name="HeaderShadow";
	Text=Screen.String("HeaderSubText");
	InitCommand=cmd(zoom,0.8;x,-SCREEN_CENTER_X+110;y,70;horizalign,left;diffuse,color("#f9b06d"));
	OnCommand=cmd(diffusealpha,0;sleep,0.55;smooth,0.3;diffusealpha,1;);
	UpdateScreenHeaderMessageCommand=function(self,param)
		self:settext(param.Header);
	end;
	OffCommand=cmd(smooth,0.3;diffusealpha,0;);
};

return t;
