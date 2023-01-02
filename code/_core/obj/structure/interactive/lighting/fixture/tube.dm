/obj/structure/interactive/lighting/fixture/tube
	name = "tube light"
	desc = "An electrical storm has been detected in proximity of the station. Please check all equipment for potential overloads."
	desc_extended = "Used to light up the area."

	icon = 'icons/obj/structure/light_tube.dmi'

	color = COLOR_LIGHT

	desired_light_power = 0.5
	desired_light_range = 7
	desired_light_color = null //Set in update_icon
	desired_light_angle = LIGHT_TUBE

	dir_offset = 2

/obj/structure/interactive/lighting/fixture/tube/clicked_on_by_object(mob/caller, atom/object, location, control, params)
	if(istype(object,/obj/item))
		var/obj/item/T = object
		if(T.flags_tool & FLAG_TOOL_WRENCH)
			if(anchored)
				caller.to_chat(span("notice","You un-anchor the light."))
				anchored = FALSE
			else
				caller.to_chat(span("notice","You anchor the light."))
				anchored = TRUE
	. = ..()

/obj/structure/interactive/lighting/fixture/tube/color
	name = "colored light"
	color = "#FFFFFF"

	desired_light_power = 1
	desired_light_range = 3

/obj/structure/interactive/lighting/fixture/tube/color/random
	name = "colored light"
	color = "#FFFFFF"

	desired_light_power = 0.8
	desired_light_range = 7

/obj/structure/interactive/lighting/fixture/tube/color/random/Initialize()

	var/list/valid_list = list(255,pick(0,255),0)


	var/r = pick(valid_list)
	valid_list -= r

	var/g = pick(valid_list)
	valid_list -= g

	var/b = pick(valid_list)
	valid_list -= b

	color = rgb(r,g,b)

	. = ..()

/obj/structure/interactive/lighting/fixture/tube/color/turf/Initialize()

	if(loc)
		color = loc.color
		name = loc.color

	. = ..()

/obj/structure/interactive/lighting/fixture/tube/syndicate
	color = "#FFBABA"
	color_frame = "#666666"
	desired_light_power = 0.6
	desired_light_range = VIEW_RANGE*0.6

/obj/structure/interactive/lighting/fixture/tube/station
	color = COLOR_LIGHT
	color_frame = COLOR_GREY
	desired_light_power = 0.75
	desired_light_range = VIEW_RANGE*0.75

/obj/structure/interactive/lighting/fixture/tube/station/rcd/Finalize()
	. = ..()
	new /light_source(src)
	desired_light_color = color
	update_sprite()
	update_atom_light()
	update_icon()

/obj/structure/interactive/lighting/fixture/tube/station/strong
	desired_light_power = 0.75
	desired_light_range = VIEW_RANGE*0.85

/obj/structure/interactive/lighting/fixture/tube/station/stronger
	desired_light_power = 0.75
	desired_light_range = VIEW_RANGE



/obj/structure/interactive/lighting/fixture/tube/fluorescent
	desired_light_power = 1
	color = COLOR_LIGHT_STRANGE
	color_frame = COLOR_GREY
