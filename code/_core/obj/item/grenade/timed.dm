/obj/item/grenade/timed/
	icon = 'icons/obj/item/grenade_new.dmi'
	icon_state = "grenade"

	var/marker_color = "#FFFFFF"

/obj/item/grenade/timed/update_icon()

	icon = initial(icon)
	icon_state = initial(icon_state)

	if(spent)
		icon_state = "[icon_state]_spent"
	else if(stored_trigger?.active)
		icon_state = "[icon_state]_active"
	else if(open)
		icon_state = "[icon_state]_casing"

/obj/item/grenade/timed/update_overlays()

	. = ..()

	if(!spent && !open)
		var/image/I = new/image(icon,"[initial(icon_state)]_marking")
		I.appearance_flags = src.appearance_flags | RESET_COLOR
		I.color = marker_color
		add_overlay(I)

/obj/item/grenade/timed/Generate()
	var/obj/item/device/timer/T = new(src)
	T.time_set = 30
	stored_trigger = T
	open = FALSE
	return ..()

/obj/item/grenade/timed/explosive
	name = "timed explosive grenade"
	desc = "Kaboom!"
	desc_extended = "A prebuilt timed explosive grenade. The labeling indicates that the fuse is set to 3 seconds."
	value = 50

	marker_color = COLOR_GREEN

/obj/item/grenade/timed/explosive/Generate()
	stored_containers += new /obj/item/container/simple/beaker/water(src)
	stored_containers += new /obj/item/container/simple/beaker/potassium(src)
	return ..()

/obj/item/grenade/timed/explosive_large
	name = "timed large explosive grenade"
	desc = "Kaboom!"
	desc_extended = "A prebuilt timed explosive grenade. The labeling indicates that the fuse is set to 3 seconds. This one has a larger payload."
	icon_state = "grenade_large"
	marker_color = COLOR_GREEN

/obj/item/grenade/timed/explosive_large/Generate()
	stored_containers += new /obj/item/container/simple/beaker/large/water(src)
	stored_containers += new /obj/item/container/simple/beaker/large/potassium(src)
	return ..()

/obj/item/grenade/timed/smoke/
	name = "timed smoke grenade"
	desc = "Kaboomish!"
	desc_extended = "A prebuilt timed smoke grenade. The labeling indicates that the fuse is set to 3 seconds."

	marker_color = COLOR_BLUE

/obj/item/grenade/timed/smoke/Generate()
	stored_containers += new /obj/item/container/simple/beaker/smoke_01(src)
	stored_containers += new /obj/item/container/simple/beaker/smoke_02(src)
	return ..()

/obj/item/grenade/timed/lube_smoke
	name = "timed lube smoke grenade"
	desc = "Kaboomish!"
	desc_extended = "A prebuilt timed lube smoke grenade. The labeling indicates that the fuse is set to 3 seconds."

	marker_color = COLOR_BLUE

/obj/item/grenade/timed/lube_smoke/Generate()
	stored_containers += new /obj/item/container/simple/beaker/large/lube_smoke_01(src)
	stored_containers += new /obj/item/container/simple/beaker/large/lube_smoke_02(src)
	return ..()


/obj/item/grenade/timed/emp
	name = "timed EMP grenade"
	desc = "Kaboomish!"
	desc_extended = "A prebuilt timed EMP grenade. The labeling indicates that the fuse is set to 3 seconds."

	marker_color = COLOR_CYAN

/obj/item/grenade/timed/emp/Generate()
	stored_containers += new /obj/item/container/simple/beaker/iron(src)
	stored_containers += new /obj/item/container/simple/beaker/uranium(src)
	return ..()

