/species/skeleton/
	name = "Skeleton"
	desc = "Meat."
	id = "skeleton"
	flags_species = SPECIES_SKELETON

	bite_size = 5

	flags_chargen = CHARGEN_EYE | CHARGEN_SKIN

	default_color_eye = "#FFFFFF"
	default_color_skin = "#FFFFFF"
	default_color_hair = "#FFFFFF"
	default_color_detail = "#FFFFFF"
	default_color_glow = "#FFFFFF"

	flags_species_traits = TRAIT_NO_PAIN | TRAIT_NO_BLOOD

	genderless = TRUE

	spawning_organs_male = list(
		BODY_TORSO = /obj/item/organ/torso/skeleton,
		BODY_HEAD = /obj/item/organ/head/skeleton,
		BODY_GROIN = /obj/item/organ/groin/skeleton,
		BODY_LEG_RIGHT = /obj/item/organ/leg/skeleton,
		BODY_LEG_LEFT = /obj/item/organ/leg/skeleton/left,
		BODY_FOOT_RIGHT = /obj/item/organ/foot/skeleton,
		BODY_FOOT_LEFT = /obj/item/organ/foot/skeleton/left,
		BODY_ARM_RIGHT = /obj/item/organ/arm/skeleton,
		BODY_ARM_LEFT = /obj/item/organ/arm/skeleton/left,
		BODY_HAND_RIGHT = /obj/item/organ/hand/skeleton,
		BODY_HAND_LEFT = /obj/item/organ/hand/skeleton/left,
		BODY_EYE_RIGHT = /obj/item/organ/eye,
		BODY_EYE_LEFT = /obj/item/organ/eye/left
	)