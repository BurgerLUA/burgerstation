/obj/item/clothing/head/light
	var/enabled = FALSE

	desired_light_range = VIEW_RANGE*0.5
	desired_light_power = 0.5
	desired_light_color = "#FFD175"
	desired_light_angle = LIGHT_OMNI

/obj/item/clothing/head/light/update_icon()

	if(enabled)
		icon_state = "[initial(icon_state)]_on"
		icon_state_held_left = "[initial(icon_state_held_left)]_on"
		icon_state_held_right = "[initial(icon_state_held_right)]_on"
		icon_state_worn = "[initial(icon_state_worn)]_on"
	else
		icon_state = initial(icon_state)
		icon_state_held_left = initial(icon_state_held_left)
		icon_state_held_right = initial(icon_state_held_right)
		icon_state_worn = initial(icon_state_worn)

	update_held_icon()

	return ..()


/obj/item/clothing/head/light/click_self(var/mob/caller)
	INTERACT_CHECK
	INTERACT_DELAY(5)
	enabled = !enabled
	update_sprite()
	update_atom_light()
	return TRUE

/obj/item/clothing/head/light/update_atom_light()
	if(enabled)
		set_light(desired_light_range, desired_light_power, desired_light_color,desired_light_angle)
	else
		set_light(FALSE)
	return TRUE



/obj/item/clothing/head/light/hardhat
	name = "industrial hardhat"
	icon = 'icons/obj/item/clothing/hats/hardhat.dmi'
	desc = "THIS IS AN OFFICIAL CONSTRUCTION ZONE! PLEASE REMOVE YOURSELF FROM THE AREA!"
	desc_extended = "A yellow industrial hardhat. Seems pretty robust against blunt trauma."
	rarity = RARITY_UNCOMMON

	defense_rating = list(
		BLADE = AP_SWORD,
		BLUNT = AP_CLUB,
		PIERCE = AP_SWORD,
		BOMB = AP_SWORD,
		PAIN = AP_CLUB
	)

	size = SIZE_2

	value = 60

	desired_light_range = VIEW_RANGE*0.5
	desired_light_power = 0.5
	desired_light_color = "#FFF0C6"
	desired_light_angle = LIGHT_WIDE
