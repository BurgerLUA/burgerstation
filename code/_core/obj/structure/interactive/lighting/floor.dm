/obj/structure/interactive/lighting/floor
	name = "tube light"
	desc = "An electrical storm has been detected in proximity of the station. Please check all equipment for potential overloads."
	desc_extended = "Used to light up the area."

	icon = 'icons/obj/structure/lights_new.dmi'
	icon_state = "floor_light"

	desired_light_power = 0.25
	desired_light_range = 7
	desired_light_color = null //Set in update_icon

	layer = LAYER_OBJ
	plane = PLANE_FLOOR

	color = "#FFFFAA"
	var/color_frame = "#888888"

	collision_bullet_flags = FLAG_COLLISION_SPECIFIC

	health = /health/construction

	health_base = 10

	lightswitch = TRUE


/obj/structure/interactive/lighting/floor/on_destruction(var/mob/caller,var/damage = FALSE)

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


/obj/structure/interactive/lighting/floor/Initialize()

	if(color)
		desired_light_color = color
		color = "#FFFFFF"

	return ..()

/obj/structure/interactive/lighting/floor/PostInitialize()
	. = ..()
	update_sprite()
	return .

/obj/structure/interactive/lighting/floor/update_icon()

	if(desired_light_range && desired_light_power && desired_light_color)
		set_light(desired_light_range,desired_light_power,desired_light_color)

	icon = initial(icon)
	icon_state = initial(icon_state)

	var/icon/I = new /icon(icon,"floor")

	var/icon/F = new /icon(icon,"floor_bulb")
	F.Blend(color_frame,ICON_MULTIPLY)
	I.Blend(F,ICON_OVERLAY)

	if(on && desired_light_color)
		var/icon/L = new /icon(icon,"floor_light")
		L.Blend(desired_light_color,ICON_MULTIPLY)
		I.Blend(L,ICON_OVERLAY)

	icon = I

