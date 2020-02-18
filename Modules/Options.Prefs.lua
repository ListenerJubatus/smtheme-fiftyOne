return {
	AutoSetStyle =
	{
		Default = true,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	GameplayShowStepsDisplay =
	{
		Default = true,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	GameplayShowScore =
	{
		Default = true,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	ShowLotsaOptions =
	{
		Default = true,
		Choices = { OptionNameString('Many'), OptionNameString('Few') },
		Values = { true, false }
	},
	LongFail =
	{
		Default = false,
		Choices = { OptionNameString('Short'), OptionNameString('Long') },
		Values = { false, true }
	},
	NotePosition =
	{
		Default = true,
		Choices = { OptionNameString('Normal'), OptionNameString('Lower') },
		Values = { true, false }
	},
	ComboOnRolls =
	{
		Default = false,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	FlashyCombo =
	{
		Default = true,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	ComboUnderField =
	{
		Default = true,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	GameplayBPM =
	{
		Default = false,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	FancyUIBG =
	{
		Default = true,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	TimingDisplay =
	{
		Default = false,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	GameplayFooter =
	{
		Default = false,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	PreferredMeter =
	{
		Default = "old",
		Choices = { OptionNameString('MeterClassic'), OptionNameString('MeterX'), OptionNameString('MeterPump') },
		Values = { "old", "X", "pump" }
	},
	GameplayBPM =
	{
		Default = false,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	CustomComboContinue =
	{
		Default = "default",
		Choices = { OptionNameString('Default'), OptionNameString('TNS_W1'), OptionNameString('TNS_W2'), OptionNameString('TNS_W3'), OptionNameString('TNS_W4'), OptionNameString('TNS_PRO_W1'), OptionNameString('TNS_PRO_W2'), OptionNameString('TNS_PRO_W3'), OptionNameString('TNS_PRO_W4'), OptionNameString('TNS_PRO_W5')  },
		Values = { "default", "TapNoteScore_W1", "TapNoteScore_W2", "TapNoteScore_W3", "TapNoteScore_W4", "TapNoteScore_ProW1", "TapNoteScore_ProW2", "TapNoteScore_ProW3", "TapNoteScore_ProW4", "TapNoteScore_ProW5" }
	},
	CustomComboMaintain =
	{
		Default = "default",
		Choices = { OptionNameString('Default'), OptionNameString('TNS_W1'), OptionNameString('TNS_W2'), OptionNameString('TNS_W3'), OptionNameString('TNS_W4'), OptionNameString('TNS_PRO_W1'), OptionNameString('TNS_PRO_W2'), OptionNameString('TNS_PRO_W3'), OptionNameString('TNS_PRO_W4'), OptionNameString('TNS_PRO_W5')  },
		Values = { "default", "TapNoteScore_W1", "TapNoteScore_W2", "TapNoteScore_W3", "TapNoteScore_W4", "TapNoteScore_ProW1", "TapNoteScore_ProW2", "TapNoteScore_ProW3", "TapNoteScore_ProW4", "TapNoteScore_ProW5" }
	},
	ForcedExtraMods =
	{
		Default = true,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	AllowAudioInEvaluation =
	{
		Default = false,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	ComboIsPerRow =
	{
		Default = false,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	CurrentStageLocation =
	{
		Default = "None",
		Choices = LoadModule("Characters.LoadStageNames.lua")(),
		Values = LoadModule("Characters.LoadStageNames.lua")()
	},
	ScreenFilter =
	{
		UserPref = true,
		Default = 0,
		Choices = { THEME:GetString('OptionNames','Off'), '0.1', '0.2', '0.3', '0.4', '0.5', '0.6', '0.7', '0.8', '0.9', '1.0' },
		Values = { 0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1 },
	},
	ProTiming =
	{
		UserPref = true,
		Default = false,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	JudgmentEval =
	{
		UserPref = true,
		Default = false,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	StatsPane =
	{
		UserPref = true,
		Default = false,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	SmartJudgments =
	{
		UserPref = true,
		OneInRow = true,
		Default = THEME:GetMetric("Common","DefaultJudgment"),
		Choices = LoadModule("Options.SmartJudgeChoices.lua")(),
		Values = LoadModule("Options.SmartJudgeChoices.lua")("Value")
	},
	SmartTimings =
	{
		GenForOther = {"SmartJudgments",LoadModule("Options.SmartJudgeChoices.lua")},
		GenForUserPref = true,
		Default = TimingModes[1],
		Choices = TimingModes,
		Values = TimingModes
	},
	SmartToasties =
	{
		UserPref = true,
		Default = THEME:GetMetric("Common","DefaultToasty"),
		Choices = LoadModule("Options.SmartToastieChoices.lua")("Show"),
		Values = LoadModule("Options.SmartToastieChoices.lua")("Show")
	},
	MiniSelector =
	{
		UserPref = true,
		Default = 100,
		Choices = fornumrange(0,200,5),
		Values = fornumrange(0,200,5),
	},
	RotateFieldZ =
	{
		UserPref = true,
		Default = 0,
		Choices = fornumrange(0,360,10),
		Values = fornumrange(0,360,10),
	},
	RotateFieldX =
	{
		UserPref = true,
		Default = 0,
		Choices = fornumrange(0,360,10),
		Values = fornumrange(0,360,10),
	},
	NoteFieldLength =
	{
		Default = SCREEN_HEIGHT,
		Choices = {"Normal", "Long"},
		Values = {SCREEN_HEIGHT, 9000},
	},
}
