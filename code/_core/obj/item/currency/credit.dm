var/global/list/credit_amounts = list(1,5,10,20,50,100,500,1000)

/obj/item/currency/credits
	name = "credits"
	desc = "Looks familiar."
	desc_extended = "A plastic microchip containing a super-unique 1024 Exabyte long hash representing ownership of local space on the bluespace net. Has real-world value, apparantly."
	icon = 'icons/obj/item/credit.dmi'
	icon_state = "null"

	item_count_max = 5000

	value = 1

/obj/item/currency/credits/update_overlays()

	. = ..()

	icon = initial(icon)
	icon_state = "0"

	var/total_count = 0
	var/local_value = item_count_current
	while(local_value > 0)
		var/chosen_value = 0
		for(var/n in credit_amounts)
			if(local_value >= n)
				chosen_value = n
		if(!chosen_value)
			break
		var/image/I = new/image(icon,"[chosen_value]")
		I.pixel_x = total_count*2*0.5
		I.pixel_y = -total_count*2*0.5
		add_overlay(I)
		total_count++
		local_value -= chosen_value

	pixel_w = -total_count*0.5
	pixel_z = total_count*0.5

/obj/item/currency/credits/update_sprite()
	. = ..()
	if(item_count_current == 1)
		name = "1 credit"
	else
		name = "[item_count_current] credits"