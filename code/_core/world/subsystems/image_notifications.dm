var/global/list/all_notifications = list()

/subsystem/image_notifications/
	name = "Image Notifications"
	desc = "Handles animations of pop-up image notifications."
	tick_rate = DECISECONDS_TO_TICKS(1)
	priority = SS_ORDER_NORMAL

/subsystem/image_notifications/on_life()
	for(var/data in all_notifications)
		var/image/I = data["image"]
		var/client/C = data["client"]

		if(data["time"] <= SECONDS_TO_DECISECONDS(2) && !data["is_fading"] && data["fade_out"])
			data["is_fading"] = TRUE
			animate(I,time=SECONDS_TO_DECISECONDS(2),alpha = 0,easing=LINEAR_EASING)

		if(data["time"] <= 0)
			remove_notification(C,I)
			all_notifications -= data

		data["time"] -= 1

	return TRUE

/proc/add_notification_colored_easy(var/client/C,var/color,var/duration,var/fade_in=TRUE,var/fade_out=TRUE)
	var/icon/I = new /icon('icons/invisible.dmi',"0")
	I.Blend(color,ICON_OVERLAY)

	var/max_possible = TILE_SIZE*(1+VIEW_RANGE)*2
	I.Scale(max_possible,max_possible)

	var/image/I2 = new /image(I)
	I2.pixel_x = 16-(max_possible*0.5) + C.pixel_x
	I2.pixel_y = 16-(max_possible*0.5) + C.pixel_y
	I2.loc = C.mob
	I2.layer = LAYER_AREA
	I2.plane = PLANE_MAP
	I2.mouse_opacity = 0

	add_notification(C,I2,duration,fade_in,fade_out)

/proc/add_notification_easy(var/client/C,var/icon,var/icon_state,var/duration,var/fade_in=TRUE,var/fade_out=TRUE)
	var/image/I = new /image(icon,icon_state)
	I.pixel_x = 16-160 + C.pixel_x
	I.pixel_y = 16-160 + C.pixel_y
	I.loc = C.mob
	I.layer = LAYER_AREA
	I.plane = PLANE_MAP_TEXT
	I.mouse_opacity = 0
	add_notification(C,I,duration)

/proc/add_notification(var/client/C,var/image/I,var/duration,var/fade_in=TRUE,var/fade_out=TRUE)

	if(!C.mob)
		return

	C.images += I

	if(fade_in)
		I.alpha = 0
		duration += SECONDS_TO_DECISECONDS(2)
		animate(I,time=SECONDS_TO_DECISECONDS(2),alpha = 255,easing=LINEAR_EASING)

	if(fade_out)
		duration += SECONDS_TO_DECISECONDS(2)

	var/list/data = list()
	data["image"] = I
	data["client"] = C
	data["time"] = duration
	data["is_fading"] = FALSE
	data["fade_out"] = fade_out
	all_notifications += list(data)

/proc/remove_notification(var/client/C,var/image/I)
	C.images -= I
	qdel(I)
