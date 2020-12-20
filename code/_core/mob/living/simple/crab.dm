/mob/living/simple/crab
	name = "crab"
	desc = "Look, sir! Free crabs!"
	desc_extended = "A harmless critter. Or so it may seem."
	icon = 'icons/mob/living/simple/crab.dmi'
	icon_state = "crab"
	damage_type = /damagetype/npc/crab
	class = /class/crab

	health_base = 50
	stamina_base = 25
	mana_base = 25

	value = 25

	butcher_contents = list(
		/obj/item/container/food/dynamic/fish/raw_crab/,
		/obj/item/container/food/dynamic/fish/raw_crab/
	)

	ai = /ai/

	stun_angle = 180

	armor_base = list(
		BLADE = AP_CLUB,
		PIERCE = AP_CLUB,
		HEAT = -AP_CLUB,
		COLD = -AP_CLUB,
		ION = INFINITY
	)

	mob_size = MOB_SIZE_ANIMAL

	movement_delay = DECISECONDS_TO_TICKS(2)

	loyalty_tag = "Crab"
	iff_tag = "Crab"

	blood_type = /reagent/blood/crab
	blood_volume = 200

/mob/living/simple/crab/post_death()
	..()
	icon_state = "[initial(icon_state)]_dead"
	update_sprite()

/mob/living/simple/crab/passive
	ai = /ai/passive/crab
	can_attack_while_moving = FALSE

/mob/living/simple/crab/king
	name = "king crab"
	desc = "A crab this size must be the work of some maniac."
	desc_extended = "A ferocious king crab with massive sharp claws and a thick magic and bullet deflecting outer shell. You'll likely have to get up close and personal in order to crack this crab."
	boss_icon_state = "crab_king"
	icon = 'icons/mob/living/simple/crab_king.dmi'
	icon_state = "king"
	pixel_x = -32
	pixel_y = -12

	health_base = 2500
	stamina_base = 1000
	mana_base = 100

	ai = /ai/

	class = /class/crab/king

	butcher_contents = list(
		/obj/item/container/food/dynamic/fish/raw_crab/,
		/obj/item/container/food/dynamic/fish/raw_crab/,
		/obj/item/container/food/dynamic/fish/raw_crab/,
		/obj/item/container/food/dynamic/fish/raw_crab/,
		/obj/item/container/food/dynamic/fish/raw_crab/,
		/obj/item/container/food/dynamic/fish/raw_crab/,
		/obj/item/container/food/dynamic/fish/raw_crab/
	)


	object_size = 1

	boss = TRUE
	force_spawn = TRUE
	boss_music = /track/crab_rave

	damage_type = /damagetype/npc/crab

	armor_base = list(
		BLADE = AP_GREATSWORD,
		BLUNT = AP_AXE,
		PIERCE = AP_GREATSWORD,
		ARCANE = -AP_SWORD,
		HEAT = -AP_CLUB,
		COLD = -AP_CLUB,
		FATIGUE = INFINITY,
		ION = INFINITY,
		PAIN = INFINITY
	)

	fatigue_from_block_mul = 0

	status_immune = list(
		STUN = TRUE,
		SLEEP = TRUE,
		PARALYZE = TRUE,
		STAMCRIT = TRUE,
		STAGGER = TRUE,
		CONFUSED = TRUE,
		CRIT = TRUE,
		REST = TRUE,
		ADRENALINE = TRUE,
		DISARM = TRUE,
		DRUGGY = TRUE,
		FIRE = TRUE
	)

	enable_medical_hud = FALSE
	enable_security_hud = FALSE

	movement_delay = DECISECONDS_TO_TICKS(3)


/mob/living/simple/crab/king/Cross(atom/movable/O)

	if(istype(O,/mob/living/simple/crab/))
		return TRUE

	return ..()