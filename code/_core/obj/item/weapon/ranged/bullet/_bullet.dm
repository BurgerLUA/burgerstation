/obj/item/weapon/ranged/bullet

	var/obj/item/bullet_cartridge/chambered_bullet //One in the chamber
	var/list/obj/item/bullet_cartridge/stored_bullets //This is a fixed list, so be careful.

	var/bullet_count_max = 0 //How many bullets can this store on top of the chambered bullet

	var/icon_state_open = "inventory"

	var/insert_limit = 1 //How many bullets are you allowed to insert at once?

	requires_bullets = TRUE

	empty_sounds = list(
		'sounds/weapons/empty1.ogg',
		'sounds/weapons/empty2.ogg',
		'sounds/weapons/empty3.ogg',
		'sounds/weapons/empty4.ogg'
	)

	var/jammed = FALSE

	var/bullet_length_min = -1
	var/bullet_length_best = -1
	var/bullet_length_max = -1

	var/bullet_diameter_min = -1
	var/bullet_diameter_best = -1
	var/bullet_diameter_max = -1


/obj/item/weapon/ranged/bullet/Destroy()

	qdel(chambered_bullet)
	chambered_bullet = null

	if(stored_bullets) //Sometimes this doesn't exist.
		for(var/obj/item/bullet_cartridge/B in stored_bullets)
			qdel(B)

		stored_bullets.Cut()

	return ..()

/obj/item/weapon/ranged/bullet/get_damage_type()
	return chambered_bullet ? chambered_bullet.damage_type : damage_type


/obj/item/weapon/ranged/bullet/proc/eject_chambered_bullet(var/mob/caller,var/new_loc)

	if(!chambered_bullet)
		return FALSE

	var/obj/item/bullet_cartridge/B = chambered_bullet

	if(jammed)
		caller.to_chat(span("notice","You unjam \the [src.name]!"))
		jammed = FALSE
	else if(B.jam_chance && prob(B.jam_chance))
		caller.to_chat(span("danger","\The [src.name] jams!"))
		jammed = TRUE
		return FALSE

	B.force_move(new_loc)
	B.update_icon()

	chambered_bullet = null

	return B

/obj/item/weapon/ranged/bullet/proc/eject_stored_bullets(var/mob/caller,var/new_loc)

	for(var/obj/item/bullet_cartridge/B in stored_bullets)
		eject_stored_bullet(caller,B,new_loc)

	return TRUE

/obj/item/weapon/ranged/bullet/proc/eject_stored_bullets_spent(var/mob/caller,var/new_loc)

	for(var/obj/item/bullet_cartridge/B in stored_bullets)
		if(!B.is_spent)
			continue
		eject_stored_bullet(caller,B,new_loc)

	return TRUE

/obj/item/weapon/ranged/bullet/proc/eject_stored_bullet(var/mob/caller,var/obj/item/bullet_cartridge/bullet_to_remove,var/new_loc)

	if(!(bullet_to_remove in stored_bullets))
		return FALSE

	stored_bullets -= bullet_to_remove
	bullet_to_remove.force_move(new_loc)
	bullet_to_remove.update_icon()
	stored_bullets += null

	return bullet_to_remove

/obj/item/weapon/ranged/bullet/proc/spend_chambered_bullet(var/mob/caller)

	if(!chambered_bullet || chambered_bullet.is_spent)
		return FALSE

	return chambered_bullet.spend_bullet(caller,is_npc(caller))

/obj/item/weapon/ranged/bullet/proc/spend_stored_bullet(var/mob/caller,var/bullet_position = 1)

	if(length(stored_bullets) && stored_bullets[bullet_position]) //Spend a bullet
		var/obj/item/bullet_cartridge/B = stored_bullets[bullet_position]
		B = B.spend_bullet(caller,is_npc(caller))
		return B

	return FALSE

/obj/item/weapon/ranged/bullet/handle_ammo(var/mob/caller)
	return spend_chambered_bullet(caller)

/obj/item/weapon/ranged/bullet/New()
	. = ..()

	if(bullet_count_max)
		stored_bullets = new/list(bullet_count_max)

	update_icon()
	return .

/obj/item/weapon/ranged/bullet/get_ammo_count()
	return chambered_bullet ? 1 : 0

/obj/item/weapon/ranged/bullet/proc/can_load_chamber(var/mob/caller,var/obj/item/bullet_cartridge/B)

	if(chambered_bullet)
		caller.to_chat(span("notice","There is already a chambered bullet inside \the [src.name]!"))
		return FALSE

	if(B.bullet_length < bullet_length_min)
		caller.to_chat(span("notice","\The [B.name] is too short to be put inside \the [src.name]!"))
		return FALSE

	if(B.bullet_length > bullet_length_max)
		caller.to_chat(span("notice","\The [B.name] is too long to be put inside \the [src.name]!"))
		return FALSE

	if(B.bullet_diameter < bullet_diameter_min)
		caller.to_chat(span("notice","\The [B.name] is too narrow to be put inside \the [src.name]!"))
		return FALSE

	if(B.bullet_diameter > bullet_diameter_max)
		caller.to_chat(span("notice","\The [B.name] is too wide to be put inside \the [src.name]!"))
		return FALSE

	return TRUE

/obj/item/weapon/ranged/bullet/proc/can_load_stored(var/mob/caller,var/obj/item/bullet_cartridge/B)

	if(!open)
		caller.to_chat(span("notice","You must open \the [src.name] first before loading it!"))
		return FALSE

	if(B.bullet_length < bullet_length_min)
		caller.to_chat(span("notice","\The [B.name] is too short to be put inside \the [src.name]!"))
		return FALSE

	if(B.bullet_length > bullet_length_max)
		caller.to_chat(span("notice","\The [B.name] is too long to be put inside \the [src.name]!"))
		return FALSE

	if(B.bullet_diameter < bullet_diameter_min)
		caller.to_chat(span("notice","\The [B.name] is too narrow to be put inside \the [src.name]!"))
		return FALSE

	if(B.bullet_diameter > bullet_diameter_max)
		caller.to_chat(span("notice","\The [B.name] is too wide to be put inside \the [src.name]!"))
		return FALSE

	if(get_real_length(stored_bullets) >= length(stored_bullets))
		caller.to_chat(span("notice","You can't fit any more bullets into \the [src.name]!"))
		return FALSE

	return TRUE