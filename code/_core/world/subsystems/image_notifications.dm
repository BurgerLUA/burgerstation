var/global/list/all_notifications = list()

/subsystem/image_notifications/
	name = "Image Notifications"
	desc = "Handles animations of pop-up image notifications."
	tick_rate = DECISECONDS_TO_TICKS(1)
	priority = SS_ORDER_PRELOAD

/subsystem/image_notifications/on_life()
	for(var/var/obj/screen/S in all_notifications)
		if(S.time <= SECONDS_TO_DECISECONDS(2) && !S.is_fading && S.fade_out)
			S.is_fading = TRUE
			animate(S,time=SECONDS_TO_DECISECONDS(2),alpha = 0,easing=LINEAR_EASING)

		if(S.time <= 0)
			remove_notification(S.client,S)

		S.time -= 1

	return TRUE

/proc/add_notification_colored_easy(var/client/C,var/color,var/duration,var/fade_in=TRUE,var/fade_out=TRUE)
	var/obj/screen/S = add_notification_easy(C,'icons/hud/screen.dmi',"blank",duration,fade_in,fade_out)
	S.color = color
	S.screen_loc = "LEFT,BOTTOM"

	return S

/proc/add_notification_easy(var/client/C,var/icon,var/icon_state,var/duration,var/fade_in=TRUE,var/fade_out=TRUE)
	var/obj/screen/S = add_notification(C,duration,fade_in,fade_out)
	S.layer = LAYER_AREA
	S.plane = PLANE_MAP_TEXT
	S.icon = icon
	S.icon_state = icon_state
	S.screen_loc = "CENTER-4.5,CENTER-4.5"
	S.update_icon()
	return S

/proc/add_notification(var/client/C,var/duration,var/fade_in=TRUE,var/fade_out=TRUE)

	if(!C.mob)
		return

	if(fade_in)
		duration += SECONDS_TO_DECISECONDS(2)

	if(fade_out)
		duration += SECONDS_TO_DECISECONDS(2)

	var/obj/screen/S = new()
	S.alpha = fade_in ? 0 : 255
	S.client = C
	S.time = duration
	S.is_fading = FALSE
	S.fade_out = fade_out

	if(fade_in)
		animate(S,time=SECONDS_TO_DECISECONDS(2),alpha = 255,easing=LINEAR_EASING)

	C.screen += S
	all_notifications += S

	return S

/proc/remove_notification(var/client/C,var/obj/screen/S)
	C.screen -= S
	all_notifications -= S
	qdel(S)
