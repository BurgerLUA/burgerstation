/species/beefman/
	name = "Beefman"
	desc = "Meat."
	id = "beefman"
	flags_species = SPECIES_BEEF

	flags_chargen = CHARGEN_EYE | CHARGEN_SKIN

	bite_size = 20

	default_color_eye = "#FFFFFF"
	default_color_skin = "#541900"
	default_color_hair = "#FFFFFF"
	default_color_detail = "#FFFFFF"
	default_color_glow = "#FFFFFF"

	genderless = TRUE

	spawning_organs_male = list(
		BODY_TORSO = /obj/item/organ/torso/beefman,
		BODY_HEAD = /obj/item/organ/head/beefman,
		BODY_GROIN = /obj/item/organ/groin/beefman,
		BODY_LEG_RIGHT = /obj/item/organ/leg/beefman,
		BODY_LEG_LEFT = /obj/item/organ/leg/beefman/left,
		BODY_FOOT_RIGHT = /obj/item/organ/foot/beefman,
		BODY_FOOT_LEFT = /obj/item/organ/foot/beefman/left,
		BODY_ARM_RIGHT = /obj/item/organ/arm/beefman,
		BODY_ARM_LEFT = /obj/item/organ/arm/beefman/left,
		BODY_HAND_RIGHT = /obj/item/organ/hand/beefman,
		BODY_HAND_LEFT = /obj/item/organ/hand/beefman/left,
		BODY_EYE_RIGHT = /obj/item/organ/eye/beefman,
		BODY_EYE_LEFT = /obj/item/organ/eye/beefman/left,

		BODY_BRAIN = /obj/item/organ/internal/brain,
		BODY_LUNGS = /obj/item/organ/internal/lungs,
		BODY_STOMACH = /obj/item/organ/internal/stomach,
		BODY_LIVER = /obj/item/organ/internal/liver,
		BODY_INTESTINTES = /obj/item/organ/internal/intestines,
		BODY_KIDNEYS = /obj/item/organ/internal/kidneys
	)