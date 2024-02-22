/ability/quick_draw
	name = "Quick Draw"
	desc = "Quickly draws the item in your equipment slot into your dominant hand."
	icon_state = "quick_draw"
	cost = 5
	cooldown = SECONDS_TO_DECISECONDS(1)
	var/attack_too = FALSE

	category = "Quick Draw"

/ability/quick_draw/on_cast_pre(var/mob/caller,var/atom/target,location,params)

	if(!is_advanced(caller))
		return FALSE

	var/mob/living/advanced/A = caller

	if(!A.inventories_by_id[BODY_TORSO_OB])
		return FALSE

	var/obj/hud/inventory/I = A.inventories_by_id[BODY_TORSO_OB]

	var/obj/item/I2 = I.get_top_object()
	if(!istype(I2))
		return FALSE

	. = ..()

	if(. && A.put_in_hands(I2))
		if(attack_too)
			var/obj/hud/inventory/new_inventory = I2.loc
			if(!new_inventory)
				return FALSE
			I2.click_on_object(caller,target,location,null,params)
		return TRUE


/ability/quick_draw/plus
	name = "Quick Draw+"
	desc = "Quickly draws the item in your equipment slot into your dominant hand. If the item is a weapon, attempt an attack on the target location."
	icon_state = "quick_draw_plus"
	attack_too = TRUE
	cost = 20