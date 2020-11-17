/obj/item/paper/book/cargo_catalog/Initialize()
	. = ..()
	name = "reference: Cargo Catalog Vol 1"
	desc = "FIRE SALE ON TOOTHPASTE? FINALLY"
	desc_extended = "A catalog featuring the many items you can buy from cargo."
	data = SScargo.catalog_data.Copy()
	return .

/obj/item/paper/book/chemistry/Initialize()
	. = ..()
	name = "reference: Chemistry"
	desc = "Winners don't drugs! Besides meth."
	desc_extended = "A catalog featuring all the medical recipes known to man."
	data = SSreagent.stored_book_data["Chemistry"].Copy()
	return .