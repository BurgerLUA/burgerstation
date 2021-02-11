/species/dummy/

	name = "Target Practice Dummy"
	desc = "It's a dummy, dummy."
	id = "dummy"

	flags_species = SPECIES_DUMMY
	flags_chargen = CHARGEN_SEX

	default_color_eye = "#000000"
	default_color_skin = "#FFE121"
	default_color_hair = "#000000"

	flags_species_traits = TRAIT_NO_PAIN | TRAIT_NO_BLOOD

	spawning_organs_male = list(
		BODY_TORSO = /obj/item/organ/torso,
		BODY_HEAD = /obj/item/organ/head,
		BODY_GROIN = /obj/item/organ/groin,
		BODY_LEG_RIGHT = /obj/item/organ/leg,
		BODY_LEG_LEFT = /obj/item/organ/leg/left,
		BODY_FOOT_RIGHT = /obj/item/organ/foot,
		BODY_FOOT_LEFT = /obj/item/organ/foot/left,
		BODY_ARM_RIGHT = /obj/item/organ/arm,
		BODY_ARM_LEFT = /obj/item/organ/arm/left,
		BODY_HAND_RIGHT = /obj/item/organ/hand,
		BODY_HAND_LEFT = /obj/item/organ/hand/left
	)

	spawning_organs_female = list(
		BODY_TORSO = /obj/item/organ/torso/female,
		BODY_HEAD = /obj/item/organ/head/female,
		BODY_GROIN = /obj/item/organ/groin/female,
		BODY_LEG_RIGHT = /obj/item/organ/leg,
		BODY_LEG_LEFT = /obj/item/organ/leg/left,
		BODY_FOOT_RIGHT = /obj/item/organ/foot,
		BODY_FOOT_LEFT = /obj/item/organ/foot/left,
		BODY_ARM_RIGHT = /obj/item/organ/arm,
		BODY_ARM_LEFT = /obj/item/organ/arm/left,
		BODY_HAND_RIGHT = /obj/item/organ/hand,
		BODY_HAND_LEFT = /obj/item/organ/hand/left
	)

/species/dummy/generate_blood_type()
	return null