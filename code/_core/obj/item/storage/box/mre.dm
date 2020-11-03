/obj/item/storage/mre
	name = "MRE"
	desc = "Crayons, my favorite!"
	desc_extended = "A regular MRE that you shouldn't really find anywhere."

	icon = 'icons/obj/item/storage/mre.dmi'
	icon_state = "mre_nt"

	size = SIZE_1

	is_container = TRUE
	container_max_size = SIZE_1

	dynamic_inventory_count = 4

	value = 10

/obj/item/storage/mre/nt
	name = "NT MRE"
	desc_extended = "Prepackaged first-response combat ration issued to NanoTrasen's combat personell. Contains a raid's worth of food."

/obj/item/storage/mre/nt/filled/fill_inventory()
	new /obj/item/container/food/package/conserved/spratts(src)
	new /obj/item/container/food/package/conserved/puree(src)
	new /obj/item/container/food/package/conserved/choccy_bar(src)
	new /obj/item/container/beaker/can/cola(src)
	return ..()

/obj/item/storage/mre/syndi
	name = "Syndicate MRE"
	desc_extended = "Prepackaged defensive combat ration issued to Syndicate's guarding troops. Contains a day's worth of food, which also includes some gifts from the revolting fellows."
	icon_state = "mre_syndi"

	size = SIZE_2

	dynamic_inventory_count = 7

/obj/item/storage/mre/syndi/filled/fill_inventory()
	new /obj/item/container/food/package/conserved/spratts(src)
	new /obj/item/container/food/package/conserved/soup(src)
	new /obj/item/container/food/package/conserved/beans(src)
	new /obj/item/container/food/package/conserved/puree(src)
	new /obj/item/container/food/package/conserved/puree(src)
	new /obj/item/container/food/package/conserved/choccy_bar(src)
	new /obj/item/container/beaker/can/space_up(src)

	return ..()

/obj/item/storage/mre/rev
	name = "Revolutionaries' MRE"
	desc_extended = "Prepackaged survival ration individually hand-picked and carried by revolutionaries. Contains a huge amount of all sorts of food and is a more common sight inside the warehouse than someone's backpack due to the enormous size."
	icon_state = "mre_rev"

	size = SIZE_3

	dynamic_inventory_count = 10

/obj/item/storage/mre/rev/filled/fill_inventory()
	new /obj/item/container/food/package/conserved/spratts(src)
	new /obj/item/container/food/package/conserved/soup(src)
	new /obj/item/container/food/package/conserved/tushenka(src)
	new /obj/item/container/food/package/conserved/puree(src)
	new /obj/item/container/food/package/conserved/puree(src)
	new /obj/item/container/food/package/conserved/choccy_bar(src)
	new /obj/item/container/food/package/conserved/choccy_bar(src)
	new /obj/item/container/food/package/conserved/can(src)
	new /obj/item/container/food/package/conserved/kasha(src)
	new /obj/item/container/beaker/alcohol/vodka/premium(src)

	return ..()