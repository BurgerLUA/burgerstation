/obj/item/paper/book
	name = "book"
	desc = "Learn something new."
	desc_extended = "Huh. It's blank."
	icon = 'icons/obj/item/book.dmi'
	icon_state = "book_template"

/obj/item/paper/book/firearms/Generate()
	name = "manual: A Guide to Firearms"
	desc_extended = "A guide on how to use and mantain modern firearms."
	data = all_paper_data["a guide to firearms"]
	return ..()

/obj/item/paper/book/cooking/Generate()
	name = "manual: A Guide to Cooking"
	desc_extended = "A guide on how to cook, and hopefully not burn the kitchen down."
	data = all_paper_data["a guide to cooking"]
	return ..()