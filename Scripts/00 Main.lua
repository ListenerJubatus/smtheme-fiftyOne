function OptionNameString(str)
	return THEME:GetString('OptionNames',str)
end

function Actor:xyz(xpos,ypos,zpos)
	self:xy(xpos,ypos):z(zpos)
	return self
end

-- Activate preferences system
LoadModule("Row.Prefs.lua")(LoadModule("Options.Prefs.lua"))

-- Colors.lua

---- color based on screen name
function ScreenColor(screen)
    local colors = {
        ["ScreenSelectStyle"]         = ScreenColors.Style, 
        ["ScreenSelectPlayMode"]      = ScreenColors.PlayMode, 
        ["ScreenSelectMusic"]         = ScreenColors.Music, 
        ["ScreenSelectCourse"]        = ScreenColors.Course, 
        ["ScreenPlayerOptions"]       = ScreenColors.PlayerOptions,
        ["ScreenNestyPlayerOptions"]  = ScreenColors.PlayerOptions,
        ["ScreenOptionsService"]      = ScreenColors.OptionsService,
        ["ScreenEvaluationNormal"]    = ScreenColors.Evaluation, 
        ["ScreenHighScores"]    = ScreenColors.Evaluation, 
        ["ScreenEvaluationSummary"]   = ScreenColors.Summary, 
        ["ScreenStageInformation"]   = ScreenColors.StageInformation, 
        ["ScreenEditMenu"]			  = ScreenColors.Edit, 
        ["ScreenSMOnlineLogin"]			  = ScreenColors.Online, 
        ["ScreenNetRoom"]			  = ScreenColors.Online, 
        ["ScreenNetSelectMusic"]			  = ScreenColors.Online, 
		["ScreenNetEvaluation"]    = ScreenColors.Evaluation, 
        ["Default"]                   = ScreenColors.Default,
    }

    if colors[screen] then return colors[screen];
    else return colors["Default"]; end;
end;

ScreenColors = {
    Style           = color("#882D47"),
    PlayMode        = color("#882D47"),
    Music           = color("#882D47"),
    Online           = color("#882D47"),
    Course          = color("#882D47"),
    PlayerOptions   = color("#882D47"),
    OptionsService  = color("#882D47"),
    Evaluation      = color("#882D47"),
    Summary         = color("#882D47"),
    StageInformation  = color("#D05722"),
    Edit         = color("#B34754"),
    Default         = color("#882D47"),
}

ModeIconColors = {
    Normal      = color("#1AE0E4"),
    Rave        = color("#3ACF2A"), 
    Nonstop     = color("#CFC42A"),
    Oni         = color("#CF502A"),
    Endless     = color("#981F41"),
}

GameColor = {
    PlayerColors = {
        PLAYER_1 = color("#4B82DC"),
        PLAYER_2 = color("#DF4C47"),
		both = color("#FFFFFF"),
    },
    PlayerDarkColors = {
        PLAYER_1 = color("#16386E"),
        PLAYER_2 = color("#65110F"),
		both = color("#F5E1E1"),
    },
    Difficulty = {
        --[[ These are for 'Custom' Difficulty Ranks. It can be very  useful
        in some cases, especially to apply new colors for stuff you
        couldn't before. (huh? -aj) ]]
        Beginner    = color("#1AE0E4"),         -- Mint
        Easy        = color("#3ACF2A"),         -- Green
        Medium      = color("#CFC42A"),         -- Yellow
        Hard        = color("#CF502A"),         -- Orange
        Challenge   = color("#981F41"),         -- Plum
        Edit        = color("0.8,0.8,0.8,1"),   -- Gray
        Couple      = color("#ed0972"),         -- hot pink
        Routine     = color("#ff9a00"),         -- orange
        --[[ These are for courses, so let's slap them here in case someone
        wanted to use Difficulty in Course and Step regions. ]]
        Difficulty_Beginner = color("#1AE0E4"),     -- Mint
        Difficulty_Easy     = color("#2FA74D"),     -- Green
        Difficulty_Medium   = color("#CFC42A"),     -- Yellow
        Difficulty_Hard     = color("#CF502A"),     -- Orange
        Difficulty_Challenge    = color("#981F41"), -- Plum
        Difficulty_Edit     = color("0.8,0.8,0.8,1"),       -- gray
        Difficulty_Couple   = color("#ed0972"),             -- hot pink
        Difficulty_Routine  = color("#ff9a00")              -- orange
    },
    Stage = {
        Stage_1st   = color("#9d324e"),
        Stage_2nd   = color("#9d3262"),
        Stage_3rd   = color("#9d3280"),
        Stage_4th   = color("#9d329d"),
        Stage_5th   = color("#7b329d"),
        Stage_6th   = color("#52329d"),
        Stage_Next  = color("#52329d"),
        Stage_Final = color("#325c9d"),
        Stage_Extra1    = color("#B60052"),
        Stage_Extra2    = color("#FF499B"),
        Stage_Nonstop   = color("#9d324e"),
        Stage_Oni   = color("#9d3232"),
        Stage_Endless   = color("#9d3232"),
        Stage_Event = color("#9d324e"),
        Stage_Demo  = color("#9d324e")
    },
    Judgment = {
	    JudgmentLine_ProW1     = color("#FFFFFF"),
        JudgmentLine_ProW2     = color("#AEEDF3"),
        JudgmentLine_ProW3     = color("#71DDE8"),
        JudgmentLine_ProW4     = color("#A0DBF1"),
        JudgmentLine_ProW5     = color("#7EC2D7"),
        JudgmentLine_W1     = color("#A0DBF1"),
        JudgmentLine_W2     = color("#F1E4A2"),
        JudgmentLine_W3     = color("#ABE39B"),
        JudgmentLine_W4     = color("#86ACD6"),
        JudgmentLine_W5     = color("#958CD6"),
        JudgmentLine_Held   = color("#FFFFFF"),
        JudgmentLine_Miss   = color("#F97E7E"),
        JudgmentLine_MaxCombo   = color("#E8D8A5")
    },
}

GameColor.Difficulty["Crazy"]       = GameColor.Difficulty["Hard"]
GameColor.Difficulty["Freestyle"]   = GameColor.Difficulty["Easy"]
GameColor.Difficulty["Nightmare"]   = GameColor.Difficulty["Challenge"]
GameColor.Difficulty["HalfDouble"]  = GameColor.Difficulty["Medium"]

local numbered_stages= {
	Stage_1st= true,
	Stage_2nd= true,
	Stage_3rd= true,
	Stage_4th= true,
	Stage_5th= true,
	Stage_6th= true,
	Stage_Next= true,
}

function thified_curstage_index(on_eval)
	local cur_stage= GAMESTATE:GetCurrentStage()
	local adjust= 1
	-- hack: ScreenEvaluation shows the current stage, but it needs to show
	-- the last stage instead.  Adjust the amount.
	if on_eval then
		adjust= 0
	end
	if numbered_stages[cur_stage] then
		return FormatNumberAndSuffix(GAMESTATE:GetCurrentStageIndex() + adjust)
	else
		return ToEnumShortString(cur_stage)
	end
end

function check_stop_course_early()
	return course_stopped_by_pause_menu
end

-- TODO make the module work
function ScreenSelectStylePositions(count)
	local poses= {}
	local choice_size = 192
	
	for i= 1, count do
		local start_x = _screen.cx + ( (choice_size / 1.5) * ( i - math.ceil(count/2) ) )
		-- The Y position depends on if the icon's index is even or odd.
		local start_y = i % 2 == 0 and _screen.cy / 0.8 or (_screen.cy / 0.8) - (choice_size / 1.5)
		poses[#poses+1] = {start_x, start_y}
	end
	
	return poses
end

function ScreenPlayerOptions_Choices()
	local Main = "1,8,14,Mini,RotateFieldX,RotateFieldZ,2,3A,3B,4,5,6,R1,R2,7,9,10,11,13,SF,Combo,Timing,Judg,Toasty,SP,17,12,16,18"

	if LoadModule("Characters.AnyoneHasChar.lua")() then
		Main = Main .. ",St"
	end

	return Main
end

-- This will take care of the artist label on the Text Banner.
function ArtistSetConversion(self)
	local Title=self:GetChild("Title");
	local Subtitle=self:GetChild("Subtitle");
	local Artist=self:GetChild("Artist");
	if Subtitle:GetText() == "" then
		Title:zoom(0.7):maxwidth(SCREEN_WIDTH*0.38):xy(-150,-13):strokecolor( color("#42292E") )
		Subtitle:visible(false)
		Artist:zoom(0.5):maxwidth(SCREEN_WIDTH*0.54):xy(-150,13):strokecolor( color("#42292E") )
	else
		Title:zoom(0.75):maxwidth(SCREEN_WIDTH*0.38):xy(-150,-17):strokecolor( color("#42292E") )
		Subtitle:visible(true):zoom(0.4):xy(-150,4):maxwidth(SCREEN_WIDTH*0.54):strokecolor( color("#42292E") )
		Artist:zoom(0.5):maxwidth(SCREEN_WIDTH*0.54):xy(-150,21):strokecolor( color("#42292E") )
	end
end

-- It's the same as the function above, but for courses.
function CourseSetConversion(self)
	local Title=self:GetChild("Title");
	local Subtitle=self:GetChild("Subtitle");
	local Artist=self:GetChild("Artist");
	if Subtitle:GetText() == "" then
		Title:zoom(0.7):xy(-220,-9):maxwidth(500)
		Subtitle:visible(false)
		Artist:zoom(0.5):maxwidth(800):xy(-220,15)
	else
		Title:zoom(0.70):xy(-220,-14):maxwidth(500)
		Subtitle:visible(true):zoom(0.45):xy(-220,4):maxwidth(800)
		Artist:zoom(0.5):maxwidth(800):xy(-220,18)
	end
end