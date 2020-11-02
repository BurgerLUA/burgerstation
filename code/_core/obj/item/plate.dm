/obj/item/armor_plate
	name = "armor plate"
	desc = "Not for eating food off of."
	desc_extended = "A protective armor plate designed to fit a plate carrier."
	icon = 'icons/obj/item/plate.dmi'
	icon_state = "light"

	var/list/armor_base = list()

	size = SIZE_2

/obj/item/armor_plate/New(var/desired_loc)
	weight = calculate_weight()
	return ..()

/obj/item/armor_plate/proc/calculate_weight()

	var/init_weight = initial(weight)

	if(init_weight != 0)
		return init_weight

	. = 1

	for(var/k in armor_base)
		if(IS_INFINITY(armor_base[k]))
			continue
		. += armor_base[k] * armor_slowdown_values[k]

	return .


/obj/item/armor_plate/get_examine_list(var/mob/examiner)
	. = ..()
	var/list/armor_list = list()
	for(var/damagetype in armor_base)
		var/damage_rating = armor_base[damagetype]
		if(damage_rating)
			armor_list += "[capitalize(damagetype)]: [damage_rating]"
	. += div("notice","<b>Armor:</b> [capitalize(english_list(armor_list))].")
	. += div("notice","<b>Armor rating applies when applied to a plate carrier. Stacking multiple plate carriers gives dimishing returns.</b>")

/obj/item/armor_plate/light
	name = "light armor plate"
	icon_state = "light"
	rarity = RARITY_COMMON
	armor_base = list(
		BLADE = 15,
		BLUNT = 15,
		PIERCE = 15,
		LASER = 10
	)


	value = 90



/obj/item/armor_plate/medium
	name = "medium armor plate"
	icon_state = "medium"
	rarity = RARITY_COMMON
	armor_base = list(
		BLADE = 15,
		BLUNT = 30,
		PIERCE = 30,
		LASER = 10,
		ARCANE = -25
	)


	value = 190




/obj/item/armor_plate/heavy
	name = "heavy armor plate"
	icon_state = "heavy"
	rarity = RARITY_UNCOMMON
	armor_base = list(
		BLADE = 15,
		BLUNT = 45,
		PIERCE = 45,
		LASER = 25,
		ARCANE = -50
	)





	value = 275

/obj/item/armor_plate/super
	name = "super armor plate"
	icon_state = "super"
	rarity = RARITY_RARE
	armor_base = list(
		BLADE = 25,
		BLUNT = 65,
		PIERCE = 65,
		LASER = 25,
		ARCANE = -75
	)



	value = 500

/obj/item/armor_plate/ultra
	name = "ultra armor plate"
	icon_state = "super"
	rarity = RARITY_MYTHICAL
	armor_base = list(
		BLADE = 50,
		BLUNT = 75,
		PIERCE = 75,
		LASER = 50,
		ARCANE = -75
	)



	value = 1000