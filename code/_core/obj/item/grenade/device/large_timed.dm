/obj/item/grenade/device/large/timed/


/obj/item/grenade/device/large/timed/Generate()
	var/obj/item/device/timer/T = new(src)
	T.time_set = 30
	stored_trigger = T
	open = FALSE
	return ..()

/obj/item/grenade/device/large/timed/explosive_large
	name = "timed large explosive grenade"
	desc = "Kaboom!"
	desc_extended = "A prebuilt timed explosive grenade. The labeling indicates that the fuse is set to 3 seconds. This one has a larger payload."
	marker_color = COLOR_GREEN

/obj/item/grenade/device/large/timed/explosive_large/Generate()
	stored_containers += new /obj/item/container/simple/beaker/large/water(src)
	stored_containers += new /obj/item/container/simple/beaker/large/potassium(src)
	return ..()



/obj/item/grenade/device/large/timed/lube_smoke
	name = "timed lube smoke grenade"
	desc = "Kaboomish!"
	desc_extended = "A prebuilt timed lube smoke grenade. The labeling indicates that the fuse is set to 3 seconds."

	marker_color = COLOR_BLUE

/obj/item/grenade/device/large/timed/lube_smoke/Generate()
	stored_containers += new /obj/item/container/simple/beaker/large/lube_smoke_01(src)
	stored_containers += new /obj/item/container/simple/beaker/large/lube_smoke_02(src)
	return ..()

/obj/item/grenade/device/large/timed/cleaning_smoke
	name = "timed BLAM! cleaning smoke grenade"
	desc = "BLAM!"
	desc_extended = "A prebuilt timed cleaing smoke grenade. The labeling indicates that the fuse is set to 3 seconds."

	paint_color = COLOR_GREEN
	marker_color = COLOR_GREEN

/obj/item/grenade/device/large/timed/cleaning_smoke/Generate()
	stored_containers += new /obj/item/container/simple/beaker/large/cleaing_smoke_01(src)
	stored_containers += new /obj/item/container/simple/beaker/large/cleaing_smoke_02(src)
	return ..()


/obj/item/grenade/device/large/timed/apocalypse
	name = "timed apocalypse grenade"
	desc = "BLAM!"
	desc_extended = "A prebuilt timed apocalypse grenade. The labeling indicates that the fuse is set to 3 seconds."

	paint_color = COLOR_RED
	marker_color = COLOR_ORANGE

	value_burgerbux = 1

/obj/item/grenade/device/large/timed/apocalypse/Generate()
	stored_containers += new /obj/item/container/simple/beaker/bluespace/oxygen(src)
	stored_containers += new /obj/item/container/simple/beaker/bluespace/phoron(src)
	return ..()