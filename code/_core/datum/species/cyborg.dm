/species/cyborg/
	name = "Cyborg"
	desc = "Fucking metal people."
	id = "cyborg"
	flags_species = SPECIES_CYBORG

	flags_chargen = CHARGEN_EYE

	default_blood_color = COLOR_OIL

	default_color_eye = "#FFFFFF"
	default_color_skin = "#FFFFFF"
	default_color_hair = "#FFFFFF"
	default_color_detail = "#FFFFFF"
	default_color_glow = "#FFFFFF"

	genderless = TRUE

	flags_species_traits = TRAIT_NO_PAIN

	spawning_organs_male = list(
		BODY_TORSO = /obj/item/organ/torso/cyborg,
		BODY_HEAD = /obj/item/organ/head/cyborg,
		BODY_GROIN = /obj/item/organ/groin/cyborg,
		BODY_LEG_RIGHT = /obj/item/organ/leg/cyborg,
		BODY_LEG_LEFT = /obj/item/organ/leg/cyborg/left,
		BODY_FOOT_RIGHT = /obj/item/organ/foot/cyborg,
		BODY_FOOT_LEFT = /obj/item/organ/foot/cyborg/left,
		BODY_ARM_RIGHT = /obj/item/organ/arm/cyborg,
		BODY_ARM_LEFT = /obj/item/organ/arm/cyborg/left,
		BODY_HAND_RIGHT = /obj/item/organ/hand/cyborg,
		BODY_HAND_LEFT = /obj/item/organ/hand/cyborg/left,

		BODY_BRAIN = /obj/item/organ/internal/brain,
		BODY_LUNGS = /obj/item/organ/internal/lungs,
		BODY_STOMACH = /obj/item/organ/internal/stomach,
		BODY_LIVER = /obj/item/organ/internal/liver,
		BODY_INTESTINTES = /obj/item/organ/internal/intestines,
		BODY_KIDNEYS = /obj/item/organ/internal/kidneys
	)