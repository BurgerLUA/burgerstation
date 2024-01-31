var/global/list/all_notifications = list()

SUBSYSTEM_DEF(image_notifications)
	name = "Image Notifications"
	desc = "Handles animations of pop-up image notifications."
	tick_rate = DS2TICKS(1)
	priority = SS_ORDER_PRELOAD

/subsystem/image_notifications/on_life()
	for(var/k in all_notifications)
		var/obj/hud/screen/S = k
		if(S.time <= 2 SECONDS && !S.is_fading && S.fade_out)
			S.is_fading = TRUE
			animate(S,time=2 SECONDS,alpha = 0,easing=LINEAR_EASING)
		if(S.time <= 0)
			remove_notification(S.client,S)
		S.time -= 1

	return TRUE

/proc/add_notification_colored_easy(client/C,color,duration,fade_in=TRUE,fade_out=TRUE)
	var/obj/hud/screen/S = add_notification_easy(C,'icons/hud/screen.dmi',"blank",duration,fade_in,fade_out)
	S.color = color
	S.screen_loc = "LEFT,BOTTOM"

	return S

/proc/add_notification_easy(client/C,icon,icon_state,duration,fade_in=TRUE,fade_out=TRUE,desired_text)
	var/obj/hud/screen/S = add_notification(C,duration,fade_in,fade_out)
	S.layer = LAYER_AREA
	S.plane = PLANE_HUD
	S.icon = icon
	S.icon_state = icon_state
	S.screen_loc = "CENTER-4.5,CENTER-4.5"
	S.update_sprite()
	if(desired_text)
		var/icon/I = new/icon(S.icon,S.icon_state)
		S.maptext = "[desired_text]"
		S.maptext_width = I.Width()
		S.maptext_height = I.Height()
		qdel(I)
	return S

/proc/add_notification(client/C,duration,fade_in=TRUE,fade_out=TRUE)

	if(!C || !C.mob)
		return

	if(fade_in)
		duration += 2 SECONDS

	if(fade_out)
		duration += 2 SECONDS

	var/obj/hud/screen/S = new()
	S.alpha = fade_in ? 0 : 255
	S.client = C
	S.time = duration
	S.is_fading = FALSE
	S.fade_out = fade_out

	if(fade_in)
		animate(S,time=2 SECONDS,alpha = 255,easing=LINEAR_EASING)

	if(C && C.screen)
		C.screen += S

	all_notifications += S

	return S

/proc/remove_notification(client/C,obj/hud/screen/S)

	if(C && C.screen)
		C.screen -= S

	all_notifications -= S
	qdel(S)
