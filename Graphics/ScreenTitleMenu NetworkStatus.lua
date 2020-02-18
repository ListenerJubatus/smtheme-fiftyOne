local netConnected = IsNetConnected();
local loggedOnSMO = IsNetSMOnline();

local t = Def.ActorFrame{
	LoadFont("Common Condensed") .. {
		InitCommand=function(self) self:uppercase(true):horizalign(left):zoom(0.75):shadowlength(1) end;
		BeginCommand=function(self)
			-- check network status
			if netConnected then
				self:diffuse( color("#268129") );
				self:diffusebottomedge( color("#153F17") );
				self:settext( Screen.String("Network OK") );
			else
				self:diffuse( color("#e3961f") );
				self:settext( Screen.String("Offline") );
			end;
		end;
	};
};

if netConnected then
	t[#t+1] = LoadFont("Common Condensed") .. {
		InitCommand=function(self) self:y(16):horizalign(left):zoom(0.5875):shadowlength(1):diffuse(color("#e3961f")) end;
		BeginCommand=function(self)
			self:settext( string.format(Screen.String("Connected to %s"), GetServerName()) );
		end;
	};
end;

return t;