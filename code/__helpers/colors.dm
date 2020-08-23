// Taken from Jeremy "Spuzzum" Gibson's s_html library.
// http://www.byond.com/developer/Spuzzum/s_html

/proc/color_matrix_identity()
	return list(1,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0,1, 0,0,0,0)

/proc/random_color()
	return rgb(rand(0,255),rand(0,255),rand(0,255))

// Couple of helpers to get the RGB of a hexadecimal colour string.
/proc/GetRedPart(var/hexadecimal)
	return hex2num(copytext(hexadecimal, 2, 4))

/proc/GetGreenPart(var/hexadecimal)
	return hex2num(copytext(hexadecimal, 4, 6))

/proc/GetBluePart(var/hexadecimal)
	return hex2num(copytext(hexadecimal, 6))


/proc/blend_colors(var/color_01,var/color_02,var/power = 0.5)
	power = clamp(power,0,1)
	var/new_red = GetRedPart(color_01)*(1-power) + GetRedPart(color_02)*power
	var/new_green = GetGreenPart(color_01)*(1-power) + GetGreenPart(color_02)*power
	var/new_blue = GetBluePart(color_01)*(1-power) + GetBluePart(color_02)*power
	return rgb(new_red,new_green,new_blue)


/*
/proc/blend_colors(var/color_01,var/color_02,var/power = 0.5)
	power = clamp(power,0,1)
	var/new_red = GetRedPart(color_01) + GetRedPart(color_02)*power
	var/new_green = GetGreenPart(color_01) + GetGreenPart(color_02)*power
	var/new_blue = GetBluePart(color_01) + GetBluePart(color_02)*power
	var/mod = max(1,max(new_red,new_green,new_blue)/255) //Normalize if needed.
	return rgb(new_red/mod,new_green/mod,new_blue/mod)
*/