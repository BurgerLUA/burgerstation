/obj/structure/interactive/lighting/bulb
	name = "bulb light"
	desc = "An electrical storm has been detected in proximity of the station. Please check all equipment for potential overloads."
	desc_extended = "Used to light up the area."

	icon = 'icons/obj/structure/lights_new.dmi'
	icon_state = "bulb_light"

	desired_light_power = 0.5
	desired_light_range = 5
	desired_light_color = null //Set in update_icon
	desired_light_angle = LIGHT_OMNI

	layer = LAYER_LARGE_OBJ
	plane = PLANE_OBJ

	color = COLOR_LIGHT
	var/color_frame = COLOR_GREY

	rotation_mod = -1

	collision_bullet_flags = FLAG_COLLISION_SPECIFIC

	health = /health/construction

	health_base = 10

	lightswitch = TRUE

/obj/structure/interactive/lighting/bulb/on_destruction(var/mob/caller,var/damage = FALSE)

	var/turf/T = get_turf(src)

	if(desired_light_color)
		desired_light_color = null
		if(health)
			health.restore()
		create_destruction(T,list(/obj/item/material/shard = 1),/material/glass)
		play('sound/effects/glass_shatter.ogg',T)
		. = ..()
		update_atom_light()
		update_sprite()
	else
		create_destruction(T,list(/obj/item/material/sheet = 1),/material/steel)
		. = ..()
		qdel(src)

	return .

/obj/structure/interactive/lighting/bulb/Initialize()

	if(color)
		desired_light_color = color
		color = "#FFFFFF"

	return ..()

/obj/structure/interactive/lighting/bulb/PostInitialize()
	. = ..()
	update_sprite()
	return .

/obj/structure/interactive/lighting/tube/update_atom_light()
	if(on && desired_light_color)
		set_light(desired_light_range,desired_light_power,desired_light_color,desired_light_angle)
	else
		set_light(FALSE)
	return TRUE

/obj/structure/interactive/lighting/bulb/update_icon()

	icon = initial(icon)
	icon_state = initial(icon_state)

	var/icon/I = new /icon(icon,"bulb")
	I.Blend(color_frame,ICON_MULTIPLY)

	if(desired_light_color)
		var/icon/F = new /icon(icon,"bulb_bulb")
		F.Blend(color_frame,ICON_MULTIPLY)
		I.Blend(F,ICON_OVERLAY)

	icon = I

/obj/structure/interactive/lighting/bulb/update_overlays()

	. = ..()

	if(on && desired_light_color)
		var/image/IS = new/image(initial(icon),"bulb_light")
		IS.plane = PLANE_LIGHTING
		IS.layer = 99
		IS.color = desired_light_color
		IS.alpha = 100
		add_overlay(IS)

	return .
