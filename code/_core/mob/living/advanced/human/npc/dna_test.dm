/mob/living/advanced/npc/dna_test
	name = "joe"
	dna = /dna/human
	ai = /ai/advanced/nanotrasen

	dialogue_id = /dialogue/npc/soldier/

	level = 10

/mob/living/advanced/npc/dna_test/Generate()
	sex = pick(MALE,FEMALE)
	gender = prob(1) ? pick(MALE,FEMALE) : sex
	if(gender == FEMALE)
		real_name = "Jill"
	else
		real_name = "Joe"
	. = ..()

/mob/living/advanced/npc/dna_test/Finalize()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/nanotrasen)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/nanotrasen)