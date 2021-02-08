/obj/item/supply_crate
	name = "supply crate"
	desc = "I wonder what is inside?"
	desc_extended = "An old, ancient military supply crate used by various corporations to send shipments across colonies."
	icon = 'icons/obj/structure/supply_crate.dmi'
	icon_state = "supply"

	health = /health/construction/

	health_base = 25

	initialize_type = INITIALIZE_LATE
	collision_bullet_flags = FLAG_COLLISION_SPECIFIC

	var/loot

	var/has_gibs = TRUE

	value = 500

	weight = 10

/obj/item/supply_crate/on_thrown(var/atom/owner,var/atom/hit_atom,var/atom/hit_wall)

	if(hit_wall || hit_atom)
		on_destruction(owner,TRUE)

	return ..()

/obj/item/supply_crate/PostInitialize()
	pixel_x = rand(-2,2)
	pixel_y = rand(-2,2)
	return ..()

/obj/item/supply_crate/can_be_attacked(var/atom/attacker,var/atom/weapon,var/params,var/damagetype/damage_type)
	return TRUE

/obj/item/supply_crate/on_destruction(var/mob/caller,var/damage = FALSE)

	var/turf/T = get_turf(src)
	play_sound('sound/effects/crate_break.ogg',T,range_max=VIEW_RANGE)
	create_alert(VIEW_RANGE,T,caller,ALERT_LEVEL_NOISE)

	if(loot)
		var/list/spawned_loot = CREATE_LOOT(loot,T)
		for(var/k in spawned_loot)
			var/obj/item/I = k
			animate(I,pixel_x = rand(-8,8),pixel_y = rand(-8,8),time=5)

	if(has_gibs)
		for(var/i=1,i<=5,i++)
			new /obj/effect/temp/crate_gib(T,600)

	. = ..()

	qdel(src)

	return .

/obj/item/supply_crate/russian
	loot = /loot/supply_crate/russian
	icon_state = "supply_russian"

/obj/item/supply_crate/syndicate
	loot = /loot/supply_crate/syndicate
	icon_state = "supply_syndicate"

/obj/item/supply_crate/american
	loot = /loot/supply_crate/american
	icon_state = "supply_american"

/obj/item/supply_crate/nanotrasen
	loot = /loot/supply_crate/nanotrasen
	icon_state = "supply_nanotrasen"

/obj/item/supply_crate/magic
	loot = /loot/supply_crate/magic
	icon_state = "supply_magic"
	value = 1000