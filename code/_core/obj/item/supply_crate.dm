/obj/item/supply_crate
	name = "supply crate"
	desc = "Hey down there! Supplies!"
	desc_extended = "An old, ancient military supply crate used by various corporations to send shipments across colonies."
	icon = 'icons/obj/structure/supply_crate.dmi'
	icon_state = "supply"

	health = /health/obj/item/misc/

	health_base = 25

	initialize_type = INITIALIZE_LATE
	collision_bullet_flags = FLAG_COLLISION_BULLET_SPECIFIC

	var/loot/loot = /loot/random/low/lots

	var/has_gibs = TRUE

	value = 1 //Dummy value.

	weight = 10

	rarity = RARITY_RARE

/obj/item/supply_crate/get_examine_list(var/mob/examiner)
	. = ..()
	. += span("notice","Attack or throw to open.")


/obj/item/supply_crate/get_base_value()
	if(!loot)
		return 0
	if(!SSloot || !SSloot.initialized)
		return null
	var/loot/L = LOOT(loot)
	return CEILING(L.average_value * 1.25,100)

/obj/item/supply_crate/on_thrown(var/atom/owner,var/atom/hit_atom)
	. = ..()
	if(hit_atom)
		on_destruction()

/obj/item/supply_crate/PostInitialize()
	. = ..()
	pixel_x = rand(-2,2)
	pixel_y = rand(-2,2)


/obj/item/supply_crate/can_be_attacked(var/atom/attacker,var/atom/weapon,var/params,var/damagetype/damage_type)
	return TRUE

/obj/item/supply_crate/on_destruction(var/damage = TRUE)

	var/turf/T = get_turf(src)
	play_sound('sound/effects/crate_break.ogg',T,range_max=VIEW_RANGE)

	if(loot)
		var/rarity = 50
		var/list/spawned_loot = SPAWN_LOOT(loot,T,rarity)
		for(var/k in spawned_loot)
			var/obj/item/I = k
			animate(I,pixel_x = rand(-8,8),pixel_y = rand(-8,8),time=5)

	if(has_gibs)
		for(var/i=1,i<=5,i++)
			new /obj/effect/temp/crate_gib(T,600)

	. = ..()

	qdel(src)


/obj/item/supply_crate/slavic
	loot = /loot/supply_crate/slavic
	icon_state = "supply_slavic"

/obj/item/supply_crate/syndicate
	loot = /loot/supply_crate/syndicate
	icon_state = "supply_syndicate"

/obj/item/supply_crate/solarian
	loot = /loot/supply_crate/solarian
	icon_state = "supply_solarian"

/obj/item/supply_crate/nanotrasen
	loot = /loot/supply_crate/nanotrasen
	icon_state = "supply_nanotrasen"

/obj/item/supply_crate/magic
	loot = /loot/supply_crate/magic
	icon_state = "supply_magic"

/obj/item/supply_crate/medicine
	loot = /loot/supply_crate/medicine
	icon_state = "supply_medicine"