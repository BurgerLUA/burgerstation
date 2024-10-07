/obj/item/crafting_bench/smelter
	name = "portable smelter"
	desc = "Oven in my car, melting ore!"
	desc_extended = "Smelts ores and rapidly heats up anything placed inside. Can be used for cooking in a pinch."
	icon = 'icons/obj/item/ore.dmi'
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

	crafting_type = "smelter"

	value = 25

	size = SIZE_4

	value_burgerbux = 1
