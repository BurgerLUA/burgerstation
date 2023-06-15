/obj/item/weapon/ranged/bullet/magazine/rifle/m13
	name = "\improper .308 M13 Service Rifle"
	desc = "HOORAH!"
	desc_extended = "The M13 is an Old War service rifle used by old Space Yankee colonies to defend territory as well as conquer it. It doesn't see much use today and can only be found in the hands of collectors and grandchildren of veterans. Uses a special 8 round clip to feed rounds."
	icon = 'icons/obj/item/weapons/ranged/rifle/sol/m13.dmi'
	icon_state = "inventory"
	value = 800

	company_type = "Solarian"

	tier_type = "marksman rifle"

	tier = 1

	shoot_delay = 3.5

	automatic = FALSE

	shoot_sounds = list('sound/weapons/ranged/rifle/m13/shoot.ogg')

	can_wield = TRUE

	size = SIZE_4
	weight = 25

	heat_max = 0.125

	bullet_length_min = 46
	bullet_length_best = 51
	bullet_length_max = 52

	bullet_diameter_min = 7.6
	bullet_diameter_best = 7.62
	bullet_diameter_max = 7.7

	ai_heat_sensitivity = 1.5

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
		/obj/item/attachment/sight/scope/large = TRUE,
		/obj/item/attachment/sight/targeting_computer = TRUE,



		/obj/item/attachment/undermount/angled_grip = TRUE,
		/obj/item/attachment/undermount/bipod = TRUE,
		/obj/item/attachment/undermount/burst_adapter = FALSE,
		/obj/item/attachment/undermount/vertical_grip = TRUE,
		/obj/item/attachment/undermount/gun/grenade_launcher = TRUE
	)

	attachment_barrel_offset_x = 32 - 16
	attachment_barrel_offset_y = 20 - 16

	attachment_sight_offset_x = 19 - 16
	attachment_sight_offset_y = 20 - 16

	attachment_undermount_offset_x = 24 - 16
	attachment_undermount_offset_y = 18 - 16

	inaccuracy_modifier = 0.1
	movement_inaccuracy_modifier = 1
	movement_spread_base = 0.04

	dan_mode = TRUE

	rarity = RARITY_COMMON

/obj/item/weapon/ranged/bullet/magazine/rifle/m13/get_static_spread()
	return 0.0001

/obj/item/weapon/ranged/bullet/magazine/rifle/m13/get_skill_spread(var/mob/living/L)
	return max(0,0.01 - (0.02 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/magazine/rifle/m13/load_new_bullet_from_magazine(var/mob/caller)
	. = ..()
	if(!chambered_bullet && stored_magazine)
		var/turf/T = get_turf(src)
		play_sound('sound/weapons/ranged/generic/clip_ping.ogg',T)
		eject_magazine(caller)

/obj/item/weapon/ranged/bullet/magazine/rifle/m13/clicked_on_by_object(var/mob/caller as mob,var/atom/object,location,control,params) //The src was clicked on by the object

	if(stored_magazine && !wielded && is_inventory(object) && is_inventory(src.loc) && !caller.attack_flags) //Can't remove magazine normally.
		return TRUE

	. = ..()


/obj/item/weapon/ranged/bullet/magazine/rifle/m13/accept_bullet(var/mob/caller as mob,var/obj/item/bullet_cartridge/B,var/silent=FALSE)

	if(!stored_magazine)
		caller.to_chat(span("warning","You can't load \the [B.name] into \the [src.name] without a clip inserted!"))
		return FALSE

	if(chambered_bullet)
		return B.transfer_src_to_magazine(caller,stored_magazine)

	. = ..()
