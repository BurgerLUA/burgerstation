/obj/item/weapon/ranged/bullet/magazine/pistol/laton
	name = "9mm Laton pistol"
	desc = "9mm is all you need."
	desc_extended = "NT's standard pistol, chambered in a 9mm cartridge. It's very easy to use and recommended for beginners."
	value = 200
	icon = 'icons/obj/item/weapons/ranged/pistol/9mm_laton.dmi'
	shoot_delay = 1.8
	tier = 1
	shoot_sounds = list('sound/weapons/ranged/pistol/laton/shoot.ogg')

	company_type = "NanoTrasen"

	movement_spread_base = 0.002
	inaccuracy_modifier = 0.5
	movement_inaccuracy_modifier = 0

	automatic = FALSE

	size = SIZE_2
	weight = 3

	heat_max = 0.075

	bullet_length_min = 16
	bullet_length_best = 19
	bullet_length_max = 20

	bullet_diameter_min = 8.5
	bullet_diameter_best = 9
	bullet_diameter_max = 9.5

	attachment_whitelist = list(
		/obj/item/attachment/barrel/charger = TRUE, /obj/item/attachment/barrel/charger/advanced = TRUE,
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
		/obj/item/attachment/sight/scope = FALSE,
		/obj/item/attachment/sight/scope/large = FALSE,
		/obj/item/attachment/sight/targeting_computer = TRUE,



		/obj/item/attachment/undermount/angled_grip = FALSE,
		/obj/item/attachment/undermount/bipod = FALSE,
		/obj/item/attachment/undermount/burst_adapter = FALSE,
		/obj/item/attachment/undermount/vertical_grip = FALSE
	)

	attachment_barrel_offset_x = 27 - 16
	attachment_barrel_offset_y = 20 - 16

	attachment_sight_offset_x = 23 - 16
	attachment_sight_offset_y = 23 - 16

	attachment_undermount_offset_x = 22 - 16
	attachment_undermount_offset_y = 16 - 16

	rarity = RARITY_COMMON

/obj/item/weapon/ranged/bullet/magazine/pistol/laton/get_static_spread()
	return 0.002

/obj/item/weapon/ranged/bullet/magazine/pistol/laton/get_skill_spread(var/mob/living/L)
	return max(0,0.005 - (0.02 * L.get_skill_power(SKILL_RANGED)) )

/obj/item/weapon/ranged/bullet/magazine/pistol/laton/prototype
	name = "10mm Laton-H Prototype"
	icon = 'icons/obj/item/weapons/ranged/pistol/9mm_laton_mining.dmi' //Actually 10mm

	bullet_length_min = 25
	bullet_length_best = 32
	bullet_length_max = 33

	bullet_diameter_min = 10
	bullet_diameter_best = 10.17
	bullet_diameter_max = 11

	rarity = RARITY_RARE

	shoot_delay = 1.4
	weight = 7
	heat_max = 0.06

	shoot_sounds = list('sound/weapons/ranged/pistol/sol/shoot.ogg')

/obj/item/weapon/ranged/bullet/magazine/pistol/laton/mod
	name = "9mm Laton MOD"
	icon = 'icons/obj/item/weapons/ranged/pistol/9mm_laton_dark.dmi'
	shoot_delay = 1.25
	weight = 4
	heat_max = 0.06
	value = 350

	rarity = RARITY_RARE

var/global/list/kitchen_gun_slogans = list(
	"And it sparkles like new!",
	"GOODBYE DIRT!",
	"I LOVE YOU, KITCHEN GUN!",
	"HAHAHAHAHA!",
	"There! All clean again!"
)

/obj/item/weapon/ranged/bullet/magazine/pistol/laton/kitchen
	name = "9mm Laton Kitchen Gun"
	desc = "And it sparkles like new!"
	desc_extended = "Say goodbye to daily stains and dirty surfaces with new Laton Kitchen Gun! A modified 9mm Laton utilizing special jaintorial silver technology to clean stains and spills as you shoot, as long as you use standard 9mm ammo. Shoots 3 round bursts."
	icon = 'icons/obj/item/weapons/ranged/pistol/9mm_laton_kitchen.dmi'
	shoot_delay = 5
	burst_delay = 25
	max_bursts = 3
	weight = 7
	heat_max = 0.03
	value = 800
	var/slogan_number = 1

	value_burgerbux = 1

	rarity = RARITY_UNCOMMON

/obj/item/weapon/ranged/bullet/magazine/pistol/laton/kitchen/play_shoot_sounds(var/mob/caller,var/list/shoot_sounds_to_use = list(),var/shoot_alert_to_use = ALERT_LEVEL_NONE)
	. = ..()
	if(.)
		caller.do_say("BANG!")
		CALLBACK("kitchen_gun_slogan_\ref[caller]",SECONDS_TO_DECISECONDS(2),src,src::say_slogan(),caller)

/obj/item/weapon/ranged/bullet/magazine/pistol/laton/kitchen/proc/say_slogan(var/mob/caller)
	var/slogan_to_say = kitchen_gun_slogans[slogan_number]
	caller.do_say(slogan_to_say)
	slogan_number += 1
	if(slogan_number > length(kitchen_gun_slogans))
		slogan_number = 1

/obj/item/weapon/ranged/bullet/magazine/pistol/laton/kitchen/on_projectile_hit(var/obj/projectile/P,var/atom/hit_atom)

	if(istype(P,/obj/projectile/thrown/))
		return ..()

	var/turf/T = get_turf(hit_atom)
	if(T)
		for(var/obj/effect/cleanable/C in T.contents)
			qdel(C)

	. = ..()

/obj/item/weapon/ranged/bullet/magazine/pistol/laton/kitchen/shoot_projectile(var/atom/caller,var/atom/target,location,params,var/obj/projectile/projectile_to_use,var/damage_type_to_use,var/icon_pos_x=0,var/icon_pos_y=0,var/accuracy_loss=0,var/projectile_speed_to_use=0,var/bullet_count_to_use=1,var/bullet_color="#FFFFFF",var/view_punch=0,var/damage_multiplier=1,var/desired_iff_tag,var/desired_loyalty_tag,var/desired_inaccuracy_modifier=1,var/base_spread = get_base_spread(),var/penetrations_left=0)

	. = ..()

	for(var/k in .)
		var/obj/projectile/P = k
		P.hit_target_turf = TRUE