/obj/structure/interactive/lighting/fixture
	name = "LIGHT ERROR"
	icon_state = "preview"

	layer = LAYER_LARGE_OBJ
	plane = PLANE_OBJ

	color = COLOR_LIGHT
	var/color_frame = COLOR_GREY

	rotation_mod = -1

	collision_bullet_flags = FLAG_COLLISION_SPECIFIC

	health = /health/construction

	health_base = 10

	lightswitch = TRUE

/obj/structure/interactive/lighting/fixture/Generate()
	desired_light_color = color
	return ..()

/obj/structure/interactive/lighting/fixture/on_destruction(var/mob/caller,var/damage = FALSE)

	var/turf/T = get_turf(src)

	if(desired_light_color)
		desired_light_color = null
		if(health) health.restore()
		create_destruction(T,list(/obj/item/material/shard = 1),/material/glass)
		play_sound('sound/effects/glass_shatter.ogg',T,range_max=VIEW_RANGE)
		. = ..()
		update_atom_light()
		update_sprite()
	else
		create_destruction(T,list(/obj/item/material/sheet = 1),/material/steel)
		. = ..()
		qdel(src)

	return .

/obj/structure/interactive/lighting/fixture/Finalize()
	update_sprite()
	update_atom_light()
	return ..()

/obj/structure/interactive/lighting/fixture/update_atom_light()
	if(on && desired_light_range && desired_light_power && desired_light_color)
		set_light(desired_light_range,desired_light_power,desired_light_color,desired_light_angle)
	else
		set_light(FALSE)
	return TRUE

/obj/structure/interactive/lighting/fixture/update_icon()
	icon = initial(icon)
	if(desired_light_color)
		icon_state = "bulb"
	else
		icon_state = "none"
	return ..()

/obj/structure/interactive/lighting/fixture/update_underlays()
	. = ..()
	var/image/IS = new/image(initial(icon),"frame")
	IS.appearance_flags = RESET_COLOR | RESET_ALPHA
	IS.color = color_frame
	add_underlay(IS)
	return .

/obj/structure/interactive/lighting/fixture/update_overlays()

	. = ..()

	if(on && light_color && light_range > 0 && light_power > 0)
		var/image/IS = new/image(initial(icon),"light")
		IS.appearance_flags = RESET_COLOR | RESET_ALPHA
		IS.plane = PLANE_LIGHTING
		IS.layer = 99
		IS.color = desired_light_color
		IS.alpha = 255*(light_power/1)
		add_overlay(IS)

	return .