/obj/item/currency/
	name = "currency"
	desc = "DOSH"
	desc_extended = "Grab it while it's hot!"

	item_count_current = 1
	item_count_max = 5000

	size = 0.002
	weight = 0.002

	var/currency_class = "none"

/obj/item/currency/can_transfer_stacks_to(var/obj/item/I)

	if(I != src && istype(I,/obj/item/currency/))
		var/obj/item/currency/C = I
		return C.currency_class == src.currency_class

	return FALSE

/obj/item/currency/Finalize()
	. = ..()
	update_sprite()
	return .

/obj/item/currency/telecrystals
	name = "telecrystals"
	desc = "These are pretty sus crystals."
	desc_extended = "Currency primarily used by syndicate operatives."
	icon = 'icons/obj/item/currency/telecrystals.dmi'
	icon_state = "1"
	value = 200

	currency_class = "Telecrystals"

/obj/item/currency/telecrystals/goblin/Generate()
	item_count_current = pick(1,1,1,1,1,1,2,2,3,3,4,5)
	return ..()

/obj/item/currency/telecrystals/player_antagonist_spawn/Generate()
	item_count_current = 50
	return ..()

/obj/item/currency/telecrystals/update_icon()
	switch(item_count_current)
		if(1 to 10)
			icon_state = "[item_count_current]"
		if(11 to 100)
			icon_state = "[FLOOR(item_count_current/10, 1)*10]"
		if(101 to 1000)
			icon_state = "[FLOOR(item_count_current/100, 1)*100]"
		if(1001 to 5000)
			icon_state = "[FLOOR(value/1000, 1)*1000]"
	return ..()

/obj/item/currency/prize_ticket
	name = "prize ticket"
	desc = "What, another useless currency? Isn't burgerbux enough???"
	desc_extended = "A prize ticket that can be redeemed at a prize vendor. Earned by completing minigames in arcade vendors."
	icon = 'icons/obj/item/currency/ticket.dmi'
	icon_state = "1"
	value = 0.25

	currency_class = "Prize Ticket"

/obj/item/currency/prize_ticket/update_icon()
	switch(item_count_current)
		if(1)
			icon_state = "1"
		if(2 to 10)
			icon_state = "2"
		if(11 to 50)
			icon_state = "3"
		if(51 to item_count_max)
			icon_state = "4"
	return ..()


/obj/item/currency/magic_token
	name = "magic shard token"
	desc = "Magically delicious!"
	desc_extended = "A special magic shard token that is commonly used to trade with the Wizard Federation. Used to buy magic items."
	icon = 'icons/obj/item/currency/magic_token.dmi'
	icon_state = "1"
	value = 800

	item_count_max = 4

	currency_class = "Magic Shard"

/obj/item/currency/magic_token/random/Generate()
	item_count_current = pick(1,1,1,1,1,1,1,1,2,2,2,3,3,4)
	return ..()

/obj/item/currency/magic_token/update_icon()
	icon_state = "[item_count_current]"
	return ..()

/obj/item/currency/magic_token/max/Generate()
	item_count_current = item_count_max