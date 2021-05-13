obj/effect/alert
	name = "alert indicator effect"
	icon = 'icons/mob/living/advanced/overlays/stealth.dmi'

obj/effect/alert/New(var/desired_location,var/desired_time)
	. = ..()
	alpha = 0
	transform *= 0.5
	animate(src,alpha = 255, pixel_z = 12, time = 4, transform = get_base_transform(),easing = ELASTIC_EASING)

obj/effect/alert/exclaim
	icon_state = "exclaim"

obj/effect/alert/question
	icon_state = "question"

obj/effect/alert/huh
	icon_state = "huh"