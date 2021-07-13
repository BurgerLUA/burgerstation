obj/item/ore/
	name = "broken ore"
	desc = "Wait, what the fuck is this?"
	desc_extended = "A rock containing minerals. Put this in a smelter to get it's precious contents."
	icon = 'icons/obj/item/ore.dmi'
	icon_state = "rock_small"
	var/ore_color = "#FFFFFF"

obj/item/ore/New(var/desired_loc)
	. = ..()
	update_icon()
	return .

obj/item/ore/update_icon()

	icon_state = initial(icon_state)
	icon = initial(icon)

	if(icon_state == "rock_small")
		var/icon/I = icon(icon,icon_state)
		var/icon/V = icon(icon,"vein_small")
		V.Blend(ore_color,ICON_MULTIPLY)
		I.Blend(V,ICON_OVERLAY)
		icon = I

	..()

obj/item/ore/iron
	name = "iron ore"
	desc = "Commonly found in caves."
	ore_color = "#B5634F"
	crafting_id = "ore_iron"
	icon_state = "ore_iron"

obj/item/ore/copper
	name = "copper ore"
	desc = "Commonly found on surfaces."
	ore_color = "#E28446"
	crafting_id = "ore_copper"

obj/item/ore/aluminium
	name = "aluminium ore"
	desc = "Commonly found in caves."
	ore_color = "#C4C4C4"
	crafting_id = "aluminum"

obj/item/ore/nickel
	name = "nickel ore"
	desc = "Commonly found near caves with sand in them."
	ore_color = "#AAC4C4"
	crafting_id = "ore_nickel"

obj/item/ore/lead
	name = "lead ore"
	desc = "Found deep underground."
	ore_color = "#5E5D77"
	crafting_id = "ore_lead"

obj/item/ore/zinc
	name = "zinc ore"
	desc = "Found near water."
	ore_color = "#E8E8EF"
	crafting_id = "ore_zinc"

obj/item/ore/silver
	name = "silver ore"
	desc = "Found deep underground, usually well hidden."
	ore_color = "#E5E5EA"
	icon_state = "ore_silver"
	crafting_id = "ore_silver"

obj/item/ore/gold
	name = "gold ore"
	desc = "Found deep underground, usually well hidden."
	ore_color = "#FFE74F"
	icon_state = "ore_gold"
	crafting_id = "ore_gold"

obj/item/ore/titanium
	name = "titanium ore"
	desc = "Found in the deepest of locations, usually well hidden."
	ore_color = "#D9E5EA"
	crafting_id = "ore_titanium"

obj/item/ore/tin
	name = "tin ore"
	desc = "Commonly found on the surface."
	ore_color = "#E2E2E2"
	crafting_id = "ore_tin"

obj/item/ore/cobalt
	name = "cobalt ore"
	desc = "Found deep underground."
	ore_color = "#ABCCCC"
	crafting_id = "ore_cobalt"

obj/item/ore/carbon
	name = "carbon ore"
	desc = "Found in caves and deep underground."
	ore_color = "#0A0A0A"
	crafting_id = "ore_carbon"
	alchemy_reagents = list("carbon" = 15)
	icon_state = "ore_coal"

obj/item/ore/magnesium
	name = "magnesium ore"
	desc = "Commonly found in caves."
	ore_color = COLOR_BLACK
	crafting_id = "ore_magnesium"

obj/item/ore/plasma
	name = "phoron plasma ore"
	desc = "Commonly found in areas of great power."
	ore_color = "#B200B6"
	icon_state = "ore_phoron"
