/obj/item/storage/bank_box
	name = "standard bankbox"
	desc = "Where else am I going to fit all of these guns I never use?"
	desc_extended = "A bluespace-enhanced container which can be fit in a bank in order to effectively add more slots. Fits 15 items."
  icon = 'icons/obj/item/storage/death_box.dmi'
	icon_state = "locked"
	is_container = TRUE
	size = SIZE_1
	container_max_size = SIZE_10
	value = 50000
	dynamic_inventory_count = 5 * 3

/obj/item/storage/bank_box/tiny
	name = "extra-miniature bankbox"
	desc = "Where else am I going to fit all of these floorpills?"
	desc_extended = "A bluespace-enhanced container which can be fit in a bank in order to effectively add more slots. Fits 5 items."
	value = 10000
	dynamic_inventory_count = 5

/obj/item/storage/bank_box/small
	name = "miniature bankbox"
	desc = "Where else am I going to fit all of these funny hats I found?"
	desc_extended = "A bluespace-enhanced box which can be fit in a bank in order to effectively add more slots. Fits 10 items."
	value = 25000
	dynamic_inventory_count = 5 * 2

/obj/item/storage/bank_box/big
	name = "expanded bankbox"
	desc = "Where else am I going to fit all of these smaller bankboxes?"
	desc_extended = "A bluespace-enhanced box which can be fit in a bank in order to effectively add more slots. Fits 20 items."
	value = 75000
	dynamic_inventory_count = 5 * 4

/obj/item/storage/bank_box/huge
	name = "ultra-expanded bankbox"
	desc = "Where else am I going to fit all of these bombs?"
	desc_extended = "A bluespace-enhanced box which can be fit in a bank in order to effectively add more slots. Fits 25 items."
	value = 75000
	dynamic_inventory_count = 5 * 5

/obj/item/storage/bank_box/giga
	name = "giga-expanded bankbox"
	desc = "Where else am I going to fit all of these bombs?"
	desc_extended = "A bluespace-enhanced box which can be fit in a bank in order to effectively add more slots. Fits 50 items."
	value = 250000
	dynamic_inventory_count = 5 * 10
