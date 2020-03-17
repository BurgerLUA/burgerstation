/obj/structure/interactive/door/alarm
	name = "alarmlock"
	desc = "Protects you from stupidity."
	collision_flags = FLAG_COLLISION_REAL
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	icon = 'icons/obj/structure/airlock/alarm.dmi'
	icon_state = "alarm"

	opacity = 0
	door_state = DOOR_STATE_OPENED

	alpha = 100

/obj/structure/interactive/door/alarm/New(var/desired_loc)
	alpha = 255
	return ..()