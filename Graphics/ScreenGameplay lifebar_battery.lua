local pn = ...
local life_meter_width = 400
local life_meter_height = 20
local life_meter_outline = 0

local function CreateSeperators()
	local t = Def.ActorFrame {}

	for i = 1, 50 do
		t[#t+1] = Def.ActorFrame {
			SetCommand=function(self)
				local life_meter = SCREENMAN:GetTopScreen():GetLifeMeter(pn)
				local num_items = life_meter:GetTotalLives()

				local function position(index)
					return scale(index/num_items,0,1,-life_meter_width/2,life_meter_width/2)
				end

				self:x(position(i))
				self:visible(i < num_items)
			end,
			OnCommand=function(self) self:playcommand("Set") end;
			--
			Def.Quad {
				InitCommand=function(self) self:zoomto(2,life_meter_height) end;
				OnCommand=function(self) self:diffuse(Color.Black) end;
			}
		}
	end

	return t
end

local t = Def.ActorFrame {}

t[#t+1] = Def.ActorFrame {
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
			local life = param.LifeMeter:GetLife()
			c.Fill:zoomtowidth( life_meter_width * life )
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
		HotCommand=function(self) self:glowshift():effectclock('beat') end;
		AliveCommand=function(self) self:diffuse(PlayerColor(pn)):stopeffect() end;
		DangerCommand=function(self) self:diffuse(Color.Red):diffuseshift(effectclock,'beat'):effectcolor1(Color.Red):effectcolor2(color("#FF797C")) end;
		DeadCommand=function(self) self:diffuse(Color.Red):stopeffect() end;
	},
	LoadFont("_open sans semibold 24px") .. {
		Text="",
		OnCommand=function(self) self:diffuse(Color.Black) end;
	},
	CreateSeperators()
}

return t