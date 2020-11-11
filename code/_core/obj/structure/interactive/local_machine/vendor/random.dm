/obj/structure/interactive/vending/random
	name = "mystery vendor"
	desc = "What a weird selection of things.."
	desc_extended = "An old, suprisingly intact vendor that contains... what?"
	icon_state = "magivend"

	stored_types = list()

/obj/structure/interactive/vending/random/Finalize()

	markup = rand(2,4)

	CREATE_LOOT(/loot/trash_pile,src.loc)

	return ..()