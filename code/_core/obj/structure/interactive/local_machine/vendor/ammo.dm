/obj/structure/interactive/vending/old_ammo
	name = "ancient ammo vendor"
	desc = "What a weird selection of ammo..."
	desc_extended = "An old, surprisingly intact ammo vendor."
	icon_state = "liberationstation"

	stored_types = list()

/obj/structure/interactive/vending/old_ammo/Finalize()

	var/list/possible_ammo = (subtypesof(/obj/item/magazine/) - typesof(/obj/item/magazine/clip/)) - stored_types

	for(var/i=1,i<=12,i++)
		var/selection = pick(possible_ammo)
		possible_ammo -= selection
		CREATE(selection,src.loc)

	return ..()
