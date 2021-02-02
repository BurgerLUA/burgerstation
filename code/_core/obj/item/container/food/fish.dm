/obj/item/container/food/fishing
	name = "fish"
	desc = "morning!! if it was a GOOD morning i'd be FISHING"
	desc_extended = "A fresh catch."
	icon = 'icons/obj/item/consumable/food/fish.dmi'
	icon_state = "fish"
	value = 100
	health = /health/obj/item/misc/
	scale_sprite = FALSE

/obj/item/container/food/fishing/can_be_attacked(var/atom/attacker,var/atom/weapon,var/params,var/damagetype/damage_type)
	return TRUE

/obj/item/container/food/fishing/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/list/damage_table,var/damage_amount,var/critical_hit_multiplier,var/stealthy=FALSE)

	if( (damage_table[BLADE] && !damage_table[BLUNT]) || damage_table[BLADE] > damage_table[BLUNT]) //Cut
		var/original_volume = reagents.volume_current
		var/turf/T = get_turf(src)
		var/obj/item/container/food/dynamic/fish/S = new(T)
		INITIALIZE(S)
		if(S.reagents) src.reagents.transfer_reagents_to(S.reagents,original_volume)
		FINALIZE(S)
		animate(S,pixel_x=rand(-8,8),pixel_y=rand(-8,8),time=5)
		attacker.visible_message(span("notice","\The [attacker.name] prepares \the [src.name]."),span("notice","You prepare \the [src.name]."))
		if(icon_state == "goldfish")
			var/obj/item/currency/telecrystals/C = new(get_turf(src))
			FINALIZE(C)
		qdel(src)

	return ..()

/obj/item/container/food/fishing/generic
	name = "cool fish"
	icon_state = "fish"

/obj/item/container/food/fishing/generic/Generate()
	reagents.add_reagent(/reagent/nutrition/meat/qualityfish,10)
	reagents.add_reagent(/reagent/nutrition/fat/fish,5)
	return ..()

/obj/item/container/food/fishing/salmon
	name = "salmon"
	icon_state = "salmon"

/obj/item/container/food/fishing/salmon/Generate()
	reagents.add_reagent(/reagent/nutrition/meat/qualityfish,15)
	reagents.add_reagent(/reagent/nutrition/fat/fish,5)
	return ..()

/obj/item/container/food/fishing/catfish
	name = "catfish"
	icon_state = "catfish"

/obj/item/container/food/fishing/catfish/Generate()
	reagents.add_reagent(/reagent/nutrition/meat/qualityfish,20)
	reagents.add_reagent(/reagent/nutrition/fat/fish,10)
	return ..()

/obj/item/container/food/fishing/babycarp
	name = "baby carp"
	icon_state = "babycarp"

/obj/item/container/food/fishing/babycarp/Generate()
	reagents.add_reagent(/reagent/nutrition/fat/fish,5)
	reagents.add_reagent(/reagent/medicine/health_potion,5)
	return ..()

/obj/item/container/food/fishing/clownfish
	name = "clown fish"
	icon_state = "clownfish"

/obj/item/container/food/fishing/clownfish/Generate()
	reagents.add_reagent(/reagent/drug/space,5)
	reagents.add_reagent(/reagent/drug/dust,5)
	reagents.add_reagent(/reagent/nutrition/fat/fish,10)
	return ..()

/obj/item/container/food/fishing/eel
	name = "eel"
	icon_state = "electric_eel"

/obj/item/container/food/fishing/eel/Generate()
	reagents.add_reagent(/reagent/nutrition/meat/qualityfish,10)
	reagents.add_reagent(/reagent/medicine/stamina_potion,5)
	reagents.add_reagent(/reagent/radioactive/radium,5)
	return ..()

/obj/item/container/food/fishing/glofish
	name = "glofish"
	icon_state = "glofish"

/obj/item/container/food/fishing/glofish/Generate()
	reagents.add_reagent(/reagent/nutrition/meat/qualityfish,10)
	reagents.add_reagent(/reagent/medicine/mana_potion,5)
	reagents.add_reagent(/reagent/radioactive/,5)
	return ..()

/obj/item/container/food/fishing/goldfish
	name = "goldfish"
	icon_state = "goldfish"

/obj/item/container/food/fishing/goldfish/Generate()
	reagents.add_reagent(/reagent/nutrition/meat/qualityfish,10)
	reagents.add_reagent(/reagent/nutrition/fat/fish,5)
	return ..()

/obj/item/container/food/fishing/shark
	name = "shark"
	desc = "what"
	icon_state = "shark"

/obj/item/container/food/fishing/shark/Generate()
	reagents.add_reagent(/reagent/nutrition/meat/qualityfish,15)
	reagents.add_reagent(/reagent/nutrition/fat/fish,10)
	reagents.add_reagent(/reagent/medicine/zombie_antidote,5)
	return ..()