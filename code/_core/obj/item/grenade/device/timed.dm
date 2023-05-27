/obj/item/grenade/device/timed/
	icon = 'icons/obj/item/grenade_new.dmi'
	icon_state = "grenade"

/obj/item/grenade/device/timed/Generate()
	var/obj/item/device/timer/T = new(src)
	T.time_set = 30
	stored_trigger = T
	open = FALSE
	return ..()

/obj/item/grenade/device/timed/explosive
	name = "timed explosive grenade"
	desc = "Kaboom!"
	desc_extended = "A prebuilt timed explosive grenade. The labeling indicates that the fuse is set to 3 seconds."
	value = 50

	marker_color = COLOR_GREEN

/obj/item/grenade/device/timed/explosive/Generate()
	stored_containers += new /obj/item/container/simple/beaker/water(src)
	stored_containers += new /obj/item/container/simple/beaker/potassium(src)
	return ..()

/obj/item/grenade/device/timed/smoke/
	name = "timed smoke grenade"
	desc = "Kaboomish!"
	desc_extended = "A prebuilt timed smoke grenade. The labeling indicates that the fuse is set to 3 seconds."

	marker_color = COLOR_BLUE

/obj/item/grenade/device/timed/smoke/Generate()
	stored_containers += new /obj/item/container/simple/beaker/smoke_01(src)
	stored_containers += new /obj/item/container/simple/beaker/smoke_02(src)
	return ..()





/obj/item/grenade/device/timed/emp
	name = "timed EMP grenade"
	desc = "Kaboomish!"
	desc_extended = "A prebuilt timed EMP grenade. The labeling indicates that the fuse is set to 3 seconds."
	marker_color = COLOR_CYAN

/obj/item/grenade/device/timed/emp/Generate()
	stored_containers += new /obj/item/container/simple/beaker/iron(src)
	stored_containers += new /obj/item/container/simple/beaker/uranium(src)
	return ..()


/obj/item/grenade/device/timed/incendiary
	name = "timed incendiary grenade"
	desc = "Kaboomish!"
	desc_extended = "A prebuilt timed incendiary grenade. The labeling indicates that the fuse is set to 3 seconds."

	paint_color = COLOR_RED
	marker_color = COLOR_ORANGE

/obj/item/grenade/device/timed/incendiary/Generate()
	stored_containers += new /obj/item/container/simple/beaker/oxygen(src)
	stored_containers += new /obj/item/container/simple/beaker/phoron(src)
	return ..()








