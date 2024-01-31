/obj/item/organ/internal/implant
	name = "implant"
	id = "implant"
	desc = "Implant."
	icon_state = "lungs"
	attach_flag = BODY_TORSO
	value_burgerbux = 1

/obj/item/organ/internal/implant/on_organ_remove(mob/living/advanced/old_owner)
	. = ..()
	if(!qdeleting)
		qdel(src)


/obj/item/organ/internal/implant/head/
	name = "head implant"
	id = "implant_head"
	attach_flag = BODY_HEAD

/obj/item/organ/internal/implant/torso
	name = "torso implant"
	id = "implant_torso"
	attach_flag = BODY_TORSO

/obj/item/organ/internal/implant/groin
	name = "groin implant"
	id = "implant_groin"
	attach_flag = BODY_GROIN

/obj/item/organ/internal/implant/hand/left
	name = "left hand implant"
	id = "implant_hand_left"
	attach_flag = BODY_HAND_LEFT