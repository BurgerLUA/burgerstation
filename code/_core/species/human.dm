/datum/species/human/
	name = "Human"
	desc = "Vanilla as fuck."

	eye_color_default = "#000000"
	skin_color_default = "#e0b19d"
	hair_color_default = "#000000"

	hair_style_default = "greytide"

	spawning_organs_male = list(
		BODY_HEAD = /obj/item/organ/head,
		BODY_TORSO = /obj/item/organ/torso,
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
		BODY_HAIR_HEAD = /obj/item/organ/hair
	)

	spawning_organs_female = list(
		BODY_HEAD = /obj/item/organ/head/female,
		BODY_TORSO = /obj/item/organ/torso/female,
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
		BODY_HAIR_HEAD = /obj/item/organ/hair
	)

	spawning_buttons = list(
		/obj/button/equip,
		/obj/button/equip/left
	)