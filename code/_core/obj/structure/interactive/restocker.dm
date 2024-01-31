/obj/structure/interactive/restocker
	name = "restocker"
	desc = "Restocks goods, as long as you have the materials to make them."
	icon = 'icons/obj/structure/vending.dmi'
	icon_state = "gear2"

	bullet_block_chance = 40

	collision_flags = FLAG_COLLISION_BARICADE
	collision_bullet_flags = FLAG_COLLISION_BULLET_ORGANIC

	layer = LAYER_OBJ_CRATE + 1

	density = TRUE
	anchored = FALSE

	pixel_y = 10

/obj/structure/interactive/restocker/ammo
	name = "portable surplus ammo restocker"
	desc = "Warning: Does not contain literature."
	desc_extended = "A machine that automatically fills magazines inserted into the machine with cheap surplus rounds."
	icon = 'icons/obj/structure/vending.dmi'
	icon_state = "gear2_ammo"
	var/premium = FALSE //Is this a premium ammo restocker?
	var/currency_left = 0 //For premium ammo restockers

/obj/structure/interactive/restocker/ammo/clicked_on_by_object(mob/caller,atom/object,location,control,params)

	if(istype(object,/obj/item/magazine/))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(5)
		var/obj/item/magazine/M = object
		var/obj/item/bullet_cartridge/bullet_to_create = premium || !M.ammo_surplus ? M.ammo : M.ammo_surplus
		if(!bullet_to_create)
			caller.to_chat(span("warning","That magazine isn't registered in our system!"))
			return TRUE
		var/bullets_to_add = M.bullet_count_max - M.get_ammo_count()
		if(bullets_to_add <= 0)
			caller.to_chat(span("warning","\The [M.name] is already full!"))
			return TRUE
		if(M.next_regen > world.time)
			caller.to_chat(span("warning","That magazine was just filled! Please wait [CEILING(DECISECONDS_TO_SECONDS(M.next_regen-world.time),1)] seconds!"))
			return TRUE
		if(premium)
			var/value_per_bullet = SSbalance.stored_value[bullet_to_create]
			if(value_per_bullet*bullets_to_add > currency_left)
				caller.to_chat(span("warning","\The [src.name] doesn't have enough credits stored to complete this operation!"))
				return TRUE
			currency_left -= value_per_bullet*bullets_to_add
		M.next_regen = world.time + 120 SECONDS
		M.stored_bullets[bullet_to_create] += bullets_to_add
		M.update_sprite()
		caller.to_chat(span("notice","\The [M.name] has been restocked with [bullets_to_add] [initial(bullet_to_create.name)]."))
		return TRUE

	if(istype(object,/obj/item/powercell/))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(5)
		if(!premium)
			caller.to_chat(span("warning","Only non-surplus ammo restockers can recharge power cells!"))
			return TRUE
		var/obj/item/powercell/C = object
		var/charge_to_add = C.charge_max - C.charge_current
		if(charge_to_add <= 0)
			caller.to_chat(span("warning","You can't cram any more power into \the [C.name]!"))
			return TRUE
		if(premium)
			if(0.001*charge_to_add > currency_left)
				caller.to_chat(span("warning","\The [src.name] doesn't have enough credits stored to complete this operation!"))
				return TRUE
			currency_left -= 0.001*charge_to_add
		C.charge_current = C.charge_max
		caller.to_chat(span("notice","You quickly recharge \the [C.name]."))
		C.update_sprite()
		return TRUE

	if(istype(object,/obj/item/bulletbox))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(5)
		if(!premium)
			caller.to_chat(span("warning","Only non-surplus ammo restockers can restock ammo boxes!"))
			return TRUE
		var/obj/item/bulletbox/B = object
		var/obj/item/bullet_cartridge/bullet_to_create = initial(B.stored_bullet)
		if(!bullet_to_create)
			caller.to_chat(span("warning","The ammo box has no registered cartridge!"))
			return TRUE
		if(B.stored_bullet && B.stored_bullet != bullet_to_create)
			caller.to_chat(span("warning","The ammo box contains a different ammo type than it's registered ammo type!"))
			return TRUE
		var/bullets_to_add = B.bullet_max - B.bullet_count
		if(bullets_to_add <= 0)
			caller.to_chat(span("warning","The [B.name] is already full!"))
			return TRUE
		if(B.next_regen > world.time)
			caller.to_chat(span("warning","That ammo box was just filled! Please wait [CEILING(DECISECONDS_TO_SECONDS(B.next_regen-world.time),1)] seconds!"))
			return TRUE
		if(premium)
			var/value_per_bullet = SSbalance.stored_value[bullet_to_create]
			if(value_per_bullet*bullets_to_add > currency_left)
				caller.to_chat(span("warning","\The [src.name] doesn't have enough credits stored to complete this operation!"))
				return TRUE
			currency_left -= value_per_bullet*bullets_to_add

		B.next_regen = world.time + 120 SECONDS
		B.bullet_count += bullets_to_add
		caller.to_chat(span("notice","The ammo box has been restocked with [bullets_to_add] [initial(bullet_to_create.name)]."))
		return TRUE

	return ..()

/obj/structure/interactive/restocker/ammo/premium
	name = "portable ammo restocker"
	desc = "Warning: Does not contain premium literature."
	desc_extended = "A machine that automatically fills magazines inserted into the machine with regular rounds. Also supports powercells and ammo boxes."
	icon = 'icons/obj/structure/vending.dmi'
	icon_state = "gear2_ammo_premium"
	premium = TRUE
	currency_left = 5000

/obj/structure/interactive/restocker/ammo/premium/get_examine_list(mob/examiner)
	. = ..()
	. += div("notice","This restocker has [currency_left] credits worth of ammo left.")

/obj/structure/interactive/restocker/ammo/premium/anchored
	name = "non-portable ammo restocker"
	anchored = TRUE
	currency_left = 10000
