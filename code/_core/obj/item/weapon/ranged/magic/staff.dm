/obj/item/weapon/ranged/magic/staff
	var/cost_charge = 100
	var/total_charge = 1000
	weight = 10

/obj/item/weapon/ranged/magic/staff/Finalize()
	cost_charge = CEILING(cost_charge,10)
	total_charge = CEILING(total_charge,100)
	return ..()

/obj/item/weapon/ranged/magic/staff/get_examine_list(var/mob/examiner)

	. = ..()

	if(total_charge > initial(total_charge)*2)
		. += span("warning","Overcharged: Uses twice as many charge as it is above capacity.")


/obj/item/weapon/ranged/magic/staff/save_item_data(var/mob/living/advanced/player/P,var/save_inventory = TRUE,var/died=FALSE,var/loadout=FALSE)
	RUN_PARENT_SAFE
	SAVEVAR("total_charge")

/obj/item/weapon/ranged/magic/staff/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data,var/loadout=FALSE)
	RUN_PARENT_SAFE
	LOADVAR("total_charge")


/obj/item/weapon/ranged/magic/staff/can_gun_shoot(var/mob/caller,var/atom/object,location,params,var/check_time=TRUE,var/messages=TRUE)

	if(total_charge < cost_charge)
		handle_empty(caller)
		return FALSE

	return ..()

/obj/item/weapon/ranged/magic/staff/get_examine_list(var/mob/caller)
	return ..() + div("notice","It has [get_ammo_count()] charges ([total_charge]) remaining.")

/obj/item/weapon/ranged/magic/staff/handle_ammo(var/mob/caller,var/bullet_position=1)
	var/charge_to_remove = cost_charge
	if(total_charge > initial(total_charge)*2)
		charge_to_remove *= 2
	total_charge -= charge_to_remove
	update_sprite()
	return null

/obj/item/weapon/ranged/magic/staff/get_ammo_count()
	return round(total_charge / cost_charge)

/obj/item/weapon/ranged/magic/staff/fire
	name = "Wand of Fireballs"
	desc = "Shoot fireballs!"
	desc = "You can also use it to reheat soup in a pinch."
	cost_charge = SOUL_SIZE_COMMON/10
	total_charge = SOUL_SIZE_COMMON

	projectile_speed = TILE_SIZE*0.75 - 1
	shoot_delay = 8

	icon = 'icons/obj/item/weapons/ranged/magic/fire.dmi'

	projectile = /obj/projectile/magic/fireball
	ranged_damage_type = /damagetype/ranged/magic/fireball

	override_icon_state = TRUE

	shoot_sounds = list('sound/weapons/magic/fireball.ogg')

	shoot_delay = 14*0.25

	value = 1200

	rarity = RARITY_UNCOMMON

/obj/item/weapon/ranged/magic/staff/fire/New()
	..()
	update_sprite()

/obj/item/weapon/ranged/magic/staff/fire/update_icon()

	icon_state = "[initial(icon_state)][get_ammo_count() >= 1 ? "_1" : ""]"

	..()

/obj/item/weapon/ranged/magic/staff/chaos

	name = "Staff of Chaos"
	desc = "Summon Chaos!"
	desc_extended = "For when you need to summon a little chaos."
	cost_charge = SOUL_SIZE_UNCOMMON/20
	total_charge = SOUL_SIZE_UNCOMMON

	shoot_delay = 8

	projectile_speed = TILE_SIZE*0.25 - 1

	bullet_count = 5

	icon = 'icons/obj/item/weapons/ranged/magic/chaos.dmi'

	projectile = /obj/projectile/magic/chaos
	ranged_damage_type = /damagetype/ranged/magic/chaos

	shoot_sounds = list('sound/weapons/magic/chaos.ogg')

	value = 900

	rarity = RARITY_UNCOMMON

/obj/item/weapon/ranged/magic/staff/chaos/get_projectile_offset(var/initial_offset_x,var/initial_offset_y,var/bullet_num,var/bullet_num_max,var/accuracy)

	var/num = bullet_num/bullet_num_max

	var/norm_x = initial_offset_x + sin(num*360)
	var/norm_y = initial_offset_y + cos(num*360)

	var/mul = max(abs(norm_x),abs(norm_y))

	return list(norm_x/mul,norm_y/mul)

/obj/item/weapon/ranged/magic/staff/chaos/get_static_spread()
	return 0



/obj/item/weapon/ranged/magic/staff/basic
	name = "Staff of the Magic Missile"
	desc = "ARCANE MISSILE!"
	desc_extended = "Point the orb end at the enemy for best result."
	cost_charge = SOUL_SIZE_COMMON/20
	total_charge = SOUL_SIZE_COMMON

	projectile_speed = TILE_SIZE - 1
	bullet_count = 1

	icon = 'icons/obj/item/weapons/ranged/magic/basic.dmi'

	projectile = /obj/projectile/magic/magic_missile
	ranged_damage_type = /damagetype/ranged/magic/magic_missile

	shoot_sounds = list('sound/weapons/magic/magic_missile.ogg')

	shoot_delay = 8

	value = 1000

	rarity = RARITY_UNCOMMON

/*
/obj/item/weapon/ranged/magic/staff/focus

	name = "Staff of the Rift"
	desc = "Shoot rifts and annoy the shit out of people."
	desc_extended = "If you pass through a Rift in a car, does it become the staff of the drift?"
	cost_charge = 100
	total_charge = 1000

	projectile_speed = 31
	bullet_count = 1
	shoot_delay = 10

	icon = 'icons/obj/item/weapons/ranged/magic/focus.dmi'

	projectile = /obj/projectile/magic/rift
	ranged_damage_type = /damagetype/ranged/magic/chaos

	shoot_sounds = list('sound/weapons/magic/teleport_out.ogg')
*/

/obj/item/weapon/ranged/magic/staff/blackflame
	name = "Staff of the Blackflame"
	desc = "Draw unholy power to cast a flame that burns black!"
	desc_extended = "You can also use it to reheat soup in a pinch."
	cost_charge = SOUL_SIZE_UNCOMMON/10
	total_charge = SOUL_SIZE_UNCOMMON

	projectile_speed = TILE_SIZE - 1
	bullet_count = 1
	shoot_delay = 10

	can_wield = TRUE

	dan_mode = TRUE

	icon = 'icons/obj/item/weapons/ranged/magic/blackflame.dmi'

	projectile = /obj/projectile/magic/blackflame
	ranged_damage_type = /damagetype/ranged/magic/blackflame

	shoot_sounds = list('sound/weapons/magic/fireball.ogg')

	value = 1400

	value_burgerbux = 1

	rarity = RARITY_RARE

