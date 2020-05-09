/obj/item/container/pill/bicaridine
	name = "bicaridine pill (20u)"

/obj/item/container/pill/bicaridine/on_spawn()
	reagents.add_reagent("bicaridine",20)
	return ..()

/obj/item/container/pill/kelotane
	name = "kelotane pill (20u)"

/obj/item/container/pill/kelotane/on_spawn()
	reagents.add_reagent("kelotane",20)
	return ..()

/obj/item/container/pill/dylovene
	name = "dylovene pill (20u)"

/obj/item/container/pill/dylovene/on_spawn()
	reagents.add_reagent("dylovene",20)
	return ..()

/obj/item/container/pill/iron
	name = "iron pill (20u)"

/obj/item/container/pill/iron/on_spawn()
	reagents.add_reagent("iron",20)
	return ..()

/obj/item/container/pill/space_drugs
	name = "space drugs (5u)"
	icon_state = "circle"

/obj/item/container/pill/space_drugs/on_spawn()
	reagents.add_reagent("space_drugs",5)
	return ..()


/obj/item/container/pill/space_dust
	name = "space dust (10u)"
	icon_state = "circle"

/obj/item/container/pill/space_drugs/on_spawn()
	reagents.add_reagent("space_dust",10)
	return ..()