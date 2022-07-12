obj/structure/interactive/door/closet
	name = "wall closet door"
	icon_state = "closet"
	color = COLOR_WOOD
	dir_offset = -5

obj/structure/interactive/door/closet/Finalize()
	. = ..()
	setup_dir_offsets()

obj/structure/interactive/door/closet/setup_dir_offsets()
	var/matrix/M = matrix()
	switch(dir)
		if(NORTH)
			M.Turn(180)
		if(EAST)
			M.Turn(270)
		if(WEST)
			M.Turn(90)
	transform = M
	icon_state = "closet"
	. = ..()
	dir = SOUTH