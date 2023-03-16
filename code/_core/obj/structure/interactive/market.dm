/obj/structure/interactive/market
	name = "market"
	desc = "Oh come to the market, where your ears are deafened from the cries of merchants!"
	desc_extended = "A machine that provides access to the general market-- where individuals are able to sell their wares to others."
	icon = 'icons/obj/structure/market.dmi'
	icon_state = "market"

	anchored = TRUE
	density = TRUE

	//the associated list of items to prices
	var/list/listed_items = list()

/obj/structure/interactive/market/clicked_on_by_object(mob/caller, atom/object, location, control, params)
	INTERACT_CHECK
	INTERACT_DELAY(5)

	if(!caller.client || !is_player(caller))
		return
	var/mob/living/advanced/player/player_caller = caller

	if(is_inventory(object))
		var/obj/hud/inventory/inventory_object = object

		var/access_market = input(player_caller, "Would you like purchase something?", "Choice Selection") as null|anything in list("Yes", "No")
		if(access_market != "Yes")
			return

		var/obj/item/purchase_item = input(player_caller, "Select the item to purchase", "Item Selection") as null|anything in listed_items
		if(!purchase_item)
			return

		var/confirm_selection = input(player_caller, "Are you sure you would like to purchase [purchase_item] for [listed_items[purchase_item]]c?", "Confirm Selection") as null|anything in list("Yes", "No")
		if(confirm_selection != "Yes")
			return

		if(player_caller.currency < listed_items[purchase_item])
			player_caller.to_chat("Insufficient Funds!")
			return

		player_caller.adjust_currency(-(listed_items[purchase_item]))
		purchase_item.force_move(get_turf(player_caller))
		inventory_object.add_object(purchase_item)
		listed_items -= purchase_item

		return

	if(is_item(object))
		var/obj/item/item_object = object

		var/selling_price = input(player_caller, "How much would you like to sell [item_object] for?", "Sell Price", round(item_object.value * 0.85)) as num
		if(selling_price >= round(item_object.value * 0.9))
			player_caller.to_chat("If an item is listed at or above a certain value, there is no gain for the middleman!")
			return
		if(selling_price < 0)
			player_caller.to_chat("You can give your items for free, but the buyer will not be given free money from me!")
			return

		selling_price = round(selling_price)

		var/confirm_sell = input(player_caller, "Are you sure you will sell [item_object] for [selling_price]c?") as null|anything in list("Yes", "No")
		if(confirm_sell != "Yes")
			return

		item_object.drop_item(src)
		listed_items += list("[item_object]" = selling_price)
		player_caller.adjust_currency(selling_price)

		return

	return ..()
