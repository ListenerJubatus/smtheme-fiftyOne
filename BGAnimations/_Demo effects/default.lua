-- These basic "gimmick" things were thrown together on a whim, because I vaguely knew how to.
-- Since I generally use ScreenJukebox for testing as opposed to ScreenGameplay, I ended up with
-- a demo mode that could be tampered with by pressing the gameplay (not menu!) buttons.
-- I ultimately decided to leave it in Lambda for two fairly simple reasons.
-- 1: Fun factor
-- 2: Educational[citation needed] factor.

-- This will basically use a (manual) listing of the effects available and return the file for one of them.
local foofy_things = {
	"fieldrotate",
	"fieldturn",
	"columnvibrate"
}

return LoadActor(foofy_things[math.random(#foofy_things)])