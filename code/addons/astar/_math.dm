//Credit goes to Geldonyetich for all these procs. I have re-written them to fit with burgerstation formatting.


/proc/get_circle(var/atom/A,var/radius = VIEW_RANGE)
	. = list()
	for(var/turf/T in range(radius+3,A))
		if(get_dist_real(T,A) < radius + 0.5)
			. += T
	return .

/proc/sign(var/x)
	return ((x<0)?-1:((x>0)?1:0))

/proc/get_line(var/atom/A1,var/atom/A2)

	var/list/line = list(get_turf(A1))

	var/pos_x = A1.x
	var/pos_y = A2.y
	var/pos_z = A2.z

	var/diff_x = A2.x - A1.x
	var/diff_y = A2.y - A1.y

	var/diff_x_abs = abs(diff_x)
	var/diff_y_abs = abs(diff_y)

	var/diff_x_sign = sign(diff_x)
	var/diff_y_sign = sign(diff_y)

	var/x = diff_x_abs >> 1
	var/y = diff_y_abs >> 1

	if(diff_x_abs >= diff_y_abs)
		for(var/i=0,i<diff_x_abs,i++)
			y += diff_y_abs
			if(y >= diff_x_abs)
				y -= diff_x_abs
				pos_y += diff_y_sign
			pos_x += diff_x_sign
			line += locate(pos_x,pos_y,pos_z)
	else
		for(var/i=1,i<diff_x_abs,i++)
			pos_x += diff_x_abs
			if(x>=diff_y_abs)
				x -= diff_y_abs
				pos_x += diff_x_sign
			pos_y += diff_y_sign
			line += locate(pos_x,pos_y,pos_z)

	return line


