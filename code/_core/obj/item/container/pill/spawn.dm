/obj/item/container/pill/bicaridine
	name = "bicaridine pill (20u)"

/obj/item/container/pill/bicaridine/Generate()
	reagents.add_reagent(/reagent/medicine/bicaridine,20)
	return ..()

/obj/item/container/pill/kelotane
	name = "kelotane pill (20u)"

/obj/item/container/pill/kelotane/Generate()
	reagents.add_reagent(/reagent/medicine/kelotane,20)
	return ..()

/obj/item/container/pill/dylovene
	name = "dylovene pill (20u)"

/obj/item/container/pill/dylovene/Generate()
	reagents.add_reagent(/reagent/medicine/dylovene,20)
	return ..()

/obj/item/container/pill/calomel
	name = "calomel pill (20u)"

/obj/item/container/pill/calomel/Generate()
	reagents.add_reagent(/reagent/medicine/purge,20)
	return ..()

/obj/item/container/pill/charcoal
	name = "charcoal pill (20u)"

/obj/item/container/pill/charcoal/Generate()
	reagents.add_reagent(/reagent/medicine/charcoal,20)
	return ..()

/obj/item/container/pill/iron
	name = "iron pill (20u)"

/obj/item/container/pill/iron/Generate()
	reagents.add_reagent(/reagent/iron,20)
	return ..()

/obj/item/container/pill/space_drugs
	name = "space drugs (5u)"
	icon_state = "circle"

/obj/item/container/pill/space_drugs/Generate()
	reagents.add_reagent(/reagent/drug/space,5)
	return ..()


/obj/item/container/pill/space_dust
	name = "space dust (10u)"
	icon_state = "circle"

/obj/item/container/pill/space_dust/Generate()
	reagents.add_reagent(/reagent/drug/liberty_dust,10)
	return ..()


/obj/item/container/pill/omnizine
	name = "omnizine pill (20u)"

/obj/item/container/pill/omnizine/Generate()
	reagents.add_reagent(/reagent/medicine/omnizine,20)
	return ..()

/obj/item/container/pill/antihol
	name = "antihol pill (20u)"

/obj/item/container/pill/antihol/Generate()
	reagents.add_reagent(/reagent/medicine/antihol,20)
	return ..()