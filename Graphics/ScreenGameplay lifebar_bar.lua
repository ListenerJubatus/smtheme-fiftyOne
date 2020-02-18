local pn = ...

local life_meter_width = 400
local life_meter_num_segments = 80
local life_meter_height = 20
local life_meter_tip_width = 2
local life_meter_tip_gap = 64
local life_meter_outline = 0

local color_normal	= Color.Green
local color_hot		= Color.Blue
local color_danger	= Color.Red
local color_dead	= Color.Outline

local pn_offset = (pn == PLAYER_1) and 0.5 or -0.5
local name_offset_x = -life_meter_width/2

local function getPlayersName(pn)
	local s = PROFILEMAN:GetPlayerName(pn)
	if s == "" then
		return PlayerNumberToString(pn)
	end
	return s
end

local function MakeSeperators()
	local function x_pos(i)
		return (-life_meter_width/2) + (i/life_meter_num_segments)* life_meter_width
	end
	local a = Def.Quad {
		InitCommand=function(self) self:zoomto(2,life_meter_height) end;
		OnCommand=function(self) self:diffuse(Color.Black):diffusealpha(0.15) end;
	}
	local t = Def.ActorFrame {}
	for i=1, life_meter_num_segments do
		t[#t+1] = Def.ActorFrame { InitCommand=function(self) self:x(x_pos(i)) end; a }
	end
	return t
end

local t = Def.ActorFrame {}

local function updateFunc(self)
	local c = self:GetChildren();
	local beat = self:GetSecsIntoEffect() % 1
	local _beat = self.life == 1.00 and 0 or beat
	local _fillWidth = (life_meter_width * self.life - _beat * life_meter_tip_gap) / life_meter_width
	local _clampedWidth = math.round(_fillWidth * life_meter_num_segments)
	local _tipPosition = self.life
	local _tipClamped = math.round( _tipPosition * life_meter_num_segments ) / life_meter_num_segments
	c.Fill:zoomtowidth( math.max(0,(_clampedWidth/life_meter_num_segments) * life_meter_width) )
	--c.Fill:zoomtowidth( (life_meter_width * self.life) - beat * life_meter_tip_gap)
	c.Tip:x( (_tipClamped*life_meter_width) - life_meter_width/2)
end

t[#t+1] = Def.ActorFrame {
	InitCommand=function(self)
		self:SetUpdateFunction(updateFunc)
		self.life = 0
	end,
	OnCommand=function(self) self:spin():effectclock('beat'):effectperiod(1):effectmagnitude(0,0,0) end,
	HealthStateChangedMessageCommand=function(self,param)
		local c = self:GetChildren()

		if param.PlayerNumber == pn then
			if param.HealthState ~= param.OldHealthState then
				local state_name = ToEnumShortString(param.HealthState)
				self:playcommand(state_name)
			end
		end
	end,
	LifeChangedMessageCommand=function(self,param)
		local c = self:GetChildren()
		if param.Player == pn then
			self.life = param.LifeMeter:GetLife()
			c.Fill:zoomtowidth( (life_meter_width) * self.life )
		end
	end,
	-- Outline
	Def.Quad {
		Name="Outline",
		InitCommand=function(self) self:zoomto(life_meter_width+life_meter_outline,life_meter_height+life_meter_outline) end;
	},
	-- Background
	Def.Quad {
		Name="Background",
		InitCommand=function(self) self:zoomto(life_meter_width,life_meter_height) end;
		OnCommand=function(self) self:diffuse(color("#32373E")) end;
		AliveCommand=function(self) self:stopeffect():diffuse(color("#32373E")) end;
		DangerCommand=function(self) self:diffuseshift():effectcolor2(ColorMidTone(Color.Red)):effectcolor1(ColorDarkTone(Color.Red)) end;
		DeadCommand=function(self) self:stopeffect():diffuse(Color.Black) end;
	},
	Def.Quad {
		Name="Fill",
		InitCommand=function(self) 
			self:x(-life_meter_width/2):zoomto(life_meter_width,life_meter_height):horizalign(left) 
		end;
		OnCommand=function(self) self:diffuse(PlayerColor(pn)) end;
		--
		HotCommand=function(self) self:diffuse(color("#ff9232")):diffuseshift(effectclock,'beat'):effectcolor1(color("#ff9232")):effectcolor2(color("#ffe263")) end;
		AliveCommand=function(self) self:diffuse(PlayerColor(pn)):stopeffect() end;
		DangerCommand=function(self) self:diffuse(Color.Red):diffuseshift(effectclock,'beat'):effectcolor1(Color.Red):effectcolor2(color("#FF797C")) end;
		DeadCommand=function(self) self:diffuse(Color.Red):stopeffect() end;
	},
	MakeSeperators(),
	Def.Quad {
		Name="Tip",
		InitCommand=function(self) self:basezoomx(life_meter_tip_width):basezoomy(life_meter_height) end;
		--
		OnCommand=function(self) self:diffuse(ColorLightTone(PlayerColor(pn))) end;
		--
		HotCommand=function(self) self:diffuse(color("#FFED31")):glowshift(effectclock,'beat') end;
		AliveCommand=function(self) self:diffuse(ColorLightTone(PlayerColor(pn))):stopeffect() end;
		DangerCommand=function(self) self:diffuse(Color.Red):diffuseshift(effectclock,'beat'):effectcolor1(Color.Black):effectcolor2(Color.Red) end;
		DeadCommand=function(self) self:diffuse(Color.Red):stopeffect() end;
	}
}

return t
