/mob/living/simple/goblin
	name = "stunted loot goblin"
	desc = "They've come to steal your loot!"
	desc_extended = "A speedy goblin obsessed with loot. Will do anything to get their hands on it, even breaking moral codes!"
	icon = 'icons/mob/living/simple/goblin.dmi'
	icon_state = "living"

	health_base = 200
	stamina_base = 200
	mana_base = 200

	ai = /ai/goblin

	damage_type = /damagetype/unarmed/claw

	armor_base = list(
		ION = INFINITY
	)

	iff_tag = "Goblin"
	loyalty_tag = "Goblin"

	size = SIZE_ANIMAL

	blood_type = /reagent/blood/goblin
	blood_volume = 300

	move_delay = 10

	stun_angle = 90

	var/list/obj/item/bag_contents = list()

	var/loot/intial_loot = /loot/goblin

	soul_size = SOUL_SIZE_COMMON

	level = 4

/mob/living/simple/goblin/Generate()

	if(intial_loot)
		var/loot/L = LOOT(intial_loot)
		if(L)
			var/turf/T = get_turf(src)
			var/list/spawned_loot = CREATE_LOOT(intial_loot,T)
			for(var/k in spawned_loot)
				var/atom/movable/I = k
				add_to_bag(I,silent=TRUE)

	return ..()

/mob/living/simple/goblin/pre_death()
	dump_bag()
	return ..()

/mob/living/simple/goblin/post_death()
	icon_state = "dead"
	return ..()

/mob/living/simple/goblin/Destroy()
	bag_contents?.Cut()
	return ..()

/mob/living/simple/goblin/proc/add_to_bag(var/atom/movable/I,var/silent=FALSE)
	if(isturf(I.loc))
		I.force_move(src)
		bag_contents += I
		if(!silent) visible_message(span("danger","\The [src.name] steals \the [I.name]!"))
	return TRUE

/mob/living/simple/goblin/proc/dump_bag()
	var/turf/T = get_turf(src)
	if(!T)
		return FALSE
	if(!length(bag_contents))
		return FALSE
	visible_message(span("warning","\The [src.name]'s loot bag spills its contents!"))
	for(var/k in bag_contents)
		var/obj/item/I = k
		var/item_move_dir = pick(DIRECTIONS_ALL)
		var/turf/turf_to_move_to = get_step(T,item_move_dir)
		if(!turf_to_move_to)
			turf_to_move_to = T
		I.force_move(turf_to_move_to)

		var/list/pixel_offsets = direction_to_pixel_offset(item_move_dir)
		I.pixel_x = -pixel_offsets[1]*TILE_SIZE
		I.pixel_y = -pixel_offsets[2]*TILE_SIZE
		animate(I,pixel_x=rand(-8,8),pixel_y=rand(-8,8),time=5)

	return TRUE
