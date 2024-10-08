/mob/living/advanced/npc/syndicate
	name = "syndicate agent"
	desc = "A member of the Syndicate crime organization."
	ai = /ai/advanced/syndicate

	dialogue_id = /dialogue/npc/soldier

	combat_dialogue = /combat_dialogue/syndicate

	dna = /dna/human

	loadout = /loadout/syndicate

	level = 20

/mob/living/advanced/npc/syndicate/Finalize()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/syndicate)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/syndicate)


/mob/living/advanced/npc/syndicate/soldier
	name = "syndicate soldier"
	loadout = /loadout/syndicate/soldier
	level = 30

/mob/living/advanced/npc/syndicate/shotgunnner
	name = "syndicate gunner"
	loadout = /loadout/syndicate/shotgunnner
	level = 40

/mob/living/advanced/npc/syndicate/hardsuit
	name = "syndicate operative"
	loadout = /loadout/syndicate/basic
	level = 60

	health_base = 100
	stamina_base = 100
	mana_base = 100

/mob/living/advanced/npc/syndicate/hardsuit/advanced
	name = "syndicate operative veteran"
	loadout = /loadout/syndicate/advanced
	level = 80

/mob/living/advanced/npc/syndicate/hardsuit/elite
	name = "syndicate operative elite"
	loadout = /loadout/syndicate/elite
	level = 100

/mob/living/advanced/npc/syndicate/hardsuit/ultra
	name = "syndicate operative ultra"
	level = 120

	loadout = /loadout/syndicate/ultra

/mob/living/advanced/npc/syndicate/ultra/get_damage_received_multiplier(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/damagetype/DT)
	. = ..()
	. *= 0.5

/mob/living/advanced/npc/syndicate/scientist
	name = "syndicate scientist"

	loadout = /loadout/syndicate/scientist

	level = 20

	soul_size = SOUL_SIZE_UNCOMMON


/mob/living/advanced/npc/syndicate/wizard
	name = "syndicate spellcaster"

	loadout = /loadout/syndicate/wizard

	level = 30

	soul_size = SOUL_SIZE_UNCOMMON

/mob/living/advanced/npc/syndicate/stress_test
	name = "stress test"
	ai = /ai/advanced/syndicate/stress_test