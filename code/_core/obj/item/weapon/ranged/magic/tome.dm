/obj/item/weapon/ranged/magic/tome/
	name = "spell tome"
	desc = "What secrets does this tome hold?"
	desc_extended = "A weapon that uses mana to cast spells."

	var/mana_cost = 100 //Base cost per cast

	var/associated_skill = SKILL_MAGIC_OFFENSE

/obj/item/weapon/ranged/magic/tome/proc/get_mana_cost()
	var/mob/living/advanced/A = get_owner()
	if(!is_advanced(A))
		return mana_cost

	return mana_cost * (1 - (A.get_skill_level(associated_skill)/200))

/obj/item/weapon/ranged/magic/tome/get_owner()
	if(is_inventory(src.loc))
		var/obj/inventory/I = src.loc
		return I.owner

	return null

/obj/item/weapon/ranged/magic/tome/get_ammo_count()
	return get_owner() && mana_cost ? floor(get_owner().mana_current / get_mana_cost()) : 0


/obj/item/weapon/ranged/magic/tome/handle_ammo(var/mob/living/caller as mob,var/atom/object,location,params)
	caller.mana_current -= get_mana_cost()
	update_icon()

/obj/item/weapon/ranged/magic/tome/lightning
	name = "tome of the lightning bolt"
	desc = "Be like Zeus!"
	desc_extended = "Costs mana to use."
	mana_cost = 25

	icon = 'icons/obj/items/weapons/ranged/magic/tomes/lightning.dmi'

	associated_skill = SKILL_PRAYER

	projectile = /obj/projectile/bullet/lightning_bolt



	shoot_sounds = list('sounds/weapon/ranged/magic/zap_large.ogg')


/obj/item/weapon/ranged/magic/tome/holy_warrior
	name = "tome of the holy warrior"
	desc = "For those too lazy for combat."
	desc_extended = "Costs mana to use."
	mana_cost = 100

	icon = 'icons/obj/items/weapons/ranged/magic/tomes/holy_summon.dmi'

	associated_skill = SKILL_PRAYER

	projectile = /obj/projectile/bullet/holy_summon

	shoot_sounds = list('sounds/weapon/ranged/magic/summon.ogg')

	bullet_speed = 3


/obj/item/weapon/ranged/magic/tome/lightning/get_static_spread() //Base spread
	return 0

/obj/item/weapon/ranged/magic/tome/lightning/get_skill_spread(var/mob/living/L) //Base spread
	return 0


/obj/item/weapon/ranged/magic/tome/heal
	name = "tome of healing"
	desc = "Wounds-B-Gone"
	desc_extended = "Costs mana to use. Those in a 3x3 area are affected by the heal."
	mana_cost = 50

	icon = 'icons/obj/items/weapons/ranged/magic/tomes/healing.dmi'

	associated_skill = SKILL_PRAYER

	projectile = /obj/projectile/bullet/mass_heal

	shoot_sounds = list('sounds/weapon/ranged/magic/heal.ogg')

	bullet_speed = 1

/obj/item/weapon/ranged/magic/tome/heal/get_static_spread() //Base spread
	return 0

/obj/item/weapon/ranged/magic/tome/heal/get_skill_spread(var/mob/living/L) //Base spread
	return 0