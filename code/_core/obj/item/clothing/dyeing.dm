/obj/item/clothing/dye_self(var/mob/caller,var/obj/item/D,var/dye_color,var/dye_strength=0.5)

	if(!polymorphic)
		return ..()

	INTERACT_CHECK

	if(!dye_color)
		dye_color = "#FFFFFF"

	var/choice = input("What do you want to dye?","Dye Selection") in list(color_primary_desc,color_secondary_desc,color_tertiary_desc,"Cancel")

	INTERACT_CHECK

	if(!choice || choice == "Cancel")
		caller.to_chat(span("notice","You decide not to dye \the [src.name]."))
		return FALSE

	if(choice == color_primary_desc)
		color_primary = blend_colors(color_primary,dye_color,dye_strength)
		//change_blend("outfit_primary",color = color_tertiary)

	else if(choice == color_secondary_desc)
		color_secondary = blend_colors(color_secondary,dye_color,dye_strength)
		//change_blend("outfit_secondary",color = color_tertiary)

	else if(choice == color_tertiary_desc)
		color_tertiary = blend_colors(color_tertiary,dye_color,dye_strength)
		//change_blend("outfit_tertiary",color = color_tertiary)

	caller.to_chat(span("notice","You dye \the [src.name]'s [choice]."))
	update_icon()

	return FALSE