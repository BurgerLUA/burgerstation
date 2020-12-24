//Here be genetic powders

/power/
	var/name = "Power Name"
	var/desc = "Power Description"
	var/add_message
	var/remove_message

/power/proc/on_add(var/mob/living/owner)
	if(add_message) owner.to_chat(add_message)
	return TRUE


/power/proc/on_remove(var/mob/living/owner)
	if(remove_message) owner.to_chat(remove_message)
	return TRUE

/power/resist/
	var/list/bonus_defense = list()

/power/resist/on_add(var/mob/living/owner)
	owner.defense_bonuses["\ref[src]"] = bonus_defense
	return ..()

/power/resist/on_remove(var/mob/living/owner)
	owner.defense_bonuses -= "\ref[src]"
	return ..()

/power/resist/thick_skin
	name = "Thick Skin"
	desc = "Your skin is now considerably thicker. You still cry when Bambi's mom dies, though."
	add_message = "Your skin feels considerably thicker..."
	remove_message = "Your skin starts to feel thin again."
	bonus_defense = list(
		BLADE = 25,
		PIERCE = 25
	)

/power/resist/moist_skin
	name = "Moist Skin"
	desc = "Your skin is now considerably moist. Don't forget to drink plenty of water."
	add_message = "Your skin feels considerably wet..."
	remove_message = "Your skin starts to dry again."
	bonus_defense = list(
		LASER = 25,
		HEAT = 25
	)

/power/resist/magically_mute
	name = "Magic Immune"
	desc = "You're completely immune to magic. As a consequence, magic spells do not work and the natural connection to this world makes leaves you physically vunerable."
	add_message = "You lose touch the magical energies..."
	remove_message = "You regain magical coherance."
	bonus_defense = list(
		ARCANE = INFINITY,
		BLADE = -50,
		PIERCE = -50,
		BLUNT = -50
	)

/power/resist/genetically_evil
	name = "Genetically Evil"
	desc = "Looks like evil is a gene. For whatever reason, you're significantly more in touch with the evil side than the good side."
	add_message = "You feel evil..."
	remove_message = "You feel neutral again."
	bonus_defense = list(
		HOLY = -100,
		DARK = 50
	)

/power/resist/genetically_good
	name = "Genetically Good"
	desc = "Looks like goodness is a gene. For whatever reason, you're significantly more in touch with the good side than the evil side."
	add_message = "You feel good..."
	remove_message = "You feel neutral again."
	bonus_defense = list(
		HOLY = 50,
		DARK = -100
	)