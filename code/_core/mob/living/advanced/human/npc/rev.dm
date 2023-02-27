/mob/living/advanced/npc/rev
	name = "revolutionary soldier"
	desc = "FOR THE REVOLUTION!"
	desc_extended = "An ex-nanotrasen revolutionary soldier fighting for their right to \[EXPUNGED\]. Surprisingly, they're not syndicate backed."
	ai = /ai/advanced/slavic

	combat_dialogue = /combat_dialogue/revolutionary

	var/list/possible_outfits = list(
		/loadout/slavic/infantry = 70,
		/loadout/slavic/sniper = 20,
		/loadout/slavic/heavy = 10

	)

	var/loadout_to_level = list(
		/loadout/slavic/infantry = 1,
		/loadout/slavic/sniper = 1.25,
		/loadout/slavic/heavy = 1.25
	)

	dna = /dna/human

	level = 20

/mob/living/advanced/npc/rev/Initialize()
	loadout = pickweight(possible_outfits)
	level *= loadout_to_level[loadout]
	. = ..()

/mob/living/advanced/npc/rev/Finalize()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/revolutionary)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/revolutionary)


/mob/living/advanced/npc/rev/elite
	name = "elite revolutionary soldier"

	possible_outfits = list(
		/loadout/slavic/infantry/advanced = 80,
		/loadout/slavic/sniper/advanced = 20,

	)

	loadout_to_level = list(
		/loadout/slavic/infantry/advanced = 1,
		/loadout/slavic/sniper/advanced = 1.2,
	)

	level = 30

/mob/living/advanced/npc/rev/commander
	name = "elite revolutionary commander"

	possible_outfits = list(
		/loadout/slavic/commander = 1

	)

	loadout_to_level = list(
		/loadout/slavic/commander = 1
	)

	level = 60

/mob/living/advanced/npc/rev/commander/get_damage_received_multiplier(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/damagetype/DT)
	. = ..()
	. *= 0.5