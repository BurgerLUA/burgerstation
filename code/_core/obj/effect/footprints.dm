/obj/effect/footprint/
	name = "footprints"
	icon = 'icons/obj/effects/footprints.dmi'
	icon_state = "human"
	layer = LAYER_MOB
	mouse_opacity = 1

/obj/effect/footprint/New(var/newloc,var/desired_dir = 0)
	dir = desired_dir
	..()

/obj/effect/footprint/emboss
	icon_state = "human_emboss_enter"

/obj/effect/footprint/emboss/exit
	icon_state = "human_emboss_exit"