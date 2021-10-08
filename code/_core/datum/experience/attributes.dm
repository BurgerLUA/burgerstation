//Damage stats should be gained through actions.
//Resistant

/experience/attribute/
	experience_power = 1
	experience_multiplier = 1
	chargen_min_level = 5
	chargen_max_level = 20

//Warrior
/experience/attribute/strength/ //100% complete
	//Leveled up by dealing damage with weapons using the strength attribute.
	//1 points of damage = 1xp
	//Level 100 is 2 million xp.
	name = "Strength"
	id = ATTRIBUTE_STRENGTH
	desc = "Gronk smash!"
	desc_extended = "A measure of how strong you are in this world. Affects damage with some weapons as well as the ability to perform certain actions, such as resisting out of a grab or maintaining a grab."
	flags = ATTRIBUTE_DAMAGE
	experience_power = 1.9
	experience_multiplier = 10.4

/experience/attribute/fortitude/ //100% complete
	//Leveled up by regenerating health.
	//Each point of health regened = 1xp
	//level 100 is 2 million xp.
	name = "Fortitude"
	id = ATTRIBUTE_FORTITUDE
	desc = "Cock and Ball Torture (also known as CBT) is a German goregrind band formed on 22 February 1997. The group is known for its groove-heavy riffing and pitchshifted vocals. The band is noted for its pornography-themed imagery and song titles and are one of the more noteworthy acts in the pornogrind subgenre."
	desc_extended = "A measure of how resilient you are to this world. Affects health regeneration."
	flags = ATTRIBUTE_RESISTANCE
	experience_power = 1.9
	experience_multiplier = 10.4

/experience/attribute/constitution/ //0% complete
	//Leveled up by taking damage.
	//Each time hit = 1xp
	//level 100 is 10000xp
	name = "Constitution"
	id = ATTRIBUTE_CONSTITUTION
	desc = "Not the worst stat!"
	desc_extended = "A measure of how resistant you are to this world. Affects resistances to all physical (blade, blunt, pierce) damage types."
	flags = ATTRIBUTE_STAT
	experience_power = 1.9
	experience_multiplier = 0.8

/experience/attribute/vitality/ //100% complete
	//Leveled by increasing Strength, Fortitude, and Constitution.
	//Each point leveled = 1xp
	name = "Vitality"
	id = ATTRIBUTE_VITALITY
	desc = "Vital signs normal."
	desc_extended = "A measure of how long your life can last in this world. Affects maximum overall health as well as maximum organ health."
	flags = ATTRIBUTE_STAT
	experience_power = 1
	experience_multiplier = 2

/experience/attribute/vitality/on_level_up(var/old_level,var/new_level)
	if(owner && owner.health)
		owner.health.update_health_stats()
	return ..()

//Wizard
/experience/attribute/intelligence/ //100% complete
	//Leveled up by dealing damage with weapons using the intelligence attribute.
	//1 point of damage = 1xp
	//Level 100 is 2 million xp
	name = "Intelligence"
	id = ATTRIBUTE_INTELLIGENCE
	desc = "Different from wisdom!"
	desc_extended = "A measure of how effective you are at using magic. Affects damage with some weapons and magic as well as the ability to perform certain actions."
	flags = ATTRIBUTE_DAMAGE
	experience_power = 1.9
	experience_multiplier = 10.4

/experience/attribute/willpower/ //100% complete
	//Leveled up by regenerating mana.
	//Each point of mana regened = 1xp
	//Level 100 is 2 million xp
	name = "Willpower"
	id = ATTRIBUTE_WILLPOWER
	desc = "Where there is a will, there is a way."
	desc_extended = "A measure of how long your mind can last in this world. Affects magic resistance and and mana regeneration."
	flags = ATTRIBUTE_RESISTANCE
	experience_power = 1.9
	experience_multiplier = 10.4

/experience/attribute/soul //100% complete
	//Leveled up by dealing damage with weapons using the soul attribute.
	//1 point of damage = 1xp
	//Level 100 is 2 million xp
	name = "Soul"
	id = ATTRIBUTE_SOUL
	desc = "Not how good you are at music."
	desc_extended = "A measure of how strong your soul is. Affects special soul-based encounters."
	flags = ATTRIBUTE_RESISTANCE
	experience_power = 1.9
	experience_multiplier = 10.4

/experience/attribute/wisdom/ //100% complete
	//Leveled up by increasing willpower, intelligence, and soul.
	//Each level up = 1xp
	name = "Wisdom"
	id = ATTRIBUTE_WISDOM
	desc = "Different from intelligence!"
	desc_extended = "A measure of how wise you are. Affects maximum mana."
	flags = ATTRIBUTE_STAT
	experience_power = 1
	experience_multiplier = 2

/experience/attribute/wisdom/on_level_up(var/old_level,var/new_level)
	if(owner && owner.health)
		owner.health.update_health_stats()
	return ..()

//Rogue
/experience/attribute/dexterity/ //100% complete
	//Leveled up by dealing damage with weapons using the dexterity attribute.
	//1 point of damage = 1xp
	//Level 100 is 2 million xp
	name = "Dexterity"
	id = ATTRIBUTE_DEXTERITY
	desc = "Weebs max this skill."
	desc_extended = "A measure of how well you can control your body. Affects damage with some weapons as well as the speed of performing actions."
	flags = ATTRIBUTE_DAMAGE
	experience_power = 1.9
	experience_multiplier = 10.4

/experience/attribute/resilience/ //100% complete
	//Leveled up by regenerating stamina.
	//Each point of stamina regened = 1xp
	//Level 100 is 2 million xp
	name = "Resilience"
	id = ATTRIBUTE_RESILIENCE
	desc = "Resist!"
	desc_extended = "A measure of how long your body can last in this world. Affects resistance to stamina damage as well as stamina regeneration"
	flags = ATTRIBUTE_RESISTANCE
	experience_power = 1.9
	experience_multiplier = 10.4

/experience/attribute/endurance/ //100% complete
	//Leveled up by increasing resilience, dexterity, and agility
	//Each point leveled up = 1xp
	name = "Endurance"
	id = ATTRIBUTE_ENDURANCE
	desc = "Endure!"
	desc_extended = "A measure of how long your stamina can last in this world. Affects maximum stamina as well as maximum carry weight."
	flags = ATTRIBUTE_STAT
	experience_power = 1
	experience_multiplier = 2

/experience/attribute/endurance/on_level_up(var/old_level,var/new_level)
	if(owner && owner.health)
		owner.health.update_health_stats()
	return ..()

/experience/attribute/agility //0% complete
	//Leveled up by moving.
	//Each tile sprinted = 1xp.
	//Level 100 is 537,300 xp.
	name = "Agility"
	id = ATTRIBUTE_AGILITY
	desc = "Agile!"
	desc_extended = "A measure of how fast you move. Affects your movement speed as well as the speed of which you perform movement based actions."
	flags = ATTRIBUTE_STAT
	experience_power = 1.9
	experience_multiplier = 5.2

//None. Everyone starts with 50.
/experience/attribute/luck/ //50% complete.
	name = "Luck"
	id = ATTRIBUTE_LUCK
	desc = "This attribute is the reason why casinos don't exist."
	desc_extended = "A measure of how gosh darn lucky you are to be alive. Luck affects everything you do in small or, sometimes big, ways."
	flags = ATTRIBUTE_STAT
	chargen_min_level = 40
	chargen_max_level = 50
	default_level = 50
	counts_towards_level = FALSE

/experience/attribute/luck/set_level(var/level)
	. = ..()
	if(.)
		owner.luck = clamp(level,1,src.get_max_level())

