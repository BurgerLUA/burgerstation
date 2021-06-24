/species/goblin/
	name = "Goblin"
	desc = "For the raid!"
	id = "goblin"
	flags_species = SPECIES_GOBLIN

	bite_size = 5

	flags_chargen = CHARGEN_EYE | CHARGEN_SKIN

	default_color_eye = "#FFFFFF"
	default_color_skin = "#4E7F00"
	default_color_hair = "#FFFFFF"
	default_color_detail = "#FFFFFF"
	default_color_glow = "#FFFFFF"

	genderless = TRUE

	spawning_organs_male = list(
		BODY_TORSO = /obj/item/organ/torso/goblin,
		BODY_HEAD = /obj/item/organ/head/goblin,
		BODY_GROIN = /obj/item/organ/groin/goblin,
		BODY_LEG_RIGHT = /obj/item/organ/leg/goblin,
		BODY_LEG_LEFT = /obj/item/organ/leg/goblin/left,
		BODY_FOOT_RIGHT = /obj/item/organ/foot/goblin,
		BODY_FOOT_LEFT = /obj/item/organ/foot/goblin/left,
		BODY_ARM_RIGHT = /obj/item/organ/arm/goblin,
		BODY_ARM_LEFT = /obj/item/organ/arm/goblin/left,
		BODY_HAND_RIGHT = /obj/item/organ/hand/goblin,
		BODY_HAND_LEFT = /obj/item/organ/hand/goblin/left,
		BODY_EYE_RIGHT = /obj/item/organ/eye,
		BODY_EYE_LEFT = /obj/item/organ/eye/left
	)

	inherent_traits = list(
		/trait/death_check/quitter
	)