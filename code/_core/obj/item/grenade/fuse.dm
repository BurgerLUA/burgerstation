/obj/item/grenade/fuse
	name = "fuse grenade"
	desc = "Activate, then throw."
	desc_extended = "A non-electronic fuse-based grenade that sends a small explosive shockwave to the contents of the grenade. Cannot be tampered with."
	max_containers = 0

	var/obj/item/device/fuse/fuse_type = /obj/item/device/fuse

/obj/item/grenade/fuse/Generate()
	. = ..()
	var/obj/item/device/fuse/T = new fuse_type(src)
	stored_trigger = T
	open = FALSE

/obj/item/grenade/fuse/trigger(var/mob/caller,var/atom/source,var/signal_freq,var/signal_code)
	. = ..()
	if(!src.reagents)
		return
	var/loyalty
	if(is_living(caller))
		var/mob/living/L = caller
		loyalty = L.loyalty_tag
	src.reagents.act_explode(caller,src,get_turf(src),1,loyalty)
	if(stored_trigger)
		qdel(stored_trigger)
		stored_trigger = null

/obj/item/grenade/fuse/he
	name = "\improper HE grenade"
	icon = 'icons/obj/item/grenade.dmi'
	icon_state = "he"
	desc_extended = "A primitive yet effective high-explosive yield handheld grenade designed to take out large groups of infantry. Pull the pin and throw."
	value = 1

/obj/item/grenade/fuse/he/Generate()
	stored_containers += new /obj/item/container/simple/beaker/tnt(src)
	return ..()

/obj/item/grenade/fuse/he/he
	name = "\improper HEHE grenade"
	icon_state = "he"
	desc_extended = "A primitive yet effective high-explosive yield handheld grenade designed to take out large groups of infantry. Pull the pin and throw. Something seems off about this..."

	value_burgerbux = 1
	fuse_type = /obj/item/device/fuse/hehe



/obj/item/grenade/fuse/holy
	name = "\improper holy hand grenade"
	icon = 'icons/obj/item/grenade.dmi'
	icon_state = "holy"
	desc = "Not a globus cruciger."
	desc_extended = "And the Lord spake, saying, 'First shalt thou take out the Holy Pin. Then shalt thou count to three, no more, no less. Three shall be the number thou shalt count, and the number of the counting shall be three. Four shalt thou not count, neither count thou two, excepting that thou then proceed to three. Five is right out. Once the number three, being the third number, be reached, then lobbest thou thy Holy Hand Grenade of Antioch towards thy foe, who, being naughty in My sight, shall snuff it."
	value_burgerbux = 1
	value = 1
	fuse_type = /obj/item/device/fuse/holy

/obj/item/grenade/fuse/holy/Generate()
	stored_containers += new /obj/item/container/simple/beaker/large/potassium(src)
	stored_containers += new /obj/item/container/simple/beaker/large/water_holy(src)
	return ..()


/obj/item/grenade/fuse/fragmentation
	name = "\improper fragmentation grenade"
	icon = 'icons/obj/item/grenade.dmi'
	icon_state = "fragmentation"
	desc_extended = "A primitive yet effective low-explosive yield handheld grenade designed to take out large groups of infantry with fragments. Pull the pin and throw."
	value = 1

/obj/item/grenade/fuse/fragmentation/Generate()
	stored_containers += new /obj/item/container/simple/beaker/tnt_fragments(src)
	return ..()


/obj/item/grenade/fuse/flashbang
	name = "\improper flashbang grenade"
	icon = 'icons/obj/item/grenade.dmi'
	icon_state = "flashbang"
	desc_extended = "A primitive yet effective very low-explosive yield handheld grenade designed to less than lethally stun or disarm enemy combatants. Pull the pin and throw."
	value = 1


/obj/item/grenade/fuse/flashbang/Generate()
	stored_containers += new /obj/item/container/simple/beaker/flashbang(src)
	return ..()



