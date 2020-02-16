/obj/item/crafting/smelter
	name = "portable smelter"
	desc = "Smelt ores! Also cooks!"
	icon = 'icons/obj/items/ore.dmi'
	icon_state = "smelter"

	container_temperature = 800 - (T0C + 20)
	container_temperature_mod = 2

	inventories = list(
		/obj/hud/inventory/crafting/slotB1,
		/obj/hud/inventory/crafting/slotB2,
		/obj/hud/inventory/crafting/slotB3,

		/obj/hud/inventory/crafting/result
	)

	crafting_id = "smelter"

	value = 25
