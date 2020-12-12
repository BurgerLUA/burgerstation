/experience/skill/
	experience_power = 1
	experience_multiplier = 1
	default_level = 15
	chargen_min_level = 5
	chargen_max_level = 25

//Warrior 6
/experience/skill/melee/ //STRENGTH
	//Each point of damage dealt = 1xp
	name = "Melee"
	id = SKILL_MELEE
	desc = "Be the ninja weeb space samurai you always wanted to be."
	desc_extended = "Your skill in performing attacks with melee weapons. Affects the damage of swords, clubs, and even a toolbox."
	experience_power = 1.5
	experience_multiplier = 21.5
	combat_level_mul = 1

/experience/skill/unarmed/ //FORTITUDE
	//Each point of damage dealt = 1xp
	name = "Unarmed"
	id = SKILL_UNARMED
	desc = "Kapooooooooooooooooooooooooooooooooooooooooooooooow."
	desc_extended = "Your skill in performing attacks with your fists. Affects the damage of your bare hands, brass knuckles, or power fists."
	experience_power = 1.4
	experience_multiplier = 22.5
	combat_level_mul = 0.75

/experience/skill/prayer/ //VITALITY
	//Each point of damage dealt or healed = 1xp
	name = "Prayer"
	id = SKILL_PRAYER
	desc = "Have a little faith in space jesus."
	desc_extended = "Your skill in praying to the gods. Affects the strength, speed, and success rate of casting prayer-based spells and abilities."
	experience_power = 1.5
	experience_multiplier = 21
	combat_level_mul = 0.75

/*
/experience/skill/block/ //FORTITUDE
	//Each time you block = 1xp
	name = "Block"
	id = SKILL_BLOCK
	desc = "Your skill in blocking attacks with a weapon or a shield. Affects the chance of a successful block of swords, bucklers, or even your fists."
	experience_power = 0.8
	experience_multiplier = 100
	combat_level_mul = 0.75
*/

//Rogue 6
/experience/skill/ranged/ //DEXTERITY
	//Each point of damage dealt = 1xp
	name = "Ranged"
	id = SKILL_RANGED
	desc = "Space Texas Sharpshooter."
	desc_extended = "Your skill in performing attacks with ranged weapons. Affects the damage and accuracy of bows, crossbows, guns, and throwing objects."
	experience_power = 1.5
	experience_multiplier = 34
	combat_level_mul = 1

/experience/skill/precision/ //AGILITY
	//Each point of extra damage in a critical hit = 1xp
	name = "Precision"
	id = SKILL_PRECISION
	desc = "There is actually a difference between precision and accurancy."
	desc_extended = "Your skill in striking vital points of creatures and humanoids. Affects the rate in which critical hits occur."
	experience_power = 1.4
	experience_multiplier = 22.5
	combat_level_mul = 1

/*
/experience/skill/dodge/ //AGILITY
	//Each time you dodge = 1 xp
	name = "Dodge"
	id = SKILL_DODGE
	desc = "Your skill in dodging incoming attacks. Affects the chance of a successful dodge from melee weapons, ranged weapons, and magic."
	experience_power = 0.8
	experience_multiplier = 100
	combat_level_mul = 0.75
*/

/experience/skill/survival //ENDURANCE
	name = "Survival"
	id = SKILL_SURVIVAL
	desc = "Wait this skill doesn't work yet."
	desc_extended = "Your skill in analyzing people, objects, or situations. Affects the chance of detecting traps and illusions, and how robust descriptions are when you examine things."
	experience_power = 1.5
	experience_multiplier = 5
	combat_level_mul = 0.75

//Mage 6
/experience/skill/magic/ //INTELLIGENCE
	name = "Magic"
	id = SKILL_MAGIC
	desc = "Not to be confused with sorcery."
	desc_extended = "Your skill in casting damage-dealing subjugation magic such as fireball, lightning bolt, and frostwave."
	experience_power = 1.5
	experience_multiplier = 21
	combat_level_mul = 1

/experience/skill/sorcery/ //WISDOM
	name = "Sorcery"
	id = SKILL_SORCERY
	desc = "Not to be confused with magic."
	desc_extended = "Your skill in casting chaos related magic such as summon demon, ruin luck, and random banish."
	experience_power = 1.5
	experience_multiplier = 21
	combat_level_mul = 0.75

/experience/skill/medicine/ //WILLPOWER
	name = "Medicine"
	id = SKILL_MEDICINE
	desc = "Surgery isn't in, yet!"
	desc_extended = "Your skill in treating yourself and others with actual medicine. Affects the treatment times and strength of bandages."
	experience_power = 1.5
	experience_multiplier = 21
	combat_level_mul = 0.75

/*
/experience/skill/parry/ //WISDOM
	//Each time you parry = 1xp
	name = "Parrying"
	id = SKILL_PARRY
	desc = "Your skill in parrying incoming attacks. Affects the chance of a successful counter-attack from melee weapons, ranged weapons, and magic."
	experience_power = 0.8
	experience_multiplier = 100
	combat_level_mul = 1
*/

//Crafting
/experience/skill/alchemy/ //Int
	name = "Alchemy"
	id = SKILL_ALCHEMY
	desc = "Also known as chemistry."
	desc_extended = "Your skill in mixing potions. Affects the speed, sucess rate, and quality of potions."
	experience_power = 1.8
	experience_multiplier = 4.1
	counts_towards_level = FALSE
	combat_level_mul = 0

/experience/skill/enchanting/ //Int
	name = "Enchanting"
	id = SKILL_ENCHANTING
	desc = "This doesn't work, yet!"
	desc_extended = "Your skill in enchanting objects. Affects the speed, sucess rate, and quality of enchanted items."
	experience_power = 1.8
	experience_multiplier = 4.1
	counts_towards_level = FALSE
	combat_level_mul = 0

/experience/skill/cooking/ //Str
	name = "Cooking"
	id = SKILL_COOKING
	desc = "This doesn't work, yet!"
	desc_extended = "Your skill in cooking food. Affects the speed, success rate, and quality of cooking new items."
	experience_power = 1.8
	experience_multiplier = 4.1
	counts_towards_level = FALSE
	combat_level_mul = 0

/experience/skill/crafting //Str
	name = "Crafting"
	id = SKILL_CRAFTING
	desc = "This doesn't work, yet!"
	desc_extended = "Your skill in crafting items. Affects the speed and success rate of crafting items."
	experience_power = 1.8
	experience_multiplier = 4.1
	counts_towards_level = FALSE
	combat_level_mul = 0