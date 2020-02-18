local t = Def.ActorFrame{
	LoadFont("_open sans condensed 24px")..{
		InitCommand=function(self) self:horizalign(right):zoom(0.8):skewx(-0.1) end;
		SetMessageCommand=function(self,param)
			local sString = THEME:GetString("StepsListDisplayRow StepsType",ToEnumShortString(param.StepsType));
			if param.Steps and param.Steps:IsAutogen() then
				self:diffusebottomedge(color("0.75,0.75,0.75,1"));
			else
				self:diffuse(Color("White"));
			end;
			self:settext( sString );
		end;
	};
};

return t;