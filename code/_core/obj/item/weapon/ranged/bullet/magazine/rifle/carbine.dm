/obj/item/weapon/ranged/bullet/magazine/rifle/carbine
	name = "\improper .223 Space Raider Carbine"
	desc = "A favorite by pirates."
	desc_extended = "A standard issue bullpup carbine used mostly by Syndicate raiding parties."
	icon = 'icons/obj/item/weapons/ranged/rifle/syndicate/223.dmi'
	icon_state = "inventory"
	value = 900

	company_type = "Syndicate"

	tier_type = "carbine"

	tier = 2

	shoot_delay = 1.7

	damage_mod = 1

	automatic = TRUE

	firemodes = list("automatic","burst","semi-automatic")

	shoot_sounds = list('sound/weapons/ranged/rifle/syndicate_carbine/shoot.ogg')

	can_wield = FALSE

	size = SIZE_3
	weight = 8

	heat_max = 0.1

	bullet_length_min = 40
	bullet_length_best = 45
	bullet_length_max = 46

	bullet_diameter_min = 5.5
	bullet_diameter_best = 5.56
	bullet_diameter_max = 5.6

	ai_heat_sensitivity = 0.75

	override_icon_state = TRUE

	attachment_whitelist = list(
		/obj/item/attachment/barrel/charger = TRUE,
		/obj/item/attachment/barrel/charger/advanced = TRUE,
		/obj/item/attachment/barrel/compensator = TRUE,
		/obj/item/attachment/barrel/extended = TRUE,
		/obj/item/attachment/barrel/gyro = TRUE,
		/obj/item/attachment/barrel/laser_charger = FALSE,
		/obj/item/attachment/barrel/suppressor = TRUE,
		/obj/item/attachment/barrel_mod/reinforced_barrel = TRUE,
		/obj/item/attachment/stock_mod/reinforced_stock = TRUE,

		/obj/item/attachment/sight/laser_sight = TRUE,
		/obj/item/attachment/sight/quickfire_adapter = TRUE,
		/obj/item/attachment/sight/red_dot = TRUE,
		/obj/item/attachment/sight/scope = TRUE,
		/obj/item/attachment/sight/scope/large = FALSE,
		/obj/item/attachment/sight/targeting_computer = TRUE,

		/obj/item/attachment/undermount/angled_grip = TRUE,
		/obj/item/attachment/undermount/bipod = TRUE,
		/obj/item/attachment/undermount/burst_adapter = TRUE,
		/obj/item/attachment/undermount/vertical_grip = TRUE
	)

	attachment_barrel_offset_x = 32 - 16
	attachment_barrel_offset_y = 20 - 16

	attachment_sight_offset_x = 15 - 16
	attachment_sight_offset_y = 21 - 16

	attachment_undermount_offset_x = 27 - 16
	attachment_undermount_offset_y = 17 - 16

	inaccuracy_modifier = 0.75
	movement_inaccuracy_modifier = 0.25
	movement_spread_base = 0.005

	rarity = RARITY_COMMON

/obj/item/weapon/ranged/bullet/magazine/rifle/carbine/update_icon()

	icon_state = initial(icon_state)

	if(!stored_magazine)
		icon_state = "[icon_state]_open"
	else
		icon_state = "[icon_state]_[CEILING((stored_magazine.get_ammo_count()/stored_magazine.bullet_count_max)*7, 1)]"

	return ..()


/obj/item/weapon/ranged/bullet/magazine/rifle/carbine/get_static_spread()
	return 0.007

/obj/item/weapon/ranged/bullet/magazine/rifle/carbine/get_skill_spread(var/mob/living/L)
	return max(0,0.02 - (0.04 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/magazine/rifle/carbine/get_cock_sound(var/direction="both")
	return 'sound/weapons/ranged/generic/smg_rack.ogg'

/obj/item/weapon/ranged/bullet/magazine/rifle/carbine/mod
	name = "\improper .223 SYN-Carbine MOD"
	icon = 'icons/obj/item/weapons/ranged/rifle/syndicate/223_mod.dmi'

	heat_max = 0.12

	damage_mod = 1

	size = SIZE_2
	weight = 4

	value = 800

	rarity = RARITY_RARE

/obj/item/weapon/ranged/bullet/magazine/rifle/carbine/mod/get_static_spread()
	return 0.03

/obj/item/weapon/ranged/bullet/magazine/rifle/carbine/mod/get_skill_spread(var/mob/living/L)
	return max(0,0.04 - (0.04 * L.get_skill_power(SKILL_RANGED)))


/obj/item/weapon/ranged/bullet/magazine/rifle/carbine/prototype
	name = "\improper .223 Space Raider Carbine PROTO"
	desc_extended = "A mass-produced prototype carbine usually only seen in the hands of collectors. Can still be used as a decent weapon."

	icon = 'icons/obj/item/weapons/ranged/rifle/syndicate/223_rifle.dmi'

	value = 1400

	tier = 2

	shoot_delay = 1.3

	damage_mod = 1.3

	automatic = TRUE

	firemodes = list("automatic","semi-automatic")

	shoot_sounds = list('sound/weapons/ranged/rifle/syndicate_carbine/shoot_prototype.ogg')

	can_wield = FALSE

	size = SIZE_4
	weight = 8

	heat_max = 0.08

	bullet_length_min = 40
	bullet_length_best = 45
	bullet_length_max = 46

	bullet_diameter_min = 5.5
	bullet_diameter_best = 5.56
	bullet_diameter_max = 5.6

	ai_heat_sensitivity = 0.75

	attachment_barrel_offset_x = 32 - 16
	attachment_barrel_offset_y = 20 - 16

	attachment_sight_offset_x = 17 - 16
	attachment_sight_offset_y = 21 - 16

	attachment_undermount_offset_x = 26 - 16
	attachment_undermount_offset_y = 17 - 16

	inaccuracy_modifier = 0.75
	movement_inaccuracy_modifier = 0.25
	movement_spread_base = 0.005

	can_wield = TRUE

	rarity = RARITY_RARE

/obj/item/weapon/ranged/bullet/magazine/rifle/carbine/prototype/equipped


/obj/item/weapon/ranged/bullet/magazine/rifle/carbine/prototype/equipped/Generate()

	attachment_sight = new /obj/item/attachment/sight/red_dot(src)
	INITIALIZE(attachment_sight)
	GENERATE(attachment_sight)
	FINALIZE(attachment_sight)

	attachment_undermount = new /obj/item/attachment/undermount/angled_grip(src)
	INITIALIZE(attachment_undermount)
	GENERATE(attachment_undermount)
	FINALIZE(attachment_undermount)

	attachment_barrel = new /obj/item/attachment/barrel/charger(src)
	INITIALIZE(attachment_barrel)
	GENERATE(attachment_barrel)
	FINALIZE(attachment_barrel)

	. = ..()