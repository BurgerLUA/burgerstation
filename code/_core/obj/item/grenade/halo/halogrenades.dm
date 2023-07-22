/obj/item/grenade/timed/explosive/halo
	name = "M9 HEDP"
	desc = "Kaboom!"
	icon_state = "hedp"
	desc_extended = "A prebuilt timed explosive grenade. The labeling indicates that the fuse is set to 3 seconds."

	value = 50

/obj/item/grenade/timed/explosive/halo/Generate()
	stored_containers += new /obj/item/container/beaker/large/grenade_water(src)
	stored_containers += new /obj/item/container/beaker/large/grenade_potassium(src)
	return ..()

/obj/item/grenade/timed/explosive/halo/plasma
	name = "Plasma grenade"
	icon_state = "plasmagrenade"
	desc_extended = "A prebuilt timed explosive grenade. The labeling indicates that the fuse is set to 3 seconds."

	value = 50

/obj/item/grenade/timed/explosive/halo/plasma/Generate()
	stored_containers += new /obj/item/container/beaker/large/grenade_water(src)
	stored_containers += new /obj/item/container/beaker/large/grenade_potassium(src)
	return ..()