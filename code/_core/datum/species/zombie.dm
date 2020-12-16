/species/zombie/
	name = "Zombie"
	desc = "BRAINS."
	id = "zombie"
	flags_species = SPECIES_ZOMBIE

	bite_size = 10

	flags_chargen = CHARGEN_SKIN | CHARGEN_EYE | CHARGEN_HAIR | CHARGEN_BEARD | CHARGEN_SEX

	default_color_eye = "#FF6E00"
	default_color_skin = "#718C4A"
	default_color_hair = "#262626"

	default_icon_hair = 'icons/mob/living/advanced/hair/human_hair_head.dmi'
	default_icon_state_hair = "hair_c"

	flags_species_traits = TRAIT_NO_PAIN

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
		BODY_HAND_RIGHT = /obj/item/organ/hand/zombie,
		BODY_HAND_LEFT = /obj/item/organ/hand/zombie/left,
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
		BODY_HAND_RIGHT = /obj/item/organ/hand/zombie,
		BODY_HAND_LEFT = /obj/item/organ/hand/zombie/left,
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

	emote_sounds_male = list()

	emote_sounds_female = list()