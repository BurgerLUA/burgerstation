/species/unggoy/
	name = "Unggoy"
	desc = "Small chad."
	id = "unga"
	flags_species = SPECIES_UNGGOY

	bite_size = 5

	flags_chargen = CHARGEN_SEX

	flags_flavor_love = FLAG_FLAVOR_COOKED | FLAG_FLAVOR_CHICKEN | FLAG_FLAVOR_MEAT | FLAG_FLAVOR_FISH | FLAG_FLAVOR_LOVE | FLAG_FLAVOR_JUNK | FLAG_FLAVOR_FAT | FLAG_FLAVOR_DAIRY
	flags_flavor_hate = FLAG_FLAVOR_GROSS | FLAG_FLAVOR_RAW | FLAG_FLAVOR_NECRO | FLAG_FLAVOR_MEDICINE

	default_color_eye = "#FFFFFF"
	default_color_skin = "#FFFFFF"
	default_color_hair = "#FFFFFF"
	default_color_detail = "#FFFFFF"
	default_color_glow = "#FFFFFF"

	emote_sounds_male = list(
		"pain" = list('sound/voice/unggoy/gruntscream_1.ogg','sound/voice/unggoy/gruntscream_2.ogg','sound/voice/unggoy/gruntscream_3.ogg','sound/voice/unggoy/gruntscream_4.ogg','sound/voice/unggoy/gruntscream_5.ogg','sound/voice/unggoy/gruntscream_6.ogg','sound/voice/unggoy/gruntscream_7.ogg'),
		"scream" = list('sound/voice/unggoy/gruntscream_1.ogg','sound/voice/unggoy/gruntscream_2.ogg','sound/voice/unggoy/gruntscream_3.ogg','sound/voice/unggoy/gruntscream_4.ogg','sound/voice/unggoy/gruntscream_5.ogg','sound/voice/unggoy/gruntscream_6.ogg','sound/voice/unggoy/gruntscream_7.ogg')
	)

	emote_sounds_female = list(
		"pain" = list('sound/voice/unggoy/gruntscream_1.ogg','sound/voice/unggoy/gruntscream_2.ogg','sound/voice/unggoy/gruntscream_3.ogg','sound/voice/unggoy/gruntscream_4.ogg','sound/voice/unggoy/gruntscream_5.ogg','sound/voice/unggoy/gruntscream_6.ogg','sound/voice/unggoy/gruntscream_7.ogg'),
		"scream" = list('sound/voice/unggoy/gruntscream_1.ogg','sound/voice/unggoy/gruntscream_2.ogg','sound/voice/unggoy/gruntscream_3.ogg','sound/voice/unggoy/gruntscream_4.ogg','sound/voice/unggoy/gruntscream_5.ogg','sound/voice/unggoy/gruntscream_6.ogg','sound/voice/unggoy/gruntscream_7.ogg')
	)

	spawning_organs_male = list(
		BODY_TORSO = /obj/item/organ/torso/halo/unggoy,
		BODY_HEAD = /obj/item/organ/head/halo/unggoy,
		BODY_GROIN = /obj/item/organ/groin/halo/unggoy,
		BODY_LEG_RIGHT = /obj/item/organ/leg/halo/unggoy,
		BODY_LEG_LEFT = /obj/item/organ/leg/halo/unggoy/left,
		BODY_FOOT_RIGHT = /obj/item/organ/foot/halo/unggoy,
		BODY_FOOT_LEFT = /obj/item/organ/foot/halo/unggoy/left,
		BODY_ARM_RIGHT = /obj/item/organ/arm/halo/unggoy,
		BODY_ARM_LEFT = /obj/item/organ/arm/halo/unggoy/left,
		BODY_HAND_RIGHT = /obj/item/organ/hand/halo/unggoy,
		BODY_HAND_LEFT = /obj/item/organ/hand/halo/unggoy/left,
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

	spawning_organs_female = list(
		BODY_TORSO = /obj/item/organ/torso/halo/unggoy/female,
		BODY_HEAD = /obj/item/organ/head/halo/unggoy/female,
		BODY_GROIN = /obj/item/organ/groin/halo/unggoy/female,
		BODY_LEG_RIGHT = /obj/item/organ/leg/halo/unggoy,
		BODY_LEG_LEFT = /obj/item/organ/leg/halo/unggoy/left,
		BODY_FOOT_RIGHT = /obj/item/organ/foot/halo/unggoy,
		BODY_FOOT_LEFT = /obj/item/organ/foot/halo/unggoy/left,
		BODY_ARM_RIGHT = /obj/item/organ/arm/halo/unggoy,
		BODY_ARM_LEFT = /obj/item/organ/arm/halo/unggoy/left,
		BODY_HAND_RIGHT = /obj/item/organ/hand/halo/unggoy,
		BODY_HAND_LEFT = /obj/item/organ/hand/halo/unggoy/left,
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