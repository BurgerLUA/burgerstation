var/global/list/portal_markers = list()

/obj/marker/portal
	name = "portal marker"
	var/loyalty_tag

/obj/marker/portal/New(var/desired_loc)
	if(loyalty_tag)
		if(!portal_markers[loyalty_tag])
			portal_markers[loyalty_tag] = list()
		portal_markers[loyalty_tag] |= src
	. = ..()

/obj/marker/portal/nanotrasen
	loyalty_tag = "NanoTrasen"

/obj/marker/portal/syndicate
	loyalty_tag = "Syndicate"

/obj/marker/portal/wizard
	loyalty_tag = "Wizard Federation"

/obj/marker/portal/revolutionary
	loyalty_tag = "Revolutionary"