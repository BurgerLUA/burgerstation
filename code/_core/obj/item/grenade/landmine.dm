/obj/item/grenade/landmine
	name = "landmine"
	icon = 'icons/obj/item/landmine.dmi'
	icon_state = "chem"

/obj/item/grenade/landmine/proximity/Generate()
	var/obj/item/device/proximity/T = new(src)
	T.time_set = 50
	stored_trigger = T
	return ..()

/obj/item/grenade/landmine/proximity/explosive/
	name = "proximity explosive landmine"
	desc = "Kaboom!"
	desc_extended = "A prebuilt proximity explosive landmine. The labeling indicates that the proximity delay is set to 5 seconds."

/obj/item/grenade/landmine/proximity/explosive/Generate()
	stored_containers += new /obj/item/container/beaker/large/grenade_water(src)
	stored_containers += new /obj/item/container/beaker/large/grenade_potassium(src)
	return ..()