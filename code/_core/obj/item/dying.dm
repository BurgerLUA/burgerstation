/obj/item/proc/dye_self(var/mob/caller,var/obj/item/D,var/dye_color,var/dye_strength=0.5)

	INTERACT_CHECK

	if(!dyeable)
		caller.to_chat("\The [src.name] cannot be dyed.")
		return FALSE

	var/choice = input("Are you sure you want to dye \the [src.name]?","Dye Selection") in list("Yes","No","Cancel")

	INTERACT_CHECK

	if(choice != "Yes")
		return FALSE

	color = blend_colors(color ? color : "#FFFFFF",dye_color,dye_strength)
	caller.to_chat(span("notice","You dye \the [src.name]'s [choice]."))
	update_icon()

	return FALSE