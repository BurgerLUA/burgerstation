/obj/structure/interactive/wizard_hole
	name = "wizard's wormhole"
	desc = "Enter the wizard's wormhole, if you dare."
	desc_extended = "A magical localized wormhole that should lead somewhere. Only Wizard Federation members know how to do this."
	icon = 'icons/obj/effects/portal.dmi'
	icon_state = "bhole3"

	var/obj/structure/interactive/wizard_hole/linked_wormhole

	density = TRUE

/obj/structure/interactive/wizard_hole/Destroy()
	. = ..()
	linked_wormhole = null

/obj/structure/interactive/wizard_hole/Finalize()

	if(!linked_wormhole)

		if(!length(wizard_rift_markers))
			log_error("WARNING: There are no wizard rift locations on this map!")
			return ..()

		var/obj/marker/wizard_rift_location/RL = pick(wizard_rift_markers)

		var/obj/structure/interactive/wizard_hole/WH = new(get_turf(RL))
		WH.linked_wormhole = src
		linked_wormhole = WH
		INITIALIZE(WH)
		GENERATE(WH)
		FINALIZE(WH)

	return ..()


/obj/structure/interactive/wizard_hole/Crossed(atom/movable/O,atom/OldLoc)

	. = ..()

	if(is_living(O))
		var/mob/living/L = O
		if(L.loyalty_tag == "Wizard Federation")
			if(!linked_wormhole)
				log_error("Warning: [L.get_debug_name()] could not teleport via wormhole as there was no linked wormhole!")
			else
				L.force_move(get_step(linked_wormhole,L.dir))

