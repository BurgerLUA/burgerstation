/obj/item/weapon/melee/shield
	name = "buckler"
	desc = "Carry two of these and be the ultimate asshole."
	desc_extended = "Good for blocking melee attacks. This buckler doubles your chance of blocking or parrying melee attacks. Can block ranged and melee attacks."
	icon = 'icons/obj/item/weapons/melee/shield.dmi'
	damage_type = /damagetype/melee/club/shield

	item_slot = SLOT_TORSO_B
	worn_layer = LAYER_MOB_CLOTHING_BACK
	slot_icons = TRUE

	value = 35

	block_defense_rating = list(
		BLADE = AP_CLUB,
		BLUNT = AP_CLUB,
		PIERCE = AP_CLUB
	)

	can_wear = TRUE

	weight = 6
	size = SIZE_4

/obj/item/weapon/melee/shield/ballistic
	name = "ballistic shield"
	desc = "Not just a slice off a plasteel wall, we swear!"
	desc_extended = "A huge shield fit to protect you from huge bullets. The sheer size makes it impossible to carry it anywhere but your back when you aren't using it."

	icon = 'icons/obj/item/weapons/melee/ballistic_shield.dmi'

	block_defense_rating = list(
		BLADE = AP_CLUB,
		BLUNT = AP_GREATSWORD,
		PIERCE = AP_GREATSWORD
	)
	weight = 25
	size = SIZE_7

/obj/item/weapon/melee/shield/glass
	name = "glass shield"
	icon = 'icons/obj/item/weapons/melee/glass_shield.dmi'

	block_defense_rating = list(
		BLADE = AP_CLUB,
		BLUNT = AP_SWORD,
		PIERCE = AP_SWORD,
		ARCANE = AP_GREATSWORD,
		DARK = AP_GREATSWORD,
		HOLY = AP_GREATSWORD
	)