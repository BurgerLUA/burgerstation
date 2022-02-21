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

/obj/item/currency/can_transfer_stacks_to(var/obj/item/I)

	if(I != src && istype(I,/obj/item/currency/))
		var/obj/item/currency/C = I
		return C.currency_class == src.currency_class

	return FALSE

/obj/item/currency/Finalize()
	. = ..()
	update_sprite()

/obj/item/currency/telecrystals
	name = "telecrystals"
	desc = "These are pretty sus crystals."
	desc_extended = "Currency primarily used by syndicate operatives."
	icon = 'icons/obj/item/currency/telecrystals.dmi'
	icon_state = "1"
	value = 200

	currency_class = "Telecrystals"

/obj/item/currency/telecrystals/update_icon()
	switch(amount)
		if(1 to 10)
			icon_state = "[amount]"
		if(11 to 100)
			icon_state = "[FLOOR(amount/10, 1)*10]"
		if(101 to 1000)
			icon_state = "[FLOOR(amount/100, 1)*100]"
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
	switch(amount)
		if(1)
			icon_state = "1"
		if(2 to 10)
			icon_state = "2"
		if(11 to 50)
			icon_state = "3"
		if(51 to amount_max)
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

	currency_class = "Magic Shard"

/obj/item/currency/magic_token/update_icon()
	icon_state = "[amount]"
	return ..()

/obj/item/currency/gold_coin
	name = "gold coin"
	icon = 'icons/obj/item/currency/gold.dmi'
	icon_state = "1"
	value = -1 //Value is based on current economy, see get_base_value()

	amount_max = 1000

	size = SIZE_4/1000
	weight = 50/1000

	currency_class = "gold"

	drop_sound = null

	plane = PLANE_CURRENCY

/obj/item/currency/gold_coin/get_base_value()
	return CEILING(SSeconomy.credits_per_gold * amount,1)

/obj/item/currency/gold_coin/Finalize()
	. = ..()
	update_value()

/obj/item/currency/gold_coin/update_sprite()
	. = ..()
	if(amount == 1)
		name = "1 gold coin"
	else
		name = "[amount] gold coins"

/obj/item/currency/gold_coin/update_icon()
	. = ..()
	switch(amount)
		if(1 to 40) //1 to 40, 1
			icon_state = "[FLOOR(amount,1)]"
		if(40 to 500) //40 to 100, 10
			// 40 + (i*(60/100))/5
			icon_state = "[40 + FLOOR((amount*(60/100))/5,10)]"
		if(500 to 1000) //100 to 200, 20
			icon_state = "[FLOOR(amount/5,20)]"

/obj/item/currency/gold_coin/update_overlays()

	. = ..()

	if(has_suffix(icon_state,"_anim"))
		return .

	var/desired_overlay
	if(amount < 10)
		desired_overlay = "sparkle_1"
	else
		desired_overlay = "sparkle_[min(50,FLOOR(amount,10))]"

	if(desired_overlay)
		var/image/I = new/image(icon,desired_overlay)
		add_overlay(I)