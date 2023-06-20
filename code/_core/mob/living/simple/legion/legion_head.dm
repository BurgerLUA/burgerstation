/mob/living/simple/legionare_head
	name = "legion head"
	desc = "So no head?"

	ai = /ai/legion_head
	damage_type = /damagetype/npc/legion_assault


	icon = 'icons/mob/living/simple/lavaland/legioner.dmi'
	icon_state = "legion_head"

	var/mob/living/simple/legionare/parent_legion

	movement_delay = DECISECONDS_TO_TICKS(3)

	health_base = 10
	stamina_base = 50
	mana_base = 50

	has_footsteps = FALSE

	iff_tag = "Legion"
	loyalty_tag = "Legion"

	size = SIZE_CRITTER

	blood_type = null

	armor = /armor/legion

	soul_size = null

	level = 2

	delete_on_death = TRUE

	var/can_convert = TRUE

/mob/living/simple/legionare_head/snow
	name = "snowlegion head"
	ai = /ai/snow_legion_head
	damage_type = /damagetype/npc/snowlegion_asault
	icon = 'icons/mob/living/simple/snowlegion.dmi'
	icon_state = "head"
	can_convert = FALSE

/mob/living/simple/legionare_head/death_message()
	return FALSE

/mob/living/simple/legionare_head/PreDestroy()
	. = ..()
	if(parent_legion)
		parent_legion.tracked_heads -= src
		parent_legion = null


/mob/living/simple/legionare_head/proc/convert(var/mob/living/advanced/A)

	if(!can_convert || !A.dead || A.qdeleting || src.qdeleting || !is_turf(A.loc) )
		return FALSE

	A.force_move(src) //Store it before it is stolen.

	var/mob/living/simple/legionare/L = new(get_turf(A))
	L.clone = TRUE
	INITIALIZE(L)
	L.stored_corpse = A
	A.force_move(L)
	GENERATE(L)
	FINALIZE(L)

	death(TRUE)

	return TRUE