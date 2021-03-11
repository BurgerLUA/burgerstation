/obj/item/container/cigarette
	name = "blank cigarette"
	desc = "Kills you slowly."
	desc_extended = "An old cigarette containing all the dangerous toxins that you crave."
	icon = 'icons/obj/item/smoking/cigarette.dmi'
	icon_state = "inventory"
	icon_state_worn = "worn"

	worn_layer = LAYER_MOB_CLOTHING_MASK
	item_slot = SLOT_FACE

	can_wear = TRUE
	can_rename = TRUE

	var/lit = FALSE

	reagents = /reagent_container/cigarette

	var/next_consume = 0

	var/consume_amount = 0.3

	desired_light_range = 1
	desired_light_power = 0.2
	desired_light_color = "#FFC58C"
	desired_light_angle = LIGHT_OMNI

	value = 200 //Smoking isn't cheap.

	health = /health/obj/item/misc/

	damage_type = /damagetype/melee/club/lighter

/obj/item/container/cigarette/get_damage_type(var/atom/attacker,var/atom/victim)
	if(lit) return /damagetype/melee/club/lighter/on
	return ..()

/obj/item/container/cigarette/can_be_attacked(var/atom/attacker,var/atom/weapon,var/params,var/damagetype/damage_type)
	return !lit

/obj/item/container/cigarette/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/list/damage_table,var/damage_amount,var/critical_hit_multiplier,var/stealthy=FALSE)

	if(damage_table[FIRE] || damage_table[LASER])
		set_lit(TRUE)

	. = ..()

/obj/item/container/cigarette/water
	name = "water cigarette"

/obj/item/container/cigarette/water/Generate()
	. = ..()
	reagents.add_reagent(/reagent/nutrition/water,reagents.volume_max)

/obj/item/container/cigarette/proc/set_lit(var/desired_lit=TRUE)

	if(lit == desired_lit)
		return FALSE

	lit = desired_lit

	update_sprite()
	update_atom_light()

	if(lit)
		start_thinking(src)
	else
		stop_thinking(src)

	return TRUE

/obj/item/container/cigarette/update_atom_light()
	if(lit)
		set_light_sprite(desired_light_range, desired_light_power, desired_light_color,desired_light_angle)
	else
		set_light_sprite(FALSE)
	return TRUE

/obj/item/container/cigarette/update_icon()

	icon_state = initial(icon_state)
	icon_state_worn = initial(icon_state_worn)

	if(reagents && lit)
		var/icon_state_num = FLOOR(clamp(reagents.volume_current/2,0,10),1)
		icon_state = "[icon_state]_[icon_state_num]"

	if(lit)
		icon_state_worn = "[icon_state_worn]_on"

	. = ..()

/obj/item/container/cigarette/update_sprite()
	. = ..()
	if(is_inventory(loc)) //Snowflake code, do not remove.
		var/obj/hud/inventory/I = loc
		if(I.worn && is_advanced(I.owner))
			var/mob/living/advanced/A = I.owner
			A.remove_overlay("\ref[src]")
			if(src in I.contents)
				I.update_worn_icon(src)

/obj/item/container/cigarette/update_overlays()
	if(lit && reagents)
		var/pixel_offset = FLOOR(clamp(reagents.volume_current/2,0,10),1) - 10
		var/image/I = new/image(icon,"light")
		I.pixel_x = pixel_offset
		add_overlay(I)
	. = ..()

/obj/item/container/cigarette/think()

	if(!lit)
		return FALSE

	if(reagents.volume_current <= 0)
		qdel(src)
		CREATE(/obj/item/trash/butt,get_turf(src))
		return FALSE

	if(next_consume <= world.time)
		next_consume = world.time + SECONDS_TO_DECISECONDS(10)
		if(istype(src.loc,/obj/hud/inventory/organs/face))
			var/obj/hud/inventory/organs/face/I = src.loc
			if(I.owner && I.owner.reagents)
				reagents.transfer_reagents_to(I.owner.reagents,consume_amount)
				return TRUE
		reagents.splash(null,get_turf(src),consume_amount,TRUE,1) //Just remove the reagents if there is no one to add it to.

	return TRUE

