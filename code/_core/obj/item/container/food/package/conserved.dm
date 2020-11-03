/obj/item/container/food/package/conserved
	icon = 'icons/obj/item/consumable/food/conserved.dmi'
	packaging = /obj/item/trash/candy

/obj/item/container/food/package/conserved/update_icon()
	icon_state = initial(icon_state)
	if(!packaging)
		icon_state = "[icon_state]_open"
	return ..()


/obj/item/container/food/package/conserved/unwrap(var/mob/caller,var/obj/hud/inventory/I)

	. = ..()

	if(.) update_sprite()

	return .

/obj/item/container/food/package/conserved/spratts
	name = "/improper military-grade canned spratts"
	desc = "Goes well with vodka and rye bread!"
	desc_extended = "Tin can of baltic spratts, produced and shipped by one of the local independent fish farms. Commonly found in the revolutionaries' MREs, but occasionaly NanoTrasen or Syndicate buys a shipment of those, because they're fucking good."
	icon_state = "fish"

/obj/item/container/food/package/conserved/spratts/Generate()
	reagents.add_reagent(/reagent/nutrition/meat/fish/cooked/spratts,16)
	reagents.add_reagent(/reagent/salt,8)
	return ..()

/obj/item/container/food/package/conserved/soup
	name = "/proper Tovarisch Povar's canned borscht'"
	desc = "Bias overload."
	desc_extended = "Tin can of ukrainian spiced red-beet borscht with potatoes, ham, smetana and cabbage. Pre-heats by itself, thanks to the chemicals that start the heating process on the contact with oxygen. Pricy!"
	icon_state = "soup"

/obj/item/container/food/package/conserved/soup/Generate()
	reagents.add_reagent(/reagent/nutrition/borscht,20)
	reagents.add_reagent(/reagent/salt,4)

/obj/item/container/food/package/conserved/beans
	name = "/proper Cowboy Dave's Pork and Beans"
	desc = "Yee-haw!"
	desc_extended = "Massive can of American pork with beans, heavily spiced with salt and pepper. Favorite among wannabe cowboys, preppers and such."
	icon_state = "beans"

/obj/item/container/food/package/conserved/beans/Generate()
	reagents.add_reagent(/reagent/nutrition/bean,10)
	reagents.add_reagent(/reagent/nutrition/meat/cooked,10)
	reagents.add_reagent(/reagent/salt,4)

/obj/item/container/food/package/conserved/tushenka
	name = "/improper military-grade tushenka"
	desc = "Geez, hopefully it's an actual meat."
	desc_extended = "Yet another tin can of stewed meat, carefully canned and produced in one of the revs' food facilities. Tastes as good as it looks, but at least you won't die of hunger."
	icon_state = "can"

/obj/item/container/food/package/conserved/tushenka/Generate()
	reagents.add_reagent(/reagent/nutrition/tushenka,20)
	reagents.add_reagent(/reagent/nutrition/salt,4)

/obj/item/container/food/package/conserved/puree
	name = "/improper dehydrated potato mash mass"
	desc = "Tastes like crap, yet is filling."
	desc_extended = "Water-resistant carton with what seems to be a dried potato powder mixed with various spices and weed. Isn't especially tasty, yet it serves as a neat breakfast, lunch and supper, as long as you eat it with different main courses."
	icon_state = "puree"

/obj/item/container/food/package/conserved/puree/Generate()
	reagents.add_reagent(/reagent/nutrition/puree/dry,20)
	reagents.add_reagent(/reagent/water,10)

/obj/item/container/food/package/conserved/can
	name = "/improper military-grade unknown meat mass"
	desc = "Soylent Green is people!"
	desc_extended = "Pretty generic can with what seems to be a meat... something. Such cans of meat are a commong sight inside any MRE package, mostly due to the fact their main manufacturer helds monopoly among such products, especially in warzones. On the other hand, there were unconfirmed reports of PMCs' bodies' disappearing or even carried away by the company's androids on the battlefield... you sure you want to eat that anymore?"
	icon_state = "cang"

/obj/item/container/food/package/conserved/can/Generate()
	reagents.add_reagent(/reagent/nutrition/tushenka/merc,20)


/obj/item/container/food/package/conserved/kasha
	name = "/improper vacuum-sealed pack of oatmeal porridge"
	desc = "Just like babushka used to make!"
	desc_extended = "Vacuum-sealed vitaminized package of boiled oatmeal porridge with raisins and milk. On the battlefield where healthy food is scarce, such thing would be priceless for the hungry mercenary."
	icon_state = "kasha"

/obj/item/container/food/package/conserved/kasha/Generate()
	reagents.add_reagent(/reagent/nutrition/oatmeal,30)



/obj/item/container/food/package/conserved/choccy_bar
	name = "/improper bar of dark chocolate"
	desc = "Military candy."
	desc_extended = "Obligatory bar of dark chocolate that comes with almost any MRE you'd find in this region. Tastes like bitter plastic mixed with cheap chocolate powder and sugar subtitutes, but, hey, free chocolate!"
	icon_state = "choco"

/obj/item/container/food/package/conserved/choccy_bar/Generate()
	reagents.add_reagent(/reagent/nutrition/choccy,25)
