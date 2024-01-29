/obj/item/spellswap

	name = "spellswap error"
	icon = 'icons/obj/item/spellswap.dmi'
	icon_state = null

	var/obj/projectile/desired_projectile
	var/desired_sound
	var/list/damage_conversion = list() //As a ratio.

	value_burgerbux = 1

	value = 3000

	rarity = RARITY_RARE


/obj/item/spellswap/click_on_object(mob/caller,atom/object,location,control,params)

	if(is_weapon(object))

		INTERACT_CHECK
		INTERACT_DELAY(10)


		var/obj/item/weapon/I = object

		var/desired_choice = input("Are you sure you wish to spellswap \the [I.name] with \the [src.name]? This cannot be undone.","Spellswap","Cancel") as null|anything in list("Yes","No","Cancel")

		if(desired_choice != "Yes")
			caller.to_chat(span("notice","You decide not to spellswap \the [I.name]."))
			return TRUE
		if(desired_projectile==null)
			if(I.stored_spellswap)
				I.stored_spellswap = src
				qdel(I.stored_spellswap)
				src.drop_item(I)
				I.damage_type = initial(I.damage_type)
			else
				caller.to_chat(span("notice", "There's no spell to remove!"))
				return TRUE
			caller.to_chat(span("notice","You spellswap \the [I.name] with \the [src.name]."))

			var/turf/T = get_turf(caller)
			play_sound(desired_sound,T)

			return TRUE

		if(I.stored_spellswap)
			qdel(I.stored_spellswap)

		src.drop_item(I)
		I.stored_spellswap = src

		caller.to_chat(span("notice","You spellswap \the [I.name] with \the [src.name]."))

		var/turf/T = get_turf(caller)
		play_sound(desired_sound,T)

		return TRUE

	. = ..()
