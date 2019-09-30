/obj/item/weapon/melee/torch //Also flashlights.
	name = "torch"
	desc = "Somehow it has unlimited fuel."
	icon = 'icons/obj/items/weapons/melee/clubs/torch.dmi'
	damage_type = "torch_off"

	var/enabled = FALSE

	block_mul = list(
		ATTACK_TYPE_MELEE = 1,
		ATTACK_TYPE_RANGED = 0,
		ATTACK_TYPE_MAGIC = 0
	)

	parry_mul = list(
		ATTACK_TYPE_MELEE = 1,
		ATTACK_TYPE_RANGED = 0,
		ATTACK_TYPE_MAGIC = 0
	)

	damage_type = "torch_off"

	override_icon_state = TRUE
	override_icon_state_held = TRUE

	desired_light_range = VIEW_RANGE*0.5
	desired_light_power = 0.5
	desired_light_color = "#FFD175"

/obj/item/weapon/melee/torch/click_self(var/atom/caller)
	enabled = !enabled
	update_icon()
	return TRUE

/obj/item/weapon/melee/torch/update_icon()

	if(enabled)
		damage_type = "torch_on"
		icon_state = "[initial(icon_state)]_on"
		icon_state_held_left = "[initial(icon_state_held_left)]_on"
		icon_state_held_right = "[initial(icon_state_held_right)]_on"
		set_light(desired_light_range, desired_light_power, desired_light_color)
	else
		damage_type = "torch_off"
		icon_state = initial(icon_state)
		icon_state_held_left = initial(icon_state_held_left)
		icon_state_held_right = initial(icon_state_held_right)
		set_light(FALSE)

	update_held_icon()

	..()