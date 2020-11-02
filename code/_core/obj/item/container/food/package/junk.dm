/obj/item/container/food/package/junkfood
	name = "junk food"
	icon = 'icons/obj/item/consumable/food/processed.dmi'

/obj/item/container/food/package/junkfood/chips
	name = "chippy crisps"
	desc = "Hmm, tastes like mediocrity!"
	desc_extended = "Plain flavoured, much like the people who eat these."
	icon_state = "chips"

/obj/item/container/food/package/junkfood/chips/Initialize()
	name = pick("chippy crisps","cripsy chips")
	return ..()

/obj/item/container/food/package/junkfood/chips/Generate()
	reagents.add_reagent(/reagent/nutrition/junk/chips,20)
	reagents.add_reagent(/reagent/salt,10)
	return ..()


/obj/item/container/food/package/junkfood/candy
	name = "getmore candy bar"
	desc = "Nougat, love it or at it."
	desc_extended = "An actually pretty good chocolate bar."
	icon_state = "candy"

/obj/item/container/food/package/junkfood/candy/Generate()
	reagents.add_reagent(/reagent/nutrition/junk/chocolate,10)
	reagents.add_reagent(/reagent/nutrition/sugar,5)
	return ..()



/obj/item/container/food/package/junkfood/jerky
	name = "sos jerky"
	desc = "For that refueling station feel."
	desc_extended = "A package containing dried pieces of meat. Common in refueling station snack shops for some reason."
	icon_state = "jerky"

/obj/item/container/food/package/junkfood/jerky/Generate()
	reagents.add_reagent(/reagent/nutrition/junk/jerky,15)
	reagents.add_reagent(/reagent/salt,5)
	return ..()

/obj/item/container/food/package/junkfood/raisins
	name = "4no raisins"
	desc = "admins pls halp"
	desc_extended = "This raisins brand mascot, called the raisin shitter, has been voted the least popular mascot for 75 years in a row."
	icon_state = "raisins"

/obj/item/container/food/package/junkfood/raisins/Generate()
	reagents.add_reagent(/reagent/nutrition/junk/raisins,10)
	reagents.add_reagent(/reagent/salt,5)
	reagents.add_reagent(/reagent/nutrition/sugar,5)
	return ..()


/obj/item/container/food/package/junkfood/cake
	name = "space cream cake"
	desc = "Will probably live longer than you."
	desc_extended = "A cream cake that is held very importantly by some people despite being junk food."
	icon_state = "cake"

/obj/item/container/food/package/junkfood/cake/Generate()
	reagents.add_reagent(/reagent/nutrition/junk/cake,10)
	reagents.add_reagent(/reagent/nutrition/junk/cream_filling,5)
	reagents.add_reagent(/reagent/nutrition/sugar,5)
	return ..()


/obj/item/container/food/package/junkfood/syndicate
	name = "syndi-cakes"
	desc = "Hmm, tastes like betrayal!"
	desc_extended = "Legends has it that the reason why this is on sale here despite being a Syndie product is that Jack Trasen can't get enough of these."
	icon_state = "syndicate"

/obj/item/container/food/package/junkfood/syndicate/Generate()
	reagents.add_reagent(/reagent/nutrition/junk/cake,10)
	reagents.add_reagent(/reagent/medicine/omnizine,10)
	return ..()

/obj/item/container/food/package/junkfood/cheese_chips
	name = "cheese honkers"
	desc = "A cheesie snack that will honk all over your mouth."
	desc_extended = "A cheese chip that for some reason uses clown branding."
	icon_state = "cheesie_honkers"

/obj/item/container/food/package/junkfood/cheese_chips/Generate()
	reagents.add_reagent(/reagent/nutrition/junk/chips,10)
	reagents.add_reagent(/reagent/salt,5)
	reagents.add_reagent(/reagent/nutrition/junk/cheese_powder,15)
	return ..()


/obj/item/container/food/package/junkfood/halloween
	icon = 'icons/obj/item/consumable/food/candy.dmi'
	packaging = /obj/item/trash/candy

/obj/item/container/food/package/junkfood/halloween/update_icon()
	icon_state = initial(icon_state)
	if(!packaging)
		icon_state = "[icon_state]_open"
	return ..()


/obj/item/container/food/package/junkfood/halloween/unwrap(var/mob/caller,var/obj/hud/inventory/I)

	. = ..()

	if(.) update_sprite()

	return .

/obj/item/container/food/package/junkfood/halloween/create_packaging()
	var/obj/item/trash/T = ..()
	T.icon = icon
	T.icon_state = "[initial(icon_state)]_trash"
	return T

/obj/item/container/food/package/junkfood/halloween/credit
	name = "100 credit bar"
	icon_state = "100_credit_bar"

/obj/item/container/food/package/junkfood/halloween/credit/Generate()
	reagents.add_reagent(/reagent/nutrition/junk/chocolate,5)
	reagents.add_reagent(/reagent/nutrition/sugar/caramel,3)
	reagents.add_reagent(/reagent/nutrition/sugar,2)
	reagents.add_reagent(/reagent/nutrition/junk/crisp_rice,5)
	return ..()

/obj/item/container/food/package/junkfood/halloween/coconut_joy
	name = "coconut joy"
	icon_state = "coconut_joy"

/obj/item/container/food/package/junkfood/halloween/coconut_joy/Generate()
	reagents.add_reagent(/reagent/nutrition/junk/chocolate,6)
	reagents.add_reagent(/reagent/nutrition/sugar,5)
	reagents.add_reagent(/reagent/nutrition/coconut,4)
	return ..()

/obj/item/container/food/package/junkfood/halloween/hurr_bar
	name = "hurr bar"
	icon_state = "hurr_bar"

/obj/item/container/food/package/junkfood/halloween/hurr_bar/Generate()
	reagents.add_reagent(/reagent/nutrition/junk/chocolate,5)
	reagents.add_reagent(/reagent/nutrition/sugar,10)
	return ..()


/obj/item/container/food/package/junkfood/halloween/sniggers_bar
	name = "sniggers bar"
	icon_state = "sniggers_bar"

/obj/item/container/food/package/junkfood/halloween/sniggers_bar/Generate()
	reagents.add_reagent(/reagent/nutrition/junk/chocolate,5)
	reagents.add_reagent(/reagent/nutrition/nut,5)
	reagents.add_reagent(/reagent/nutrition/sugar/caramel,5)
	return ..()


/obj/item/container/food/package/junkfood/halloween/kit_catgirl_metaclique_bar
	name = "kit-catgirl metaclique bar"
	icon_state = "kit_catgirl_metaclique_bar"

/obj/item/container/food/package/junkfood/halloween/kit_catgirl_metaclique_bar/Generate()
	reagents.add_reagent(/reagent/nutrition/junk/chocolate,5)
	reagents.add_reagent(/reagent/nutrition/junk/wafer,10)
	return ..()


/obj/item/container/food/package/junkfood/halloween/twink_bar
	name = "twink bar"
	icon_state = "twink_bar"

/obj/item/container/food/package/junkfood/halloween/twink_bar/Generate()
	reagents.add_reagent(/reagent/nutrition/junk/chocolate,5)
	reagents.add_reagent(/reagent/nutrition/junk/cookie,7)
	reagents.add_reagent(/reagent/nutrition/sugar/caramel,7)
	return ..()

/obj/item/container/food/package/junkfood/halloween/elon_musk_bar
	name = "elon \"husky musk\" bar"
	icon_state = "elon_musk_bar"

/obj/item/container/food/package/junkfood/halloween/elon_musk_bar/Generate()
	reagents.add_reagent(/reagent/nutrition/junk/chocolate,5)
	reagents.add_reagent(/reagent/nutrition/junk/nougat,10)
	return ..()

/obj/item/container/food/package/junkfood/halloween/malf_way
	name = "\improper MALF way bar"
	icon_state = "malf_way"

/obj/item/container/food/package/junkfood/halloween/malf_way/Generate()
	reagents.add_reagent(/reagent/nutrition/junk/chocolate,5)
	reagents.add_reagent(/reagent/nutrition/junk/nougat,10)
	return ..()

/obj/item/container/food/package/junkfood/halloween/triggerfinger
	name = "triggerfinger bar"
	icon_state = "triggerfinger"

/obj/item/container/food/package/junkfood/halloween/triggerfinger/Generate()
	reagents.add_reagent(/reagent/nutrition/junk/chocolate,5)
	reagents.add_reagent(/reagent/nutrition/nut/butter,5)
	reagents.add_reagent(/reagent/nutrition/sugar,5)
	return ..()
