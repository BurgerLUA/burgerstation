/datum/species/reptile/
	name = "Reptile"
	desc = "Fucking furries"

	eye_color_default = "#FF8800"
	color_skin_default = "#448844"
	color_hair_default = "#000000"

	hair_style_default = "bald"

	spawning_organs_male = list(
		BODY_TORSO = /obj/item/organ/torso/reptile,
		BODY_HEAD = /obj/item/organ/head/reptile,
		BODY_HAIR = /obj/item/organ/hair,
		BODY_GROIN = /obj/item/organ/groin/reptile,
		BODY_LEG_RIGHT = /obj/item/organ/leg/reptile,
		BODY_LEG_LEFT = /obj/item/organ/leg/reptile/left,
		BODY_FOOT_RIGHT = /obj/item/organ/foot/reptile,
		BODY_FOOT_LEFT = /obj/item/organ/foot/reptile/left,
		BODY_ARM_RIGHT = /obj/item/organ/arm/reptile,
		BODY_ARM_LEFT = /obj/item/organ/arm/reptile/left,
		BODY_HAND_RIGHT = /obj/item/organ/hand/reptile,
		BODY_HAND_LEFT = /obj/item/organ/hand/reptile/left,
		BODY_EYE_RIGHT = /obj/item/organ/eye/reptile,
		BODY_EYE_LEFT = /obj/item/organ/eye/reptile/left,
		BODY_EAR_RIGHT = /obj/item/organ/ear/reptile,
		BODY_EAR_LEFT = /obj/item/organ/ear/reptile/left,
		BODY_TAIL = /obj/item/organ/tail/reptile
	)

	spawning_organs_female = list(
		BODY_TORSO = /obj/item/organ/torso/reptile/female,
		BODY_HEAD = /obj/item/organ/head/reptile/female,
		BODY_HAIR = /obj/item/organ/hair,
		BODY_GROIN = /obj/item/organ/groin/reptile/female,
		BODY_LEG_RIGHT = /obj/item/organ/leg/reptile,
		BODY_LEG_LEFT = /obj/item/organ/leg/reptile/left,
		BODY_FOOT_RIGHT = /obj/item/organ/foot/reptile,
		BODY_FOOT_LEFT = /obj/item/organ/foot/reptile/left,
		BODY_ARM_RIGHT = /obj/item/organ/arm/reptile,
		BODY_ARM_LEFT = /obj/item/organ/arm/reptile/left,
		BODY_HAND_RIGHT = /obj/item/organ/hand/reptile,
		BODY_HAND_LEFT = /obj/item/organ/hand/reptile/left,
		BODY_EYE_RIGHT = /obj/item/organ/eye/reptile,
		BODY_EYE_LEFT = /obj/item/organ/eye/reptile/left,
		BODY_EAR_RIGHT = /obj/item/organ/ear/reptile,
		BODY_EAR_LEFT = /obj/item/organ/ear/reptile/left,
		BODY_TAIL = /obj/item/organ/tail/reptile
	)

	spawning_buttons = list(
		/obj/button/equip,
		/obj/button/equip/left
	)