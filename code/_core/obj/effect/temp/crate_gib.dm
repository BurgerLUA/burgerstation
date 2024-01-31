/obj/effect/temp/crate_gib/
	name = "crate gib effect"
	icon = 'icons/obj/structure/supply_crate.dmi'
	icon_state = "gib"
	mouse_opacity = 0
	plane = PLANE_MOVABLE

/obj/effect/temp/crate_gib/New(desired_location,desired_time)
	. = ..()
	icon_state = "[icon_state]_[rand(1,5)]"
	var/matrix/M = get_base_transform()
	M.Turn(rand(360,360*3))
	M.Translate(rand(-TILE_SIZE,TILE_SIZE),rand(-TILE_SIZE,TILE_SIZE))
	animate(src,transform = M,time = 4)
