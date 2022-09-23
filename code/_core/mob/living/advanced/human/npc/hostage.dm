/mob/living/advanced/npc/hostage/

	desc = "A very important VIP, also known as a very important Very Important Person. You should escort them back to station."

	dna = /dna/human

	ai = /ai/advanced/hostage
	health_base = 200 //Extra health so the escort mission isn't fucking hell.
	level = 8

	var/hostage = TRUE

/mob/living/advanced/npc/hostage/setup_appearance(var/set_default=FALSE)
	. = ..()
	if(gender == FEMALE && !prob(10))
		loadout = /loadout/hostage/female
	else
		loadout = /loadout/hostage/male

/mob/living/advanced/npc/hostage/Finalize()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/nanotrasen)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/nanotrasen)