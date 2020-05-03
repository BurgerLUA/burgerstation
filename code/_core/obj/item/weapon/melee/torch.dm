/obj/item/weapon/melee/torch //Also flashlights.
	name = "torch"
	desc = "Somehow it has unlimited fuel."
	icon = 'icons/obj/items/weapons/melee/clubs/torch.dmi'

	var/enabled = FALSE

	damage_type = /damagetype/melee/club/torch/
	var/damage_type_on = /damagetype/melee/club/torch/on

	override_icon_state = TRUE
	override_icon_state_held = TRUE

	desired_light_range = VIEW_RANGE*0.5
	desired_light_power = 0.5
	desired_light_color = "#FFD175"

	attack_delay = 5
	attack_delay_max = 10

	value = 5

/obj/item/weapon/melee/torch/click_self(var/atom/caller)
	enabled = !enabled
	update_sprite()
	return TRUE

/obj/item/weapon/melee/torch/update_icon()

	if(enabled)
		damage_type = damage_type_on
		icon_state = "[initial(icon_state)]_on"
		icon_state_held_left = "[initial(icon_state_held_left)]_on"
		icon_state_held_right = "[initial(icon_state_held_right)]_on"
		set_light(desired_light_range, desired_light_power, desired_light_color,desired_light_angle)
	else
		damage_type = initial(damage_type)
		icon_state = initial(icon_state)
		icon_state_held_left = initial(icon_state_held_left)
		icon_state_held_right = initial(icon_state_held_right)
		set_light(FALSE)

	update_held_icon()

	..()


/obj/item/weapon/melee/torch/flashlight
	name = "plastic flashlight"
	desc = "Can't live without it!"
	icon = 'icons/obj/items/weapons/melee/clubs/flashlight.dmi'

	damage_type = /damagetype/item/light
	damage_type_on = /damagetype/item/light

	override_icon_state = TRUE
	override_icon_state_held = TRUE

	desired_light_range = VIEW_RANGE*0.5
	desired_light_power = 0.5
	desired_light_color = "#FFD175"
	desired_light_angle = LIGHT_WIDE

