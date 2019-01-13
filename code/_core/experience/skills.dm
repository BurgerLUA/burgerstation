//Mobility
//Rogue 5
/experience/skill/athletics //Endurance
	name = "Athletics"
	id = SKILL_ATHLETICS
	desc = "Your skill in walking, running, jumping, climbing, and swimming. Affects your movement speed when performing these actions."
	desc_extended = "You can level this skill by walking, running, climbing, swimming, and jumping."
	experience_power = 1.7
	experience_multiplier = 2
	//Each tile traveled = 1xp

/experience/skill/ranged/ //Agility
	name = "Ranged Weapons"
	id = SKILL_RANGED
	desc = "Your skill in performing attacks with ranged weapons. Affects the damage and accuracy of bows, crossbows, guns, and throwing objects."
	experience_power = 1.9
	experience_multiplier = 2.5
	//Each point of damage dealt = 1xp

/experience/skill/dodge/ //Agility
	name = "Dodge"
	id = SKILL_DODGE
	desc = "Your skill in dodging incoming attacks. Affects the chance of a successful dodge from melee weapons, ranged weapons, and magic."
	//Each point of damage dodged = 1xp, rounded up.
	experience_power = 1.5
	experience_multiplier = 3.1

/experience/skill/stealth/ //Dexterity
	name = "Stealth"
	id = SKILL_STEALTH
	desc = "Your skill in blending in with your surroundings. Affects how well you're conceled in your enviroment when sneaking."
	//Each successful tile stepped unnoticed with others around = 1xp
	//Each successful sneak attack = 10xp
	experience_power = 1.7
	experience_multiplier = 0.7

/experience/skill/theft/ //Dexterity
	name = "Theft"
	id = SKILL_THEFT
	desc = "Your skill in taking items undetected. Affects how well you can secretly take items, steal take items off of people, or break into locks"
	//Each time stolen in the open = 2xp
	//Each item pickpocked = 10xp
	//Each lock picked = 1xp
	experience_power = 2.2
	experience_multiplier = 0.2

//Warrior 5
/experience/skill/unarmed/ //STRENGTH
	name = "Unarmed"
	id = SKILL_UNARMED
	desc = "Your skill in performing attacks with your fists. Affects the damage of your bare hands, brass knuckles, or power fists."
	//Each point of damage dealt = 1xp
	experience_power = 2
	experience_multiplier = 1

/experience/skill/melee/ //STRENGTH
	name = "Melee Weapons"
	id = SKILL_MELEE
	desc = "Your skill in performing attacks with melee weapons. Affects the damage of swords, clubs, and even a toolbox."
	//Each successful blow = 1xp
	experience_power = 1.9
	experience_multiplier = 2.5

/experience/skill/block/ //FORTITUDE
	name = "Blocking"
	id = SKILL_BLOCK
	desc = "Your skill in blocking attacks with a weapon or a shield. Affects the chance of a successful block of swords, bucklers, or even your fists."
	//Each point of damage blocked = 1xp, rounded up.
	experience_power = 1.5
	experience_multiplier = 3.1

/experience/skill/armor/ //FORTITUDE
	name = "Armor"
	id = SKILL_ARMOR
	desc = "Your skill in wearing armor. Affects the protection rate of armor, as well as how much armor negatively affects you."
	//Each point of damage absorbed = 1xp, rounded up.
	experience_power = 1.5
	experience_multiplier = 4.8

/experience/skill/prayer/ //VITALITY
	name = "Prayer"
	id = SKILL_PRAYER
	desc = "Your skill in praying to the gods. Affects the strength, speed, and success rate of casting prayer-based spells and abilities."
	//Each point of power in a spell successfully casted = 1xp
	experience_power = 1.8
	experience_multiplier = 4.1

//Mage 6
/experience/skill/parry/
	name = "Parrying"
	id = SKILL_PARRY
	desc = "Your skill in parrying incoming attacks. Affects the chance of a successful counter-attack from melee weapons, ranged weapons, and magic."
	//Each point of damage parried = 1xp, rounded up.
	experience_power = 1.5
	experience_multiplier = 3.1

/experience/skill/offensive_magic/ //Intelligence
	name = "Offensive Magic"
	id = SKILL_MAGIC_OFFENSE
	desc = "Your skill in casting offensive magic such as fireball, lightning bolt, and frostburn."
	//Each successful spell = 1xp
	//Each point of power in a spell successfully casted = 1xp
	experience_power = 1.8
	experience_multiplier = 4.1

/experience/skill/defensive_magic/
	name = "Defensive Magic"
	id = SKILL_MAGIC_DEFENSE
	desc = "Your skill in casting defense magic such as conjure armor, raise wall, and shield."
	//Each successful spell = 1xp
	//Each point of power in a spell successfully casted = 1xp
	experience_power = 1.8
	experience_multiplier = 4.1

/experience/skill/supportive_magic/
	name = "Supportive Magic"
	id = SKILL_MAGIC_SUPPORT
	desc = "Your skill in casting supportive magic such as mend flesh, protect, and fortify."
	//Each successful spell = 1xp
	//Each point of power in a spell successfully casted = 1xp
	experience_power = 1.8
	experience_multiplier = 4.1


//Crafting
/experience/skill/alchemy/
	name = "Alchemy"
	id = SKILL_ALCHEMY
	desc = "Your skill in enchanting objects. Affects the speed, sucess rate, and quality of enchanted items."
	experience_power = 1.8
	experience_multiplier = 4.1

/experience/skill/enchanting/
	name = "Enchanting"
	id = SKILL_ENCHANTING
	desc = "Your skill in enchanting objects. Affects the speed, sucess rate, and quality of enchanted items."
	experience_power = 1.8
	experience_multiplier = 4.1

/experience/skill/cooking/
	name = "Cooking"
	id = SKILL_COOKING
	desc = "Your skill in cooking food. Affects the speed, success rate, and quality of cooking new items."
	experience_power = 1.8
	experience_multiplier = 4.1

/experience/skill/blacksmithing
	name = "Blacksmithing"
	id = SKILL_BLACKSMITH
	desc = "Your skill in crafting weapons and armor. Affects the speed and success rate of crafting items."
	experience_power = 1.8
	experience_multiplier = 4.1