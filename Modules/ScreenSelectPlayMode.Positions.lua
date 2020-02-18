return function()
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