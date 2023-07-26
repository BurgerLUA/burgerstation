/obj/item/grenade/timed/explosive/halo
	name = "M9 HEDP"
	desc = "Kaboom!"
	icon_state = "hedp"
	desc_extended = "A prebuilt timed explosive grenade. The labeling indicates that the fuse is set to 3 seconds."
	value = 50

/obj/item/grenade/device/timed/explosive/halo/Generate()
	stored_containers += new /obj/item/container/simple/beaker/water(src)
	stored_containers += new /obj/item/container/simple/beaker/potassium(src)
	return ..()

/obj/item/grenade/timed/explosive/halo/plasma
	name = "Plasma grenade"
	icon_state = "plasmagrenade"
	desc_extended = "A prebuilt timed explosive grenade. The labeling indicates that the fuse is set to 3 seconds."
	value = 50

/obj/item/grenade/device/timed/explosive/halo/plasma/Generate()
	stored_containers += new /obj/item/container/simple/beaker/water(src)
	stored_containers += new /obj/item/container/simple/beaker/potassium(src)
	return ..()