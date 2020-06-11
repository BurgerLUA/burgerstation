/obj/item/paper/book
	name = "book"
	desc = "Learn something new."
	desc_extended = "Huh. It's blank."
	icon = 'icons/obj/items/book.dmi'
	icon_state = "book_template"

/obj/item/paper/book/firearms/Generate()
	name = "manual: A Guide to Firearms"
	data = all_paper_data["a guide to firearms"]
	return ..()

/obj/item/paper/book/cooking/Generate()
	name = "manual: A Guide to Cooking"
	data = all_paper_data["a guide to cooking"]
	return ..()