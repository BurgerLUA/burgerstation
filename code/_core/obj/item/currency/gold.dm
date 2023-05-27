//Coins
/obj/item/currency/gold_coin
	name = "gold coin"
	icon = 'icons/obj/item/currency/gold.dmi'
	icon_state = "1"
	value = 0 //Value is based on current economy, see get_base_value()

	amount_max = GOLD_AMOUNT_MAX

	size = SIZE_4/GOLD_AMOUNT_MAX
	weight = 50/GOLD_AMOUNT_MAX

	currency_class = "gold coin"

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
		if(500 to GOLD_AMOUNT_MAX) //100 to 200, 20
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





//Bars
/obj/item/currency/gold_bar
	name = "gold bar"
	icon = 'icons/obj/item/currency/gold_bar.dmi'
	icon_state = "1"
	value = 0 //Value is based on current economy, see get_base_value()

	amount_max = 5

	size = (SIZE_4/GOLD_AMOUNT_MAX) * (GOLD_AMOUNT_MAX/5)
	weight = (50/GOLD_AMOUNT_MAX) * (GOLD_AMOUNT_MAX/5)

	currency_class = "gold bar"

	drop_sound = null

	plane = PLANE_CURRENCY

	rarity = RARITY_RARE

/obj/item/currency/gold_bar/Finalize()
	. = ..()
	update_value()

/obj/item/currency/gold_bar/update_sprite()
	. = ..()
	if(amount == 1)
		name = "1 gold bar"
	else
		name = "[amount] gold bars"

/obj/item/currency/gold_bar/update_overlays()
	. = ..()
	var/image/I = new/image(icon,"sparkle_[amount]")
	add_overlay(I)

/obj/item/currency/gold_bar/get_base_value()
	return CEILING(SSeconomy.credits_per_gold * amount * (GOLD_AMOUNT_MAX/5),1)


/obj/item/currency/gold_bar/update_icon()
	. = ..()
	icon_state = "[amount]"