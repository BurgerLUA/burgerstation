/proc/get_z_level(var/atom/A)
	return list(1 + floor(A.x/255),1 + floor(A.y/255))