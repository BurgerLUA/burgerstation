/obj/item/container/edible/dynamic/cheese
	name = "cheese"
	desc = "A rat's favorite."
	desc_extended = "Nothing says class like huge yellow blocks of cheddar."

	icon = 'icons/obj/item/consumable/food/cheese.dmi'
	icon_state = "wheel"

	health = /health/obj/item/misc/

	scale_sprite = FALSE

	var/created_date //Timestamp here.
	var/created_time

	scale_sprite = FALSE

	reagents = /reagent_container/food/cheese

	value = 0

/obj/item/container/edible/dynamic/cheese/Generate()
	created_date = get_date()
	created_time = get_time()
	return ..()

/obj/item/container/edible/dynamic/cheese/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/damagetype/DT,var/list/damage_table,var/damage_amount,var/critical_hit_multiplier,var/stealthy=FALSE)

	if( (damage_table[BLADE] && !damage_table[BLUNT]) || damage_table[BLADE] > damage_table[BLUNT]) //Cut

		var/original_volume = reagents.volume_current

		if(icon_state == "wheel")
			var/pieces = FLOOR(original_volume/10, 1)
			if(pieces <= 1 || original_volume < pieces)
				if(is_living(attacker))
					var/mob/living/L = attacker
					L.to_chat(span("notice","There isn't enough cheese in \the [src.name] to cut!"))
				return ..()

			for(var/i=1,i<=pieces,i++)
				var/obj/item/container/edible/dynamic/cheese/C = new(get_turf(src))
				C.icon_state = "wheel"
				INITIALIZE(C)
				reagents.transfer_reagents_to(C.reagents,original_volume/pieces)
				FINALIZE(C)
				animate(C,pixel_x = rand(-16,16),pixel_y=rand(-16,16),time=SECONDS_TO_DECISECONDS(1))

			if(is_living(attacker))
				var/mob/living/L = attacker
				L.visible_message(span("notice","\The [L.name] cuts \the [src.name] into several cheese pieces."),span("notice","You cut \the [src.name] into [pieces] cheese pieces."))

			qdel(src)

		else if(has_prefix(icon_state,"block"))
			if(original_volume > 10)
				var/pieces = FLOOR(original_volume/10, 1)
				if(pieces <= 1 || original_volume < pieces)
					if(is_living(attacker))
						var/mob/living/L = attacker
						L.to_chat(span("warning","There isn't enough cheese in \the [src.name] to cut!"))
					return ..()

				for(var/i=1,i<=pieces,i++)
					var/obj/item/container/edible/dynamic/cheese/C = new(get_turf(src))
					C.icon_state = "block"
					INITIALIZE(C)
					reagents.transfer_reagents_to(C.reagents,original_volume/pieces)
					FINALIZE(C)
					animate(C,pixel_x = rand(-16,16),pixel_y=rand(-16,16),time=SECONDS_TO_DECISECONDS(1))

				if(is_living(attacker))
					var/mob/living/L = attacker
					L.visible_message(span("notice","\The [L.name] cuts \the [src.name] into several cheese pieces."),span("notice","You cut \the [src.name] into [pieces] cheese pieces."))

				qdel(src)

			else if(original_volume <= 1)
				if(is_living(attacker))
					var/mob/living/L = attacker
					L.to_chat(span("warning","There isn't enough cheese in \the [src.name] to cut!"))
				return ..()
			else
				var/obj/item/container/edible/dynamic/cheese/C = new(get_turf(src))
				C.icon_state = "block"
				INITIALIZE(C)
				reagents.transfer_reagents_to(C.reagents,1)
				FINALIZE(C)
				animate(C,pixel_x = rand(-16,16),pixel_y=rand(-16,16),time=SECONDS_TO_DECISECONDS(1))
				if(is_living(attacker))
					var/mob/living/L = attacker
					L.visible_message(span("notice","\The [L.name] slices a thin slice of cheese off the top of \the [src.name]."),span("notice","You slice a thin slice of cheese off the top of \the [src.name]."))

	return ..()

/obj/item/container/edible/dynamic/cheese/can_be_attacked(var/atom/attacker,var/atom/weapon,var/params,var/damagetype/damage_type)
	return TRUE

/obj/item/container/edible/dynamic/cheese/update_icon()

	if(icon_state == "wheel" && reagents.volume_current <= 10)
		icon_state = "wheel_slice"

	else if(has_prefix(icon_state,"block"))
		if(reagents.volume_current > 10)
			icon_state = "block"
			pixel_height = 10
		else
			icon_state = "block_slice_[CEILING(reagents.volume_current, 1)]"
			pixel_height = CEILING(reagents.volume_current, 1)

	color = reagents.color

	return ..()

/obj/item/container/edible/dynamic/cheese/block
	name = "block cheese"
	icon_state = "block"
	value = 1

/obj/item/container/edible/dynamic/cheese/block/Generate()
	reagents.add_reagent(/reagent/nutrition/cheese,40)
	return ..()

/obj/item/container/edible/dynamic/cheese/wheel
	name = "wheel cheese"
	icon_state = "wheel"
	value = 1

/obj/item/container/edible/dynamic/cheese/wheel/Generate()
	reagents.add_reagent(/reagent/nutrition/cheese,40)
	return ..()