/obj/item/paper/book/firearms/Initialize()
	. = ..()
	name = "manual: A Guide to Firearms"
	desc = "Use more gun."
	desc_extended = "A guide on how to use and mantain modern firearms."
	data = SSpaper.all_paper_data["a guide to firearms"].Copy()
	return .

/obj/item/paper/book/cooking/Initialize()
	. = ..()
	name = "manual: A Guide to Cooking"
	desc = "she cookk me"
	desc_extended = "A guide on how to cook, and hopefully not burn the kitchen down or summoning demons."
	data = SSpaper.all_paper_data["a guide to cooking"].Copy()
	return .

/obj/item/paper/book/ghost/Initialize()
	. = ..()
	name = "manual: Ghosthunting Manual"
	desc = "How not to die to ghosts."
	desc_extended = "A reference guide on how to successfully ghosthunt."
	data = SSpaper.all_paper_data["ghosthunting guide"].Copy()
	return .

/obj/item/paper/book/controls/Initialize()
	. = ..()
	name = "manual: A Guide to Controlling Yourself"
	desc = "Don't ERP."
	desc_extended = "A guide on how to master self-control"
	data = SSpaper.all_paper_data["a guide to controlling yourself"].Copy()
	return .