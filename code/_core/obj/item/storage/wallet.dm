/obj/item/storage/wallet
	name = "wallet"
	desc = "How do I attach this to my chest?"
	desc_extended = "A plain old faux leather wallet. For storing small objects."

	icon = 'icons/obj/item/storage/wallet.dmi'
	icon_state = "wallet"

	size = SIZE_1

	is_container = TRUE
	container_max_size = SIZE_0

	dynamic_inventory_count = 4

	value = 40

/obj/item/storage/wallet/random_colonist
	loot_to_generate = /loot/zombie_wallet
