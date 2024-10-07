/obj/item/container/simple/chemistry
	desc = "Today we're gonna be doing some cool science. DRUG SCIENCE!"
	desc_extended = "Reagent container most likely containing chemicals for chemistry."
	icon = 'icons/obj/item/container/chemistry.dmi'
	icon_state = null
	reagents = /reagent_container/beaker/bottle/large
	size = SIZE_3

	var/reagent/reagent_to_add

/obj/item/container/simple/chemistry/Generate()
	. = ..()
	if(reagents && reagent_to_add)
		reagents.add_reagent(reagent_to_add,reagents.volume_max)

/obj/item/container/simple/chemistry/ammonia
	name = "ammonia jug"
	icon_state = "ammonia"
	reagent_to_add = /reagent/ammonia
	value = 1

/obj/item/container/simple/chemistry/sodium_chloride
	name = "sodium chloride bottle"
	icon_state = "sodium_chloride"
	reagents = /reagent_container/beaker/bottle
	reagent_to_add = /reagent/salt/sodium_chloride
	value = 1

/obj/item/container/simple/chemistry/sulfur
	name = "sulfur bottle"
	icon_state = "sulfur"
	reagents = /reagent_container/beaker/bottle
	reagent_to_add = /reagent/sulfur
	value = 1

/obj/item/container/simple/chemistry/silicon
	name = "silicon bottle"
	icon_state = "silicon"
	reagents = /reagent_container/beaker/bottle
	reagent_to_add = /reagent/silicon
	value = 1

/obj/item/container/simple/chemistry/acetone
	name = "acetone jug"
	icon_state = "acetone"
	reagent_to_add = /reagent/fuel/acetone
	value = 1

/obj/item/container/simple/chemistry/phenol
	name = "phenol jug"
	icon_state = "phenol"
	reagent_to_add = /reagent/phenol
	value = 1