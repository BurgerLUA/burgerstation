/obj/item/weapon/ranged/bullet

	var/obj/item/bullet_cartridge/chambered_bullet //One in the chamber
	var/list/obj/item/bullet_cartridge/stored_bullets //This is a fixed list, so be careful. Used for shotguns and stuff.

	var/bullet_count_max = 0 //How many bullets can this store on top of the chambered bullet?

	var/icon_state_open = "inventory"

	var/insert_limit = 1 //How many bullets are you allowed to insert at once?

	requires_bullets = TRUE

	empty_sounds = list(
		'sound/weapons/empty1.ogg',
		'sound/weapons/empty2.ogg',
		'sound/weapons/empty3.ogg',
		'sound/weapons/empty4.ogg'
	)

	var/jammed = FALSE

	var/bullet_length_min = -1
	var/bullet_length_best = -1
	var/bullet_length_max = -1

	var/bullet_diameter_min = -1
	var/bullet_diameter_best = -1
	var/bullet_diameter_max = -1

	var/standard_bullet_type //The standard bullet type this weapon normally uses.


/obj/item/weapon/ranged/bullet/save_item_data(var/save_inventory = TRUE)
	. = ..()

	if(src.chambered_bullet) .["chambered_bullet"] = src.chambered_bullet.type

	if(length(src.stored_bullets))
		.["stored_bullets"] = new/list(length(src.stored_bullets))
		for(var/i=1,i<=length(src.stored_bullets),i++)
			var/obj/item/bullet_cartridge/B = src.stored_bullets[i]
			if(B) .["stored_bullets"][i] = B.type

	return .

/obj/item/weapon/ranged/bullet/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()

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

	return .


/obj/item/weapon/ranged/bullet/get_examine_list(var/mob/examiner)

	. = ..()

	if(chambered_bullet)
		. += div("notice","There is a bullet loaded in the chamber.")

	return .

/obj/item/weapon/ranged/bullet/Destroy()
	QDEL_NULL(chambered_bullet)
	QDEL_CUT(stored_bullets)
	return ..()

/obj/item/weapon/ranged/bullet/get_ranged_damage_type()
	return chambered_bullet ? chambered_bullet.damage_type : damage_type


/obj/item/weapon/ranged/bullet/proc/eject_chambered_bullet(var/mob/caller,var/new_loc,var/play_sound=FALSE)

	if(!chambered_bullet)
		return FALSE

	var/obj/item/bullet_cartridge/B = chambered_bullet
	var/jam_chance = B.jam_chance
	if(quality <= 25)
		jam_chance += 10
	if(B.bullet_length != bullet_length_best)
		jam_chance += 10
	if(B.bullet_diameter != bullet_diameter_best)
		jam_chance += 25

	if(jammed)
		if(jam_chance < 100) caller.to_chat(span("notice","You unjam \the [src.name]!"))
		jammed = FALSE
	else if(jam_chance && luck(list(B,src,caller),jam_chance,FALSE))
		if(jam_chance < 100) caller.to_chat(span("danger","\The [src.name] jams!"))
		jammed = TRUE
		return FALSE

	if(B.is_spent && B.caseless)
		qdel(B)
	else
		if(B.is_spent && !ENABLE_BULLET_CASINGS)
			if(B.drop_sound)
				play_sound(B.drop_sound,get_turf(src),range_max=VIEW_RANGE*0.25)
			qdel(B)
		else
			B.drop_item(new_loc)
			B.update_sprite()

	chambered_bullet = null

	return B

/obj/item/weapon/ranged/bullet/proc/eject_stored_bullet(var/mob/caller,var/obj/item/bullet_cartridge/bullet_to_remove,var/new_loc,var/play_sound=FALSE)

	if(!(bullet_to_remove in stored_bullets))
		return FALSE

	stored_bullets -= bullet_to_remove
	bullet_to_remove.drop_item(new_loc)
	bullet_to_remove.update_sprite()
	stored_bullets += null

	if(bullet_to_remove.is_spent && bullet_to_remove.caseless)
		qdel(chambered_bullet)
	else
		if(bullet_to_remove.is_spent && !ENABLE_BULLET_CASINGS)
			if(bullet_to_remove.drop_sound)
				play_sound(bullet_to_remove.drop_sound,get_turf(src),range_max=VIEW_RANGE*0.25)
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

	return .

/obj/item/weapon/ranged/bullet/proc/spend_stored_bullet(var/mob/caller,var/bullet_position = 1)

	if(length(stored_bullets) && stored_bullets[bullet_position]) //Spend a bullet
		var/obj/item/bullet_cartridge/B = stored_bullets[bullet_position]
		var/misfire_chance = 0
		if(B.bullet_length != bullet_length_best)
			misfire_chance += 25
		if(B.bullet_diameter != bullet_diameter_best)
			misfire_chance += 50
		return B.spend_bullet(caller,misfire_chance)


	return null

/obj/item/weapon/ranged/bullet/handle_ammo(var/mob/caller)
	return spend_chambered_bullet(caller)

/obj/item/weapon/ranged/bullet/New()
	. = ..()

	if(bullet_count_max > 0)
		stored_bullets = new/list(bullet_count_max)
	else
		stored_bullets = null

	update_sprite()
	return .

/obj/item/weapon/ranged/bullet/get_ammo_count()
	return chambered_bullet ? 1 : 0

/obj/item/weapon/ranged/bullet/proc/can_load_chamber(var/mob/caller,var/obj/item/bullet_cartridge/B)

	if(chambered_bullet)
		caller?.to_chat(span("warning","There is already a chambered bullet inside \the [src.name]!"))
		return FALSE

	if(B.bullet_length < bullet_length_min)
		caller?.to_chat(span("warning","\The [B.name] is too short to be put inside \the [src.name]!"))
		return FALSE

	if(B.bullet_length > bullet_length_max)
		caller?.to_chat(span("warning","\The [B.name] is too long to be put inside \the [src.name]!"))
		return FALSE

	if(B.bullet_diameter < bullet_diameter_min)
		caller?.to_chat(span("warning","\The [B.name] is too narrow to be put inside \the [src.name]!"))
		return FALSE

	if(B.bullet_diameter > bullet_diameter_max)
		caller?.to_chat(span("warning","\The [B.name] is too wide to be put inside \the [src.name]!"))
		return FALSE

	return TRUE

/obj/item/weapon/ranged/bullet/proc/can_load_stored(var/mob/caller,var/obj/item/bullet_cartridge/B)

	if(!stored_bullets || !length(stored_bullets))
		return FALSE

	if(!open)
		caller?.to_chat(span("warning","You must open \the [src.name] first before loading it!"))
		return FALSE

	if(B.bullet_length < bullet_length_min)
		caller?.to_chat(span("warning","\The [B.name] is too short to be put inside \the [src.name]!"))
		return FALSE

	if(B.bullet_length > bullet_length_max)
		caller?.to_chat(span("warning","\The [B.name] is too long to be put inside \the [src.name]!"))
		return FALSE

	if(B.bullet_diameter < bullet_diameter_min)
		caller?.to_chat(span("warning","\The [B.name] is too narrow to be put inside \the [src.name]!"))
		return FALSE

	if(B.bullet_diameter > bullet_diameter_max)
		caller?.to_chat(span("warning","\The [B.name] is too wide to be put inside \the [src.name]!"))
		return FALSE

	if(get_real_length(stored_bullets) >= length(stored_bullets))
		caller?.to_chat(span("warning","You can't fit any more bullets into \the [src.name]!"))
		return FALSE

	return TRUE