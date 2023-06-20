/obj/item/weapon/ranged/bullet

	var/obj/item/bullet_cartridge/chambered_bullet //One in the chamber
	var/list/obj/item/bullet_cartridge/stored_bullets //This is a fixed list, so be careful. Used for shotguns and stuff.

	var/bullet_count_max = 0 //How many bullets can this store on top of the chambered bullet?

	var/icon_state_open = "inventory"

	var/insert_limit = 1 //How many bullets are you allowed to insert at once?

	requires_bullets = TRUE

	empty_sounds = list(
		'sound/weapons/ranged/generic/empty1.ogg',
		'sound/weapons/ranged/generic/empty2.ogg',
		'sound/weapons/ranged/generic/empty3.ogg',
		'sound/weapons/ranged/generic/empty4.ogg'
	)

	var/jammed = FALSE

	var/bullet_length_min = -1
	var/bullet_length_best = -1
	var/bullet_length_max = -1

	var/bullet_diameter_min = -1
	var/bullet_diameter_best = -1
	var/bullet_diameter_max = -1

	uses_until_condition_fall = 50 // ~5000 rounds.

	use_iff_tag = TRUE

	var/bullet_time = 0 //Not slow-mo, but how long it takes to insert a bullet into the gun.

	var/sound_pitch = 1

/obj/item/weapon/ranged/bullet/Finalize()
	. = ..()
	uses_until_condition_fall = 50 * (1/shoot_delay)
	sound_pitch = get_sound_pitch()

/obj/item/weapon/ranged/bullet/PreDestroy()
	QDEL_NULL(chambered_bullet)
	QDEL_CUT(stored_bullets)
	return ..()

obj/item/weapon/ranged/bullet/handle_empty(var/mob/caller)
	if(length(empty_sounds))
		var/turf/T = get_turf(src)
		play_sound(pick(empty_sounds),T,range_max = VIEW_RANGE*0.5,pitch=sound_pitch)
	return FALSE


/obj/item/weapon/ranged/bullet/proc/get_sound_pitch() //For cocking and reloads.

	var/low_end = 4.6*30
	var/high_end = 20*117

	var/result = SCALE(bullet_length_best*bullet_diameter_best,low_end,high_end)

	return 0.25 + clamp(1-result,0.25,1)*0.75

/obj/item/weapon/ranged/bullet/proc/accept_bullet(var/mob/caller as mob,var/obj/item/bullet_cartridge/B,var/silent=FALSE)

	if(can_load_chamber(caller,B))
		if(B.amount <= 1)
			B.drop_item(src)
			src.chambered_bullet += B
		else
			var/obj/item/bullet_cartridge/B2 = new B.type(src)
			B2.is_spent = B.is_spent
			INITIALIZE(B2)
			B2.amount = 1
			FINALIZE(B2)
			src.chambered_bullet += B2
			B.add_item_count(-1)
		. = TRUE

	else if(src.can_load_stored(caller,B))
		for(var/i=1,i<=length(src.stored_bullets),i++)
			if(src.stored_bullets[i])
				continue
			if(B.amount <= 1)
				B.drop_item(src)
				src.stored_bullets[i] = B
			else
				var/obj/item/bullet_cartridge/B2 = new B.type(src)
				B2.is_spent = B.is_spent
				INITIALIZE(B2)
				B2.amount = 1
				FINALIZE(B2)
				src.stored_bullets[i] = B2
				B.add_item_count(-1)
			. = TRUE
			break

	if(!silent)
		if(.)
			var/turf/T = get_turf(src)
			play_sound(B.bullet_insert_sound,T,range_max=VIEW_RANGE*0.25,pitch=sound_pitch)
			if(istype(src,/obj/item/weapon/ranged/bullet/magazine/))
				var/obj/item/weapon/ranged/bullet/magazine/M = src
				play_sound(M.get_cock_sound("forward"),T,range_max=VIEW_RANGE*0.5,pitch=sound_pitch)
		else
			caller?.to_chat(span("warning","You can't load \the [B.name] into \the [src.name]!"))

	return .





/obj/item/weapon/ranged/bullet/save_item_data(var/mob/living/advanced/player/P,var/save_inventory = TRUE,var/died=FALSE,var/loadout=FALSE)

	RUN_PARENT_SAFE

	if(src.chambered_bullet) .["chambered_bullet"] = src.chambered_bullet.type

	if(length(src.stored_bullets))
		.["stored_bullets"] = new/list(length(src.stored_bullets))
		for(var/i=1,i<=length(src.stored_bullets),i++)
			var/obj/item/bullet_cartridge/B = src.stored_bullets[i]
			if(B) .["stored_bullets"][i] = B.type


/obj/item/weapon/ranged/bullet/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data,var/loadout=FALSE)

	RUN_PARENT_SAFE

	if(object_data["chambered_bullet"])
		var/b_type = object_data["chambered_bullet"]
		var/obj/item/bullet_cartridge/B = new b_type(src)
		INITIALIZE(B)
		FINALIZE(B)
		src.chambered_bullet = B

	if(object_data["stored_bullets"] && length(object_data["stored_bullets"]))
		for(var/i=1, i <= length(object_data["stored_bullets"]), i++)
			var/b_type = object_data["stored_bullets"][i]
			if(b_type)
				var/obj/item/bullet_cartridge/B = new b_type(src)
				INITIALIZE(B)
				FINALIZE(B)
				src.stored_bullets[i] = B



/obj/item/weapon/ranged/bullet/get_examine_list(var/mob/examiner)

	. = ..()

	if(chambered_bullet)
		. += div("notice","There is a bullet loaded in the chamber.")

/obj/item/weapon/ranged/bullet/get_ranged_damage_type()
	return chambered_bullet ? chambered_bullet.damage_type : null


/obj/item/weapon/ranged/bullet/proc/eject_chambered_bullet(var/mob/caller,var/atom/new_loc,var/play_sound=FALSE)

	if(!chambered_bullet)
		return FALSE

	var/obj/item/bullet_cartridge/B = chambered_bullet
	var/jam_chance = B.jam_chance
	if(B.bullet_length != bullet_length_best)
		jam_chance += 10
	if(B.bullet_diameter != bullet_diameter_best)
		jam_chance += 25

	if(B.jam_chance < 100)
		jam_chance *= 0.1 + 0.9*(heat_max ? heat_current/heat_max : 0)

	if(jammed)
		if(B.jam_chance < 100) caller.to_chat(span("notice","You unjam \the [src.name]!"))
		jammed = FALSE
	else if(jam_chance && luck(list(B,src,caller),jam_chance,FALSE))
		if(B.jam_chance < 100) caller.to_chat(span("danger","\The [src.name] jams!"))
		jammed = TRUE
		return FALSE

	if(B.is_spent && !CONFIG("ENABLE_BULLET_CASINGS",FALSE))
		qdel(B)
	else
		B.drop_item(new_loc)
		B.update_sprite()

	chambered_bullet = null

	return TRUE

/obj/item/weapon/ranged/bullet/proc/eject_stored_bullet(var/mob/caller,var/obj/item/bullet_cartridge/bullet_to_remove,var/new_loc,var/play_sound=FALSE)

	if(!(bullet_to_remove in stored_bullets))
		return FALSE

	stored_bullets -= bullet_to_remove
	bullet_to_remove.drop_item(new_loc)
	bullet_to_remove.update_sprite()
	stored_bullets += null

	if(bullet_to_remove.is_spent && !CONFIG("ENABLE_BULLET_CASINGS",FALSE))
		if(bullet_to_remove.drop_sound)
			play_sound(bullet_to_remove.drop_sound,get_turf(src),range_max=VIEW_RANGE*0.25,pitch=sound_pitch)
		qdel(bullet_to_remove)
	else
		bullet_to_remove.drop_item(new_loc)
		bullet_to_remove.update_sprite()

	return bullet_to_remove


/obj/item/weapon/ranged/bullet/proc/eject_stored_bullets(var/mob/caller,var/new_loc,var/play_sound=FALSE)

	for(var/k in stored_bullets)
		if(!k) continue
		var/obj/item/bullet_cartridge/B = k
		eject_stored_bullet(caller,B,new_loc,play_sound)

	return TRUE

/obj/item/weapon/ranged/bullet/proc/eject_stored_bullets_spent(var/mob/caller,var/new_loc,var/play_sound=FALSE)

	for(var/k in stored_bullets)
		if(!k) continue
		var/obj/item/bullet_cartridge/B = k
		if(!B.is_spent)
			continue
		eject_stored_bullet(caller,B,new_loc,play_sound)

	return TRUE

/obj/item/weapon/ranged/bullet/proc/spend_chambered_bullet(var/mob/caller)

	if(!chambered_bullet || chambered_bullet.is_spent)
		return FALSE

	var/misfire_chance = 0
	if(chambered_bullet.bullet_length != bullet_length_best)
		misfire_chance += 25
	if(chambered_bullet.bullet_diameter != bullet_diameter_best)
		misfire_chance += 50

	. = chambered_bullet.spend_bullet(caller,misfire_chance)

	if(chambered_bullet.qdeleting)
		chambered_bullet = null


/obj/item/weapon/ranged/bullet/proc/spend_stored_bullet(var/mob/caller,var/bullet_position = 1)

	if(!length(stored_bullets) || !stored_bullets[bullet_position])
		return FALSE

	var/obj/item/bullet_cartridge/B = stored_bullets[bullet_position]

	var/misfire_chance = 0
	if(B.bullet_length != bullet_length_best)
		misfire_chance += 25
	if(B.bullet_diameter != bullet_diameter_best)
		misfire_chance += 50

	. = B.spend_bullet(caller,misfire_chance)

	if(. && B.qdeleting)
		stored_bullets[bullet_position] = null

/obj/item/weapon/ranged/bullet/handle_ammo(var/mob/caller)
	return spend_chambered_bullet(caller)

/obj/item/weapon/ranged/bullet/New()
	. = ..()

	if(bullet_count_max > 0)
		stored_bullets = new/list(bullet_count_max)
	else
		stored_bullets = null

	update_sprite()

/obj/item/weapon/ranged/bullet/get_ammo_count()
	return chambered_bullet ? 1 : 0

/obj/item/weapon/ranged/bullet/proc/can_load_chamber(var/mob/caller,var/obj/item/bullet_cartridge/B) //B can be a type or a path.

	if(chambered_bullet)
		caller?.to_chat(span("warning","There is already a chambered bullet inside \the [src.name]!"))
		return FALSE

	if(!can_fit_bullet(B))
		caller?.to_chat(span("warning","\The [initial(B.name)] can't fit inside \the [src.name]!"))
		return FALSE

	return TRUE

/obj/item/weapon/ranged/bullet/proc/can_fit_bullet(var/obj/item/bullet_cartridge/B) //B can be a type or a path

	if(!B)
		return FALSE

	if(istype(B) && B.is_spent)
		return FALSE

	if(initial(B.bullet_length) < bullet_length_min)
		return FALSE

	if(initial(B.bullet_length) > bullet_length_max)
		return FALSE

	if(initial(B.bullet_diameter) < bullet_diameter_min)
		return FALSE

	if(initial(B.bullet_diameter) > bullet_diameter_max)
		return FALSE

	return TRUE


/obj/item/weapon/ranged/bullet/proc/can_load_stored(var/mob/caller,var/obj/item/bullet_cartridge/B)

	if(!stored_bullets || !length(stored_bullets))
		return FALSE

	if(!can_fit_bullet(B))
		caller?.to_chat(span("warning","\The [initial(B.name)] cannot fit inside \the [src.name]!"))
		return FALSE

	if(!open)
		caller?.to_chat(span("warning","You must open \the [src.name] first before loading it!"))
		return FALSE

	if(get_real_length(stored_bullets) >= length(stored_bullets))
		caller?.to_chat(span("warning","You can't fit any more bullets into \the [src.name]!"))
		return FALSE

	return TRUE