/obj/item/proc/dye_self(var/mob/caller,var/obj/item/D,var/dye_color,var/dye_strength=0.5)

	if(!dye_color)
		dye_color = "#FFFFFF"

	INTERACT_CHECK_NO_DELAY(src)
	INTERACT_CHECK_NO_DELAY(D)

	if(!dyeable)
		caller.to_chat(span("warning","\The [src.name] cannot be dyed."))
		return FALSE

	var/choice

	if(length(polymorphs))
		choice = input("What do you want to dye?","Dye Selection") as null|anything in polymorphs
		if(choice)
			INTERACT_CHECK_NO_DELAY(src)
			INTERACT_CHECK_NO_DELAY(D)
			polymorphs[choice] = blend_colors(polymorphs[choice] ? polymorphs[choice] : "#FFFFFF",dye_color,dye_strength)
	else
		choice = input("Are you sure you want to dye \the [src.name]?","Dye Selection") as null|anything in list("Yes","No","Cancel")
		if(choice == "Yes")
			INTERACT_CHECK_NO_DELAY(src)
			INTERACT_CHECK_NO_DELAY(D)
			color = blend_colors(color ? color : "#FFFFFF",dye_color,dye_strength)
		else
			choice = null

	if(choice)
		caller.to_chat(span("notice","You dye \the [src.name]."))
		update_sprite()
		if(is_inventory(loc)) //Snowflake code, do not remove.
			var/obj/hud/inventory/I = loc
			if(I.worn && is_advanced(I.owner))
				var/mob/living/advanced/A = I.owner
				A.remove_overlay("\ref[src]")
				if(src in I.contents)
					I.update_worn_icon(src)

		return TRUE
	else
		caller.to_chat(span("notice","You decide not to dye anything."))

	return FALSE