obj/effect/temp/ash_drake/swoop_up
	name = "ash drake swoop up effect"
	icon = 'icons/mob/living/simple/ashdrake.dmi'
	icon_state = "swoop"
	desc = "FLY, CLIFF RACER FLY"
	duration = SECONDS_TO_DECISECONDS(3)
	mouse_opacity = 0

obj/effect/temp/ash_drake/swoop_up/New(var/desired_loc)
	..()
	animate(src,pixel_x = pick(-32 - 16,-32 - 16), pixel_z = TILE_SIZE*VIEW_RANGE, alpha=0, duration)

/obj/effect/temp/ash_drake/swoop_down
	name = "ash drake swoop up effect"
	icon = 'icons/mob/living/simple/ashdrake.dmi'
	icon_state = "swoop"
	desc = "FLY, CLIFF RACER FLY"
	duration = SECONDS_TO_DECISECONDS(1)
	mouse_opacity = 0

/obj/effect/temp/ash_drake/swoop_down/New(var/desired_loc)
	..()
	alpha = 255
	pixel_x = pick(-32 - 16,32 - 16)
	pixel_z = TILE_SIZE*VIEW_RANGE
	animate(src,pixel_x = initial(src.pixel_x), pixel_z = initial(src.pixel_z), alpha=255, duration)


/obj/effect/temp/target/
	name = "target"
	icon = 'icons/obj/effects/targets.dmi'
	icon_state = "basic"
	duration = SECONDS_TO_DECISECONDS(2)
	mouse_opacity = 0
	color = "#FF0000"