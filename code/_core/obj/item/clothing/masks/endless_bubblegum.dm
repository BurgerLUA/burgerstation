/obj/item/clothing/mask/endless_bubblegum
	name = "endless bubblegum"
	icon = 'icons/obj/item/clothing/masks/bubblegum.dmi'
	flags_clothing = 0x0
	desc = "Everlasting, even."
	desc_extended = "A mysterious piece of bubblegum flavored chewing gum that never seems to lose its chew, flavor, juice, or nutrients. Can be equipped to mask slot."

	armor = null

	size = SIZE_1

	item_slot_layer = 1

	ignore_other_slots = TRUE

	rarity = RARITY_MYTHICAL

/obj/item/clothing/mask/endless_bubblegum/get_base_value()
	. = ..()
	. += 5000

/obj/item/clothing/mask/endless_bubblegum/on_equip(var/atom/old_location,var/silent=FALSE)
	. = ..()
	var/obj/hud/inventory/I = loc
	if(I.worn)
		START_THINKING(src)

/obj/item/clothing/mask/endless_bubblegum/on_unequip(var/obj/hud/inventory/old_inventory,var/silent=FALSE) //When the object is dropped from the old_inventory
	. = ..()
	STOP_THINKING(src)

/obj/item/clothing/mask/endless_bubblegum/think()
	. = ..()
	if(!is_inventory(loc))
		return FALSE
	var/obj/hud/inventory/I = loc
	if(!I.owner || !I.worn)
		return FALSE
	var/mob/living/advanced/A = I.owner

	var/nurition_to_add = clamp(A.nutrition_max - A.nutrition_normal,-A.nutrition_max*0.01,A.nutrition_max*0.01)
	var/hydration_to_add = clamp(A.hydration_max - A.hydration,-A.hydration_max,A.hydration_max)
	A.add_nutrition_normal(nurition_to_add)
	A.add_hydration(hydration_to_add)

