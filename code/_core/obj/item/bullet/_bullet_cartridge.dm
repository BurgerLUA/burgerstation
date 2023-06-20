/obj/item/bullet_cartridge/
	name = "bullet"
	desc = "Try not to bite it."
	desc_extended = "Bullets can be put in guns with the matching ammo type."
	rarity = RARITY_COMMON

	icon_state = "bullet"

	var/bullet_length = -1
	var/bullet_diameter = -1

	amount_max_icon = 1
	amount_max = 1

	worn_layer = LAYER_MOB_CLOTHING_BELT
	item_slot = SLOT_GROIN


	var/is_spent = FALSE
	var/obj/projectile/projectile //The projectile to create when the bullet is fired. Optional. Overrides the gun's settings.
	var/damage_type_bullet
	var/list/shoot_sounds //The shoots sounds to create when the bullet is fired. Optional. Overrides the gun's settings.
	var/base_spread = 0 //The additional spread of this type of bullet. Optional. Adds to the gun's settings.
	var/projectile_count = 1 //The amount of projectiles shot out of this bullet. Optional. Overrides the gun's settings.
	var/projectile_speed = BULLET_SPEED_PISTOL_HEAVY //The speed of the bullet, in pixels per tick. Optional. Overrides the gun's settings.
	var/bullet_color //The bullet color of the projectile.
	var/inaccuracy_modifier = 1 //The modifier for target doll inaccuracy. Lower values means more accurate.
	var/penetrations = 0 //How many additional penetrations this bullet is allowed.
	var/view_punch_mod = 1


	var/caseless = FALSE

	var/override_bullet_insert_sound = FALSE

	var/jam_chance = 0 //Chance to not eject when spent.
	var/misfire_chance = 0 //Chance not to shoot when shot.

	maptext_x = 2
	maptext_y = 2

	size = 0.01

	var/bullet_seed //For icon generation.

	drop_sound = 'sound/items/drop/bullet.ogg'

	var/bullet_insert_sound = 'sound/weapons/ranged/generic/mag_bullet_insert.ogg'

	var/power = 0 //Set in SSweapons.

	var/bulletbox_icon_state = "bullet"

/obj/item/bullet_cartridge/Finalize()
	. = ..()
	update_sprite()

/obj/item/bullet_cartridge/New(var/desired_loc)
	calculate_weight()
	return ..()

/obj/item/bullet_cartridge/proc/calculate_weight()
	return initial(size)*0.25

/obj/item/bullet_cartridge/get_base_value()

	. = SSbalance.stored_value[src.type] ? SSbalance.stored_value[src.type] : 1

	if(is_spent)
		. *= 0.05

	. = max(0.01,.)

/obj/item/bullet_cartridge/proc/get_ammo_count()
	return amount

/obj/item/bullet_cartridge/New(var/desired_loc)
	. = ..()
	update_sprite()

/obj/item/bullet_cartridge/on_unequip(var/obj/hud/inventory/old_inventory,var/silent=FALSE)
	. = ..()
	update_sprite()

/obj/item/bullet_cartridge/on_equip(var/atom/old_location,var/silent=FALSE)
	. = ..()
	update_sprite()

/obj/item/bullet_cartridge/update_icon()

	if(!is_spent)
		icon_state = "[initial(icon_state)]_[min(amount_max_icon,amount)]"
	else
		icon_state = "[initial(icon_state)]_spent"

	size = initial(size)*amount

	return ..()

/obj/item/bullet_cartridge/update_overlays()

	. = ..()

	if(is_spent)
		if(!bullet_seed)
			bullet_seed = rand(100,999)
		for(var/i=1,i<=min(9,amount-1),i++)
			var/image/I = new(icon,icon_state)
			I.pixel_x = sin(i*bullet_seed)*TILE_SIZE % TILE_SIZE*0.5
			I.pixel_y = cos(i*bullet_seed)*TILE_SIZE % TILE_SIZE*0.5
			add_overlay(I)


/obj/item/bullet_cartridge/get_examine_list(var/mob/examiner)

	. = ..()

	if(is_spent)
		. += div("notice","It is spent.")

	if(amount > 1)
		. += div("notice","It contains [amount] [src.name]\s.")


/obj/item/bullet_cartridge/proc/spend_bullet(var/mob/caller,var/bonus_misfire_chance=0)

	if(!is_spent)
		var/total_misfire_chance = bonus_misfire_chance + misfire_chance
		if(total_misfire_chance && luck(list(caller,src,loc),total_misfire_chance,FALSE))
			return FALSE
		is_spent = TRUE
		plane = PLANE_JUNK
		amount_max = max(amount_max,100000) //Some absurd value.
		if(caseless)
			qdel(src)
		return src

	return FALSE

/obj/item/bullet_cartridge/Crossed(atom/movable/O,atom/OldLoc)

	if(!O.qdeleting && istype(O,/obj/item/bullet_cartridge/))
		var/obj/item/bullet_cartridge/B = O
		if(B.damage_type_bullet == src.damage_type_bullet && B.is_spent && src.is_spent)
			B.transfer_amount_to(src)

	return ..()

/obj/item/bullet_cartridge/proc/transfer_src_to_bullet(var/mob/caller as mob,var/obj/item/bullet_cartridge/transfer_target,location,control,params,var/talk = TRUE)

	if(src == transfer_target)
		return FALSE

	if(src.type != transfer_target.type)
		return FALSE

	var/bullets_to_add = min(amount,transfer_target.amount_max - transfer_target.get_ammo_count())
	if(bullets_to_add <= 0)
		caller.to_chat(span("notice","You have difficulty holding this many bullets at once."))
		return FALSE

	src.transfer_amount_to(transfer_target,bullets_to_add)
	if(talk)
		caller.to_chat(span("notice","You add [bullets_to_add] bullet\s into \the [transfer_target] pile."))

	return TRUE

/obj/item/bullet_cartridge/proc/transfer_src_to_magazine(var/mob/caller as mob,var/obj/item/magazine/transfer_target,location,control,params,var/messages = TRUE)

	if(!transfer_target.can_load_magazine(caller,src))
		return FALSE

	var/bullets_to_add = min(amount,transfer_target.bullet_count_max - transfer_target.get_ammo_count())
	if(bullets_to_add <= 0)
		return FALSE

	if(bullets_to_add > 0)
		src.add_item_count(-bullets_to_add,TRUE)
		transfer_target.stored_bullets[src.type] += bullets_to_add
		transfer_target.update_sprite()

	if(messages)
		caller.to_chat(span("notice","You insert [bullets_to_add] bullet\s into \the [transfer_target.name]."))

	return TRUE

/obj/item/bullet_cartridge/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(is_magazine(object))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(1)
		var/obj/item/magazine/M = object
		if(transfer_src_to_magazine(caller,M,location,control,params))
			play_sound(bullet_insert_sound,get_turf(object),range_max=VIEW_RANGE*0.25)
		return TRUE

	if(is_ranged_bullet_weapon(object))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(1)
		var/obj/item/weapon/ranged/bullet/G = object
		if(caller.attack_flags & CONTROL_MOD_DISARM && istype(G.attachment_undermount,/obj/item/attachment/undermount/gun))
			var/obj/item/attachment/undermount/gun/AG = G.attachment_undermount
			G = AG.stored_gun

		if(G.bullet_time > 0)
			PROGRESS_BAR(caller,G,G.bullet_time,/obj/item/weapon/ranged/bullet/proc/accept_bullet,caller,src)
			PROGRESS_BAR_CONDITIONS(caller,src,src::can_load_bullet_into(),caller,G)
		else
			G.accept_bullet(caller,src)

		return TRUE

	. = ..()

/obj/item/bullet_cartridge/proc/can_load_bullet_into(var/mob/caller,var/obj/item/weapon/ranged/bullet/G) //Only used for bullettime. This feels like shitcode but whatever.
	return src.can_caller_interact_with(caller,delay_checks=FALSE) && G.can_caller_interact_with(caller,delay_checks=FALSE)


/obj/item/bullet_cartridge/can_transfer_stacks_to(var/obj/item/target)

	if(target == src)
		return FALSE

	if(target.amount_max <= 1)
		return FALSE

	if(src.amount_max <= 1)
		return FALSE

	if(target.amount >= target.amount_max)
		return FALSE

	if(!istype(target,/obj/item/bullet_cartridge/))
		return FALSE

	var/obj/item/bullet_cartridge/BC = target

	if(BC.bullet_length != bullet_length)
		return FALSE

	if(BC.bullet_diameter != bullet_diameter)
		return FALSE

	return TRUE

/obj/item/bullet_cartridge/proc/get_recommended_value(var/debug=FALSE)

	if(!damage_type_bullet)
		return 0

	var/damagetype/D = all_damage_types[damage_type_bullet]
	if(!D) return 0

	//https://www.desmos.com/calculator/qgzesfmsl1
	. = (D.get_damage_per_hit(0)*0.1 + D.get_damage_per_hit(100)*0.2 + D.get_damage_per_hit(200)*0.7) * projectile_count
	. *= 0.5 + (D.falloff/VIEW_RANGE)*0.5 //Falloff.
	. *= 0.75 + (projectile_speed/TILE_SIZE)*0.25 //Speed
	. *= 0.75 + 0.25*(1- (base_spread/0.1)) //Spread
	. *= 1 + max(0,1-inaccuracy_modifier)*0.5 //Inaccuracy
	. *= 0.1 + min(max(0,1 - (jam_chance + misfire_chance)/50),0.9) //Reliability.
	. *= 0.04
	. += ((bullet_length*bullet_diameter)/(9*19))*1 //Material costs.
