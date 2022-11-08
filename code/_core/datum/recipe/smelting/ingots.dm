/recipe/smelter/iron
	name = "smelt iron ore"
	desc = "Smelt iron into iron ingots."
	required_items = list("/obj/item/material/ore/iron" = 3)
	product = list("/obj/item/material/ingot/iron" =100)

/recipe/smelter/steel
	name = "smelt steel"
	desc = "Smelt iron and coal into iron ingots."
	required_items = list("/obj/item/material/ingot/iron" = 1,"/obj/item/material/ore/carbon" = 2)
	product = list("/obj/item/material/ingot/steel" =100)

/recipe/smelter/cobalt
	name = "smelt cobalt"
	desc = "Smelt cobalt ore into cobalt ingots"
	required_items = list("/obj/item/material/ingot/cobalt" = 3)
	product = list("/obj/item/material/ingot/cobalt" =100)

/recipe/smelter/gold
	name = "smelt gold"
	desc = "Smelt gold into gold bars."
	required_items = list("/obj/item/material/ore/gold" = 3)
	product = list("/obj/item/material/ingot/gold" =100)

/recipe/smelter/silver
	name = "smelt silver"
	desc = "Smelt silver into silver bars."
	required_items = list("/obj/item/material/ore/silver" = 3)
	product = list("/obj/item/material/ingot/silver" =100)

/recipe/smelter/electrum
	name = "smelt electrum"
	desc = "Smelt silver and gold into electrum ingots."
	required_items = list("/obj/item/material/ingot/gold" = 1,"/obj/item/material/ingot/silver" = 1)
	product = list("/obj/item/material/ingot/electrum" =100)
	amount = list(2)

/recipe/smelter/diamond
	name = "compress diamonds"
	desc = "smelt diamond dust into diamonds"
	required_items = list("/obj/item/material/ore/diamond" = 3)
	product = list("/obj/item/material/ingot/diamond" =100)

/recipe/smelter/uranium
	name = "smelt uranium"
	desc = "Smelt pitchblende into uranium ingots."
	required_items = list("/obj/item/material/ore/uranium" = 3)
	product = list("/obj/item/material/ingot/uranium" =100)

/recipe/smelter/titanium
	name = "smelt titanium"
	desc = "Smelt titanium into titanium ingots."
	required_items = list("/obj/item/material/ore/titanium" = 3)
	product = list("/obj/item/material/ingot/titanium" =100)

/recipe/smelter/zinc
	name = "smelt zinc"
	desc = "Smelt zinc into zinc ingots."
	required_items = list("/obj/item/material/ore/zinc" = 3)
	product = list("/obj/item/material/ingot/zinc" =100)

/recipe/smelter/magnesium
	name = "smelt magnesium"
	desc = "Smelt magnesium into magnesium ingots."
	required_items = list("/obj/item/material/ore/magnesium" = 3)
	product = list("/obj/item/material/ingot/magnesium" =100)

/recipe/smelter/phoron
	name = "compress phoron"
	desc = "Compress phoron into phoron crystals."
	required_items = list("/obj/item/material/ore/plasma" = 3)
	product = list("/obj/item/material/ingot/phoron" =100)

/recipe/smelter/plasteel
	name = "alloy plasteel"
	desc = "alloy steel and phoron into plasteel sheets."
	required_items = list("/obj/item/material/ingot/steel" = 1,"/obj/item/material/ingot/phoron" = 1)
	product = list("/obj/item/material/ingot/plasteel" =100)

/recipe/smelter/aluminium
	name = "smelt aluminium"
	desc = "smelt aluminium into aluminium ingots."
	required_items = list("/obj/item/material/ore/aluminium" = 3)
	product = list("/obj/item/material/ingot/aluminium" =100)

/recipe/smelter/nickel
	name = "smelt nickel"
	desc = "smelt nickel into nickel ingots."
	required_items = list("/obj/item/material/ore/nickel" = 3)
	product = list("/obj/item/material/ingot/nickel" =100)

/recipe/smelter/uranium_235
	name = "alloy uranium plasma"
	desc = "alloy uranium and plasma for uranium 235"
	required_items = list("/obj/item/material/ingot/uranium" = 2,"/obj/item/material/ingot/plasma" = 1)
	product = list("/obj/item/material/ingot/uranium_235" =75)
	fail_product = list("/obj/item/material/ingot/uranium" = 100)
