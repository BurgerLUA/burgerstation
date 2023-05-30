/obj/structure/interactive/vending/random
	name = "mystery vendor"
	desc = "What a weird selection of things.."
	desc_extended = "An old, surprisingly intact vendor that contains... what?"
	icon_state = "sustenance"

	stored_types = list()

	ignore_economy = TRUE

	accepts_item = /obj/item/currency/dosh

	health = null

/obj/structure/interactive/vending/random/Finalize()

	markup = rand(2,4)

	for(var/i=1,i<=rand(3,6),i++)
		switch(rand(1,3))
			if(1)
				SPAWN_LOOT(/loot/random/trash,src.loc)
			if(2)
				SPAWN_LOOT(/loot/random/low,src.loc)
			if(3)
				SPAWN_LOOT(/loot/random/medium,src.loc)

	return ..()
