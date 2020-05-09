/experience/skill/
	experience_power = 1
	experience_multiplier = 1
	default_level = SKILL_STARTING_NONE
	chargen_min_level = 5
	chargen_max_level = 25

//Warrior 6
/experience/skill/melee/ //STRENGTH
	name = "Melee"
	id = SKILL_MELEE
	desc = "Your skill in performing attacks with melee weapons. Affects the damage of swords, clubs, and even a toolbox."
	//Each point of damage dealt = 1xp
	experience_power = 1.9
	experience_multiplier = 2.5
	combat_level_mul = 1

/experience/skill/unarmed/ //STRENGTH
	name = "Unarmed"
	id = SKILL_UNARMED
	desc = "Your skill in performing attacks with your fists. Affects the damage of your bare hands, brass knuckles, or power fists."
	//Each point of damage dealt = 1xp
	experience_power = 2
	experience_multiplier = 1
	combat_level_mul = 0.75

/experience/skill/prayer/ //VITALITY
	name = "Prayer"
	id = SKILL_PRAYER
	desc = "Your skill in praying to the gods. Affects the strength, speed, and success rate of casting prayer-based spells and abilities."
	//Each point of power in a spell successfully casted = 1xp
	experience_power = 1.8
	experience_multiplier = 4.1
	combat_level_mul = 0.75

/experience/skill/block/ //FORTITUDE
	name = "Block"
	id = SKILL_BLOCK
	desc = "Your skill in blocking attacks with a weapon or a shield. Affects the chance of a successful block of swords, bucklers, or even your fists."
	//Each point of damage blocked = 1xp, rounded up.
	experience_power = 1.5
	experience_multiplier = 3.1
	combat_level_mul = 0.75

//Rogue 6
/experience/skill/ranged/ //DEXTERITY
	name = "Ranged"
	id = SKILL_RANGED
	desc = "Your skill in performing attacks with ranged weapons. Affects the damage and accuracy of bows, crossbows, guns, and throwing objects."
	experience_power = 1.9
	experience_multiplier = 2.5
	//Each point of damage dealt = 1xp
	combat_level_mul = 1

/experience/skill/precision/ //DEXTERITY
	name = "Precision"
	id = SKILL_PRECISION
	desc = "Your skill in striking vital points of creatures and humanoids. Affects the rate in which critical hits occur."
	experience_power = 1.9
	experience_multiplier = 2.5
	//Each point of damage dealt = 1xp
	combat_level_mul = 1

/experience/skill/dodge/ //AGILITY
	name = "Dodge"
	id = SKILL_DODGE
	desc = "Your skill in dodging incoming attacks. Affects the chance of a successful dodge from melee weapons, ranged weapons, and magic."
	//Each point of damage dodged = 1xp, rounded up.
	experience_power = 1.5
	experience_multiplier = 3.1
	combat_level_mul = 0.75

/experience/skill/survival //ENDURANCE
	name = "Survival"
	id = SKILL_SURVIVAL
	desc = "Your skill in analyzing people, objects, or situations. Affects the chance of detecting traps and illusions, and how robust descriptions are when you examine things."
	desc_extended = "You can level this skill by walking, running, climbing, swimming, and jumping."
	experience_power = 1.5
	experience_multiplier = 5
	combat_level_mul = 0.75

//Mage 6
/experience/skill/magic/ //INTELLIGENCE
	name = "Magic"
	id = SKILL_MAGIC
	desc = "Your skill in casting damage-dealing subjugation magic such as fireball, lightning bolt, and frostwave."
	//Each successful spell = 1xp
	//Each point of power in a spell successfully casted = 1xp
	experience_power = 1.8
	experience_multiplier = 4.1
	combat_level_mul = 1

/experience/skill/sorcery/ //INTELLIGENCE
	name = "Sorcery"
	id = SKILL_SORCERY
	desc = "Your skill in casting chaos related magic such as summon demon, ruin luck, and random banish."
	//Each successful spell = 1xp
	//Each point of power in a spell successfully casted = 1xp
	experience_power = 1.8
	experience_multiplier = 4.1
	combat_level_mul = 0.75

/experience/skill/medicine/ //WILLPOWER
	name = "Medicine"
	id = SKILL_MEDICINE
	desc = "Your skill in casting damage-warding deterrence magic such as raise barrier, conjure armor, and reflect spell."
	//Each successful spell = 1xp
	//Each point of power in a spell successfully casted = 1xp
	experience_power = 1.8
	experience_multiplier = 4.1
	combat_level_mul = 0.75

/experience/skill/parry/ //WISDOM
	name = "Parrying"
	id = SKILL_PARRY
	desc = "Your skill in parrying incoming attacks. Affects the chance of a successful counter-attack from melee weapons, ranged weapons, and magic."
	//Each point of damage parried = 1xp, rounded up.
	experience_power = 1.5
	experience_multiplier = 3.1
	combat_level_mul = 1

//Crafting
/experience/skill/alchemy/ //Int
	name = "Alchemy"
	id = SKILL_ALCHEMY
	desc = "Your skill in mixing potions. Affects the speed, sucess rate, and quality of potions."
	experience_power = 1.8
	experience_multiplier = 4.1
	counts_towards_level = FALSE
	combat_level_mul = 0

/experience/skill/enchanting/ //Int
	name = "Enchanting"
	id = SKILL_ENCHANTING
	desc = "Your skill in enchanting objects. Affects the speed, sucess rate, and quality of enchanted items."
	experience_power = 1.8
	experience_multiplier = 4.1
	counts_towards_level = FALSE
	combat_level_mul = 0

/experience/skill/cooking/ //Str
	name = "Cooking"
	id = SKILL_COOKING
	desc = "Your skill in cooking food. Affects the speed, success rate, and quality of cooking new items."
	experience_power = 1.8
	experience_multiplier = 4.1
	counts_towards_level = FALSE
	combat_level_mul = 0

/experience/skill/crafting //Str
	name = "Crafting"
	id = SKILL_CRAFTING
	desc = "Your skill in crafting items. Affects the speed and success rate of crafting items."
	experience_power = 1.8
	experience_multiplier = 4.1
	counts_towards_level = FALSE
	combat_level_mul = 0