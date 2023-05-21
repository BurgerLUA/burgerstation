/loadout/zombie/
	var/list/possible_extra_clothing = list() //pickweight
	var/list/possible_extra_weapon = list()

	var/extra_weapon_chance = 0
	var/extra_clothing_chance = 0

/loadout/zombie/get_spawning_items()

	. = ..()

	if(length(possible_extra_weapon) && prob(extra_weapon_chance))
		. += pickweight(possible_extra_weapon)

	if(length(possible_extra_clothing) && prob(extra_clothing_chance))
		. += pickweight(possible_extra_clothing)