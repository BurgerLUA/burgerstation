/experience/attribute/
	experience_power = 1
	experience_multiplier = 1
	chargen_min_level = 5
	chargen_max_level = 20

//Warrior
/experience/attribute/strength/ //100% complete
	name = "Strength"
	desc = "A measure of how strong you are."
	skill_for_examine = 5
	desc_vague = "Affects your damage in some way alongside increasing grab resistance."
	desc_extended = "Affects the damage of most melee weapons as well as some ranged weapons, as well as your ability to escape grabs.\nCan be increased by dealing damage with strength-based weapons."
	id = ATTRIBUTE_STRENGTH
	flags = ATTRIBUTE_DAMAGE
	experience_power = 1.9
	experience_multiplier = 10.4

/experience/attribute/constitution/ //100% complete
	name = "Constitution"
	desc = "A measure of your physical well-being."
	skill_for_examine = 3
	desc_vague = "Affects your resistances in some way."
	desc_extended = "Affects your natural resistance to the physical elements.\nCan be increased by taking damage from non-magical attacks."
	id = ATTRIBUTE_CONSTITUTION
	flags = ATTRIBUTE_RESISTANCE
	experience_power = 1.9
	experience_multiplier = 10.4

/experience/attribute/fortitude/ //100% complete
	name = "Fortitude"
	desc = "A measure of how your body responds to adversity."
	skill_for_examine = 4
	desc_vague = "Affects your health in some way."
	desc_extended = "Affects your natural health regeneration rate.\nCan be increased from regenerating your health naturally."
	id = ATTRIBUTE_FORTITUDE
	flags = ATTRIBUTE_REGEN
	experience_power = 1.9
	experience_multiplier = 10.4

/experience/attribute/vitality/ //100% complete
	name = "Vitality"
	desc = "A measure of your lifeforce."
	skill_for_examine = 4
	desc_vague = "Affects your health in some way."
	desc_extended = "Affects your maximum health.\nCan be increased by leveling up strength, constitution, or fortitude."
	id = ATTRIBUTE_VITALITY
	flags = ATTRIBUTE_STAT | ATTRIBUTE_NO_DIFFICULTY_XP_MUL
	experience_power = 1
	experience_multiplier = 2

/experience/attribute/vitality/on_level_up(var/old_level,var/new_level)
	if(owner && owner.health)
		owner.health.update_health_stats()
	return ..()

//Rogue
/experience/attribute/dexterity/ //100% complete
	name = "Dexterity"
	desc = "A measure of raw overall skill."
	skill_for_examine = 5
	desc_vague = "Affects your damage in some way."
	desc_extended = "Affects the damage and the attack speed of most melee weapons as well as some ranged weapons.\nCan be increased by dealing damage with dexterity-based weapons."
	id = ATTRIBUTE_DEXTERITY
	flags = ATTRIBUTE_DAMAGE
	experience_power = 1.9
	experience_multiplier = 10.4

/experience/attribute/agility //0% complete
	name = "Agility"
	desc = "A measure of how fast your body can move."
	skill_for_examine = 2
	desc_vague = "Affects your speed in some way."
	desc_extended = "Affects the maximum speed at which you can move, as well as the strength of slowdown negation.\nCan be increased by sprinting."
	id = ATTRIBUTE_AGILITY
	flags = ATTRIBUTE_RESISTANCE
	experience_power = 1.9
	experience_multiplier = 5.2

/experience/attribute/resilience/ //100% complete
	name = "Resilience"
	desc = "A measure of how well your body reacts to physical exhertion."
	skill_for_examine = 2
	desc_vague = "Affects your stamina in some way."
	desc_extended = "Affects your natural stamina regeneration rate.\nCan be increased from regenerating your stamina naturally."
	id = ATTRIBUTE_RESILIENCE
	flags = ATTRIBUTE_REGEN
	experience_power = 1.9
	experience_multiplier = 10.4

/experience/attribute/endurance/ //100% complete
	name = "Endurance"
	desc = "A measure of how long your body can last."
	skill_for_examine = 3
	desc_vague = "Affects your stamina in some way."
	desc_extended = "Affects your maximum stamina.\nCan be increased by leveling up dexterity, agility, or resilience."
	id = ATTRIBUTE_ENDURANCE
	flags = ATTRIBUTE_STAT | ATTRIBUTE_NO_DIFFICULTY_XP_MUL
	experience_power = 1
	experience_multiplier = 2

/experience/attribute/endurance/on_level_up(var/old_level,var/new_level)
	if(owner && owner.health)
		owner.health.update_health_stats()
	return ..()


//Wizard
/experience/attribute/intelligence/ //100% complete
	name = "Intelligence"
	desc = "A measure of how quickly and accurately you can apply knowledge."
	skill_for_examine = 6
	desc_vague = "Affects your damage in some way."
	desc_extended = "Affects the damage of most magical spells, powers, and abilities.\nCan be increased by dealing damage with spell-based weapons."
	id = ATTRIBUTE_INTELLIGENCE
	flags = ATTRIBUTE_DAMAGE
	experience_power = 1.9
	experience_multiplier = 10.4

/experience/attribute/willpower/ //100% complete
	name = "Willpower"
	desc = "A measure of how well you can control your mind."
	skill_for_examine = 6
	desc_vague = "Affects your mana in some way."
	desc_extended = "Affects your natural mana regeneration rate.\nCan be increased by regenerating your mana naturally."
	id = ATTRIBUTE_WILLPOWER
	flags = ATTRIBUTE_REGEN
	experience_power = 1.9
	experience_multiplier = 10.4

/experience/attribute/soul //100% complete
	name = "Soul"
	desc = "A measure of how strong your spirtual being is."
	skill_for_examine = 7
	desc_vague = "Affects your resistances in some way."
	desc_extended = "Affects your natural resistances to the arcane.\nCan be increased by taking damage from magical attacks."
	id = ATTRIBUTE_SOUL
	flags = ATTRIBUTE_RESISTANCE
	experience_power = 1.9
	experience_multiplier = 10.4

/experience/attribute/wisdom/ //100% complete
	name = "Wisdom"
	desc = "A measure of how much knowledge you have."
	skill_for_examine = 7
	desc_vague = "Affects your mana in some way."
	desc_extended = "Affects your maximum mana.\nCan be increased by leveling up willpower, soul, and intelligence."
	id = ATTRIBUTE_WISDOM
	flags = ATTRIBUTE_STAT | ATTRIBUTE_NO_DIFFICULTY_XP_MUL
	experience_power = 1
	experience_multiplier = 2

/experience/attribute/wisdom/on_level_up(var/old_level,var/new_level)
	if(owner && owner.health)
		owner.health.update_health_stats()
	return ..()










//None. Everyone starts with 50.
/experience/attribute/luck/ //50% complete.
	name = "Luck"
	id = ATTRIBUTE_LUCK
	flags = ATTRIBUTE_STAT | ATTRIBUTE_NO_DIFFICULTY_XP_MUL
	chargen_min_level = 40
	chargen_max_level = 50
	default_level = 50
	counts_towards_level = FALSE

/experience/attribute/luck/set_level(var/level)
	. = ..()
	if(.)
		owner.luck = clamp(level,1,src.get_max_level())

