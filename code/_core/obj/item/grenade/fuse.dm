/obj/item/grenade/fuse
	name = "fuse grenade"
	desc = "Activate, then throw."
	desc_extended = "A non-electronic fuse-based grenade that sends a small explosive shockwave to the contents of the grenade. Cannot be tampered with."
	max_containers = 1

/obj/item/grenade/fuse/Generate()
	. = ..()
	var/obj/item/device/fuse/T = new(src)
	T.time_set = 50
	stored_trigger = T
	open = FALSE

/obj/item/grenade/fuse/clicked_on_by_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(is_item(object))
		var/obj/item/I = object
		if(I.flags_tool & FLAG_TOOL_SCREWDRIVER)
			caller.to_chat(span("warning","\The [src.name] has nothing to unscrew!"))
			return TRUE

	. = ..()

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
	icon_state = "he"
	desc_extended = "A primitive yet effective high-explosive yield handheld grenade designed to take out large groups of infantry. Pull the pin and throw."

/obj/item/grenade/fuse/he/Generate()
	stored_containers += new /obj/item/container/beaker/tnt(src)
	return ..()

/obj/item/grenade/fuse/fragmentation
	name = "\improper fragmentation grenade"
	icon_state = "fragmentation"
	desc_extended = "A primitive yet effective low-explosive yield handheld grenade designed to take out large groups of infantry with fragments. Pull the pin and throw."

/obj/item/grenade/fuse/fragmentation/Generate()
	stored_containers += new /obj/item/container/beaker/tnt_fragments(src)
	return ..()