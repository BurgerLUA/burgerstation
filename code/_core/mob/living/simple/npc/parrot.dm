/mob/living/simple/npc/parrot
	name = "parrot"
	desc = "SQUAWK!"
	desc_extended = "A basic colorful parrot."
	icon = 'icons/mob/living/simple/parrot.dmi'
	icon_state = "fly"

	damage_type = /damagetype/unarmed/claw/
	class = /class/bear

	health_base = 25

	listener = TRUE

	value = 500

	var/sitting = FALSE

/mob/living/simple/npc/parrot/Finalize()
	post_move(src.loc)
	return ..()

/mob/living/simple/npc/parrot/post_move(var/atom/old_loc)

	if(dead || !isturf(src.loc))
		return ..()

	var/old_sitting = sitting

	for(var/obj/structure/S in loc.contents)
		if(!S.density)
			continue
		if(S.collision_flags & FLAG_COLLISION_WALKING)
			sitting = TRUE
			break

	if(old_sitting != sitting)
		update_sprite()

	return ..()

/mob/living/simple/npc/parrot/post_death()
	update_sprite()
	return ..()

/mob/living/simple/npc/parrot/update_icon()

	if(dead)
		icon_state = "dead"
	else if(sitting)
		icon_state = "sit"
	else
		icon_state = "fly"

	return ..()

/mob/living/simple/npc/parrot/on_listen(var/atom/speaker,var/datum/source,var/text,var/language_text,var/talk_type,var/frequency,var/language =LANGUAGE_BASIC,var/talk_range=TALK_RANGE)

	if(!CALLBACK_EXISTS("\ref[src]_parrot") && length(text) <= 30 && speaker != src && prob(5))
		text = remove_trailing_punctuation(text)
		if(length(text))
			CALLBACK_GLOBAL("\ref[src]_parrot",rand(30,100),.proc/talk,src,src,text,TEXT_TALK,null,language,TALK_RANGE)

	return TRUE

/mob/living/simple/npc/parrot/poly
	name = "Poly"
	desc = "SQUAWK! WIRE THE SOLARS! SQUAWK!"
	desc_extended = "The CE's trusted pet bird."

	loyalty_tag = "NanoTrasen"
	iff_tag = "NanoTrasen"

/mob/living/simple/npc/parrot/poly/setup_name()
	name = initial(name)
	return TRUE