// Taken from Jeremy "Spuzzum" Gibson's s_html library.
// http://www.byond.com/developer/Spuzzum/s_html
/proc/hex2num(hex)
	//Converts a hexadecimal string (eg. "9F") into a numeral (eg. 159).

	if(!istext(hex))
		CRASH("hex2num not given a hexadecimal string argument (user error)")
		return

	var/num = 0
	var/power = 0

	for(var/i = lentext(hex), i > 0, i--)
		var/char = copytext(hex, i, i+1) //extract hexadecimal character from string
		switch(char)
			if("0")
				power++  //We don't do anything with a zero, so we'll just increase the power,
				continue // then go onto the next iteration.

			if("1","2","3","4","5","6","7","8","9")
				num += text2num(char) * (16 ** power)

			if("A","a") num += 10 * (16 ** power)
			if("B","b") num += 11 * (16 ** power)
			if("C","c") num += 12 * (16 ** power)
			if("D","d") num += 13 * (16 ** power)
			if("E","e") num += 14 * (16 ** power)
			if("F","f") num += 15 * (16 ** power)

			else
				CRASH("hex2num given non-hexadecimal string (user error)")
				return

		power++

	return(num)

// Couple of helpers to get the RGB of a hexadecimal colour string.
/proc/GetRedPart(var/hexadecimal)
	return hex2num(copytext(hexadecimal, 2, 4))

/proc/GetGreenPart(var/hexadecimal)
	return hex2num(copytext(hexadecimal, 4, 6))

/proc/GetBluePart(var/hexadecimal)
	return hex2num(copytext(hexadecimal, 6))
