/obj/item/paper/book
	name = "book"
	desc = "Learn something new."
	desc_extended = "Huh. It's blank."
	icon = 'icons/obj/item/book.dmi'
	icon_state = "book_template"

	editable = FALSE

	value = 49

/obj/item/paper/book/firearms/Initialize()
	. = ..()
	name = "manual: A Guide to Firearms"
	desc = "Use more gun."
	desc_extended = "A guide on how to use and mantain modern firearms."
	data = all_paper_data["a guide to firearms"].Copy()
	return .

/obj/item/paper/book/cooking/Initialize()
	. = ..()
	name = "manual: A Guide to Cooking"
	desc = "she cookk me"
	desc_extended = "A guide on how to cook, and hopefully not burn the kitchen down or summoning demons."
	data = all_paper_data["a guide to cooking"].Copy()
	return .

/obj/item/paper/book/controls/Initialize()
	. = ..()
	name = "manual: A Guide to Controlling Yourself"
	desc = "Don't ERP."
	desc_extended = "A guide on how to master self-control"
	data = all_paper_data["a guide to controlling yourself"].Copy()
	return .

/obj/item/paper/book/cargo_catalog/Initialize()
	. = ..()
	name = "catalog: Cargo Catalog Vol 1"
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

/obj/item/paper/book/ghost/Initialize()
	. = ..()
	name = "reference:Ghosthunting Manual"
	desc = "How not to die to ghosts."
	desc_extended = "A reference guide on how to successfully ghosthunt."
	data = SSreagent.stored_book_data["Ghosthunting Manual"].Copy()
	return .