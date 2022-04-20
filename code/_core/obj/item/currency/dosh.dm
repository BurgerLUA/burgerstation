/obj/item/currency/dosh
	name = "dosh"
	desc = "Dosh can be exchanged for goods and services."
	desc_extended = "A paper note used by Solarian government citizens that represents the relationship between supply and demand and the stability of the economic market and- yeah it's dosh."
	icon = 'icons/obj/item/currency/dosh.dmi'
	icon_state = "null"

	amount_max = 200

	value = 50

/obj/item/currency/dosh/update_icon()

	. = ..()

	icon_state = "null" //Fallback

	switch(amount)
		if(1 to 5)
			icon_state = "[amount]"
		if(5 to 25)
			icon_state = "[FLOOR(amount,5)]"
		if(25 to 200)
			icon_state = "[FLOOR(amount,25)]"
		if(200 to INFINITY)
			icon_state = "200"

/obj/item/currency/dosh/update_sprite()
	. = ..()
	if(amount == 1)
		name = "1 dosh"
	else
		name = "[amount] doshes"