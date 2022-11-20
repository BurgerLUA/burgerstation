/obj/item/spellswap/magic_missile
	name = "SpellSwapper(tm) - Magic Missile"
	desc_extended = "Use this on a weapon to trade the bullets for Magic Missiles. Brought to you by The Demon Prince of Hot Lead."
	icon_state = "magic_missile"

	desired_projectile = /obj/projectile/magic/magic_missile
	desired_sound = list('sound/weapons/magic/magic_missile.ogg')
	damage_conversion = list(
		ARCANE = 0.9
	)

/obj/item/spellswap/chaos
	name = "SpellSwapper(tm) - Chaos Orb"
	desc_extended = "Use this on a weapon to trade the bullets for Chaos Orbs. Brought to you by The Demon Prince of Hot Lead."
	icon_state = "chaos"

	desired_projectile = /obj/projectile/magic/chaos
	desired_sound = list('sound/weapons/magic/chaos.ogg')
	damage_conversion = list(
		ARCANE = 0.45,
		DARK = 0.45
	)

/obj/item/spellswap/fireball
	name = "SpellSwapper(tm) - Fireball"
	desc_extended = "Use this on a weapon to trade the bullets for Fireball. Brought to you by The Demon Prince of Hot Lead."
	icon_state = "fireball"

	desired_projectile = /obj/projectile/magic/fireball
	desired_sound = list('sound/weapons/magic/fireball.ogg')

	damage_conversion = list(
		ARCANE = 0.2,
		BOMB = 0.2,
		HEAT = 0.5
	)

/obj/item/spellswap/flame
	name = "SpellSwapper(tm) - Flame"
	desc_extended = "Use this on a weapon to trade the bullets for Flame Bolts. Brought to you by The Demon Prince of Hot Lead."
	icon_state = "flame"

	desired_projectile = /obj/projectile/magic/lesser_fire
	desired_sound = list('sound/weapons/magic/firestream.ogg')

	damage_conversion = list(
		ARCANE = 0.2,
		HEAT = 0.7
	)

/obj/item/spellswap/frost
	name = "SpellSwapper(tm) - Frost"
	desc_extended = "Use this on a weapon to trade the bullets for Frost Bolts. Brought to you by The Demon Prince of Hot Lead."
	icon_state = "frost"

	desired_projectile = /obj/projectile/magic/frost
	desired_sound = list('sound/weapons/magic/frost.ogg')

	damage_conversion = list(
		ARCANE = 0.2,
		COLD = 0.7
	)

/obj/item/spellswap/arcblade
	name = "SpellSwapper(tm) - ArcBlade"
	desc_extended = "Use this on a weapon to trade the bullets for ArcBlades. Brought to you by The Demon Prince of Hot Lead."
	icon_state = "arcblade"

	desired_projectile = /obj/projectile/magic/arcblade
	desired_sound = list('sound/weapons/magic/arc_blade.ogg')

	damage_conversion = list(
		ARCANE = 0.2,
		BLADE = 0.2,
		SHOCK = 0.5
	)

/obj/item/spellswap/tesla
	name = "SpellSwapper(tm) - Tesla"
	desc_extended = "Use this on a weapon to trade the bullets for Tesla Balls. Brought to you by The Demon Prince of Hot Lead."
	icon_state = "tesla"

	desired_projectile = /obj/projectile/magic/tesla
	desired_sound = list('sound/weapons/magic/zap.ogg')

	damage_conversion = list(
		ARCANE = 0.2,
		SHOCK = 0.7
	)

/obj/item/spellswap/negate
	name= "SpellSwapper(tm) - NULL"
	desc_extended = "Use this on a weapon to trade the bullets for....bullets?."

	desired_projectile = null
	value = 1000