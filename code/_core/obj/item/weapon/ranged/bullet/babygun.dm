/obj/item/weapon/ranged/bullet/pump/babygun
	name = ".22 sport shooter rifle"
	desc = "Baby's first gun."
	desc_extended = "A mass produced, shit-tier 4 capacity .22LR pump action rifle designed for target practice and small rodent hunting. Some of the stock and barrel has been sawn off as its raw materials is worth more than the actual gun.."
	icon = 'icons/obj/items/weapons/ranged/babygun_compact.dmi'
	icon_state = "inventory"
	value = 10

	shoot_delay = 1

	automatic = FALSE

	bullet_count_max = 4

	bullet_type = ".22"

	//shoot_sounds = list('sounds/weapons/pumpshotgun/shoot.ogg')

	view_punch = 4

/obj/item/weapon/ranged/bullet/pump/babygun/get_static_spread() //Base spread
	return 0

/obj/item/weapon/ranged/bullet/pump/babygun/get_skill_spread(var/mob/living/L) //Base spread
	return 0.01 - (0.01 * L.get_skill_power(SKILL_RANGED))