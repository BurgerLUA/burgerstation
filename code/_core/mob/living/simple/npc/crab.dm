/mob/living/simple/npc/crab
	name = "crab"
	desc = "Look, sir! Free crabs!"
	desc_extended = "A harmless critter. Or so it may seem."
	icon = 'icons/mob/living/simple/crab.dmi'
	icon_state = "crab"
	damage_type = /damagetype/npc/crab
	class = /class/crab

	value = 25

	butcher_contents = list(
		/obj/item/container/food/dynamic/fish/crab/
	)

	ai = /ai/

	stun_angle = 180

	armor_base = list(
		BLADE = 25,
		BLUNT = -25,
		PIERCE = 75,
		LASER = 25,
		MAGIC = 50,
		HEAT = -25,
		COLD = -25,
		BOMB = 50,
		BIO = 25,
		HOLY = 100,
		DARK = 100
	)

	mob_size = MOB_SIZE_ANIMAL

	movement_delay = DECISECONDS_TO_TICKS(2)

/mob/living/simple/npc/crab/post_death()
	..()
	icon_state = "[initial(icon_state)]_dead"
	update_sprite()

/mob/living/simple/npc/crab/passive
	ai = /ai/passive/crab
	can_attack_while_moving = FALSE

/mob/living/simple/npc/crab/king
	name = "king crab"
	desc = "A crab this size must be the work of some maniac."
	desc_extended = "A ferocious king crab with massive sharp claws and a thick magic and bullet deflecting outer shell. You'll likely have to get up close and personal in order to crack this crab."
	id = "crab_king"
	icon = 'icons/mob/living/simple/crab_king.dmi'
	icon_state = "king"
	pixel_x = -32
	pixel_y = -12

	health_base = 3000

	ai = /ai/

	class = /class/crab/king

	butcher_contents = list(
		/obj/item/container/food/dynamic/fish/crab/,
		/obj/item/container/food/dynamic/fish/crab/,
		/obj/item/container/food/dynamic/fish/crab/,
		/obj/item/container/food/dynamic/fish/crab/,
		/obj/item/container/food/dynamic/fish/crab/,
		/obj/item/container/food/dynamic/fish/crab/,
		/obj/item/container/food/dynamic/fish/crab/
	)


	object_size = 1

	boss = TRUE
	force_spawn = TRUE
	boss_music = "crab_rave"

	damage_type = /damagetype/npc/crab/king

	armor_base = list(
		BLADE = 75,
		BLUNT = 75,
		PIERCE = 75,
		LASER = 50,
		MAGIC = 25,
		HEAT = 25,
		COLD = 25,
		BOMB = 75,
		BIO = 25,
		RAD = 25,
		HOLY = 100,
		DARK = 100,
		FATIGUE = INFINITY
	)

	damage_received_multiplier = 0.5

	status_immune = list(
		STUN = STAGGER,
		SLEEP = STAGGER,
		PARALYZE = STAGGER,
		FATIGUE = STAGGER,
		DISARM = TRUE
	)

	enable_medical_hud = FALSE
	enable_security_hud = FALSE


/mob/living/simple/npc/crab/king/Cross(atom/movable/O,var/atom/NewLoc,var/atom/OldLoc)

	if(istype(O,/mob/living/simple/npc/crab/))
		return TRUE

	return ..()