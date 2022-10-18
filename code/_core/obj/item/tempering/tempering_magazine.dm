/obj/item/tempering/magazine
	name = "magazine improvement"
	desc = "You shouldn't be seeing this..."
	desc_extended = "Report this to burger."

	//TODO: persist magic bullets on save/load?
	//TODO sprites for all the new stuff.

/obj/item/tempering/magazine/bluespace
	name = "Magazine bluespacer"
	desc = "Have you tried just putting more bullets in it?"
	desc_extended = "A tightly controlled bluespace pocket condenser. Fits to expand inside a magazine, and increases capacity 5x for that magazine"
	icon_state = "bluespacer"

	temper_whitelist = /obj/item/magazine

	value = 50000

	value_burgerbux = 1

/obj/item/tempering/magazine/bluespace/can_temper(var/mob/caller,var/obj/item/magazine/I)

	if(!istype(I,/obj/item/magazine))
		return FALSE

	if(I.bluespaced)
		caller.to_chat(span("warning","\The [I.name] is already bluespaced!"))
		return FALSE

	return ..()

/obj/item/tempering/magazine/bluespace/on_temper(var/mob/caller,var/obj/item/magazine/I)
	I.bluespaced = TRUE
	I.bullet_count_max *= 5
	return ..()

/obj/item/tempering/magazine/refiller
	name = "magazine refill upgrade system"
	desc = "Subscribe to magazine+ to get the best of your bullets."
	desc_extended = "A special digital rights management labeler that tells magazine restockers to fill the magazine with standard quality ammo. Single use."
	icon_state = "mag_enchant"

	temper_whitelist = /obj/item/magazine

	value = 50000

	value_burgerbux = 1

/obj/item/tempering/magazine/refiller/can_temper(var/mob/caller,var/obj/item/magazine/I)
	if(!istype(I,/obj/item/magazine))
		return FALSE

	if(I.regenerate)
		caller.to_chat(span("warning","\The [I.name] already has the label applied!"))
		return FALSE

	return ..()

/obj/item/tempering/magazine/refiller/on_temper(var/mob/caller,var/obj/item/magazine/I)
	I.regenerate = TRUE
	return ..()

/obj/item/tempering/magazine/spellswap
	name = "SpellSwapper Vanilla"
	desc = "Get your gun to shoot spells! Terms and conditions apply. Spells revert to normal bullets upon sleeping."
	desc_extended = "Use this on a full magazine to change out your bullets for magic projectiles."
	icon_state = "mag_enchant"

	temper_whitelist = /obj/item/magazine

	value = 2000
	value_burgerbux = 1

	var/new_projectile = /obj/projectile
	var/new_damage_type = /damagetype
	var/new_sound = list('sound/weapons/magic/chaos.ogg')

/obj/item/tempering/magazine/spellswap/can_temper(var/mob/caller,var/obj/item/magazine/I)
	if(!istype(I,/obj/item/magazine))
		return FALSE

	return ..()

/obj/item/tempering/magazine/spellswap/on_temper(var/mob/caller,var/obj/item/magazine/I)
	if(length(I.stored_bullets))
		//TODO: get this working so you have to use magic to level magic?
		//var/D = new_damage_type
		//D.bonus_experience_attribute = list(ATTRIBUTE_DEXTERITY = 10) //matches ranged.
		//D.skill_stats = list() //clear out magic-gain
		//D.attribute_stats = list() //clear out magic-gain
		for(var/i=1,i<=length(I.stored_bullets),i++)
			var/obj/item/bullet_cartridge/B = I.stored_bullets[i]
			B.projectile = new_projectile
			B.damage_type_bullet = new_damage_type
			B.shoot_sounds = new_sound

	return ..()
