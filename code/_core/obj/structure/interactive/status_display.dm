var/global/list/status_displays = list()

/proc/set_status_display(var/status_id,var/message)

	if(!length(status_displays))
		return FALSE

	if(!length(status_displays[status_id]))
		return FALSE

	for(var/k in status_displays[status_id])
		var/obj/structure/interactive/status_display/S = k
		S.set_text(message)

	return TRUE

/obj/structure/interactive/status_display
	name = "status display"
	desc = "ASS BLAST USA"
	desc_extended = "Displays text, depending on what it's supposed to display."
	icon = 'icons/obj/structure/status_display.dmi'
	icon_state = "icon"

	var/screen_color = "#000000"
	var/frame_color = "#888888"

	maptext_y = -2

	plane = PLANE_OBJ

	desired_light_power = 0.25
	desired_light_range = 2
	desired_light_color = "#FFFFFF"

/obj/structure/interactive/status_display/update_icon()
	icon_state = null
	return ..()

/obj/structure/interactive/status_display/update_underlays()
	. = ..()
	var/image/I = new(icon,"screen")
	I.color = screen_color
	underlays += I
	return .

/obj/structure/interactive/status_display/update_overlays()
	. = ..()
	var/image/I1 = new(icon,"frame")
	I1.color = frame_color
	add_overlay(I1)
	var/image/I2 = new(icon,"reflection")
	add_overlay(I2)

	return .

/obj/structure/interactive/status_display/New(var/desired_loc)
	. = ..()
	update_sprite()
	set_text("Hello")
	return .

/obj/structure/interactive/status_display/proc/set_text(var/desired_text)
	maptext = "<center style='font-size:1px'>[desired_text]</center>"
	return TRUE

/obj/structure/interactive/status_display/global_display/
	var/status_id

/obj/structure/interactive/status_display/global_display/Initialize()
	if(status_id)
		if(!status_displays[status_id])
			status_displays[status_id] = list()
		status_displays[status_id] += src
	return ..()

/obj/structure/interactive/status_display/global_display/Destroy()
	status_displays[status_id] -= src
	return ..()

/obj/structure/interactive/status_display/global_display/arrivals_01
	name = "arrivals ship 1 status display"
	desc = "ASS BLAST USA"
	desc_extended = "Displays text, depending on what it's supposed to display. This one shows status of the Arrivals Shuttle."
	status_id = "arrivals_01"

/obj/structure/interactive/status_display/global_display/arrivals_02
	name = "arrivals ship 2 status display"
	desc = "ASS BLAST USA"
	desc_extended = "Displays text, depending on what it's supposed to display. This one shows status of the Arrivals Shuttle."
	status_id = "arrivals_02"


/obj/structure/interactive/status_display/global_display/cargo_inbound
	name = "cargo inbound status display"
	desc = "ASS BLAST USA"
	desc_extended = "Displays text, depending on what it's supposed to display. This one shows status of the Cargo Shuttle."
	status_id = "cargo_inbound"

/obj/structure/interactive/status_display/global_display/cargo
	name = "cargo status display"
	desc = "ASS BLAST USA"
	desc_extended = "Displays text, depending on what it's supposed to display. This one shows status of the Inbound Cargo Shuttle."
	status_id = "cargo"

/obj/structure/interactive/status_display/global_display/round
	name = "mission status display"
	desc = "ASS BLAST USA"
	desc_extended = "Displays text, depending on what it's supposed to display. This one shows status of Nanotrasen's mission."
	frame_color = "#E5C14B"
	status_id = "mission"

/obj/structure/interactive/status_display/global_display/lz420_elevator
	name = "elevator status display"
	desc = "ASS BLAST USA"
	desc_extended = "Displays text, depending on what it's supposed to display. This one shows status of the Elevator."
	status_id = "lz420_elevator"

/obj/structure/interactive/status_display/global_display/drop_pod
	name = "drop pod status display"
	desc = "ASS BLAST USA"
	desc_extended = "Displays text, depending on what it's supposed to display. This one shows status of the next drop pod cluster launch."
	frame_color = "#2E00AF"
	status_id = "drop_pod"


/obj/structure/interactive/status_display/global_display/alpha
	name = "alpha shuttle status display"
	desc = "ASS BLAST USA"
	desc_extended = "Displays text, depending on what it's supposed to display. This one shows status of the next shuttle launch for alpha."
	status_id = "alpha"

/obj/structure/interactive/status_display/global_display/bravo
	name = "bravo shuttle status display"
	desc = "ASS BLAST USA"
	desc_extended = "Displays text, depending on what it's supposed to display. This one shows status of the next shuttle launch for bravo."
	status_id = "bravo"

/obj/structure/interactive/status_display/global_display/charlie
	name = "charlie shuttle status display"
	desc = "ASS BLAST USA"
	desc_extended = "Displays text, depending on what it's supposed to display. This one shows status of the next shuttle launch for charlie."
	status_id = "charlie"

/obj/structure/interactive/status_display/global_display/delta
	name = "delta shuttle status display"
	desc = "ASS BLAST USA"
	desc_extended = "Displays text, depending on what it's supposed to display. This one shows status of the next shuttle launch for delta."
	status_id = "delta"