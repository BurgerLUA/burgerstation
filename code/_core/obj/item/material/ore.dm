/obj/item/material/ore

	name = "ore"
	desc = "This should be smelted."
	desc_extended = "A piece of ore containing minerals. Put this in a smelter to get it's precious contents."
	icon = 'icons/obj/item/ore.dmi'
	icon_state = "vein_small"

	amount_max = 1

	material_multiplier = 1

	value = 0.25

/obj/item/material/ore/update_sprite()
	var/material/M = MATERIAL(material_id)
	if(M.icon_state_ore) icon_state = M.icon_state_ore
	if(M.name) name = "[M.name] ore"
	. = ..()

/obj/item/material/ore/update_underlays()

	. = ..()

	if(icon_state == "vein_small")
		var/image/I = icon(icon,"rock_small")
		I.appearance_flags = src.appearance_flags | RESET_COLOR
		add_underlay(I)


/*
/obj/item/material/ore/iron
	material_id = /material/iron
	name = "iron ore"
	desc = "Insert FE-ic pun here."
	ore_color = "#B5634F"
	grinder_reagents = /reagent/iron
	reagent_count = 10
	icon_state = "ore_iron"

/obj/item/material/ore/silver
	material_id = /material/silver
	name = "silver ore"
	desc = "Silver and ..... what was the other one?"
	ore_color = "#E5E5EA"
	grinder_reagents = /reagent/silver
	reagent_count = 5
	icon_state = "ore_silver"

/obj/item/material/ore/gold
	material_id = /material/gold
	name = "gold ore"
	desc = "WERE RICH!"
	ore_color = "#FFE74F"
	icon_state = "ore_gold"

/obj/item/material/ore/carbon
	material_id = /material/carbon
	name = "carbon ore"
	desc = "Almost a diamond. Just a few million years and some pressure early."
	ore_color = "#0A0A0A"
	grinder_reagents = /reagent/carbon
	reagent_count = 10
	icon_state = "ore_coal"

/obj/item/material/ore/phoron
	material_id = /material/phoron
	name = "phoron plasma ore"
	desc = "Hey what happens if I light it on fi..."
	ore_color = "#B200B6"
	grinder_reagents = /reagent/fuel/phoron
	reagent_count = 5
	icon_state = "ore_phoron"

/obj/item/material/ore/uranium
	material_id = /material/uranium
	name = "uranium ore"
	desc = "URAAAAANIUM FEVER."
	ore_color = "#003f15"
	icon_state = "ore_uranium"

/obj/item/material/ore/diamond
	material_id = /material/diamond
	name = "diamond ore"
	desc = "MIIIINING AWAY"
	ore_color = "#009ee2"
	icon_state = "ore_diamond"

/obj/item/material/ore/titanium
	material_id = /material/titanium
	name = "titanium ore"
	desc = "Stronk"
	ore_color = "#D9E5EA"
	icon_state = "ore_titanium"

/obj/item/material/ore/platinum
	material_id = /material/platinum
	name = "platinum ore"
	desc = "Precious metal."
	grinder_reagents = /reagent/platinum
	reagent_count = 10
	ore_color = "#C4C4C4"
	icon_state = "ore_platinum"

/obj/item/material/ore/sand
	material_id = /material/sand
	name = "sand"
	desc = "I hate sand."
	grinder_reagents = /reagent/sand
	reagent_count = 10
	ore_color = "#E2AD63"
	icon_state = "ore_sand"

/obj/item/material/ore/ash
	material_id = /material/ash
	name = "ash"
	desc = "I hate ash."
	grinder_reagents = /reagent/ash
	reagent_count = 10
	ore_color = "#555555"
	icon_state = "ore_sand_black"
*/


/*
/obj/item/material/ore/copper
	material_id = /material/copper
	name = "copper ore"
	desc = "Tastes like coins."
	grinder_reagents = /reagent/copper
	reagent_count = 10
	ore_color = "#E28446"

/obj/item/material/ore/aluminium
	material_id = /material/aluminium
	name = "aluminium ore"
	desc = "Alu-min-ium"
	grinder_reagents = /reagent/aluminium
	reagent_count = 10
	ore_color = "#C4C4C4"

/obj/item/material/ore/nickel
	material_id = /material/nickel
	name = "nickel ore"
	desc = "Tastes like 5 credits."
	ore_color = "#AAC4C4"

/obj/item/material/ore/lead
	material_id = /material/lead
	name = "lead ore"
	desc = "Tastes like poision"
	ore_color = "#5E5D77"

/obj/item/material/ore/zinc
	material_id = /material/zinc
	name = "zinc ore"
	desc = "A nessicary material in brass."
	ore_color = "#E8E8EF"

/obj/item/material/ore/tin
	material_id = /material/tin
	name = "tin ore"
	desc = "Blocks phycics and aliens. Dont forget the government!"
	ore_color = "#E2E2E2"

/obj/item/material/ore/cobalt
	material_id = /material/cobalt
	name = "cobalt ore"
	desc = "Not as pretty as your eyes."
	ore_color = "#ABCCCC"

/obj/item/material/ore/magnesium
	material_id = /material/magnesium
	name = "magnesium ore"
	desc = "Do not mix with water. Or was that Potassium?"
	ore_color = COLOR_BLACK
*/

