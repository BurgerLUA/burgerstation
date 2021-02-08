/obj/item/weapon/melee/torch //Also flashlights.
	name = "torch"
	desc = "A staple of cavemen and revolutionaries."
	desc_extended = "Emits light. Somehow it has unlimited fuel."
	icon = 'icons/obj/item/weapons/melee/clubs/torch.dmi'

	var/enabled = FALSE

	damage_type = /damagetype/melee/club/torch/
	var/damage_type_on = /damagetype/melee/club/torch/on

	override_icon_state = TRUE
	override_icon_state_held = TRUE

	desired_light_range = VIEW_RANGE*0.5
	desired_light_power = 0.5
	desired_light_color = "#FFD175"
	desired_light_angle = LIGHT_OMNI

	size = SIZE_3
	weight = 3

	value = 10

/obj/item/weapon/melee/torch/click_self(var/mob/caller)

	INTERACT_CHECK
	INTERACT_DELAY(1)

	enabled = !enabled
	update_sprite()
	update_atom_light()
	update_held_icon()
	return TRUE

/obj/item/weapon/melee/torch/update_atom_light()
	if(enabled)
		set_light_sprite(desired_light_range, desired_light_power, desired_light_color,desired_light_angle)
	else
		set_light_sprite(FALSE)
	return TRUE

/obj/item/weapon/melee/torch/update_icon()

	if(enabled)
		damage_type = damage_type_on
		icon_state = "[initial(icon_state)]_on"
		icon_state_held_left = "[initial(icon_state_held_left)]_on"
		icon_state_held_right = "[initial(icon_state_held_right)]_on"
	else
		damage_type = initial(damage_type)
		icon_state = initial(icon_state)
		icon_state_held_left = initial(icon_state_held_left)
		icon_state_held_right = initial(icon_state_held_right)

	update_held_icon()

	return ..()


/obj/item/weapon/melee/torch/lantern
	name = "lantern"
	desc = "But what type of lantern? Eh, who cares."
	desc_extended = "Emits a lot of light. Somehow it has unlimited fuel."
	icon = 'icons/obj/item/weapons/melee/clubs/lantern.dmi'

	damage_type = /damagetype/item/medium
	damage_type_on = /damagetype/item/medium

	override_icon_state = TRUE
	override_icon_state_held = TRUE

	desired_light_range = VIEW_RANGE*0.5
	desired_light_power = 0.5
	desired_light_color = "#FFD175"

	value = 100

	size = SIZE_2


/obj/item/weapon/melee/torch/flashlight
	name = "plastic flashlight"
	desc = "Can't live without it!"
	desc_extended = "Emits light in a certain radius and direction when activated."
	icon = 'icons/obj/item/weapons/melee/clubs/flashlight.dmi'

	damage_type = /damagetype/item/light
	damage_type_on = /damagetype/item/light

	override_icon_state = TRUE
	override_icon_state_held = TRUE

	desired_light_range = VIEW_RANGE*0.5
	desired_light_power = 0.45
	desired_light_color = "#FFF0C6"
	desired_light_angle = LIGHT_WIDE

	value = 20

	size = SIZE_2

/obj/item/weapon/melee/torch/flashlight/maglight
	name = "maglight"
	desc = "A robust flashlight."
	icon = 'icons/obj/item/weapons/melee/clubs/maglight.dmi'

	damage_type = /damagetype/item/medium
	damage_type_on = /damagetype/item/medium

	override_icon_state = TRUE
	override_icon_state_held = TRUE

	desired_light_range = VIEW_RANGE*0.75
	desired_light_power = 0.6
	desired_light_color = "#FFF0C6"
	desired_light_angle = LIGHT_NARROW

	value = 80

	size = SIZE_2