obj/structure/interactive/status_display
	name = "status display"
	icon = 'icons/obj/structure/status_display.dmi'
	icon_state = "icon"

	var/screen_color = "#000000"
	var/frame_color = "#888888"

obj/structure/interactive/status_display/update_icon()

	icon_state = null

	overlays.Cut()
	underlays.Cut()

	var/image/I = new(icon,"screen")
	I.color = screen_color

	var/image/I2 = new(icon,"frame")
	I2.color = frame_color

	underlays += I
	overlays += I2


obj/structure/interactive/status_display/New(var/desired_loc)
	. = ..()
	update_icon()
	set_text("Hello")
	return .

obj/structure/interactive/status_display/proc/set_text(var/desired_text)
	maptext = "<center style='font-size:1px'>[desired_text]</center>"
	return TRUE