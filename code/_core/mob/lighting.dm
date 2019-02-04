/mob/proc/get_map_color()
	var/list/returning = list()
	var/area/A = get_area(src)
	returning["r"] = A.map_color_r
	returning["g"] = A.map_color_g
	returning["b"] = A.map_color_b
	returning["a"] = A.map_color_a
	return returning