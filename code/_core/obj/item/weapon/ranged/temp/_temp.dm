/obj/item/weapon/ranged/temporary
	var/cost_charge = 1
	var/total_charge = 1
	size = 777 //TOO BIG TO PUT ANYWHERE, THIS WILL HOLD THEM ALRIGHT
	value = -100 //If this price ever rises above the negative, PLEASE, tell someone!
	item_slot = SLOT_NONE // Just TRY AND STORE IT
	value_burgerbux = 1 //just in case
	
	throwable = FALSE //lazy solution. Throwing still deletes guns, but this prevents errors.
	
/obj/item/weapon/ranged/temporary/on_drop()
	Destroy()

/obj/item/weapon/ranged/temporary/handle_empty()
	Destroy()

/obj/item/weapon/ranged/temporary/can_gun_shoot(var/mob/caller)

	if(total_charge < cost_charge)
		handle_empty()
		return FALSE

	return ..()

/obj/item/weapon/ranged/temporary/get_examine_list(var/mob/caller)
	return ..() + div("notice","[get_ammo_count()] uses left.")

/obj/item/weapon/ranged/temporary/handle_ammo(var/mob/caller,var/bullet_position=1)
	var/charge_to_remove = cost_charge
	total_charge -= charge_to_remove
	update_sprite()
	return FALSE

/obj/item/weapon/ranged/temporary/get_ammo_count()
	return round(total_charge / cost_charge)
	
/obj/item/weapon/ranged/temporary/revolver
	name = "Imaginary Revolver"
	desc = "Six shots."
	desc_extended = "Reloading like this is a revolution!"
	icon = 'icons/obj/item/weapons/ranged/revolver/45.dmi'
	icon_state = "inventory"
	rarity = RARITY_COMMON
	value_burgerbux = 1 //just in case
	shoot_sounds = list('sound/weapons/revolver_light/revolver.ogg')
	
	cost_charge = 1	
	total_charge = 6

	projectile = /obj/projectile/bullet/firearm/revolver/
	ranged_damage_type = /damagetype/ranged/bullet/revolver_38

	shoot_delay = 1

	projectile_speed = BULLET_SPEED_PISTOL_HEAVY

	bullet_color = COLOR_BULLET

	inaccuracy_modifier = 0.25
	movement_inaccuracy_modifier = 0.25
	movement_spread_base = 0.04

/obj/item/weapon/ranged/temporary/revolver/get_static_spread()
	return 0

/obj/item/weapon/ranged/temporary/revolver/get_skill_spread(var/mob/living/L)
	return max(0,0.01 - (0.01 * L.get_skill_power(SKILL_RANGED)))
