if not GAMESTATE:IsCourseMode() then return Def.ActorFrame{} end; -- short circuit
local slideTime = 1.1;
local slideWait = 1.25;
local bottomSlide = 0.76;
local course = GAMESTATE:GetCurrentCourse()

local t = Def.ActorFrame{
	-- background
	Def.Sprite{
		InitCommand=function(self) self:Center() end;
		BeginCommand=function(self)
			if course:GetBackgroundPath() then
				self:Load( course:GetBackgroundPath() )
			else
				-- default to the BG of the first song in the course
				self:LoadFromCurrentSongBackground()
			end
		end;
		OnCommand=function(self)
			self:scale_or_crop_background()
			self:addy(SCREEN_HEIGHT):sleep(slideWait):smooth(slideTime):addy(-SCREEN_HEIGHT);
		end;	
	};
	-- alternate background
	Def.Sprite{
		InitCommand=function(self) self:Center() end;
		BeginCommand=function(self) self:LoadFromSongBackground():scale_or_crop_background():diffusealpha(0) end;
		OnCommand=function(self) playcommand("Show") end;
		ShowCommand=function(self)
			if course:HasBackground() then
				self:addy(SCREEN_HEIGHT):sleep(slideWait):smooth(slideTime):addy(-SCREEN_HEIGHT);
			end
		end;
	};
};

return t;