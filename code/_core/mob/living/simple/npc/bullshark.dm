/mob/living/simple/npc/bullshark
	name = "bullshark"
	icon = 'icons/mob/living/simple/bullshark.dmi'
	icon_state = "living"

	health_base = 500

	ai = /ai/bullshark
	class = /class/bull
	damage_type = /damagetype/unarmed/bite/

/mob/living/simple/npc/bullshark/post_death()
	. = ..()
	icon_state = "dead"
	return .

