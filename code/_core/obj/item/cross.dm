/obj/item/cross
	name = "wooden cross"
	desc = "SPIRITS BE GONE."
	desc_extended = "A special wooden cross that prevents ghosts from hunting once, as well as block any unholy things."
	icon = 'icons/obj/item/cross.dmi'
	icon_state = "inventory"

	collision_bullet_flags = FLAG_COLLISION_SPECIFIC

	value = 100

	weight = 3

	var/broken = FALSE

	health = /health/obj/item/misc/

	health_base = 10

/obj/item/cross/save_item_data(var/save_inventory = TRUE)
	. = ..()
	SAVEVAR("broken")
	return .

/obj/item/cross/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADVAR("broken")
	return .

/obj/item/cross/Finalize()
	update_sprite()
	return ..()

/obj/item/cross/on_destruction(var/mob/caller,var/damage = FALSE)

	if(!broken)
		var/turf/T = get_turf(src)
		play_sound('sound/effects/crate_break.ogg',T,range_max=VIEW_RANGE)
		create_alert(VIEW_RANGE,T,caller,ALERT_LEVEL_NOISE)
		broken = TRUE
		update_sprite()

	. = ..()

	return .

/obj/item/cross/update_icon()
	icon_state = initial(icon_state)
	if(broken) icon_state = "[icon_state]_broken"
	return ..()

/obj/item/cross/Cross(var/atom/movable/O)

	if(O.health && icon_state == initial(icon_state))
		var/list/defense = O.health.get_defense(ignore_luck=TRUE)
		if(defense[HOLY] - defense[DARK] < 0)
			return FALSE

	return ..()