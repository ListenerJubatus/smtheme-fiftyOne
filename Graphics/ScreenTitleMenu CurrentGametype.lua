local icon_params = {
	base_color = color("#FFFFFF"),
	label_text = Screen.String("CurrentGametype"),
	value_text = GAMESTATE:GetCurrentGame():GetName()
}

return LoadActor(THEME:GetPathG("", "_title_info_icon"), icon_params)