obj/effect/temp/alert
	name = "alert indicator"
	icon = 'icons/mob/living/advanced/overlays/stealth.dmi'

obj/effect/temp/New(var/desired_location,var/desired_time)
	. = ..()
	alpha = 0
	transform *= 0.5
	animate(src,alpha = 255, pixel_z = 12, time = 4, transform = matrix(),easing = ELASTIC_EASING)
	return .

obj/effect/temp/alert/exclaim
	icon_state = "exclaim"
	duration = 10

obj/effect/temp/alert/question
	icon_state = "question"
	duration = 10

obj/effect/temp/alert/huh
	icon_state = "huh"
	duration = 10