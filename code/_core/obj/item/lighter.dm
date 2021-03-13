/obj/item/lighter
	name = "lighter"
	desc = "Lights things."
	desc_extended = "A basic lighter."
	icon = 'icons/obj/item/lighter/basic.dmi'
	icon_state = "inventory"
	var/lit = FALSE

	damage_type = /damagetype/melee/club/lighter

	desired_light_range = 2
	desired_light_power = 0.3
	desired_light_color = "#FFC58C"
	desired_light_angle = LIGHT_OMNI

	value = 80

/obj/item/lighter/click_self(var/mob/caller)
	set_lit(!lit,caller)
	return TRUE

/obj/item/lighter/update_sprite()
	. = ..()
	icon_state = initial(icon_state)
	if(lit)
		icon_state = "[icon_state]_on"

/obj/item/lighter/update_atom_light()
	if(lit)
		set_light_sprite(desired_light_range, desired_light_power, desired_light_color,desired_light_angle)
	else
		set_light_sprite(FALSE)
	return TRUE

/obj/item/lighter/proc/set_lit(var/desired_lit,var/mob/caller)

	if(desired_lit == lit)
		return FALSE

	lit = desired_lit

	update_sprite()
	update_atom_light()

	if(caller)
		caller.to_chat(span("notice","You [lit ? "open" : "close"] \the [src.name]."))

	return TRUE


/obj/item/lighter/get_damage_type(var/atom/attacker,var/atom/victim)

	if(lit)
		return /damagetype/melee/club/lighter/on

	return ..()