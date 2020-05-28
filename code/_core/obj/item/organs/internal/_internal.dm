/obj/item/organ/internal
	name = "internal organ"
	desc = "An internal organ, it is now outside."
	has_dropped_icon = TRUE

	enable_skin = FALSE
	enable_glow = FALSE
	enable_detail = FALSE
	enable_wounds = FALSE

	reagents = null

	has_life = FALSE

/obj/item/organ/internal/brain
	name = "brain"
	id = BODY_BRAIN
	icon_state = BODY_BRAIN
	desc = "Produces thoughts. Requires oxygenated blood."

	attach_flag = BODY_HEAD

/obj/item/organ/internal/brain/unattach_from_parent(var/turf/T)
	if(is_advanced(src.loc))
		var/mob/living/advanced/A = src.loc
		A.death()

	..()

/obj/item/organ/internal/lungs
	name = "lungs"
	id = BODY_LUNGS
	desc = "Produces oxygenated blood. Requires blood, oxygen."
	icon_state = "lungs"

	attach_flag = BODY_TORSO

/obj/item/organ/internal/liver
	name = "liver"
	id = BODY_LIVER
	icon_state = BODY_LIVER
	desc = "Produces bile. Requires vitamins and oxygenated blood."

	attach_flag = BODY_TORSO

/obj/item/organ/internal/intestines
	name = "intestines"
	id = BODY_INTESTINTES
	icon_state = BODY_INTESTINTES
	desc = "Produces vitamins and waste. Requires digested nutrients, digested liquid, and oxygenated blood."

	attach_flag = BODY_GROIN

/obj/item/organ/internal/kidneys
	name = "kidneys"
	id = BODY_KIDNEYS
	icon_state = BODY_KIDNEYS
	desc = "Filters waste from blood. Requires things."

	attach_flag = BODY_GROIN




