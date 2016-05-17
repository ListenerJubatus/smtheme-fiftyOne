local sString;
local t = Def.ActorFrame{
--[[ 	LoadActor("TestStep") .. {
		InitCommand=cmd(zoomto,20,20);
	}; --]]
	LoadFont("Common Condensed")..{
		InitCommand=cmd(shadowlength,1;horizalign,center;zoom,0.75);
		SetMessageCommand=function(self,param)
			sString = THEME:GetString("StepsListDisplayRow StepsType",ToEnumShortString(param.StepsType));
			if param.Steps and param.Steps:IsAutogen() then
				self:diffusebottomedge(color("0.75,0.75,0.75,1"));
			else
				self:diffuse(Color("Black")):diffusealpha(0.75);
			end;
			self:settext( sString );
		end;
	};
	-- argh this isn't working as nicely as I would've hoped...
	--[[
	Def.Sprite{
		SetMessageCommand=function(self,param)
			self:Load( THEME:GetPathG("","_StepsType/"..ToEnumShortString(param.StepsType)) );
			self:diffusealpha(0.5);
		end;
	};
	--]]
};

return t;