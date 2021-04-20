/obj/item/weapon/ranged/bullet/magazine/rifle/vintorez
	name = "\improper 9x39mm VSS Vintorez"
	desc = "The last thing you never see."
	desc_extended = "A special military sniper rifle purpose-built for silent, flashless sniping during special operations where early detection of the shooter may be critical."
	icon = 'icons/obj/item/weapons/ranged/rifle/939_vintar.dmi'
	icon_state = "inventory"

	shoot_delay = 3

	automatic = TRUE

	damage_mod = 1.3

	shoot_sounds = list('sound/weapons/russia/vintorez.ogg')

	can_wield = TRUE
	wield_only = FALSE


	size = SIZE_4
	weight = 14

	heat_max = 0.3

	bullet_length_min = 38
	bullet_length_best = 39
	bullet_length_max = 40

	bullet_diameter_min = 8
	bullet_diameter_best = 9
	bullet_diameter_max = 10

	size = SIZE_4


	value = 450

	ai_heat_sensitivity = 2

	shoot_alert = ALERT_LEVEL_NONE

	attachment_whitelist = list(
		/obj/item/attachment/barrel/charger = TRUE, /obj/item/attachment/barrel/charger/advanced = TRUE,
		/obj/item/attachment/barrel/compensator = TRUE,
		/obj/item/attachment/barrel/extended = TRUE,
		/obj/item/attachment/barrel/suppressor = TRUE,
		/obj/item/attachment/undermount/bipod = TRUE,
		/obj/item/attachment/undermount/burst_adapter = TRUE
	)

	attachment_barrel_offset_x = 32 - 16
	attachment_barrel_offset_y = 20 - 16

	attachment_sight_offset_x = 15 - 16
	attachment_sight_offset_y = 20 - 16

	attachment_undermount_offset_x = 23 - 16
	attachment_undermount_offset_y = 17 - 16

	firing_pin = /obj/item/firing_pin/electronic/iff/revolutionary

	inaccuracy_modifier = 0.1
	movement_inaccuracy_modifier = 1
	movement_spread_base = 0.02

/obj/item/weapon/ranged/bullet/magazine/rifle/vintorez/get_static_spread()
	if(!wielded) return 0.005
	return 0.001

/obj/item/weapon/ranged/bullet/magazine/rifle/vintorez/get_skill_spread(var/mob/living/L)
	if(!heat_current) return 0
	return max(0,0.002 - (0.004 * L.get_skill_power(SKILL_RANGED)))