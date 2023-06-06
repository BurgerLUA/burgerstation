/obj/item/paper/book/cargo_catalog/
	name = "reference: Cargo Catalog Vol 1"
	desc = "FIRE SALE ON TOOTHPASTE? FINALLY"
	icon_state = "book3"
	desc_extended = "A catalog featuring the many items you can buy from cargo."


/obj/item/paper/book/cargo_catalog/Initialize()
	. = ..()
	data = SScargo.catalog_data.Copy()

/obj/item/paper/book/chemistry/
	name = "reference: Chemistry"
	desc = "Winners don't drugs! Besides meth."
	icon_state = "chemistrybook"
	desc_extended = "A catalog featuring all the medical recipes known to man."

/obj/item/paper/book/chemistry/Initialize()
	. = ..()
	data = SSreagent.stored_book_data["Chemistry"].Copy()

/*
/obj/item/paper/book/cookingchem/Initialize()
	. = ..()
	name = "reference: Cooking Recipes"
	desc = "I am the one who cooks burgers."
	desc_extended = "A catalog featuring all the cooking recipes known to man."
	icon_state = "chefbook"
	data =

/obj/item/paper/book/bartending/Initialize()
	. = ..()
	name = "reference: Mixing Drinks"
	desc = "Drinks are on you from now on"
	icon_state = "barbook"
	desc_extended = "A catalog featuring all the drink recipes known to man."
	data =
*/

//I am not touching book code, someone please add these.
