if IsNetSMOnline() then
	-- don't show "Ready" online; it will obscure the immediately-starting steps.
	return Def.ActorFrame{}
end

return LoadActor("go") .. {
	InitCommand=function(self) self:Center():draworder(105) end;
	StartTransitioningCommand=function(self)
		self:zoom(1.3):diffusealpha(0):bounceend(0.25):zoom(1):diffusealpha(1)
		self:linear(0.15):glow(1,1,1,0.5):decelerate(0.3):glow(1,1,1,0)
		self:sleep(1-0.45):linear(0.25):diffusealpha(0)
	end;
};