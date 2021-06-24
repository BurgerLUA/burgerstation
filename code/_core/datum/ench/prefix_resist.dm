/ench/prefix/resist/
	var/damage_id = BLADE
	desc = "Reduces incoming #DT damage by #M%."
	magnitude_min = 1
	magnitude_max = 5

/ench/prefix/resist/on_equipped(var/mob/living/L,var/obj/item/clothing/C)
	. = ..()
	L.add_mob_value("[damage_id]_resist","ench:\ref[src]",magnitude)

/ench/prefix/resist/on_unequipped(var/mob/living/L,var/obj/item/clothing/C)
	. = ..()
	L.remove_mob_value("[damage_id]_resist","ench:\ref[src]")

/ench/prefix/resist/get_description()
	. = ..()
	. = replacetextEx(.,"#DT",damage_id)

/ench/prefix/resist/blade
	name = "Shattering"
	damage_id = BLADE

/ench/prefix/resist/blunt
	name = "Padded"
	damage_id = BLUNT

/ench/prefix/resist/pierce
	name = "Deflecting"
	damage_id = PIERCE

/ench/prefix/resist/laser
	name = "Dampening"
	damage_id = LASER

/ench/prefix/resist/arcane
	name = "Nullifying"
	damage_id = ARCANE

/ench/prefix/resist/heat
	name = "Fireproof"
	damage_id = HEAT

/ench/prefix/resist/cold
	name = "Heat Insulated"
	damage_id = COLD

/ench/prefix/resist/shock
	name = "Shock Insulated"
	damage_id = SHOCK

/ench/prefix/resist/bomb
	name = "Bomb Proof"
	damage_id = BOMB

/ench/prefix/resist/bio
	name = "Lab Resistant"
	damage_id = BIO

/ench/prefix/resist/rad
	name = "Radproof"
	damage_id = RAD

/ench/prefix/resist/holy
	name = "Unholy"
	damage_id = HOLY

/ench/prefix/resist/dark
	name = "Holy"
	damage_id = DARK

/ench/prefix/resist/fatigue
	name = "Tireless"
	damage_id = FATIGUE

/ench/prefix/resist/pain
	name = "Painless"
	damage_id = PAIN

/ench/prefix/resist/ion
	name = "Augmented"
	damage_id = ION

/ench/prefix/resist/sanity
	name = "Sane"
	damage_id = SANITY