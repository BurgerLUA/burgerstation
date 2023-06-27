/obj/item/magazine/
	name = "weapon magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	var/bullet_count_max = 0 //How many bullets can this store
	var/list/obj/item/bullet_cartridge/stored_bullets = list() //Type to count.

	var/list/weapon_whitelist = list() //What guns can fit this object? Assoic list (type = TRUE/FALSE)

	var/ammo
	var/ammo_surplus //This is given via autorestockers. If none is listed, then it cannot give the ammo.
	var/prem_restock_ammo //What ammo to give at a premium restocker. If not listed, gives the default ammo for that mag.
	size = SIZE_2

	var/bullet_length_min = -1
	var/bullet_length_best = -1
	var/bullet_length_max = -1

	var/bullet_diameter_min = -1
	var/bullet_diameter_best = -1
	var/bullet_diameter_max = -1

	var/icon_states = 1

	var/next_regen = 0 //When we can use this on a bullet restocker again.

	weight = 0.25
	has_quick_function = TRUE //Allows mags to show up in the belt slots.

	rarity = RARITY_COMMON

	value = 0

/obj/item/magazine/quick(var/mob/caller,var/atom/object,location,params)

	if(!is_advanced(caller) || !is_inventory(src.loc))
		return FALSE

	var/mob/living/advanced/A = caller

	return A.put_in_hands(src,params)


/obj/item/magazine/Finalize()
	. = ..()
	update_sprite()

/obj/item/magazine/update_icon()

	if(icon_states && bullet_count_max)
		var/bullet_num = src.get_ammo_count()
		var/icon_num = min(bullet_num/bullet_count_max,1)*icon_states
		icon_num = FLOOR(icon_num,1)
		if(!icon_num && bullet_num)
			icon_num = 1 //This is needed to show there is at least 1 bullet in the magazine.
		icon_state = "[initial(icon_state)]_[icon_num]"
	else
		icon_state = initial(icon_state)

	return ..()

/obj/item/magazine/save_item_data(var/mob/living/advanced/player/P,var/save_inventory = TRUE,var/died=FALSE,var/loadout=FALSE)

	RUN_PARENT_SAFE
	SAVELIST("stored_bullets")

/obj/item/magazine/load_item_data_post(var/mob/living/advanced/player/P,var/list/object_data,var/loadout=FALSE)

	RUN_PARENT_SAFE
	for(var/k in object_data["stored_bullets"])
		stored_bullets[text2path(k)] = object_data["stored_bullets"][k]

/obj/item/magazine/Generate()

	if(ammo)
		stored_bullets[ammo] = bullet_count_max

	return ..()

/obj/item/magazine/PreDestroy()
	stored_bullets.Cut()
	. = ..()

/obj/item/magazine/Finalize()
	. = ..()
	update_sprite()

/obj/item/magazine/get_examine_list(var/mob/examiner)
	var results = div("notice","It contains [get_ammo_count()] bullets.")
	return ..()  + results

/obj/item/magazine/proc/get_ammo_count()
	. = 0
	for(var/k in stored_bullets)
		var/amount = stored_bullets[k]
		. += amount

/obj/item/magazine/proc/can_load_magazine(var/mob/caller,var/obj/item/bullet_cartridge/B)

	if(B.is_spent)
		caller?.to_chat(span("warning","The bullet is spent!"))
		return FALSE

	if(src.bullet_count_max <= src.get_ammo_count())
		caller?.to_chat(span("warning","The magazine is full."))
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

/obj/item/magazine/clicked_on_by_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(is_inventory(object) && length(stored_bullets))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(3)
		var/obj/hud/inventory/I = object
		if(I.drag_to_take)
			var/obj/item/bullet_cartridge/B = pickweight(stored_bullets)
			src.stored_bullets[B] -= 1
			if(stored_bullets[B] <= 0)
				stored_bullets -= B
			B = new B(src)
			INITIALIZE(B)
			B.amount = 1
			FINALIZE(B)
			if(!I.add_object(B))
				B.drop_item(get_turf(caller))
			B.update_sprite()
			update_sprite()

		return TRUE

	. = ..()

/obj/item/magazine/click_self(var/mob/caller,location,control,params)

	if(length(stored_bullets) && is_inventory(loc))
		INTERACT_CHECK
		INTERACT_DELAY(3)
		var/obj/item/bullet_cartridge/B = pickweight(stored_bullets)
		stored_bullets[B] -= 1
		if(stored_bullets[B] <= 0)
			stored_bullets -= B
		B = new B(src)
		INITIALIZE(B)
		B.amount = 1
		FINALIZE(B)
		B.drop_item(get_turf(caller))
		B.update_sprite()
		src.update_sprite()
		return TRUE

	return ..()


/obj/item/magazine/proc/get_magazine_insert_sound()
	return pick(\
		'sound/weapons/ranged/generic/mag_insert1.ogg',\
		'sound/weapons/ranged/generic/mag_insert2.ogg',\
		'sound/weapons/ranged/generic/mag_insert3.ogg',\
		'sound/weapons/ranged/generic/mag_insert4.ogg',\
		'sound/weapons/ranged/generic/mag_insert5.ogg',\
		'sound/weapons/ranged/generic/mag_insert6.ogg',\
		'sound/weapons/ranged/generic/mag_insert7.ogg',\
		'sound/weapons/ranged/generic/mag_insert8.ogg',\
		'sound/weapons/ranged/generic/mag_insert9.ogg'\
	)

/obj/item/magazine/proc/get_magazine_eject_sound()
	return pick(\
		'sound/weapons/ranged/generic/mag_remove1.ogg',\
		'sound/weapons/ranged/generic/mag_remove2.ogg',\
		'sound/weapons/ranged/generic/mag_remove3.ogg',\
		'sound/weapons/ranged/generic/mag_remove4.ogg',\
		'sound/weapons/ranged/generic/mag_remove5.ogg'\
	)

/obj/item/magazine/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(istype(object,/obj/item/weapon/ranged/bullet/) && !istype(src,/obj/item/magazine/clip))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(1)
		var/obj/item/weapon/ranged/bullet/magazine/G = object
		if(!weapon_whitelist[G.type])
			if(caller) caller.to_chat(span("warning","You can't insert this type of magazine into \the [G]!"))
			return TRUE
		if(G.stored_magazine)
			G.eject_magazine(caller)
		src.drop_item(G)
		G.stored_magazine = src
		G.open = FALSE
		play_sound(get_magazine_insert_sound(),get_turf(src),range_max=VIEW_RANGE*0.25,pitch=G.sound_pitch)
		G.update_sprite()
		return TRUE

	return ..()

/obj/item/magazine/gold
	name = "dev magazine"
	icon = 'icons/obj/item/magazine/golden.dmi'
	icon_state = "inventory"

	contraband = TRUE

	value = 0
	value_burgerbux = 1

	bullet_count_max = 30

	icon_states = 0

/obj/item/magazine/gold/can_load_magazine(var/mob/caller,var/obj/item/bullet_cartridge/B)
	return TRUE

/obj/item/magazine/gold/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(istype(object,/obj/item/weapon/ranged/bullet/magazine))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(1)
		var/obj/item/weapon/ranged/bullet/magazine/G = object
		if(G.stored_magazine)
			G.eject_magazine(caller)
		src.drop_item(G)
		G.stored_magazine = src
		G.open = FALSE

		stored_bullets.Cut()

		if(!SSbalance.weapon_to_bullet[G.type])
			caller.to_chat(span("warning","Could not find any valid bullets..."))
		else
			stored_bullets[SSbalance.weapon_to_bullet[G.type]] = bullet_count_max

		play_sound(get_magazine_insert_sound(),get_turf(src),range_max=VIEW_RANGE*0.25,pitch=G.sound_pitch)
		G.update_sprite()

		return TRUE

	return TRUE
