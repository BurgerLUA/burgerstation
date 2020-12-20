/species/monkey
	name = "Monkey"
	desc = "OOK"
	id = "monkey"
	flags_species = SPECIES_MONKEY

	bite_size = 5

	//flags_chargen = CHARGEN_SKIN | CHARGEN_EYE | CHARGEN_HAIR | CHARGEN_BEARD | CHARGEN_SEX

	flags_flavor_love = FLAG_FLAVOR_COOKED | FLAG_FLAVOR_CHICKEN | FLAG_FLAVOR_MEAT | FLAG_FLAVOR_FISH | FLAG_FLAVOR_LOVE | FLAG_FLAVOR_JUNK | FLAG_FLAVOR_FAT | FLAG_FLAVOR_DAIRY
	flags_flavor_hate = FLAG_FLAVOR_GROSS | FLAG_FLAVOR_RAW

	default_color_eye = "#000000"
	default_color_skin = "#FFFFFF"
	default_color_hair = "#000000"

	default_icon_hair = 'icons/mob/living/advanced/hair/human_hair_head.dmi'
	default_icon_state_hair = "hair_c"

	spawning_organs_male = list(
		BODY_TORSO = /obj/item/organ/torso/monkey,
		BODY_HEAD = /obj/item/organ/head/monkey,
		BODY_GROIN = /obj/item/organ/groin/monkey,
		BODY_LEG_RIGHT = /obj/item/organ/leg/monkey,
		BODY_LEG_LEFT = /obj/item/organ/leg/monkey/left,
		BODY_FOOT_RIGHT = /obj/item/organ/foot/monkey,
		BODY_FOOT_LEFT = /obj/item/organ/foot/monkey/left,
		BODY_ARM_RIGHT = /obj/item/organ/arm/monkey,
		BODY_ARM_LEFT = /obj/item/organ/arm/monkey/left,
		BODY_HAND_RIGHT = /obj/item/organ/hand/monkey,
		BODY_HAND_LEFT = /obj/item/organ/hand/monkey/left,
		BODY_EYE_RIGHT = /obj/item/organ/eye/monkey,
		BODY_EYE_LEFT = /obj/item/organ/eye/monkey/left,
		BODY_EAR_RIGHT = /obj/item/organ/ear/monkey,
		BODY_EAR_LEFT = /obj/item/organ/ear/monkey/left,
		BODY_TAIL = /obj/item/organ/tail/monkey,

		BODY_BRAIN = /obj/item/organ/internal/brain,
		BODY_LUNGS = /obj/item/organ/internal/lungs,
		BODY_STOMACH = /obj/item/organ/internal/stomach,
		BODY_LIVER = /obj/item/organ/internal/liver,
		BODY_INTESTINTES = /obj/item/organ/internal/intestines,
		BODY_KIDNEYS = /obj/item/organ/internal/kidneys
	)

	spawning_organs_female = list(
		BODY_TORSO = /obj/item/organ/torso/monkey/female,
		BODY_HEAD = /obj/item/organ/head/monkey/female,
		BODY_GROIN = /obj/item/organ/groin/monkey/female,
		BODY_LEG_RIGHT = /obj/item/organ/leg/monkey,
		BODY_LEG_LEFT = /obj/item/organ/leg/monkey/left,
		BODY_FOOT_RIGHT = /obj/item/organ/foot/monkey,
		BODY_FOOT_LEFT = /obj/item/organ/foot/monkey/left,
		BODY_ARM_RIGHT = /obj/item/organ/arm/monkey,
		BODY_ARM_LEFT = /obj/item/organ/arm/monkey/left,
		BODY_HAND_RIGHT = /obj/item/organ/hand/monkey,
		BODY_HAND_LEFT = /obj/item/organ/hand/monkey/left,
		BODY_EYE_RIGHT = /obj/item/organ/eye/monkey,
		BODY_EYE_LEFT = /obj/item/organ/eye/monkey/left,
		BODY_EAR_RIGHT = /obj/item/organ/ear/monkey,
		BODY_EAR_LEFT = /obj/item/organ/ear/monkey/left,
		BODY_TAIL = /obj/item/organ/tail/monkey,

		BODY_BRAIN = /obj/item/organ/internal/brain,
		BODY_LUNGS = /obj/item/organ/internal/lungs,
		BODY_STOMACH = /obj/item/organ/internal/stomach,
		BODY_LIVER = /obj/item/organ/internal/liver,
		BODY_INTESTINTES = /obj/item/organ/internal/intestines,
		BODY_KIDNEYS = /obj/item/organ/internal/kidneys
	)