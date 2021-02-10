/obj/item/bullet_cartridge/
	name = "bullet"
	desc = "Try not to bite it."
	desc_extended = "Bullets can be put in guns with the matching ammo type."
	rarity = RARITY_COMMON

	icon_state = "bullet"

	var/bullet_length = -1
	var/bullet_diameter = -1

	item_count_max_icon = 1
	item_count_max = 1
	item_count_current = 1 //How many bullets are in this object?

	item_slot = SLOT_GROIN_O
	worn_layer = LAYER_MOB_CLOTHING_BACK

	var/is_spent = FALSE
	var/obj/projectile/projectile //The projectile to create when the bullet is fired. Optional. Overrides the gun's settings.
	var/damage_type_bullet
	var/list/shoot_sounds //The shoots sounds to create when the bullet is fired. Optional. Overrides the gun's settings.
	var/base_spread = 0 //The additional spread of this type of bullet. Optional. Adds to the gun's settings.
	var/projectile_count = 1 //The amount of projectiles shot out of this bullet. Optional. Overrides the gun's settings.
	var/projectile_speed = BULLET_SPEED_PISTOL_HEAVY //The speed of the bullet, in pixels per tick. Optional. Overrides the gun's settings.
	var/bullet_color //The bullet color of the projectile.
	var/inaccuracy_modifer = 1 //The modifer for target doll inaccuracy. Lower values means more accurate.

	var/caseless = FALSE

	var/jam_chance = 0 //Chance to not eject when spent.
	var/misfire_chance = 0 //Chance not to shoot when shot.

	maptext_x = 2
	maptext_y = 2

	size = 0.01

	var/bullet_seed //For icon generation.

	drop_sound = 'sound/items/drop/bullet.ogg'

/obj/item/bullet_cartridge/New(var/desired_loc)
	calculate_weight()
	return ..()

/obj/item/bullet_cartridge/proc/calculate_weight()
	return size*0.25

/obj/item/bullet_cartridge/get_value()

	. = ..()

	if(is_spent)
		. *= 0.05

	return .

/obj/item/bullet_cartridge/proc/get_bullet_insert_sound()
	return 'sound/weapons/gun/general/mag_bullet_insert.ogg'

/obj/item/bullet_cartridge/proc/get_ammo_count()
	return item_count_current

/obj/item/bullet_cartridge/New(var/desired_loc)
	. = ..()
	update_sprite()
	return .

/obj/item/bullet_cartridge/on_drop(var/obj/hud/inventory/old_inventory,var/atom/new_loc,var/silent=FALSE)
	. = ..()
	update_sprite()
	return .

/obj/item/bullet_cartridge/on_pickup(var/atom/old_location,var/obj/hud/inventory/new_location)
	. = ..()
	update_sprite()
	return .

/obj/item/bullet_cartridge/update_icon()

	if(!is_spent)
		icon_state = "[initial(icon_state)]_[min(item_count_max_icon,item_count_current)]"
	else
		icon_state = "[initial(icon_state)]_spent"

	size = initial(size)*item_count_current

	return ..()

/obj/item/bullet_cartridge/update_overlays()

	. = ..()

	if(is_spent)
		if(!bullet_seed)
			bullet_seed = rand(100,999)
		for(var/i=1,i<=min(9,item_count_current-1),i++)
			var/image/I = new(icon,icon_state)
			I.pixel_x = sin(i*bullet_seed)*TILE_SIZE % 16
			I.pixel_y = cos(i*bullet_seed)*TILE_SIZE % 16
			add_overlay(I)

	return .

/obj/item/bullet_cartridge/get_examine_list(var/mob/examiner)

	. = ..()

	if(is_spent)
		. += div("notice","It is spent.")

	if(item_count_current > 1)
		. += div("notice","It contains [item_count_current] [src.name]\s.")

	return .

/obj/item/bullet_cartridge/proc/spend_bullet(var/mob/caller,var/bonus_misfire_chance=0)

	if(!is_spent)
		var/total_misfire_chance = bonus_misfire_chance + misfire_chance
		if(total_misfire_chance && luck(list(caller,src,loc),total_misfire_chance,FALSE))
			return FALSE
		is_spent = TRUE
		plane = PLANE_JUNK
		item_count_max = max(item_count_max,100000) //Some absurd value.
		if(caseless)
			qdel(src)
		return src

	return FALSE

/obj/item/bullet_cartridge/Crossed(atom/movable/O)

	if(is_bullet(O))
		var/obj/item/bullet_cartridge/B = O
		if(!B.qdeleting && B.damage_type_bullet == src.damage_type_bullet && B.is_spent && src.is_spent)
			B.transfer_item_count_to(src)

	return ..()

/obj/item/bullet_cartridge/proc/transfer_src_to_bullet(var/mob/caller as mob,var/obj/item/bullet_cartridge/transfer_target,location,control,params,var/talk = TRUE)

	if(src == transfer_target)
		return FALSE //TODO: THIS USED TO BE TRUE, TEST BULLETS TO SEE IF THIS SHOULD BE TRUE

	if(type != transfer_target.type)
		caller.to_chat(span("notice","It wouldn't be a good idea to mix different bullet types."))
		return FALSE

	var/bullets_to_add = min(item_count_current,transfer_target.item_count_max - transfer_target.get_ammo_count())
	if(!bullets_to_add)
		caller.to_chat(span("notice","You have difficulty holding this many bullets at once."))
		return FALSE

	src.transfer_item_count_to(transfer_target,bullets_to_add)
	if(talk)
		caller.to_chat(span("notice","You add [bullets_to_add] bullet\s into \the [transfer_target] pile."))

	return TRUE

/obj/item/bullet_cartridge/proc/transfer_src_to_magazine(var/mob/caller as mob,var/obj/item/magazine/transfer_target,location,control,params,var/talk = TRUE)

	if(!transfer_target.can_load_magazine(caller,src))
		return FALSE
	//Shitcode ahoy.

	var/bullets_to_add = min(item_count_current,transfer_target.bullet_count_max - transfer_target.get_ammo_count())

	var/should_transfer_self = bullets_to_add == item_count_current

	if(should_transfer_self)
		bullets_to_add--

	if(bullets_to_add)
		add_item_count(-bullets_to_add,TRUE)
		for(var/i=1,i<=bullets_to_add,i++)
			var/obj/item/bullet_cartridge/B = new src.type(transfer_target)
			B.is_spent = is_spent
			INITIALIZE(B)
			FINALIZE(B)
			transfer_target.stored_bullets += B
	if(should_transfer_self)
		src.drop_item(transfer_target)
		transfer_target.stored_bullets += src
	if(talk)
		if(should_transfer_self) bullets_to_add++
		caller.to_chat(span("notice","You insert [bullets_to_add] bullet\s into \the [transfer_target.name]."))
	transfer_target.update_sprite()

	return TRUE

/obj/item/bullet_cartridge/proc/transfer_src_to_gun(var/mob/caller as mob,var/obj/item/weapon/ranged/bullet/W,location,control,params,var/talk = TRUE)

	if(W.can_load_chamber(caller,src))
		if(item_count_current <= 1)
			src.drop_item(W)
			W.chambered_bullet += src
		else
			var/obj/item/bullet_cartridge/B = new src.type(W)
			B.is_spent = is_spent
			INITIALIZE(B)
			FINALIZE(B)
			W.chambered_bullet += B
			add_item_count(-1)
		return TRUE

	if(W.can_load_stored(caller,src))
		var/valid_slot = 0
		for(var/i=1,i<=length(W.stored_bullets),i++)
			if(!W.stored_bullets[i])
				valid_slot = i
				break
		if(valid_slot)
			if(item_count_current <= 1)
				src.drop_item(W)
				W.stored_bullets[valid_slot] = src
			else
				var/obj/item/bullet_cartridge/B = new src.type(W)
				B.is_spent = is_spent
				INITIALIZE(B)
				FINALIZE(B)
				W.stored_bullets[valid_slot] = B
				add_item_count(-1)
			return TRUE

	caller.to_chat(span("warning","You can't load \the [src.name] into \the [W.name]!"))

	return FALSE

/obj/item/bullet_cartridge/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(is_bullet(object))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(1)
		var/obj/item/bullet_cartridge/B = object
		B.transfer_src_to_bullet(caller,src,location,control,params)
		return TRUE

	if(is_magazine(object))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(1)
		var/obj/item/magazine/M = object
		if(transfer_src_to_magazine(caller,M,location,control,params))
			play_sound(get_bullet_insert_sound(),get_turf(src),range_max=VIEW_RANGE*0.25)
		return TRUE

	if(is_bullet_gun(object))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(1)
		var/obj/item/weapon/ranged/bullet/G = object
		if(transfer_src_to_gun(caller,G,location,control,params))
			var/turf/T = get_turf(src)
			play_sound(get_bullet_insert_sound(),T,range_max=VIEW_RANGE*0.25)
			if(istype(object,/obj/item/weapon/ranged/bullet/magazine/))
				var/obj/item/weapon/ranged/bullet/magazine/M = G
				play_sound(M.get_cock_sound("forward"),T,range_max=VIEW_RANGE*0.5)
			return TRUE

	return ..()


/obj/item/bullet_cartridge/can_transfer_stacks_to(var/obj/item/I)

	if(!istype(I,/obj/item/bullet_cartridge/))
		return FALSE

	var/obj/item/bullet_cartridge/BC = I

	if(BC.bullet_length != bullet_length)
		return FALSE

	if(BC.bullet_diameter != bullet_diameter)
		return FALSE

	return ..()
