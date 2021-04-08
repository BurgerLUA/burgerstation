/obj/item/whistle
	name = "whistle"
	desc = "Be an annoying rules lawyer with this device."
	desc_extended = "Makes an annoying whistle sound when used."
	icon = 'icons/obj/item/whistle.dmi'
	damage_type = /damagetype/item/light

	value = 200

	icon_state_held_left = "held_left"
	icon_state_held_right = "held_right"

	weight = 0.25

/obj/item/whistle/click_self(var/mob/caller)

	INTERACT_CHECK
	INTERACT_DELAY(30)

	var/turf/T = get_turf(src)

	play_sound('sound/effects/whistle.ogg',T,range_min=VIEW_RANGE*0.25,range_max=VIEW_RANGE*2,pitch=RAND_PRECISE(0.95,1.05))

	create_alert(VIEW_RANGE,T,caller,ALERT_LEVEL_CAUTION)

	return TRUE


