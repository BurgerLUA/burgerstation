/datum/species/human/
	name = "Human"
	desc = "Vanilla as fuck."

	eye_color_default = "#000000"
	color_skin_default = "#e0b19d"
	color_hair_default = "#000000"

	hair_style_default = "greytide"

	spawning_organs_male = list(
		BODY_TORSO = /obj/item/organ/torso,
		BODY_HEAD = /obj/item/organ/head,
		BODY_HAIR_HEAD = /obj/item/organ/hair,
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
		BODY_EAR_LEFT = /obj/item/organ/ear/left
	)

	spawning_buttons = list(
		/obj/button/equip,
		/obj/button/equip/left
	)

	spawning_health = list(
		"hp" = /obj/health/hp,
		"sp" = /obj/health/sp,
		"mp" = /obj/health/mp
	)