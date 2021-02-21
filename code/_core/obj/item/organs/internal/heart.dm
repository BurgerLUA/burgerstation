/obj/item/organ/internal/heart
	name = "heart"
	id = BODY_HEART
	icon_state = BODY_HEART
	desc = "Pumps blood throughout the body."

	attach_flag = BODY_TORSO

	reagents = /reagent_container/heart

	var/heart_rate = 60 //Resting, Measured in beats per minute

	var/heart_ticks = 0

	has_life = FALSE



/obj/item/organ/internal/heart/robotic
	name = "robotic heart"