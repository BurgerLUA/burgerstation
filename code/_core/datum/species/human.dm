/species/human/
	name = "Human"
	desc = "Vanilla as fuck."
	id = "human"
	flags_species = SPECIES_HUMAN

	bite_size = 5

	flags_chargen = CHARGEN_SKIN | CHARGEN_EYE | CHARGEN_HAIR | CHARGEN_BEARD | CHARGEN_SEX

	flags_flavor_love = FLAG_FLAVOR_COOKED | FLAG_FLAVOR_CHICKEN | FLAG_FLAVOR_MEAT | FLAG_FLAVOR_FISH | FLAG_FLAVOR_LOVE | FLAG_FLAVOR_JUNK | FLAG_FLAVOR_FAT | FLAG_FLAVOR_DAIRY
	flags_flavor_hate = FLAG_FLAVOR_GROSS | FLAG_FLAVOR_RAW | FLAG_FLAVOR_NECRO | FLAG_FLAVOR_MEDICINE

	default_color_eye = "#000000"
	default_color_skin = "#e0b19d"
	default_color_hair = "#000000"

	default_icon_hair = 'icons/mob/living/advanced/hair/human_hair_head.dmi'
	default_icon_state_hair = "hair_c"

	spawning_organs_male = list(
		BODY_TORSO = /obj/item/organ/torso,
		BODY_HEAD = /obj/item/organ/head,
		BODY_HAIR_HEAD = /obj/item/organ/hair,
		BODY_HAIR_FACE = /obj/item/organ/beard,
		BODY_GROIN = /obj/item/organ/groin,
		BODY_LEG_RIGHT = /obj/item/organ/leg,
		BODY_LEG_LEFT = /obj/item/organ/leg/left,
		BODY_FOOT_RIGHT = /obj/item/organ/foot,
		BODY_FOOT_LEFT = /obj/item/organ/foot/left,
		BODY_ARM_RIGHT = /obj/item/organ/arm,
		BODY_ARM_LEFT = /obj/item/organ/arm/left,
		BODY_HAND_RIGHT = /obj/item/organ/hand,
		BODY_HAND_LEFT = /obj/item/organ/hand/left,
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
		BODY_TORSO = /obj/item/organ/torso/female,
		BODY_HEAD = /obj/item/organ/head/female,
		BODY_HAIR_HEAD = /obj/item/organ/hair,
		BODY_HAIR_FACE = /obj/item/organ/beard,
		BODY_GROIN = /obj/item/organ/groin/female,
		BODY_LEG_RIGHT = /obj/item/organ/leg,
		BODY_LEG_LEFT = /obj/item/organ/leg/left,
		BODY_FOOT_RIGHT = /obj/item/organ/foot,
		BODY_FOOT_LEFT = /obj/item/organ/foot/left,
		BODY_ARM_RIGHT = /obj/item/organ/arm,
		BODY_ARM_LEFT = /obj/item/organ/arm/left,
		BODY_HAND_RIGHT = /obj/item/organ/hand,
		BODY_HAND_LEFT = /obj/item/organ/hand/left,
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