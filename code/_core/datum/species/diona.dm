/species/diona/
	name = "Dionae"
	desc = "Fucking tree people."
	id = "diona"
	flags_species = SPECIES_DIONA

	bite_size = 20

	flags_chargen = CHARGEN_SKIN | CHARGEN_DETAIL | CHARGEN_GLOW

	default_color_eye = "#88FF88"
	default_color_skin = "#BC9D58"
	default_color_hair = "#008800"
	default_color_detail = "#719333"
	default_color_glow = "#B2F861"

	genderless = TRUE

	flags_species_traits = TRAIT_NO_PAIN

	spawning_organs_male = list(
		BODY_TORSO = /obj/item/organ/torso/diona,
		BODY_HEAD = /obj/item/organ/head/diona,
		BODY_GROIN = /obj/item/organ/groin/diona,
		BODY_LEG_RIGHT = /obj/item/organ/leg/diona,
		BODY_LEG_LEFT = /obj/item/organ/leg/diona/left,
		BODY_FOOT_RIGHT = /obj/item/organ/foot/diona,
		BODY_FOOT_LEFT = /obj/item/organ/foot/diona/left,
		BODY_ARM_RIGHT = /obj/item/organ/arm/diona,
		BODY_ARM_LEFT = /obj/item/organ/arm/diona/left,
		BODY_HAND_RIGHT = /obj/item/organ/hand/diona,
		BODY_HAND_LEFT = /obj/item/organ/hand/diona/left,

		BODY_BRAIN = /obj/item/organ/internal/brain,
		BODY_LUNGS = /obj/item/organ/internal/lungs,
		BODY_STOMACH = /obj/item/organ/internal/stomach,
		BODY_LIVER = /obj/item/organ/internal/liver,
		BODY_INTESTINTES = /obj/item/organ/internal/intestines,
		BODY_KIDNEYS = /obj/item/organ/internal/kidneys
	)