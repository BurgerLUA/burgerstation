/obj/structure/interactive/crate
	name = "crate"
	desc = "Freight for hauling."
	desc_extended = "A storage container for storing goodies. Also acts as decent cover in a gunfight."
	icon = 'icons/obj/structure/crates.dmi'
	icon_state = "crate"

	anchored = FALSE
	collision_flags = FLAG_COLLISION_WALKING //Not wall because crawling.
	collision_bullet_flags = FLAG_COLLISION_SPECIFIC
	density = TRUE
	layer = LAYER_OBJ_CRATE

	var/list/crate_contents = list()

	var/open = FALSE

	initialize_type = INITIALIZE_LATE

	bullet_block_chance = 50

	var/max_mob_size = MOB_SIZE_HUMAN

	var/collect_contents_on_initialize = TRUE

	var/loot/loot

	value = 300

	can_rotate = FALSE

/obj/structure/interactive/crate/on_crush()

	for(var/k in contents)
		var/atom/movable/M = k
		M.on_crush()

	return ..()

/obj/structure/interactive/crate/Exit(atom/movable/O, atom/newloc)

	. = ..()

	if(!open)
		open(null)
		return TRUE

	return .

/obj/structure/interactive/crate/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/list/damage_table,var/damage_amount,var/critical_hit_multiplier,var/stealthy=FALSE)

	if(!open && damage_amount > 20 & luck(src,20 + damage_amount,FALSE))
		visible_message(span("warning","\The [src.name] shoots open!"))
		open(null)

	return ..()

/obj/structure/interactive/crate/Cross(var/atom/movable/O)

	if(istype(O,/obj/structure/interactive/crate))
		return FALSE

	if(open)
		return TRUE

	if(!(O.collision_flags && FLAG_COLLISION_ETHEREAL))
		return TRUE

	return ..()

/obj/structure/interactive/crate/Uncross(var/atom/movable/O)

	if(open)
		return TRUE

	return ..()

/obj/structure/interactive/crate/update_icon()
	icon_state = initial(icon_state)
	if(open)
		icon_state = "[icon_state]_open"

	return ..()

/obj/structure/interactive/crate/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(!(caller.attack_flags & CONTROL_MOD_GRAB))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(10)
		toggle(caller)
		return TRUE

	return ..()

/obj/structure/interactive/crate/Generate()

	if(collect_contents_on_initialize && !open)
		for(var/k in loc.contents)
			CHECK_TICK(50,FPS_SERVER)
			var/atom/movable/M = k
			if(M == src || M.anchored)
				continue
			if(M.loc != src.loc)
				continue
			M.force_move(src)
			M.pixel_x = initial(M.pixel_x)
			M.pixel_y = initial(M.pixel_y)
			crate_contents += M

	update_sprite()

	return ..()

/obj/structure/interactive/crate/proc/toggle(var/mob/caller)
	return open ? close(caller) : open(caller)

/obj/structure/interactive/crate/proc/can_store(var/atom/movable/M)
	if(M.anchored)
		return FALSE
	if(istype(M, /mob/living/advanced/player/))
		var/mob/living/advanced/player/playerCorpse = M
		if(playerCorpse.dead)
			visible_message(span("warning", "\The [playerCorpse.name] hilariously looses balance and falls out of the crate!"))
			return FALSE
	return TRUE

/obj/structure/interactive/crate/proc/can_prevent_close(var/atom/movable/M)
	if(is_living(M))
		var/mob/living/L = M
		if(!L.horizontal || L.mob_size > max_mob_size)
			return TRUE
	return FALSE

/obj/structure/interactive/crate/proc/add_to_crate(var/atom/movable/M)
	M.force_move(src)
	M.pixel_x = initial(M.pixel_x)
	M.pixel_y = initial(M.pixel_y)
	crate_contents += M
	return TRUE

/obj/structure/interactive/crate/proc/close(var/mob/caller)

	var/atom/blocking
	for(var/k in loc.contents)
		var/atom/movable/M = k
		if(can_prevent_close(M))
			blocking = M
		break

	if(blocking)
		caller.to_chat(span("warning","\The [blocking.name] is preventing \the [src.name] from being closed!"))
		return FALSE

	for(var/k in loc.contents)
		var/atom/movable/M = k
		CHECK_TICK(50,FPS_SERVER)
		if(M == src)
			continue
		if(M.loc != src.loc)
			continue
		if(!can_store(M))
			continue
		add_to_crate(M)

	open = FALSE

	play_sound('sound/effects/click.ogg',get_turf(src),range_max=VIEW_RANGE)

	update_sprite()

	return TRUE

/obj/structure/interactive/crate/proc/open(var/mob/caller)

	if(loot)
		var/loot/L = LOOT(loot)
		L.do_spawn(src.loc)
		loot = null

	for(var/k in crate_contents)
		CHECK_TICK(50,FPS_SERVER)
		var/atom/movable/M = k
		crate_contents -= M
		M.force_move(src.loc)
		//animate(M,pixel_x = initial(M.pixel_x) + rand(-16,16),pixel_y = initial(M.pixel_y) + rand(-16,16),time = 4)

	open = TRUE

	play_sound('sound/effects/click.ogg',get_turf(src),range_max=VIEW_RANGE)

	update_sprite()

	return TRUE


/obj/structure/interactive/crate/loot
	name = "abandoned supply crate"
	desc = "What could be inside?"

/obj/structure/interactive/crate/loot/Generate()

	switch(rand(1,32))
		if(1 to 2)
			for(var/i=1,i<=rand(2,4),i++)
				CREATE(/obj/item/weapon/ranged/bullet/magazine/pistol/deagle,src.loc)
			for(var/i=1,i<=rand(6,12),i++)
				CREATE(/obj/item/magazine/pistol_50,src.loc)
		if(3)
			for(var/i=1,i<=rand(2,4),i++)
				CREATE(/obj/item/weapon/ranged/bullet/magazine/rifle/assault,src.loc)
			for(var/i=1,i<=rand(6,12),i++)
				CREATE(/obj/item/magazine/rifle_308,src.loc)
		if(4 to 6)
			for(var/i=1,i<=rand(2,4),i++)
				CREATE(/obj/item/weapon/ranged/bullet/magazine/shotgun/bulldog,src.loc)
			for(var/i=1,i<=rand(6,12),i++)
				CREATE(/obj/item/magazine/shotgun_auto,src.loc)
		if(7)
			for(var/i=1,i<=rand(2,4),i++)
				CREATE(/obj/item/weapon/ranged/bullet/revolver/commander,src.loc)
			for(var/i=1,i<=rand(6,12),i++)
				CREATE(/obj/item/magazine/clip/revolver/bullet_44,src.loc)
		if(8 to 10)
			for(var/i=1,i<=rand(2,4),i++)
				CREATE(/obj/item/storage/kit/brute/filled,src.loc)
			for(var/i=1,i<=rand(2,4),i++)
				CREATE(/obj/item/storage/kit/burn/filled,src.loc)
		if(10 to 14)
			for(var/i=1,i<=rand(2,3),i++)
				CREATE(/obj/item/weapon/ranged/bullet/revolver/big_game,src.loc)
			for(var/i=1,i<=rand(6,10),i++)
				CREATE(/obj/item/bullet_cartridge/revolver_300,src.loc)
		if(14 to 18)
			for(var/i=1,i<=rand(4,12),i++)
				CREATE(/obj/item/magazine/rifle_556,src.loc)
		if(18 to 22)
			for(var/i=1,i<=rand(1,3),i++)
				new /mob/living/advanced/npc/beefman(src.loc)
		if(22 to 26)
			for(var/i=1,i<=rand(1,2),i++)
				CREATE(/obj/item/defib,src.loc)
			for(var/i=1,i<=rand(2,4),i++)
				CREATE(/obj/item/storage/kit/filled,src.loc)
		if(26 to 30)
			for(var/i=1,i<=rand(1,3),i++)
				CREATE(/obj/item/container/beaker/bottle/large/health_potion,src.loc)
			for(var/i=1,i<=rand(1,3),i++)
				CREATE(/obj/item/container/beaker/bottle/large/stamina_potion,src.loc)
			for(var/i=1,i<=rand(1,3),i++)
				CREATE(/obj/item/container/beaker/bottle/large/mana_potion,src.loc)
		if(30 to 32)
			for(var/i=1,i<=rand(2,4),i++)
				CREATE(/obj/item/grenade/timed/explosive/,src.loc)


	return ..()
