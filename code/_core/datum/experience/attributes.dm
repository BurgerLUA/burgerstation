/experience/attribute/
	experience_power = 1
	experience_multiplier = 1
	default_level = ATTRIBUTE_STARTING_NONE
	chargen_min_level = 5
	chargen_max_level = 20

//Warrior
/experience/attribute/strength/
	name = "Strength"
	id = ATTRIBUTE_STRENGTH
	desc = "A measure of how strong you are in this world. Affects damage with some weapons as well as the ability to perform certain actions."
	flags = ATTRIBUTE_DAMAGE
	experience_power = 1.35
	experience_multiplier = 10
	combat_level_mul = 1

/experience/attribute/vitality/
	name = "Vitality"
	id = ATTRIBUTE_VITALITY
	desc = "A measure of how long your life can last in this world. Affects maximum health."
	flags = ATTRIBUTE_STAT
	combat_level_mul = 0.75

/experience/attribute/fortitude/
	name = "Fortitude"
	id = ATTRIBUTE_FORTITUDE
	desc = "A measure of how resistant you are to the troubles of this world. Affects pain tolerance and physical damage resistance and health regeneration."
	flags = ATTRIBUTE_RESISTANCE
	experience_power = 1.2
	experience_multiplier = 25
	combat_level_mul = 0.5
	//19,000 xp to level 100

//Wizard
/experience/attribute/intelligence/
	name = "Intelligence"
	id = ATTRIBUTE_INTELLIGENCE
	desc = "A measure of how effective you are at using magic. Affects damage with some weapons and magic as well as the ability to perform certain actions."
	flags = ATTRIBUTE_DAMAGE
	experience_power = 1.35
	experience_multiplier = 10
	combat_level_mul = 1

/experience/attribute/wisdom/
	name = "Wisdom"
	id = ATTRIBUTE_WISDOM
	desc = "A measure of how wise you are. Affects maximum mana."
	flags = ATTRIBUTE_STAT
	combat_level_mul = 0.75

/experience/attribute/willpower/
	name = "Willpower"
	id = ATTRIBUTE_WILLPOWER
	desc = "A measure of how long your mind can last in this world. Affects magic resistance and and mana regeneration."
	flags = ATTRIBUTE_RESISTANCE
	experience_power = 1.2
	experience_multiplier = 25
	combat_level_mul = 0.5

//Rogue
/experience/attribute/dexterity/
	name = "Dexterity"
	id = ATTRIBUTE_DEXTERITY
	desc = "A measure of how well you can control your body. Affects damage with some weapons as well as the speed of performing actions."
	flags = ATTRIBUTE_DAMAGE
	experience_power = 1.35
	experience_multiplier = 10
	combat_level_mul = 1

/experience/attribute/agility/
	name = "Agility"
	id = ATTRIBUTE_AGILITY
	desc = "A measure of how agile you are in the world. Affects movement speed and the speed of which you perform movement based actions."
	flags = ATTRIBUTE_STAT
	experience_power = 1.5
	experience_multiplier = 5
	combat_level_mul = 0.75

/experience/skill/agility/get_power()
	return min(0.10,log(10,get_current_level()+1)*0.5)

/experience/attribute/endurance/
	name = "Endurance"
	id = ATTRIBUTE_ENDURANCE
	desc = "A measure of how long your body can last in this world. Affects resistance to poison, disease, fatigue, stamina damage. Also increases maximum stamina and stamina regeneration."
	flags = ATTRIBUTE_RESISTANCE
	experience_power = 1.2
	experience_multiplier = 25
	combat_level_mul = 0.5

//None. Everyone starts with 50.
/experience/attribute/luck/
	name = "Luck"
	id = ATTRIBUTE_LUCK
	combat_level_mul = 1
	desc = "A measure of how gosh darn lucky you are to be alive. Luck affects everything you do in small or, sometimes big, ways."
	flags = ATTRIBUTE_STAT
	chargen_min_level = 40
	chargen_max_level = 50
	default_level = 50
	counts_towards_level = FALSE