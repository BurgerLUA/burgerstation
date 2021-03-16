/obj/item/crafting/workbench
	name = "portable workbench"
	icon = 'icons/obj/item/ore.dmi'
	icon_state = "workbench"

	inventories = list(
		/obj/hud/inventory/crafting/slotA1,
		/obj/hud/inventory/crafting/slotA2,
		/obj/hud/inventory/crafting/slotA3,

		/obj/hud/inventory/crafting/slotB1,
		/obj/hud/inventory/crafting/slotB2,
		/obj/hud/inventory/crafting/slotB3,

		/obj/hud/inventory/crafting/slotC1,
		/obj/hud/inventory/crafting/slotC2,
		/obj/hud/inventory/crafting/slotC3,

		/obj/hud/inventory/crafting/result
	)

	crafting_id = "workbench"

	crafting_type = /recipe/workbench/

	value = 25

	size = SIZE_4