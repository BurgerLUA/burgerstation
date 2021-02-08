/obj/item/magazine/
	name = "weapon magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	var/bullet_count_max = 30 //How many bullets can this store
	var/list/obj/item/bullet_cartridge/stored_bullets

	var/list/weapon_whitelist = list() //What guns can fit this object? Assoic list (type = TRUE/FALSE)

	var/ammo

	size = SIZE_2

	var/bullet_length_min = -1
	var/bullet_length_best = -1
	var/bullet_length_max = -1

	var/bullet_diameter_min = -1
	var/bullet_diameter_best = -1
	var/bullet_diameter_max = -1

	var/icon_states = 1

	weight = 0.25


/obj/item/magazine/update_icon()

	var/icon_num = 1

	if(icon_states)
		var/bullet_num = length(stored_bullets)
		icon_num = min(bullet_num/bullet_count_max,1)*icon_states
		icon_num = FLOOR(icon_num,1)
		if(!icon_num && bullet_num)
			icon_num = 1
		icon_state = "[initial(icon_state)]_[icon_num]"
	else
		icon_state = initial(icon_states)

	return ..()

/obj/item/magazine/save_item_data(var/save_inventory = TRUE)

	. = ..()

	if(length(stored_bullets))
		.["stored_bullets"] = list()
		for(var/i=1,i<=length(stored_bullets),i++)
			var/obj/item/bullet_cartridge/B = stored_bullets[i]
			if(B) .["stored_bullets"][B.type] += 1

	return .

/obj/item/magazine/load_item_data_post(var/mob/living/advanced/player/P,var/list/object_data)

	. = ..()

	if(object_data["stored_bullets"])
		for(var/k in object_data["stored_bullets"])
			var/v = object_data["stored_bullets"][k]
			for(var/i=1,i<=v,i++)
				var/obj/item/bullet_cartridge/B = new k(src)
				INITIALIZE(B)
				FINALIZE(B)
				stored_bullets += B

	return .

/obj/item/magazine/Generate()

	if(ammo)
		for(var/i=1, i <= bullet_count_max, i++)
			var/obj/item/bullet_cartridge/B = new ammo(src)
			INITIALIZE(B)
			FINALIZE(B)
			stored_bullets += B

		update_sprite()

	return ..()

/obj/item/magazine/Destroy()

	for(var/k in stored_bullets)
		if(!k) continue
		var/obj/item/bullet_cartridge/B = k
		qdel(B)

	stored_bullets.Cut()

	return ..()

/obj/item/magazine/PostInitialize()
	. = ..()
	update_sprite()
	return .

/obj/item/magazine/get_examine_list(var/mob/examiner)
	return ..() + div("notice","It contains [length(stored_bullets)] bullets.")

/obj/item/magazine/New()
	stored_bullets = list()
	..()

/obj/item/magazine/proc/get_ammo_count()
	return length(stored_bullets)

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



	if(is_inventory(object) && !(is_dynamic_inventory(src.loc) || is_pocket(src.loc)) && length(stored_bullets))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(1)
		var/obj/hud/inventory/I = object
		var/obj/item/bullet_cartridge/B = stored_bullets[length(stored_bullets)]
		if(I.add_object(B))
			B.update_sprite()
			stored_bullets -= B
			update_sprite()
		return TRUE

	return ..()

/obj/item/magazine/click_self(var/mob/caller)

	if(length(stored_bullets))
		INTERACT_CHECK
		INTERACT_DELAY(1.5)
		var/obj/item/bullet_cartridge/B = stored_bullets[length(stored_bullets)]
		B.drop_item(get_turf(caller))
		B.update_sprite()
		stored_bullets -= B
		update_sprite()
		return TRUE

	return ..()


/obj/item/magazine/proc/get_magazine_insert_sound()
	return length(stored_bullets) ? 'sound/weapons/gun/general/magazine_insert_full.ogg' : 'sound/weapons/gun/general/magazine_insert_empty.ogg'

/obj/item/magazine/proc/get_magazine_eject_sound()
	return length(stored_bullets) ? 'sound/weapons/gun/general/magazine_remove_full.ogg' : 'sound/weapons/gun/general/magazine_remove_empty.ogg'

/obj/item/magazine/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)



	if(is_bullet_gun(object) && !istype(src,/obj/item/magazine/clip))
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
		play_sound(get_magazine_insert_sound(),get_turf(src),range_max=VIEW_RANGE*0.25)
		G.update_sprite()
		return TRUE

	return ..()