-- color based on screen name
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
        ["ScreenEvaluationSummary"]   = ScreenColors.Summary, 
        ["Default"]                   = ScreenColors.Default,
    }

    if colors[screen] then return colors[screen];
    else return colors["Default"]; end;
end;

ScreenColors = {
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
}