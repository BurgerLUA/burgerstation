/obj/item/weapon/ranged/bullet/magazine/shotgun/bulldog/cursed
	name = "\improper Cursed Canine"
	desc = "For when you want to clear a room, but spookier"
	desc_extended = "Some ammo-obsessed eldritch forces have possessed the lower receiver of this shotgun, and replace normal shells with magical projectiles in their place when fired. Trying to make sense of what gods beyond the edges of reality want with 20g buckshot is how you go crazy."
	icon = 'icons/obj/item/weapons/ranged/shotgun/cursed.dmi'
	icon_state = "inventory"
	value = 2700
	projectile = /obj/projectile/magic/chaos
	ranged_damage_type = /damagetype/ranged/magic/chaos/canine

	bullet_length_min = 17
	bullet_length_best = 16.66
	bullet_length_max = 18

	tier = 4

	bullet_count = 4
	projectile_speed = TILE_SIZE*0.2 - 1

/obj/item/weapon/ranged/bullet/magazine/shotgun/bulldog/cursed/get_ranged_damage_type()
    return /damagetype/ranged/magic/chaos

/obj/item/weapon/ranged/bullet/magazine/shotgun/bulldog/cursed/spend_chambered_bullet(var/mob/caller) //magazine/shotgun/bulldog/cursed/
    //remove a bullet from the chamber, but make a new one to return.
    if(!chambered_bullet || chambered_bullet.is_spent)
        return FALSE

    var/obj/item/bullet_cartridge/shotgun_20/cursed/S = new()
    INITIALIZE(S)
    FINALIZE(S)

    chambered_bullet = S

    . = chambered_bullet.spend_bullet(caller,0)

    if(chambered_bullet.qdeleting)
        chambered_bullet = null
