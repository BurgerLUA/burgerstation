/obj/item/currency/
	name = "currency"
	desc = "DOSH"
	desc_extended = "Grab it while it's hot!"

	amount_max = 10000

	size = 0.002
	weight = 0.002

	var/currency_class = "none"

	value_burgerbux = 1 //Prevents being sold in vendors.

	glide_size = 1

	rarity = RARITY_UNCOMMON

/obj/item/currency/can_transfer_stacks_to(var/obj/item/target)

	if(target == src) //Self-stacking.
		return FALSE

	if(target.amount_max <= 1 || src.amount_max <= 1) //Non-stackable.
		return FALSE

	if(target.amount >= target.amount_max) //Full.
		return FALSE

	if(!istype(target,/obj/item/currency/)) //Not a currency.
		return FALSE

	var/obj/item/currency/C = target
	if(C.currency_class != src.currency_class) //Not the same currency.
		return FALSE

	return TRUE


/obj/item/currency/Finalize()
	. = ..()
	update_sprite()

/obj/item/currency/telecrystals
	name = "telecrystals"
	desc = "These are pretty sus crystals."
	desc_extended = "Currency primarily used by syndicate operatives."
	icon = 'icons/obj/item/currency/telecrystals.dmi'
	icon_state = "1"
	value = 100

	amount_max = 5000

	currency_class = "telecrystal"

	rarity = RARITY_RARE

/obj/item/currency/telecrystals/update_icon()
	switch(amount)
		if(1 to 10)
			icon_state = "[amount]"
		if(10 to 100)
			icon_state = "[FLOOR(amount/10, 1)*10]"
		if(100 to 1000)
			icon_state = "[FLOOR(amount/100, 1)*100]"
		if(1000 to 5000)
			icon_state = "[FLOOR(amount/1000, 1)*1000]"
	return ..()

/obj/item/currency/prize_ticket
	name = "prize ticket"
	desc = "What, another useless currency? Isn't burgerbux enough???"
	desc_extended = "A prize ticket that can be redeemed at a prize vendor. Earned by completing minigames in arcade vendors."
	icon = 'icons/obj/item/currency/ticket.dmi'
	icon_state = "1"
	value = 0.25

	amount_max = 10000

	currency_class = "prize ticket"

/obj/item/currency/prize_ticket/update_icon()
	switch(amount)
		if(1)
			icon_state = "1"
		if(2 to 10)
			icon_state = "2"
		if(11 to 50)
			icon_state = "3"
		if(51 to INFINITY)
			icon_state = "4"
	return ..()


/obj/item/currency/magic_token
	name = "magic shard token"
	desc = "Magically delicious!"
	desc_extended = "A special magic shard token that is commonly used to trade with the Wizard Federation. Used to buy magic items."
	icon = 'icons/obj/item/currency/magic_token.dmi'
	icon_state = "1"
	value = 800

	amount_max = 4

	currency_class = "magic shard"

	rarity = RARITY_RARE

/obj/item/currency/magic_token/update_icon()
	icon_state = "[amount]"
	return ..()