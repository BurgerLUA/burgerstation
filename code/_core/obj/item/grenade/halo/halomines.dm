/obj/item/grenade/device/landmine/halo
	name = "landmine"
	icon_state = "landmine"

/obj/item/grenade/device/landmine/halo/proximity/Generate()
	var/obj/item/device/proximity/T = new(src)
	T.time_set = 50
	stored_trigger = T
	open = FALSE
	return ..()

/obj/item/grenade/device/landmine/halo/proximity/explosive/
	name = "proximity explosive landmine"
	desc = "Kaboom!"
	desc_extended = "A prebuilt proximity explosive landmine. The labeling indicates that the proximity delay is set to 5 seconds."
	value = 50

/obj/item/grenade/device/landmine/halo/proximity/explosive/Generate()
	stored_containers += new /obj/item/container/simple/beaker/water(src)
	stored_containers += new /obj/item/container/simple/beaker/potassium(src)
	return ..()