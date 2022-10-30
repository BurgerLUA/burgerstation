/obj/item/paper/book/firearms/Initialize()
	. = ..()
	name = "manual: A Guide to Firearms"
	desc = "Use more gun."
	icon_state = "rulebook"
	desc_extended = "A guide on how to use and mantain modern firearms."
	data = SSpaper.all_paper_data["a guide to firearms"].Copy()

/obj/item/paper/book/cooking/Initialize()
	. = ..()
	name = "manual: A Guide to Cooking"
	desc = "she cookk me"
	icon_state = "chefbook"
	desc_extended = "A guide on how to cook, and hopefully not burn the kitchen down or summoning demons."
	data = SSpaper.all_paper_data["a guide to cooking"].Copy()

/obj/item/paper/book/fishing/Initialize()
	. = ..()
	name = "manual: A Guide to Fishing"
	desc = "how to enjoy life"
	icon_state = "book4"
	desc_extended = "A guide on how to fish. Gnarly!"
	data = SSpaper.all_paper_data["a guide to fishing"].Copy()

/obj/item/paper/book/ghost/Initialize()
	. = ..()
	name = "manual: Ghosthunting Manual"
	desc = "How not to die to ghosts."
	icon_state = "tome"
	desc_extended = "A reference guide on how to successfully ghosthunt."
	data = SSpaper.all_paper_data["ghosthunting guide"].Copy()

/obj/item/paper/book/controls/Initialize()
	. = ..()
	name = "manual: A Guide to Controlling Yourself"
	desc = "Don't ERP."
	icon_state = "cqcmanual"
	desc_extended = "A guide on how to master self-control"
	data = SSpaper.all_paper_data["a guide to controlling yourself"].Copy()

/obj/item/paper/book/enchanting_guide/Initialize()
	. = ..()
	name = "manual: A Guide to Enchanting"
	desc = "Don't ERP."
	icon_state = "bookfancy"
	desc_extended = "A guide on how to master the art of enchanting."
	data = SSpaper.all_paper_data["a guide to enchanting"].Copy()
