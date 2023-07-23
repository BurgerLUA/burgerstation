/species/elite/
	name = "Sangheili"
	desc = "Very dangerous enemy."
	id = "Elite"
	flags_species = SPECIES_ELITE

	bite_size = 10

//	flags_chargen = CHARGEN_HAIR | CHARGEN_SEX

	flags_flavor_love = FLAG_FLAVOR_COOKED | FLAG_FLAVOR_CHICKEN | FLAG_FLAVOR_MEAT | FLAG_FLAVOR_FISH | FLAG_FLAVOR_LOVE | FLAG_FLAVOR_JUNK | FLAG_FLAVOR_FAT | FLAG_FLAVOR_DAIRY
	flags_flavor_hate = FLAG_FLAVOR_GROSS | FLAG_FLAVOR_RAW | FLAG_FLAVOR_NECRO | FLAG_FLAVOR_MEDICINE

	default_color_eye = "#FFFFFF"
	default_color_skin = "#FFFFFF"
	default_color_hair = "#FFFFFF"
	default_color_detail = "#FFFFFF"
	default_color_glow = "#FFFFFF"

	emote_sounds_male = list(
		"pain" = list('sound/voice/elite/elitescream_1.ogg','sound/voice/elite/elitescream_2.ogg','sound/voice/elite/elitescream_3.ogg','sound/voice/elite/elitescream_4.ogg','sound/voice/elite/elitescream_5.ogg'),
		"scream" = list('sound/voice/elite/elitescream_6.ogg','sound/voice/elite/elitescream_7.ogg','sound/voice/elite/elitescream_8.ogg','sound/voice/elite/elitescream_9.ogg','sound/voice/elite/elitescream_10.ogg')
	)

	spawning_organs_male = list(
		BODY_TORSO = /obj/item/organ/torso/halo/elite,
		BODY_HEAD = /obj/item/organ/head/halo/elite,
		BODY_GROIN = /obj/item/organ/groin/halo/elite,
		BODY_LEG_RIGHT = /obj/item/organ/leg/halo/elite,
		BODY_LEG_LEFT = /obj/item/organ/leg/halo/elite/left,
		BODY_FOOT_RIGHT = /obj/item/organ/foot/halo/elite,
		BODY_FOOT_LEFT = /obj/item/organ/foot/halo/elite/left,
		BODY_ARM_RIGHT = /obj/item/organ/arm/halo/elite,
		BODY_ARM_LEFT = /obj/item/organ/arm/halo/elite/left,
		BODY_HAND_RIGHT = /obj/item/organ/hand/halo/elite,
		BODY_HAND_LEFT = /obj/item/organ/hand/halo/elite/left,

		BODY_EYE_RIGHT = /obj/item/organ/eye,
		BODY_EYE_LEFT = /obj/item/organ/eye/left,
		BODY_EAR_RIGHT = /obj/item/organ/ear,
		BODY_EAR_LEFT = /obj/item/organ/ear/left,

		BODY_BRAIN = /obj/item/organ/internal/brain,
		BODY_HEART = /obj/item/organ/internal/heart,
		BODY_LUNGS = /obj/item/organ/internal/lungs,
		BODY_STOMACH = /obj/item/organ/internal/stomach,
		BODY_LIVER = /obj/item/organ/internal/liver,
		BODY_INTESTINTES = /obj/item/organ/internal/intestines,
		BODY_KIDNEYS = /obj/item/organ/internal/kidneys

	)