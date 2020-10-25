/obj/item/mech_part/arms
	name = "arms"
	desc = "Bigger than yours."
	desc_extended = "Arms for your mech. You need these to hold weapons."

	var/maximum_support = 0 //How much these arms can carry (SIZE LIMIT PER HAND)
	var/maximum_weapons = 1
	var/list/weapon_whitelist = list()


/obj/item/mech_part/arms/loader
	name = "loader arms"
	icon_state = "loader_arms"

	weight = 20

	maximum_weapons = 2

	maximum_support = SIZE_4

	value = 400

/obj/item/mech_part/arms/combat
	name = "combat arms"
	icon_state = "combat_arms"

	weight = 20

	maximum_weapons = 2

	maximum_support = SIZE_4

	value = 400

/obj/item/mech_part/arms/light
	name = "light arms"
	icon_state = "light_arms"

	weight = 15

	maximum_weapons = 1

	maximum_support = SIZE_3

	value = 300

/obj/item/mech_part/arms/heavy
	name = "heavy arms"
	icon_state = "heavy_arms"

	weight = 30

	maximum_weapons = 2

	maximum_support = SIZE_8

	value = 600