/mob/living/advanced/npc/nanotrasen
	name = "\improper NanoTrasen security personnel"
	desc = "A security team that actually follows orders!"
	desc_extended = "A low-ranking NanoTrasen soldier tasked with defending the station and assisting with higher ranking NanoTrasen personnel with missions."
	ai = /ai/advanced/nanotrasen

	dialogue_id = /dialogue/npc/soldier/
	loadout = /loadout/nanotrasen/soldier

	dna = /dna/human

	level = 8

/mob/living/advanced/npc/nanotrasen/Finalize()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/nanotrasen)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/nanotrasen)


/mob/living/advanced/npc/nanotrasen/hanger_guard //For guarding the station against antags.
	name = "\improper NanoTrasen hanger guard"
	dialogue_id = null
	loadout = /loadout/nanotrasen/hanger_guard
	level = 40
	ai = /ai/advanced/guarding

/mob/living/advanced/npc/nanotrasen/hanger_guard/get_damage_received_multiplier(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/damagetype/DT)
	return ..() * 0.5



/mob/living/advanced/npc/nanotrasen/hanger_guard/immortal
	name = "\improper NanoTrasen arrivals guard"
	loadout = /loadout/nanotrasen/hanger_guard/approachable
	level = 80
	ai = /ai/advanced/guarding
	anchored = 2

/mob/living/advanced/npc/nanotrasen/hanger_guard/immortal/Finalize()
	. = ..()
	add_status_effect(IMMORTAL)



/mob/living/advanced/npc/nanotrasen/shaft_miner
	name = "shaft miner"
	desc = "Someone didn't do their job."
	dialogue_id = null
	loadout = /loadout/shaft_miner

	level = 6