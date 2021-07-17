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

/recipe/smelter/nickel
	name = "smelt nickel"
	desc = "smelt nickel into nickel ingots."
	required_items = list("ore_nickel")
	product = /obj/item/material/ingot/nickel

/recipe/smelter/aluminium_gun
	name = "smelt Aluminium-2045"
	desc = "alloy various metals into gun aluminium."
	required_items = list("ingot_zinc","ingot_aluminium","ingot_magnesium")
	product = /obj/item/crafting/ingredient/alloy/aluminium/gun

/recipe/smelter/aluminium_armor
	name = "smelt Aluminium-4090"
	desc = "alloy various metals into armor aluminium."
	required_items = list("Al_2045","ingot_phoron","ore_carbon")
	product = /obj/item/crafting/ingredient/alloy/aluminium/armor

/recipe/smelter/steel_gun
	name = "smelt Steel-4150"
	desc = "alloy various metals into gun steel."
	required_items = list("sheet_steel","sheet_steel","ingot_magnesium")
	product = /obj/item/crafting/ingredient/alloy/steel/gun

/recipe/smelter/steel_armor
	name = "smelt Steel-9300"
	desc = "alloy gun steel with highly carbonised gem into armor steel."
	required_items = list("FeC_4150","ingot_diamond")
	product = /obj/item/crafting/ingredient/alloy/steel/armor

/recipe/smelter/nickel_gun
	name = "smelt Nickel-7075"
	desc = "alloy various metals into gun nickel."
	required_items = list("ingot_nickel","ingot_zinc","ingot_electrum")
	product = /obj/item/crafting/ingredient/alloy/nickel/gun

/recipe/smelter/nickel_armor
	name = "smelt Nickel-14150"
	desc = "alloy various metals into armor nickel."
	required_items = list("Ni_7075","ingot_phoron","ingot_diamond")
	product = /obj/item/crafting/ingredient/alloy/nickel/armor

/recipe/smelter/titanium_gun
	name = "smelt Titanium-9180"
	desc = "alloy various metals into gun titanium."
	required_items = list("ingot_titanium","ingot_zinc","ingot_magnesium")
	product = /obj/item/crafting/ingredient/alloy/titanium/gun

/recipe/smelter/titanium_armor
	name = "smelt Titanium-18360"
	desc = "alloy various metals into armor titanium."
	required_items = list("Ti_9180","sheet_steel","ore_uranium")
	product = /obj/item/crafting/ingredient/alloy/titanium/armor

/recipe/smelter/plasteel_gun
	name = "smelt Plasteel-20000"
	desc = "alloy various metals into gun plasteel."
	required_items = list("ingot_plasteel","ingot_diamond","ingot_phoron")
	product = /obj/item/crafting/ingredient/alloy/plasteel/gun

/recipe/smelter/plasteel_armor
	name = "smelt Plasteel-40000"
	desc = "alloy various metals into armor plasteel."
	required_items = list("FeCPl_20000","ingot_diamond","ingot_titanium")
	product = /obj/item/crafting/ingredient/alloy/plasteel/armor