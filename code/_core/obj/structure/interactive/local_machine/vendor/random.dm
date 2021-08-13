/obj/structure/interactive/vending/random
	name = "mystery vendor"
	desc = "What a weird selection of things.."
	desc_extended = "An old, surprisingly intact vendor that contains... what?"
	icon_state = "sustenance"

	stored_types = list()

	ignore_economy = TRUE

/obj/structure/interactive/vending/random/Finalize()

	markup = rand(4,8)

	CREATE_LOOT(/loot/trash_pile,src.loc)

	return ..()
