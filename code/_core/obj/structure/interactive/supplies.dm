/obj/structure/interactive/supplies
	name = "supply crate"
	icon = 'icons/obj/structure/loot.dmi'
	icon_state = "closed"
	bound_width = TILE_SIZE*3

	density = TRUE

	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	var/opened = FALSE

	var/loot/loot = /loot/supply_crate/all

	var/chance_none = 90

/obj/structure/interactive/supplies/Generate()
	. = ..()

	if(prob(chance_none))
		qdel(src)


/obj/structure/interactive/supplies/update_icon()

	if(opened)
		icon_state = "opened"
	else
		icon_state = "closed"

	return ..()

/obj/structure/interactive/supplies/proc/open(var/mob/caller)

	opened = TRUE
	update_sprite()

	if(loot)
		var/rarity = 0
		if(is_player(caller))
			var/mob/living/advanced/player/P = caller
			rarity = P.get_rarity()
		for(var/i=1,i<=3,i++)
			var/turf/actual_turf = locate(x+(i-1),y,z)
			SPAWN_LOOT(loot,actual_turf,rarity)

	return TRUE


/obj/structure/interactive/supplies/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	INTERACT_CHECK
	INTERACT_DELAY(5)

	if(!opened)
		open()
		return TRUE

	return ..()