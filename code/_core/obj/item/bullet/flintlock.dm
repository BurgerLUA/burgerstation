/obj/item/bullet_cartridge/flintlock
	name = "\improper .62 powder charge and iron ball"
	desc = "Hm. If only there was a way to combine both the projectile and the powder easier for transport and loading... like in one cartridge."
	desc_extended = "For ancient weapons that require this bullshit."
	icon = 'icons/obj/item/bullet/flintlock.dmi'

	bullet_length = 15.7
	bullet_diameter = 15.7

	amount_max = 3
	amount_max_icon = 3

	projectile = /obj/projectile/bullet/flintlock
	damage_type_bullet = /damagetype/ranged/bullet/flintlock

	projectile_speed = BULLET_SPEED_PISTOL_HEAVY

	size = 0.1
	value = 1 //Dummy value.

	caseless = TRUE

/obj/item/bullet_cartridge/flintlock/premium
	name = "\improper premium .62 powder charge and iron ball"
	desc = "Wow, look at how technology's advancing."
	desc = "It's really just another iron ball and powder charge, but they're wrapped in paper so it's a tiny bit easier to load."
	icon = 'icons/obj/item/bullet/flintlock_premium.dmi'

	damage_type_bullet = /damagetype/ranged/bullet/flintlock/premium