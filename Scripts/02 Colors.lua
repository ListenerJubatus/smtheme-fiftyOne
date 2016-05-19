-- color based on screen name
function ScreenColor(screen)
    local colors = {
        ["ScreenSelectStyle"]         = ScreenColor.Style, 
        ["ScreenSelectPlayMode"]      = ScreenColor.PlayMode, 
        ["ScreenSelectMusic"]         = ScreenColor.Music, 
        ["ScreenSelectCourse"]        = ScreenColor.Course, 
        ["ScreenPlayerOptions"]       = ScreenColor.PlayerOptions,
        ["ScreenNestyPlayerOptions"]  = ScreenColor.PlayerOptions,
        ["ScreenOptionsService"]      = ScreenColor.OptionsService,
        ["ScreenEvaluationNormal"]    = ScreenColor.Evaluation, 
        ["ScreenEvaluationSummary"]   = ScreenColor.Summary, 
        ["Default"]                   = ScreenColor.Default,
    }

    if colors[screen] then return colors[screen];
    else return colors["Default"]; end;
end;

ScreenColor = {
    Style           = color("#81468B"),
    PlayMode        = color("#478e6f"),
    Music           = color("#1268aa"),
    Course          = color("#1268aa"),
    PlayerOptions   = color("#544abe"),
    OptionsService  = color("#1C1C1B"),
    Evaluation      = color("#806635"),
    Summary         = color("#B38D47"),
    Default         = color("#1C1C1B"),
}

<<<<<<< HEAD
ModeIconColors = {
    Normal      = color("#FFEE00"), -- yellow
    Rave        = color("#db93ff"), -- violet
    Nonstop     = color("#5ca9ff"), -- blue
    Oni         = color("#00f1e2"), -- cyan
    Endless     = color("#b4c3d2"), -- steel
}

GameColor = {
    PlayerColors = {
        PLAYER_1 = color("#437CE7"),
        PLAYER_2 = color("#EB3F8C"),
    },
    PlayerDarkColors = {
        PLAYER_1 = color("#EB3F8C"),
        PLAYER_2 = color("#89385A"),
    },
    Difficulty = {
        --[[ These are for 'Custom' Difficulty Ranks. It can be very  useful
        in some cases, especially to apply new colors for stuff you
        couldn't before. (huh? -aj) ]]
        Beginner    = color("#8541B9"),         --  purple
        Easy        = color("#5EBA42"),         -- green
        Medium      = color("#D1C340"),         -- yellow
        Hard        = color("#CB4833"),         -- orange
        Challenge   = color("#1cd8ff"),         -- light blue
        Edit        = color("0.8,0.8,0.8,1"),   -- gray
        Couple      = color("#ed0972"),         -- hot pink
        Routine     = color("#ff9a00"),         -- orange
        --[[ These are for courses, so let's slap them here in case someone
        wanted to use Difficulty in Course and Step regions. ]]
        Difficulty_Beginner = color("#8541B9"),     -- purple
        Difficulty_Easy     = color("#5EBA42"),     -- green
        Difficulty_Medium   = color("#D1C340"),     -- yellow
        Difficulty_Hard     = color("#CB4833"),     -- orange
        Difficulty_Challenge    = color("#1cd8ff"), -- light blue
        Difficulty_Edit     = color("0.8,0.8,0.8,1"),       -- gray
        Difficulty_Couple   = color("#ed0972"),             -- hot pink
        Difficulty_Routine  = color("#ff9a00")              -- orange
    },
    Stage = {
        Stage_1st   = color("#00ffc7"),
        Stage_2nd   = color("#58ff00"),
        Stage_3rd   = color("#f400ff"),
        Stage_4th   = color("#00ffda"),
        Stage_5th   = color("#ed00ff"),
        Stage_6th   = color("#73ff00"),
        Stage_Next  = color("#73ff00"),
        Stage_Final = color("#ff0707"),
        Stage_Extra1    = color("#fafa00"),
        Stage_Extra2    = color("#ff0707"),
        Stage_Nonstop   = color("#9d324e"),
        Stage_Oni   = color("#9d324e"),
        Stage_Endless   = color("#9d324e"),
        Stage_Event = color("#9d324e"),
        Stage_Demo  = color("#9d324e")
    },
    Judgment = {
        JudgmentLine_W1     = color("#A0DBF1"),
        JudgmentLine_W2     = color("#F1E4A2"),
        JudgmentLine_W3     = color("#ABE39B"),
        JudgmentLine_W4     = color("#86ACD6"),
        JudgmentLine_W5     = color("#958CD6"),
        JudgmentLine_Held   = color("#FFFFFF"),
        JudgmentLine_Miss   = color("#ff3c3c"),
        JudgmentLine_MaxCombo   = color("#ffc600")
    },
=======
GameColor = {
	PlayerColors = {
		PLAYER_1 = color("#437CE7"),
		PLAYER_2 = color("#EB3F8C"),
	},
	PlayerDarkColors = {
		PLAYER_1 = color("#EB3F8C"),
		PLAYER_2 = color("#89385A"),
	},
	Difficulty = {
		--[[ These are for 'Custom' Difficulty Ranks. It can be very  useful
		in some cases, especially to apply new colors for stuff you
		couldn't before. (huh? -aj) ]]
		Beginner	= color("#8541B9"),			--  purple
		Easy		= color("#5EBA42"),			-- green
		Medium		= color("#D1C340"),			-- yellow
		Hard		= color("#CB4833"),			-- orange
		Challenge	= color("#1cd8ff"),			-- light blue
		Edit		= color("0.8,0.8,0.8,1"),	-- gray
		Couple		= color("#ed0972"),			-- hot pink
		Routine		= color("#ff9a00"),			-- orange
		--[[ These are for courses, so let's slap them here in case someone
		wanted to use Difficulty in Course and Step regions. ]]
		Difficulty_Beginner	= color("#8541B9"),		-- purple
		Difficulty_Easy		= color("#5EBA42"),		-- green
		Difficulty_Medium	= color("#D1C340"),		-- yellow
		Difficulty_Hard		= color("#CB4833"),		-- orange
		Difficulty_Challenge	= color("#1cd8ff"),	-- light blue
		Difficulty_Edit 	= color("0.8,0.8,0.8,1"),		-- gray
		Difficulty_Couple	= color("#ed0972"),				-- hot pink
		Difficulty_Routine	= color("#ff9a00")				-- orange
	},
	Stage = {
		Stage_1st	= color("#00ffc7"),
		Stage_2nd	= color("#58ff00"),
		Stage_3rd	= color("#f400ff"),
		Stage_4th	= color("#00ffda"),
		Stage_5th	= color("#ed00ff"),
		Stage_6th	= color("#73ff00"),
		Stage_Next	= color("#73ff00"),
		Stage_Final	= color("#ff0707"),
		Stage_Extra1	= color("#fafa00"),
		Stage_Extra2	= color("#ff0707"),
		Stage_Nonstop	= color("#9d324e"),
		Stage_Oni	= color("#9d324e"),
		Stage_Endless	= color("#9d324e"),
		Stage_Event	= color("#9d324e"),
		Stage_Demo	= color("#9d324e")
	},
	Judgment = {
		JudgmentLine_W1		= color("#A0DBF1"),
		JudgmentLine_W2		= color("#F1E4A2"),
		JudgmentLine_W3		= color("#ABE39B"),
		JudgmentLine_W4		= color("#86ACD6"),
		JudgmentLine_W5		= color("#958CD6"),
		JudgmentLine_Held	= color("#FFFFFF"),
		JudgmentLine_Miss	= color("#ff3c3c"),
		JudgmentLine_MaxCombo	= color("#ffc600")
	},
>>>>>>> parent of b856be8... start on course
}