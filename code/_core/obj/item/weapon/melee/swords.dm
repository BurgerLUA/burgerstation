/obj/item/weapon/melee/sword
	drop_sound = 'sound/items/drop/knife.ogg'

/obj/item/weapon/melee/sword/sabre

	name = "sabre"
	desc = "A curved sword. Curved. Sword."
	desc_extended = "A cavalry sabre that was often used as a weapon by non-commissioned officers of the Sol Army before being replaced by energy swords, nowadays it's used as a dress decoration more than anything."

	icon = 'icons/obj/item/weapons/melee/swords/sabre.dmi'
	crafting_id = "sabre"

	icon_state_worn = "worn"

	damage_type = /damagetype/melee/sword/sabre

	size = SIZE_3
	weight = 6

	can_wear = TRUE

	value = 140


/obj/item/weapon/melee/sword/claymore
	name = "steel claymore sword"
	desc = "Looking at this really makes you want to go on a crusade."
	desc_extended = "A very basic claymore sword known for its use by knights in Medieval Europe. It is one of the most common weapons in The Realm, as it is a un-cursed version of the unholy cult blade."

	icon = 'icons/obj/item/weapons/melee/swords/claymore.dmi'
	crafting_id = "claymore"

	damage_type = /damagetype/melee/sword/claymore

	size = SIZE_3
	weight = 6

	value = 120

	can_wear = TRUE

/obj/item/weapon/melee/sword/claymore/cult
	name = "cultist sword"
	icon = 'icons/obj/item/weapons/melee/swords/cult.dmi'
	desc = "Looking at this really makes you want to go on an EVIL crusade."
	desc_extended = "A very basic claymore sword known for its use by knights in Medieval Europe, now cursed with Nar'sie's magic."

	damage_type = /damagetype/melee/sword/claymore/cult
	crafting_id = "cult"

	size = SIZE_3
	weight = 6

	value = 200

/obj/item/weapon/melee/spear
	name = "steel shortspear"
	desc = "Unga bunga."
	desc_extended = "Commonly used by the local Ashwalkers for hunting and settlement defense. Can be thrown for heavy damage."
	icon = 'icons/obj/item/weapons/melee/swords/spear.dmi'
	damage_type = /damagetype/melee/spear/basic/
	damage_type_thrown = /damagetype/melee/spear/basic/thrown
	crafting_id = "shortspear"

	size = SIZE_4

	value = 40

	attack_range = 1

	weight = 5

/obj/item/weapon/melee/spear/clockwork
	name = "clockwork spear"
	desc = "FOR RATVAR."
	desc_extended = "A very sharp brass alloy spear. Doesn't do that much damage when thrown."
	icon = 'icons/obj/item/weapons/melee/swords/ratvar.dmi'
	damage_type = /damagetype/melee/spear/ratvar/
	crafting_id = "clockworkspear"

	size = SIZE_4

	value = 400

	attack_range = 2

	weight = 10

/obj/item/weapon/melee/sword/zweihander
	name = "zweihander"
	rarity = RARITY_MYTHICAL
	desc = "THE LEGEND."
	desc_extended = "A steel sword that makes up for it's simplicity by being heavy and huge, the Zweihander is a fearsome sight only used by PMCs with no self-regard whatsoever."
	icon = 'icons/obj/item/weapons/melee/swords/zweihander.dmi'
	damage_type = /damagetype/melee/sword/zweihander
	crafting_id = "zweihander"

	size = SIZE_5

	value = 900

	attack_range = 2

/obj/item/weapon/melee/sword/zweihander/should_cleave(var/atom/attacker,var/atom/victim,var/list/params)

	if(wielded)
		return TRUE

	return ..()

/obj/item/weapon/melee/sword/curvedsword
	name = "steel curved sword"
	desc = "A curved blade. Poor at trusting, excells at slashing quickly."
	desc_extended = "A standard curved sword. Capable of fast swings, and when maintained it can be exceptionally sharp."

	icon = 'icons/obj/item/weapons/melee/swords/curvedsword.dmi'
	crafting_id = "curvedsword"

	dan_mode = TRUE

	damage_type = /damagetype/melee/sword/curvedsword

	size = SIZE_3
	weight = 5

	value = 500

/obj/item/weapon/melee/sword/skana
	name = "skana"
	desc = "A lightweight metal katana that's been space-ified."
	desc_extended = "A straight katana-like sword, with a curved starting near the end. Incredibly sharp."

	icon = 'icons/obj/item/weapons/melee/swords/skana.dmi'
	crafting_id = "skana"

	dan_mode = TRUE

	damage_type = /damagetype/melee/sword/skana

	size = SIZE_3
	weight = 4

	value = 180

/obj/item/weapon/melee/sword/gladius
	name = "gladius"
	desc = "A steel bladed gladius."
	desc_extended = "A light gladius with a bronze hilt and steel blade."

	icon = 'icons/obj/item/weapons/melee/swords/gladius.dmi'
	crafting_id = "gladius"

	dan_mode = TRUE

	damage_type = /damagetype/melee/sword/gladius

	size = SIZE_2
	weight = 4

	value = 200

/obj/item/weapon/melee/sword/allium
	name = "allium"
	desc = "An allium made of copper."
	desc_extended = "A light copper allium, better for thrusting than a gladius."
	crafting_id = "allium"

	icon = 'icons/obj/item/weapons/melee/swords/allium.dmi'

	dan_mode = TRUE

	damage_type = /damagetype/melee/sword/allium

	size = SIZE_2
	weight = 5

	value = 150