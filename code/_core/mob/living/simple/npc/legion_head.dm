/mob/living/simple/npc/legionare_head
	name = "legion head"
	desc = "So no head?"

	ai = /ai/legion_head
	damage_type = /damagetype/npc/legion_assault
	class = /class/passive

	icon = 'icons/mob/living/simple/lavaland/legioner.dmi'
	icon_state = "legion_head"

	var/mob/living/simple/npc/legionare/parent_legion

	movement_delay = DECISECONDS_TO_TICKS(1)

	health_base = 10

	has_footsteps = FALSE

	iff_tag = "Legion"
	loyalty_tag = "Legion"

/mob/living/simple/npc/legionare_head/death_message()
	return FALSE

/mob/living/simple/npc/legionare_head/Destroy()

	if(parent_legion)
		parent_legion.tracked_heads -= src

	parent_legion = null

	return ..()

/mob/living/simple/npc/legionare_head/post_death()
	qdel(src)
	return ..()

/mob/living/simple/npc/legionare_head/proc/convert(var/mob/living/advanced/A)

	if(!A.dead || A.qdeleting || src.qdeleting || !isturf(A.loc) )
		return FALSE //Wew.

	A.force_move(src) //Store it before it is stolen.

	var/mob/living/simple/npc/legionare/L = new(get_turf(A))
	L.clone = TRUE
	INITIALIZE(L)
	L.stored_corpse = A
	A.force_move(L)
	GENERATE(L)
	FINALIZE(L)

	qdel(src)

	return TRUE