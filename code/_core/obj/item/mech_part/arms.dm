/obj/item/mech_part/arms
	name = "arms"

	var/maximum_support = 0 //How much these arms can carry (SIZE LIMIT PER HAND)
	var/maximum_weapons = 1
	var/list/weapon_whitelist = list()


/obj/item/mech_part/arms/loader
	name = "loader arms"
	icon_state = "loader_arms"

	weight = 20

	maximum_weapons = 2

	maximum_support = SIZE_4

/obj/item/mech_part/arms/combat
	name = "combat legs"
	icon_state = "combat_arms"

	weight = 20

	maximum_weapons = 2

	maximum_support = SIZE_4

/obj/item/mech_part/arms/light
	name = "light legs"
	icon_state = "light_arms"

	weight = 15

	maximum_weapons = 1

	maximum_support = SIZE_3

/obj/item/mech_part/arms/heavy
	name = "heavy legs"
	icon_state = "heavy_arms"

	weight = 30

	maximum_weapons = 2

	maximum_support = SIZE_8