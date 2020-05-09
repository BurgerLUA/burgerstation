/obj/item/clothing/dye_self(var/mob/caller,var/obj/item/D,var/dye_color,var/dye_strength=0.5)

	if(!length(polymorphs))
		return ..()

	INTERACT_CHECK

	if(!dye_color)
		dye_color = "#FFFFFF"

	var/choice = input("What do you want to dye?","Dye Selection") as null|anything in polymorphs

	INTERACT_CHECK

	if(!choice)
		caller.to_chat(span("notice","You decide not to dye \the [src.name]."))
		return FALSE

	polymorphs[choice] = blend_colors(polymorphs[choice],dye_color,dye_strength)
	//initialize_blends()
	update_sprite()

	caller.to_chat(span("notice","You dye \the [choice]."))
	update_sprite()

	return FALSE