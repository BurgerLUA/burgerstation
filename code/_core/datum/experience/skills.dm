/experience/skill/
	experience_power = 1
	experience_multiplier = 1
	chargen_min_level = 5
	chargen_max_level = 25

//Warrior
/experience/skill/melee/ //ATTRIBUTE_STRENGTH
	//Each point of damage dealt = 1xp
	//Level 100 is 2 million xp.
	name = "Melee"
	id = SKILL_MELEE
	desc = "Be the ninja weeb space samurai you always wanted to be."
	skill_for_examine = 2
	desc_vague = "Affects your damage in some way."
	desc_extended = "Your skill in performing attacks with melee weapons. Affects the damage of swords, clubs, and even a toolbox."
	experience_power = 1.6
	experience_multiplier = 43

/experience/skill/prayer/ //ATTRIBUTE_CONSTITUTION
	//Each point of damage dealt or healed = 1xp
	name = "Prayer"
	id = SKILL_PRAYER
	desc = "Have a little faith in space jesus."
	skill_for_examine = 6
	desc_vague = "Affects some of your spells in some way."
	desc_extended = "Your skill in praying to the gods. Affects the strength, speed, and success rate of casting prayer-based spells and abilities."
	experience_power = 1.6
	experience_multiplier = 43


/experience/skill/block/ //ATTRIBUTE_FORTITUDE
	//Each point of damage blocked = 1xp
	//Level 100 is 1 million xp.
	name = "Block"
	id = SKILL_BLOCK
	desc = "YOU SHALL NOT PASS!"
	skill_for_examine = list(3, 7, 8)
	desc_vague = "Affects your blocking in some way."
	desc_extended = "Your skill in blocking attacks with a weapon or a shield. Affects the chance of a successful block of swords, bucklers, or even your fists."
	tips = list(
		"When blocking, if an enemy attacks you in 1 second you will parry them, avoiding all damage and possibly stunning the opponent.",
		"Perfect parrying whilst avoiding all damage, does not grant you blocking expirience.",
	)
	experience_power = 1.6
	experience_multiplier = 28

/experience/skill/armor/ //ATTRIBUTE_FORTITUDE
	//Each point of damage blocked by armor = 1xp
	//Level 100 is 1 million xp.
	name = "Armor"
	id = SKILL_ARMOR
	desc = "As close to immortality as you can get."
	skill_for_examine = 3
	desc_vague = "Affects your armor in some way."
	desc_extended = "Your skill in blocking attacks with armor. Affects which armor you can wear."
	experience_power = 1.6
	experience_multiplier = 28

//Rogue 6

/experience/skill/ranged/ //ATTRIBUTE_DEXTERITY
	//Each point of damage dealt = 1xp
	//Level 100 is 2 million xp.
	name = "Ranged"
	id = SKILL_RANGED
	desc = "Space Texas Sharpshooter."
	skill_for_examine = 4
	desc_vague = "Affects your damage in some way."
	desc_extended = "Your skill in performing attacks with ranged weapons. Affects the damage and accuracy of bows, crossbows, guns, and throwing objects."
	experience_power = 1.6
	experience_multiplier = 43

/experience/skill/evasion/ //ATTRIBUTE_AGILITY
	//Each time you dodge = 1 xp
	name = "Evasion"
	id = SKILL_EVASION
	desc = "\"Turns on bullet time and dodges your every attack\""
	skill_for_examine = 4
	desc_vague = "Affects your dodging in some way."
	desc_extended = "Your skill in dodging incoming attacks. Affects the chance of a successful dodge from melee weapons, ranged weapons, and magic."
	experience_power = 1.6
	experience_multiplier = 2.6

/experience/skill/unarmed/ //ATTRIBUTE_RESILIENCE
	//Each point of damage dealt = 1xp
	//Level 100 is 1 million xp.
	name = "Unarmed"
	id = SKILL_UNARMED
	desc = "Kapooooooooooooooooooooooooooooooooooooooooooooooow."
	skill_for_examine = 2
	desc_vague = "Affects your damage in some way."
	desc_extended = "Your skill in performing attacks with your fists. Affects the damage of your bare hands, brass knuckles, or power fists."
	experience_power = 1.6
	experience_multiplier = 28

/experience/skill/survival //ATTRIBUTE_RESILIENCE
	name = "Survival"
	id = SKILL_SURVIVAL
	desc = "Doesn't make you immortal."
	desc_extended = "Your skill in analyzing people, objects, or situations. Affects the chance of detecting traps and illusions, and how robust descriptions are when you examine things."
	experience_power = 1.6
	experience_multiplier = 28


//Mage
/experience/skill/magic/ //ATTRIBUTE_INTELLIGENCE
	name = "Magic"
	id = SKILL_MAGIC
	desc = "Not to be confused with sorcery."
	skill_for_examine = 6
	desc_vague = "Affects your spells in some way."
	desc_extended = "Your skill in casting support and defensive spells like summoning magic."
	experience_power = 1.6
	experience_multiplier = 43

/experience/skill/summoning //ATTRIBUTE_SOUL
	name = "Summoning"
	id = SKILL_SUMMONING
	desc = "Not to be confused with prayer."
	skill_for_examine = list(5, 10)
	desc_extended = "Your skill in casting summoning related magic such as summon skeleton."
	experience_power = 1.6
	experience_multiplier = 43

/experience/skill/summoning/get_examine_list(var/mob/living/examiner)
	tips = list("Your summoning slots are expanded as you level up summoning, currently you can maintain [floor(max(1,1 + get_power(0,1,2)*3))] creatures")
	return ..()

/experience/skill/medicine/ //ATTRIBUTE_WILLPOWER
	name = "Medicine"
	id = SKILL_MEDICINE
	desc = "Surgery isn't in, yet!"
	skill_for_examine = 5
	desc_vague = "Affects your treatment in some way."
	desc_extended = "Your skill in treating yourself and others with actual medicine. Affects the treatment times and strength of bandages."
	experience_power = 1.6
	experience_multiplier = 28

/experience/skill/precision/ //ATTRIBUTE_WILLPOWER
	//Each point of extra damage in a critical hit = 1xp
	//Level 100 is 1 million xp.
	name = "Precision"
	id = SKILL_PRECISION
	desc = "There is actually a difference between precision and accuracy."
	skill_for_examine = 7
	desc_vague = "Affects your damage in some way."
	desc_extended = "Your skill in striking vital points of creatures and humanoids. Affects the rate in which critical hits occur."
	experience_power = 1.6
	experience_multiplier = 28
