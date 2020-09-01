/obj/item/paper/book
	name = "book"
	desc = "Learn something new."
	desc_extended = "Huh. It's blank."
	icon = 'icons/obj/item/book.dmi'
	icon_state = "book_template"

	editable = FALSE

	value = 99

/obj/item/paper/book/firearms/Initialize()
	. = ..()
	name = "manual: A Guide to Firearms"
	desc_extended = "A guide on how to use and mantain modern firearms."
	data = all_paper_data["a guide to firearms"]
	return .

/obj/item/paper/book/cooking/Initialize()
	. = ..()
	name = "manual: A Guide to Cooking"
	desc_extended = "A guide on how to cook, and hopefully not burn the kitchen down."
	data = all_paper_data["a guide to cooking"]
	return .


/obj/item/paper/book/controls/Initialize()
	. = ..()
	name = "manual: A Guide to Controlling Yourself"
	desc_extended = "A guide on how to masteer self-control"
	data = all_paper_data["a guide to cooking"]
	return .

/obj/item/paper/book/controls/Initialize()
	. = ..()
	name = "manual: A Guide to Controlling Yourself"
	desc_extended = "A guide on how to masteer self-control"
	data = all_paper_data["a guide to controlling yourself"]
	return .


/obj/item/paper/book/cargo_catalog/Initialize()
	. = ..()
	name = "catalog: Cargo Catalog Vol 1"
	desc_extended = "A catalog featuring the many items you can buy from cargo."
	data = SScargo.catalog_data
	return .