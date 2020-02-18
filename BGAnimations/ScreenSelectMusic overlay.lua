local t = Def.ActorFrame {};

-- Sort order
t[#t+1] = Def.ActorFrame {
    InitCommand=function(self)
		self:xy(SCREEN_RIGHT-290,SCREEN_TOP+49)
	end;
    OffCommand=function(self) self:sleep(0.175):decelerate(0.4):addy(-105) end;
	LoadActor(THEME:GetPathG("", "_sortFrame"))  .. {
		InitCommand=function(self) self:diffusealpha(0.9):zoom(1.5) end;	   
		OnCommand=function(self)
			self:diffuse(ColorMidTone(ScreenColor(SCREENMAN:GetTopScreen():GetName())));
		end
	};

    LoadFont("Common Condensed") .. {
            InitCommand=function(self) self:zoom(1):diffuse(Color.White):diffusealpha(0.85):horizalign(left):addx(-115) end;
            OnCommand=function(self) self:queuecommand("Set") end;
            ChangedLanguageDisplayMessageCommand=function(self) self:queuecommand("Set") end;
            SetCommand=function(self)
                self:settext("SORT:");
                self:queuecommand("Refresh");
            end;
    };

    LoadFont("Common Condensed") .. {
          InitCommand=function(self) self:zoom(1):maxwidth(157):addx(115):diffuse(Color.White):uppercase(true):horizalign(right) end;
          OnCommand=function(self) self:queuecommand("Set") end;
          SortOrderChangedMessageCommand=function(self) self:queuecommand("Set") end;
          ChangedLanguageDisplayMessageCommand=function(self) self:queuecommand("Set") end;
          SetCommand=function(self)
               local sortorder = GAMESTATE:GetSortOrder();
               if sortorder then
					self:finishtweening();
					self:smooth(0.4);
					self:diffusealpha(0);
                    self:settext(SortOrderToLocalizedString(sortorder));
                    self:queuecommand("Refresh"):stoptweening():diffusealpha(0):smooth(0.3):diffusealpha(1)
				else
					self:settext("");
					self:queuecommand("Refresh");
               end
          end;
    };
};

return t