/obj/item/weapon/ranged/bullet/magazine/smg/bullpup
	name = ".45 C-20r submachine gun"
	desc = "GET DAT FUKKEN DISK"
	desc_extended = "Commonly used by Syndicate Operatives for its reliability and light weight, the 45 C-20r was the primary firearm of the Syndicate Nuclear Operatives, before NT figured out having self destruct nukes on their station wasn't a great idea."
	icon = 'icons/obj/item/weapons/ranged/smg/45_2.dmi'
	icon_state = "inventory"

	projectile_speed = 20
	shoot_delay = 1.5

	automatic = TRUE

	shoot_sounds = list('sound/weapons/45/shoot.ogg')

	can_wield = FALSE

	override_icon_state = TRUE

	view_punch = 6



	size = SIZE_3
	weight = 10


	heat_per_shot = 0.03
	heat_max = 0.09

	bullet_length_min = 20
	bullet_length_best = 23
	bullet_length_max = 24

	bullet_diameter_min = 11
	bullet_diameter_best = 11.43
	bullet_diameter_max = 12

	value = 150

	ai_heat_sensitivity = 0.75

	shoot_alert = ALERT_LEVEL_NONE

	attachment_whitelist = list(
		/obj/item/attachment/barrel/charger = TRUE, /obj/item/attachment/barrel/charger/advanced = TRUE,
		/obj/item/attachment/barrel/compensator = TRUE,
		/obj/item/attachment/barrel/extended = TRUE,
		/obj/item/attachment/barrel/gyro = TRUE,
		/obj/item/attachment/barrel/laser_charger = FALSE,
		/obj/item/attachment/barrel/suppressor = TRUE,

		/obj/item/attachment/sight/laser_sight = TRUE,
		/obj/item/attachment/sight/quickfire_adapter = TRUE,
		/obj/item/attachment/sight/red_dot = TRUE,
		/obj/item/attachment/sight/scope = FALSE,
		/obj/item/attachment/sight/scope/large = FALSE,
		/obj/item/attachment/sight/targeting_computer = TRUE,

		/obj/item/attachment/stock/c20r = TRUE,

	)

	attachment_barrel_offset_x = 29 - 16
	attachment_barrel_offset_y = 19 - 16

	attachment_sight_offset_x = 23 - 16
	attachment_sight_offset_y = 21 - 16

	attachment_undermount_offset_x = 0 - 16
	attachment_undermount_offset_y = 0 - 16

	firing_pin = /obj/item/firing_pin/electronic/iff/syndicate

/obj/item/weapon/ranged/bullet/magazine/smg/bullpup/standard/Generate()

	. = ..()

	var/obj/item/attachment/stock/c20r/S = new(src)
	attachment_stock = S

	var/obj/item/attachment/sight/red_dot/RD = new(src)
	attachment_sight = RD

	var/obj/item/attachment/barrel/suppressor/SS = new(src)
	attachment_barrel = SS

	update_attachment_stats()
	update_sprite()

	return .

/obj/item/weapon/ranged/bullet/magazine/smg/bullpup/update_icon()

	icon_state = initial(icon_state)

	if(stored_magazine)
		icon_state = "[icon_state]_[CEILING((length(stored_magazine.stored_bullets)/stored_magazine.bullet_count_max)*5, 1)]"

	return ..()

/obj/item/weapon/ranged/bullet/magazine/smg/bullpup/get_static_spread()
	return 0.01

/obj/item/weapon/ranged/bullet/magazine/smg/bullpup/get_skill_spread(var/mob/living/L)
	if(!heat_current) return 0
	return max(0,0.02 - (0.04 * L.get_skill_power(SKILL_RANGED)))