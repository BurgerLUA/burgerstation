/mob/living/advanced/npc/syndicate
	name = "syndicate operative"
	desc = "A member of the Syndicate crime organization."
	ai = /ai/advanced/syndicate

	dialogue_id = /dialogue/npc/soldier

	combat_dialogue = /combat_dialogue/syndicate

	dna = /dna/human

	var/list/possible_outfits = list(
		/loadout/syndicate/soldier = 90,
		/loadout/syndicate/shotgunnner = 20,
		//Hardsuits below.
		/loadout/syndicate/basic = 6,
		/loadout/syndicate/advanced = 3,
		/loadout/syndicate/elite = 1
	)

	var/list/loadout_to_level = list(
		/loadout/syndicate/soldier = 1,
		/loadout/syndicate/shotgunnner = 1.25,
		//Hardsuits below.
		/loadout/syndicate/basic = 2,
		/loadout/syndicate/advanced = 3,
		/loadout/syndicate/elite = 4
	)

	level = 25

/mob/living/advanced/npc/syndicate/Initialize()

	loadout = pickweight(possible_outfits)
	level *= loadout_to_level[loadout]

	. = ..()

/mob/living/advanced/npc/syndicate/Finalize()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/syndicate)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/syndicate)



/mob/living/advanced/npc/syndicate/double
	level = 40

/mob/living/advanced/npc/syndicate/triple
	level = 60

/mob/living/advanced/npc/syndicate/quadruple
	level = 80

/mob/living/advanced/npc/syndicate/stress_test
	name = "stress test"
	ai = /ai/advanced/syndicate/stress_test

/mob/living/advanced/npc/syndicate/scientist
	name = "syndicate scientist"

	possible_outfits = list(
		/loadout/syndicate/scientist = 1
	)
	loadout_to_level = list(
		/loadout/syndicate/scientist = 1
	)

	level = 16

	soul_size = SOUL_SIZE_UNCOMMON


/mob/living/advanced/npc/syndicate/wizard
	name = "syndicate wizard"

	possible_outfits = list(
		/loadout/syndicate/wizard = 1
	)
	loadout_to_level = list(
		/loadout/syndicate/wizard = 1
	)

	level = 24

	soul_size = SOUL_SIZE_UNCOMMON

/mob/living/advanced/npc/syndicate/ultra
	name = "\improper ULTRA syndicate operative"
	level = 100

	health_base = 100
	stamina_base = 100
	mana_base = 100

	possible_outfits = list(
		/loadout/syndicate/ultra = 1
	)

	loadout_to_level = list(
		/loadout/syndicate/ultra = 1
	)
	soul_size = SOUL_SIZE_RARE

/mob/living/advanced/npc/syndicate/ultra/get_damage_received_multiplier(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/damagetype/DT)
	. = ..()
	. *= 0.5

/mob/living/advanced/npc/syndicate/shotgun

	possible_outfits = list(
		/loadout/syndicate/shotgunnner = 20,
	)

	loadout_to_level = list(
		/loadout/syndicate/shotgunnner = 1.25,
	)