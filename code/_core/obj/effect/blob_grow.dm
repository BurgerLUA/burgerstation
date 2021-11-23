/obj/effect/blob_grow/
	name = "footprints"
	icon = 'icons/obj/projectiles/magic.dmi'
	icon_state = "lightning_01"
	mouse_opacity = 1

	layer = LAYER_EFFECT
	plane = PLANE_EFFECT

/obj/effect/blob_grow/post_move(var/atom/old_loc)
	icon_state = pick("lightning_01","lightning_02","lightning_03","lightning_04","lightning_05")
	var/matrix/M = get_base_transform()
	M.Turn(get_angle(old_loc,loc)+90)
	animate(src,transform=M,time=1)
	. = ..()