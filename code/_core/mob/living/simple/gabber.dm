/mob/living/simple/gabber
	name = "test boss"
	icon = 'icons/mob/living/simple/gabber.dmi'
	icon_state = "idle"
	pixel_x = -16

/mob/living/simple/gabber/Finalize()
	. = ..()
	update_sprite()
	set_light_sprite(VIEW_RANGE*0.5,0.25, "#3184B7",LIGHT_OMNI)

/mob/living/simple/gabber/update_overlays()
	. = ..()
	var/image/I = new/image(initial(icon),"[icon_state]_light")
	I.plane = PLANE_LIGHTING
	I.appearance_flags = src.appearance_flags | RESET_COLOR | KEEP_APART
	I.alpha = 125
	I.layer = 1000
	add_overlay(I)