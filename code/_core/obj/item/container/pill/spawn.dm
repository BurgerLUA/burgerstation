/obj/item/container/pill/bicaridine
	marking = "B 20"

/obj/item/container/pill/bicaridine/on_spawn()
	reagents.add_reagent("bicaridine",20)
	reagents.add_reagent("sugar",10)
	update_icon()

/obj/item/container/pill/kelotane
	marking = "K 20"

/obj/item/container/pill/kelotane/on_spawn()
	reagents.add_reagent("kelotane",20)
	reagents.add_reagent("sugar",10)
	update_icon()

/obj/item/container/pill/dylovene
	marking = "D 20"

/obj/item/container/pill/dylovene/on_spawn()
	reagents.add_reagent("dylovene",20)
	reagents.add_reagent("sugar",10)
	update_icon()