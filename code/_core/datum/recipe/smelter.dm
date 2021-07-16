/recipe/smelter/
	name = "smelting recipe"
	desc = "A smelting recipe"
	desc_extended = "Smelting recipe information."

	required_item_grid = list()
	required_items = list()

	recipe_type = "smelter"

/recipe/smelter/iron
	name = "smelt iron ore"
	desc = "Smelt iron into iron ingots."
	required_items = list("ore_iron")
	product = /obj/item/material/ingot/iron

/recipe/smelter/steel
	name = "smelt steel"
	desc = "Smelt steel and coal into iron ingots."
	required_items = list("ingot_iron","ore_carbon")
	product = /obj/item/material/ingot/steel

/recipe/smelter/gold
	name = "smelt gold"
	desc = "Smelt gold into gold bars."
	required_items = list("ore_gold")
	product = /obj/item/material/ingot/gold

/recipe/smelter/silver
	name = "smelt silver"
	desc = "Smelt silver into silver bars."
	required_items = list("ore_silver")
	product = /obj/item/material/ingot/silver

/recipe/smelter/electrum
	name = "smelt electrum"
	desc = "Smelt silver and gold into electrum ingots."
	required_items = list("ingot_gold","ingot_silver")
	product = /obj/item/material/ingot/electrum

/recipe/smelter/diamond
	name = "compress diamonds"
	desc = "smelt diamond dust into diamonds"
	required_items = list("ore_diamond")
	product = /obj/item/material/ingot/diamond

/recipe/smelter/uranium
	name = "smelt uranium"
	desc = "Smelt pitchblende into uranium ingots."
	required_items = list("ore_uranium")
	product = /obj/item/material/ingot/uranium

/recipe/smelter/titanium
	name = "smelt titanium"
	desc = "Smelt titanium into titanium ingots."
	required_items = list("ore_titanium")
	product = /obj/item/material/ingot/titanium

/recipe/smelter/zinc
	name = "smelt zinc"
	desc = "Smelt zinc into zinc ingots."
	required_items = list("ore_zinc")
	product = /obj/item/material/ingot/zinc

/recipe/smelter/magnesium
	name = "smelt magnesium"
	desc = "Smelt magnesium into magnesium ingots."
	required_items = list("ore_magnesium")
	product = /obj/item/material/ingot/magnesium

/recipe/smelter/phoron
	name = "compress phoron"
	desc = "Compress phoron into phoron crystals."
	required_items = list("ore_phoron")
	product = /obj/item/material/ingot/phoron

/recipe/smelter/plasteel
	name = "alloy plasteel"
	desc = "alloy steel and phoron into plasteel sheets."
	required_items = list("ingot_steel","ingot_phoron")
	product = /obj/item/material/ingot/plasteel

/recipe/smelter/aluminium
	name = "smelt aluminium"
	desc = "smelt aluminium into aluminium ingots."
	required_items = list("ore_aluminium")
	product = /obj/item/material/ingot/aluminium