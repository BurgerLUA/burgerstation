/obj/item/paper/book/firearms/
	name = "Manual: A Guide to Firearms"
	desc = "Use more gun."
	icon_state = "bookSpaceLaw"
	desc_extended = "A guide on how to use and mantain modern firearms."

/obj/item/paper/book/firearms/Initialize()
	. = ..()
	data = SSpaper.all_paper_data["a guide to firearms"].Copy()

/obj/item/paper/book/cooking/
	name = "Manual: A Guide to Cooking"
	desc = "she cookk me"
	icon_state = "cooked_book"
	desc_extended = "A guide on how to cook, and hopefully not burn the kitchen down or summoning demons."

/obj/item/paper/book/cooking/Initialize()
	. = ..()
	data = SSpaper.all_paper_data["a guide to cooking"].Copy()


/obj/item/paper/book/fishing/
	name = "Manual: A Guide to Fishing"
	desc = "how to enjoy life"
	icon_state = "hydrobucket"
	desc_extended = "A guide on how to fish. Gnarly!"

/obj/item/paper/book/fishing/Initialize()
	. = ..()
	data = SSpaper.all_paper_data["a guide to fishing"].Copy()

/obj/item/paper/book/ghost/
	name = "Manual: Ghosthunting Manual"
	desc = "How not to die to ghosts."
	icon_state = "bookDetective"
	desc_extended = "A reference guide on how to successfully ghosthunt."

/obj/item/paper/book/ghost/Initialize()
	. = ..()
	data = SSpaper.all_paper_data["ghosthunting guide"].Copy()

/obj/item/paper/book/controls/
	name = "Manual: A Guide to Controlling Yourself"
	desc = "Don't ERP."
	icon_state = "book2"
	desc_extended = "A guide on how to master self-control"

/obj/item/paper/book/controls/Initialize()
	. = ..()
	data = SSpaper.all_paper_data["a guide to controlling yourself"].Copy()

/obj/item/paper/book/enchanting_guide
	name = "Manual: A Guide to Enchanting"
	desc = "Don't ERP."
	icon_state = "tome_old"
	desc_extended = "A guide on how to master the art of enchanting."


/obj/item/paper/book/enchanting_guide/Initialize()
	. = ..()
	data = SSpaper.all_paper_data["a guide to enchanting"].Copy()

/obj/item/paper/book/crafting_guide/
	name = "Manual: How to Create"
	desc = "Whats this about a 'Mince-raft'?"
	icon_state = "bookCrafting"
	desc_extended = "A reference for crafting recipes."

/obj/item/paper/book/crafting_guide/Initialize()
	. = ..()
	data = SSpaper.all_paper_data["crafting recipes"].Copy()