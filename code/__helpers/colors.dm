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



//Below code is credit of Lummox JR
#define TO_HEX_DIGIT(n) ascii2text((n&15) + ((n&15)<10 ? 48 : 87))

/proc/HSVtoRGB(hsv)
	if(!hsv) return "#000000"
	var/list/HSV = ReadHSV(hsv)
	if(!HSV) return "#000000"

	var/hue = HSV[1]
	var/sat = HSV[2]
	var/val = HSV[3]

	// Compress hue into easier-to-manage range
	hue -= hue >> 8
	if(hue >= 0x5fa) hue -= 0x5fa

	var/hi,mid,lo,r,g,b
	hi = val
	lo = round((255 - sat) * val / 255, 1)
	mid = lo + round(abs(round(hue, 510) - hue) * (hi - lo) / 255, 1)
	if(hue >= 765)
		if(hue >= 1275)      {r=hi;  g=lo;  b=mid}
		else if(hue >= 1020) {r=mid; g=lo;  b=hi }
		else                 {r=lo;  g=mid; b=hi }
	else
		if(hue >= 510)       {r=lo;  g=hi;  b=mid}
		else if(hue >= 255)  {r=mid; g=hi;  b=lo }
		else                 {r=hi;  g=mid; b=lo }

	return (HSV.len > 3) ? rgb(r,g,b,HSV[4]) : rgb(r,g,b)

/proc/RGBtoHSV(rgb)
	if(!rgb) return "#0000000"
	var/list/RGB = ReadRGB(rgb)
	if(!RGB) return "#0000000"

	var/r = RGB[1]
	var/g = RGB[2]
	var/b = RGB[3]
	var/hi = max(r,g,b)
	var/lo = min(r,g,b)

	var/val = hi
	var/sat = hi ? round((hi-lo) * 255 / hi, 1) : 0
	var/hue = 0

	if(sat)
		var/dir
		var/mid
		if(hi == r)
			if(lo == b) {hue=0; dir=1; mid=g}
			else {hue=1535; dir=-1; mid=b}
		else if(hi == g)
			if(lo == r) {hue=512; dir=1; mid=b}
			else {hue=511; dir=-1; mid=r}
		else if(hi == b)
			if(lo == g) {hue=1024; dir=1; mid=r}
			else {hue=1023; dir=-1; mid=g}
		hue += dir * round((mid-lo) * 255 / (hi-lo), 1)

	return hsv(hue, sat, val, (RGB.len>3 ? RGB[4] : null))


/proc/ReadRGB(rgb)
	if(!rgb) return

	// interpret the HSV or HSVA value
	var/i=1,start=1
	if(text2ascii(rgb) == 35) ++start // skip opening #
	var/ch,which=0,r=0,g=0,b=0,alpha=0,usealpha
	var/digits=0
	for(i=start, i<=length(rgb), ++i)
		ch = text2ascii(rgb, i)
		if(ch < 48 || (ch > 57 && ch < 65) || (ch > 70 && ch < 97) || ch > 102) break
		++digits
		if(digits == 8) break

	var/single = digits < 6
	if(digits != 3 && digits != 4 && digits != 6 && digits != 8) return
	if(digits == 4 || digits == 8) usealpha = 1
	for(i=start, digits>0, ++i)
		ch = text2ascii(rgb, i)
		if(ch >= 48 && ch <= 57) ch -= 48
		else if(ch >= 65 && ch <= 70) ch -= 55
		else if(ch >= 97 && ch <= 102) ch -= 87
		else break
		--digits
		switch(which)
			if(0)
				r = (r << 4) | ch
				if(single)
					r |= r << 4
					++which
				else if(!(digits & 1)) ++which
			if(1)
				g = (g << 4) | ch
				if(single)
					g |= g << 4
					++which
				else if(!(digits & 1)) ++which
			if(2)
				b = (b << 4) | ch
				if(single)
					b |= b << 4
					++which
				else if(!(digits & 1)) ++which
			if(3)
				alpha = (alpha << 4) | ch
				if(single) alpha |= alpha << 4

	. = list(r, g, b)
	if(usealpha) . += alpha

/proc/ReadHSV(hsv)
	if(!hsv) return

	// interpret the HSV or HSVA value
	var/i=1,start=1
	if(text2ascii(hsv) == 35) ++start // skip opening #
	var/ch,which=0,hue=0,sat=0,val=0,alpha=0,usealpha
	var/digits=0
	for(i=start, i<=length(hsv), ++i)
		ch = text2ascii(hsv, i)
		if(ch < 48 || (ch > 57 && ch < 65) || (ch > 70 && ch < 97) || ch > 102) break
		++digits
		if(digits == 9) break
	if(digits > 7) usealpha = 1
	if(digits <= 4) ++which
	if(digits <= 2) ++which
	for(i=start, digits>0, ++i)
		ch = text2ascii(hsv, i)
		if(ch >= 48 && ch <= 57) ch -= 48
		else if(ch >= 65 && ch <= 70) ch -= 55
		else if(ch >= 97 && ch <= 102) ch -= 87
		else break
		--digits
		switch(which)
			if(0)
				hue = (hue << 4) | ch
				if(digits == (usealpha ? 6 : 4)) ++which
			if(1)
				sat = (sat << 4) | ch
				if(digits == (usealpha ? 4 : 2)) ++which
			if(2)
				val = (val << 4) | ch
				if(digits == (usealpha ? 2 : 0)) ++which
			if(3)
				alpha = (alpha << 4) | ch

	. = list(hue, sat, val)
	if(usealpha) . += alpha

/proc/hsv(hue, sat, val, alpha)
	if(hue < 0 || hue >= 1536) hue %= 1536
	if(hue < 0) hue += 1536
	if((hue & 0xFF) == 0xFF)
		++hue
		if(hue >= 1536) hue = 0
	if(sat < 0) sat = 0
	if(sat > 255) sat = 255
	if(val < 0) val = 0
	if(val > 255) val = 255
	. = "#"
	. += TO_HEX_DIGIT(hue >> 8)
	. += TO_HEX_DIGIT(hue >> 4)
	. += TO_HEX_DIGIT(hue)
	. += TO_HEX_DIGIT(sat >> 4)
	. += TO_HEX_DIGIT(sat)
	. += TO_HEX_DIGIT(val >> 4)
	. += TO_HEX_DIGIT(val)
	if(!isnull(alpha))
		if(alpha < 0) alpha = 0
		if(alpha > 255) alpha = 255
		. += TO_HEX_DIGIT(alpha >> 4)
		. += TO_HEX_DIGIT(alpha)


/proc/blend_colors(var/color_01,var/color_02,var/power = 0.5)
	power = clamp(power,0,1)
	var/new_red = GetRedPart(color_01)*(1-power) + GetRedPart(color_02)*power
	var/new_green = GetGreenPart(color_01)*(1-power) + GetGreenPart(color_02)*power
	var/new_blue = GetBluePart(color_01)*(1-power) + GetBluePart(color_02)*power
	return rgb(new_red,new_green,new_blue)
