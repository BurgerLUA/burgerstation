/obj/structure/smooth/table/cooking/barbecue
	name = "electric portable barbecue"
	desc = "I just wanna grill for god's sake."
	desc_extended = "You can cook or heat up items by placing it on the barbecue. Click on it with an empty hand to toggle the barbecue."
	icon = 'icons/obj/structure/bbq.dmi'
	icon_state = "bbq"
	anchored = FALSE
	desired_light_range = VIEW_RANGE*0.2
	desired_light_power = 1
	desired_light_color = "#B82E00"
	desired_light_angle = LIGHT_OMNI
	corner_category = null

	collision_flags = FLAG_COLLISION_WALKING
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	bullet_block_chance = 50

/obj/structure/smooth/table/cooking/barbecue/update_atom_light()
	if(enabled)
		set_light(desired_light_range, desired_light_power, desired_light_color,desired_light_angle)
	else
		set_light(FALSE)
	return TRUE

/obj/structure/smooth/table/cooking/barbecue/update_icon()
	. = ..()

	icon = initial(icon)
	icon_state = initial(icon_state)

	if(enabled)
		icon_state = "[icon_state]_on"
	else
		icon_state = "[icon_state]_off"
