/mob/living/advanced/npc/nanotrasen
	name = "\improper NanoTrasen security personnel"
	desc = "A security team that doesn't like following orders."
	desc_extended = "A low-ranking NanoTrasen soldier tasked with defending the station."
	ai = /ai/advanced/nanotrasen

	loadout = /loadout/nanotrasen/soldier

	dna = /dna/human

	level = 12

/mob/living/advanced/npc/nanotrasen/recruitable
	name = "\improper NanoTrasen security personnel recruit"
	desc = "A security team that actually follows orders!"
	desc_extended = "A low-ranking NanoTrasen soldier tasked with assisting with higher ranking NanoTrasen personnel with missions."

	dialogue_id = /dialogue/npc/soldier/
	loadout = /loadout/nanotrasen/recruit
	ai = /ai/advanced/nanotrasen

	dna = /dna/human

	level = 8


/mob/living/advanced/npc/nanotrasen/Finalize()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/nanotrasen)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/nanotrasen)


/mob/living/advanced/npc/nanotrasen/hanger_guard //For guarding the station against antags.
	name = "\improper NanoTrasen hanger guard"
	loadout = /loadout/nanotrasen/hanger_guard
	level = 40
	ai = /ai/advanced/guarding

/mob/living/advanced/npc/nanotrasen/hanger_guard/get_damage_received_multiplier(atom/attacker,atom/victim,atom/weapon,atom/hit_object,atom/blamed,damagetype/DT)
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