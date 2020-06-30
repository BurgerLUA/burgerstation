/obj/structure/interactive/plastic_flaps
	name = "airtight plastic flaps"
	desc = "Impassable flaps. What kind of sorcery is this?"
	desc_extended = "Somehow prevents air and *large* beings from crossing."
	anchored = TRUE
	icon = 'icons/obj/structure/plastic_flaps.dmi'
	icon_state = "plastic_flaps"
	plane = PLANE_WALL

	bullet_block_chance = 25

/obj/structure/interactive/plastic_flaps/Cross(atom/movable/O)

	if(is_living(O))
		var/mob/living/L = O
		if(!L.horizontal)
			return FALSE

	return ..()