/mob/living/advanced/proc/update_lighting()

	var/total_light_sources = 0

	var/best_power = 0
	var/best_range = 0

	var/total_red = 0
	var/total_green = 0
	var/total_blue = 0

	var/list/obj/item/final_list = worn_objects + held_objects

	for(var/obj/item/I in final_list)
		if(!I.light_power || !I.light_range || !I.light_color)
			continue

		best_power = max(I.light_power,best_power)
		best_range = max(I.light_range,best_range)

		total_red += GetRedPart(I.light_color)
		total_green += GetGreenPart(I.light_color)
		total_blue += GetBluePart(I.light_color)

		total_light_sources += 1

	var/largest_color = max(total_red,total_green,total_blue,1)



	var/final_color = rgb((total_red/largest_color)*255,(total_green/largest_color)*255,(total_blue/largest_color)*255)

	if(best_power && best_range && final_color)
		set_light(best_range,best_power,final_color)
	else
		set_light(FALSE)



	return TRUE