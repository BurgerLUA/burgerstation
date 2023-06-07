/obj/item/container/cigarette
	name = "cigarette"
	desc = "Kills you slowly."
	desc_extended = "An old cigarette containing all the dangerous toxins that you crave."
	icon = 'icons/obj/item/smoking/cigarette.dmi'
	icon_state = "inventory"
	icon_state_worn = "worn"

	worn_layer = LAYER_MOB_CLOTHING_MASK

	item_slot = SLOT_FACE
	item_slot_layer = 3

	can_wear = TRUE
	can_rename = TRUE

	var/lit = FALSE

	reagents = /reagent_container/cigarette

	var/next_consume = 0

	var/consume_amount = 0.3 //Per 4 seconds.

	desired_light_range = 1
	desired_light_power = 0.2
	desired_light_color = "#FFC58C"
	desired_light_angle = LIGHT_OMNI

	value = 10

	damage_type = /damagetype/melee/club/lighter

	size = SIZE_0

/obj/item/container/cigarette/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)
	if(!lit)
		var/damagetype/DT = all_damage_types[object.get_damage_type(caller,src)]
		if(DT.attack_damage_base[HEAT] || DT.attack_damage_base[LASER])
			set_lit(TRUE)
			return TRUE
	. = ..()

/obj/item/container/cigarette/feed(var/mob/caller,var/mob/living/target)
	return FALSE

/obj/item/container/cigarette/get_damage_type(var/atom/attacker,var/atom/victim)
	if(lit) return /damagetype/melee/club/lighter/on
	return ..()

/obj/item/container/cigarette/proc/set_lit(var/desired_lit=TRUE)

	if(lit == desired_lit)
		return FALSE

	lit = desired_lit

	update_sprite()
	update_atom_light()

	if(lit)
		START_THINKING(src)
	else
		STOP_THINKING(src)

	return TRUE

/obj/item/container/cigarette/update_atom_light()
	if(lit)
		set_light_sprite(desired_light_range, desired_light_power, desired_light_color,desired_light_angle)
	else
		set_light_sprite(FALSE)
	return TRUE

/obj/item/container/cigarette/update_icon()

	icon_state = initial(icon_state)
	icon_state_worn = initial(icon_state_worn)

	if(reagents && lit)
		var/icon_state_num = FLOOR(clamp(reagents.volume_current/2,0,10),1)
		icon_state = "[icon_state]_[icon_state_num]"

	if(lit)
		icon_state_worn = "[icon_state_worn]_on"

	. = ..()

/obj/item/container/cigarette/update_overlays()
	if(lit && reagents)
		var/pixel_offset = FLOOR(clamp(reagents.volume_current/2,0,10),1) - 10
		var/image/I = new/image(icon,"light")
		I.pixel_x = pixel_offset
		add_overlay(I)
	. = ..()

/obj/item/container/cigarette/proc/consume(var/multiplier=1)
	if(istype(src.loc,/obj/hud/inventory/organs/face))
		var/obj/hud/inventory/organs/face/I = src.loc
		if(I.owner && I.owner.reagents)
			reagents.transfer_reagents_to(I.owner.reagents,consume_amount*multiplier,caller=I.owner,include_abstract=TRUE)
			return TRUE
	reagents.splash(null,get_turf(src),consume_amount*0.25,TRUE,1) //Just remove the reagents if there is no one to add it to.
	return TRUE

/obj/item/container/cigarette/think()

	if(!lit)
		return FALSE

	if(reagents.volume_current <= 0)
		var/turf/T = get_turf(src)
		CREATE(/obj/item/trash/butt,T)
		qdel(src)
		return FALSE

	if(next_consume <= world.time)
		next_consume = world.time + SECONDS_TO_DECISECONDS(4)
		consume(1)

	return TRUE


/obj/item/container/cigarette/water/Generate()
	. = ..()
	reagents.add_reagent(/reagent/nutrition/water,reagents.volume_max)

/obj/item/container/cigarette/red/Generate()
	. = ..() //Each contain 20
	reagents.add_reagent(/reagent/tobacco/cigarette,10)
	reagents.add_reagent(/reagent/medicine/nicotine,4)
	reagents.add_reagent(/reagent/medicine/bicaridine,6)

/obj/item/container/cigarette/green/Generate()
	. = ..() //Each contain 20
	reagents.add_reagent(/reagent/tobacco/cigarette,10)
	reagents.add_reagent(/reagent/medicine/nicotine,4)
	reagents.add_reagent(/reagent/medicine/dylovene,6)

/obj/item/container/cigarette/blue/Generate()
	. = ..() //Each contain 20
	reagents.add_reagent(/reagent/tobacco/cigarette,10)
	reagents.add_reagent(/reagent/medicine/nicotine,4)
	reagents.add_reagent(/reagent/medicine/dexalin,6)

/obj/item/container/cigarette/gold/Generate()
	. = ..() //Each contain 20
	reagents.add_reagent(/reagent/tobacco/cigarette,10)
	reagents.add_reagent(/reagent/medicine/nicotine,4)
	reagents.add_reagent(/reagent/medicine/kelotane,6)

/obj/item/container/cigarette/purple/Generate()
	. = ..() //Each contain 20
	reagents.add_reagent(/reagent/tobacco/cigarette,10)
	reagents.add_reagent(/reagent/medicine/nicotine,4)
	reagents.add_reagent(/reagent/medicine/tricordrazine,6)

/obj/item/container/cigarette/orange/Generate()
	. = ..() //Each contain 20
	reagents.add_reagent(/reagent/tobacco/cigarette,10)
	reagents.add_reagent(/reagent/medicine/nicotine,4)
	reagents.add_reagent(/reagent/medicine/kelotane,3)
	reagents.add_reagent(/reagent/medicine/bicaridine,3)

/obj/item/container/cigarette/syndicate
	consume_amount = 1

/obj/item/container/cigarette/syndicate/Generate()
	. = ..() //Each contain 20
	reagents.add_reagent(/reagent/medicine/omnizine,20)

/obj/item/container/cigarette/slavic
	consume_amount = 1

/obj/item/container/cigarette/slavic/Generate()
	. = ..() //Each contain 20
	reagents.add_reagent(/reagent/medicine/omnizine,20)