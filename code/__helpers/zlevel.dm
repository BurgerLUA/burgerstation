/proc/get_z_level(var/atom/A)
	return list(1 + FLOOR(A.x/255, 1),1 + FLOOR(A.y/255, 1))