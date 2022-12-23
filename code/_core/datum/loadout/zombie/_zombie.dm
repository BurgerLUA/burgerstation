/loadout/zombie/
	var/list/possible_extra_clothing = list() //pickweight
	var/list/possible_extra_weapon = list()

	var/extra_weapon_chance = 0
	var/extra_clothing_chance = 0

/loadout/zombie/pre_add(var/mob/living/advanced/A,var/obj/item/I)
	. = ..()
	if(.)
		I.adjust_quality(rand(-50,-90))
		I.set_bloodstain(rand(2,5),"#880000")

/loadout/zombie/get_spawning_items()

	. = ..()

	if(length(possible_extra_weapon) && prob(extra_weapon_chance))
		. += pickweight(possible_extra_weapon)

	if(length(extra_clothing_chance) && prob(extra_clothing_chance))
		. += pickweight(possible_extra_clothing)