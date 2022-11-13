/obj/structure/interactive/plastic_flaps
	name = "airtight plastic flaps"
	desc = "Impassable flaps. What kind of sorcery is this?"
	desc_extended = "Somehow prevents air and *large* beings from crossing."
	anchored = TRUE
	icon = 'icons/obj/structure/plastic_flaps.dmi'
	icon_state = "plastic_flaps"
	plane = PLANE_SCENERY

	bullet_block_chance = 25

	density = TRUE

/obj/structure/interactive/plastic_flaps/Cross(atom/movable/O,atom/oldloc)

	if(is_living(O))
		var/mob/living/L = O
		if(!L.horizontal)
			return FALSE

	return ..()

/obj/structure/interactive/plastic_flaps/clicked_on_by_object(mob/caller, atom/object, location, control, params)
	if(istype(object,/obj/item))
		var/obj/item/T = object
		if(T.flags_tool & FLAG_TOOL_WRENCH)
			if(anchored)
				caller.to_chat(span("notice","You un-anchor the flaps."))
				anchored = FALSE
			else
				caller.to_chat(span("notice","You anchor the flaps."))
				anchored = TRUE
	. = ..()
