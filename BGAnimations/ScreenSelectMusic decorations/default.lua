local t = LoadFallbackB();

-- Banner underlay
t[#t+1] = Def.ActorFrame {
    InitCommand=cmd(x,SCREEN_CENTER_X-230;draworder,125);
    OffCommand=cmd(smooth,0.2;diffusealpha,0;);
    Def.Quad {
        InitCommand=cmd(zoomto,468,196;diffuse,color("#fce1a1");diffusealpha,0.4;y,SCREEN_CENTER_Y-94+25;);
      };
};

-- Sort and stage display tiles
t[#t+1] = Def.ActorFrame {
    InitCommand=cmd(x,SCREEN_CENTER_X-226;);
    OffCommand=cmd(smooth,0.2;diffusealpha,0;);
    Def.Quad {
        InitCommand=cmd(zoomto,150,60;diffuse,color("#fce1a1");diffusealpha,0.4;y,SCREEN_CENTER_Y-205;);
      };
    LoadFont("Common Condensed") .. {
          InitCommand=cmd(zoom,0.8;y,SCREEN_CENTER_Y-198;maxwidth,SCREEN_WIDTH;diffuse,color("#9d324e");visible,not GAMESTATE:IsCourseMode(););
          SortOrderChangedMessageCommand=cmd(playcommand,"Set");
          ChangedLanguageDisplayMessageCommand=cmd(playcommand,"Set");
          SetCommand=function(self)
               local sortorder = GAMESTATE:GetSortOrder();
               if sortorder then
					self:finishtweening();
					self:smooth(0.4);
					self:diffusealpha(0);
					self:addx(6);
                    self:settext(SortOrderToLocalizedString(sortorder));
                    self:playcommand("Refresh");
					(cmd(stoptweening;diffusealpha,0.0;zoomy,0;smooth,0.35;zoomy,0.8;diffusealpha,1))(self)
				else
					self:settext("");
					self:playcommand("Refresh");
               end
          end;
    };
};

t[#t+1] = Def.ActorFrame {
    OffCommand=cmd(sleep,0.1;smooth,0.2;diffusealpha,0;);
    InitCommand=cmd(x,SCREEN_CENTER_X-71;);
    Def.Quad {
        InitCommand=cmd(zoomto,150,60;diffuse,color("#fce1a1");diffusealpha,0.4;y,SCREEN_CENTER_Y-205;);
      };
};

t[#t+1] = StandardDecorationFromFileOptional("DifficultyList","DifficultyList");

return t;
