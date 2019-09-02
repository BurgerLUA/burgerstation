mob/living/simple/npc/summon
	name = "summon"

	var/mob/living/owner

	var/time_left = 0

	ai = /ai/summon/

mob/living/simple/npc/summon/New(var/loc/spawning_location,var/client/C,var/mob/living/desired_owner,var/desired_time)
	owner = desired_owner
	time_left = desired_time
	name = "[owner.name]'s [initial(name)]"
	. = ..()
	src.factions = desired_owner.factions
	return .

mob/living/simple/npc/summon/on_life()
	..()
	time_left -= 1
	if(time_left <= 0)
		death()

mob/living/simple/npc/summon/holy_warrior
	name = "holy warrior"
	desc = "With an unholy attitude."

	icon = 'icons/mob/living/simple/summons.dmi'
	icon_state = "holy"

	desc_extended = "A common summon among high level prayer users."

	damage_type = "holy_warrior"
