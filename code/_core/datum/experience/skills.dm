/experience/skill/
	experience_power = 1
	experience_multiplier = 1
	chargen_min_level = 5
	chargen_max_level = 25

//Warrior
/experience/skill/melee/ //STRENGTH
	//Each point of damage dealt = 1xp
	//Level 100 is 2 million xp.
	name = "Melee"
	id = SKILL_MELEE
	desc = "Be the ninja weeb space samurai you always wanted to be."
	desc_extended = "Your skill in performing attacks with melee weapons. Affects the damage of swords, clubs, and even a toolbox."
	experience_power = 1.6
	experience_multiplier = 43

/experience/skill/unarmed/ //FORTITUDE
	//Each point of damage dealt = 1xp
	//Level 100 is 1 million xp.
	name = "Unarmed"
	id = SKILL_UNARMED
	desc = "Kapooooooooooooooooooooooooooooooooooooooooooooooow."
	desc_extended = "Your skill in performing attacks with your fists. Affects the damage of your bare hands, brass knuckles, or power fists."
	experience_power = 1.6
	experience_multiplier = 28

/experience/skill/prayer/ //VITALITY
	//Each point of damage dealt or healed = 1xp
	name = "Prayer"
	id = SKILL_PRAYER
	desc = "Have a little faith in space jesus."
	desc_extended = "Your skill in praying to the gods. Affects the strength, speed, and success rate of casting prayer-based spells and abilities."
	experience_power = 1.6
	experience_multiplier = 43

/experience/skill/block/ //FORTITUDE
	//Each time you block = 1xp
	//Must block 7600 times.
	name = "Block"
	id = SKILL_BLOCK
	desc = "Your skill in blocking attacks with a weapon or a shield. Affects the chance of a successful block of swords, bucklers, or even your fists."
	experience_power = 1.6
	experience_multiplier = 1.3

/experience/skill/armor/ //???
	//Each point of damage blocked by armor = 1xp
	//Level 100 is 1 million xp.
	name = "Armor"
	id = SKILL_ARMOR
	desc = "Your skill in blocking attacks with armor. Affects which armor you can wear."
	experience_power = 1.6
	experience_multiplier = 28

//Rogue 6
/experience/skill/ranged/ //DEXTERITY
	//Each point of damage dealt = 1xp
	//Level 100 is 2 million xp.
	name = "Ranged"
	id = SKILL_RANGED
	desc = "Space Texas Sharpshooter."
	desc_extended = "Your skill in performing attacks with ranged weapons. Affects the damage and accuracy of bows, crossbows, guns, and throwing objects."
	experience_power = 1.6
	experience_multiplier = 43

/experience/skill/precision/ //AGILITY
	//Each point of extra damage in a critical hit = 1xp
	//Level 100 is 1 million xp.
	name = "Precision"
	id = SKILL_PRECISION
	desc = "There is actually a difference between precision and accurancy."
	desc_extended = "Your skill in striking vital points of creatures and humanoids. Affects the rate in which critical hits occur."
	experience_power = 1.6
	experience_multiplier = 28

/experience/skill/evasion/ //AGILITY
	//Each time you dodge = 1 xp
	//Must dodge 7600 times.
	name = "Evasion"
	id = SKILL_EVASION
	desc = "Your skill in dodging incoming attacks. Affects the chance of a successful dodge from melee weapons, ranged weapons, and magic."
	experience_power = 1.6
	experience_multiplier = 1.3

/experience/skill/survival //ENDURANCE
	//Each time you avoid a trap = 1xp
	//Must avoid 1000 times.
	name = "Survival"
	id = SKILL_SURVIVAL
	desc = "Wait this skill doesn't work yet."
	desc_extended = "Your skill in analyzing people, objects, or situations. Affects the chance of detecting traps and illusions, and how robust descriptions are when you examine things."
	experience_power = 1.5
	experience_multiplier = 1

/experience/skill/parry/ //WISDOM
	//Each time you parry = 1xp
	name = "Parrying"
	id = SKILL_PARRY
	desc = "Your skill in parrying incoming attacks. Affects the chance of a successful counter-attack from melee weapons, ranged weapons, and magic."
	experience_power = 1.6
	experience_multiplier = 2.6

//Mage
/experience/skill/magic/ //INTELLIGENCE
	name = "Magic"
	id = SKILL_MAGIC_DEFENSIVE
	desc = "Not to be confused with sorcery."
	desc_extended = "Your skill in casting support and defensive spells like summoning magic."
	experience_power = 1.6
	experience_multiplier = 43

/experience/skill/sorcery/ //WISDOM
	name = "Sorcery"
	id = SKILL_MAGIC_OFFENSIVE
	desc = "Not to be confused with magic."
	desc_extended = "Your skill in casting damage-dealing magic such as fireball."
	experience_power = 1.6
	experience_multiplier = 43

/experience/skill/summoning //WISDOM
	name = "Summoning"
	id = SKILL_MAGIC_SUMMONING
	desc = "Not to be confused with prayer."
	desc_extended = "Your skill in casting summoning related magic such as summon skeleton."
	experience_power = 1.6
	experience_multiplier = 43

/experience/skill/medicine/ //WILLPOWER
	name = "Medicine"
	id = SKILL_MEDICINE
	desc = "Surgery isn't in, yet!"
	desc_extended = "Your skill in treating yourself and others with actual medicine. Affects the treatment times and strength of bandages."
	experience_power = 1.6
	experience_multiplier = 28

/experience/skill/enchanting/ //INTELLIGENCE
	name = "Enchanting"
	id = SKILL_MAGIC_ENCHANTING
	desc = "This doesn't work, yet!"
	desc_extended = "Your skill in enchanting objects. Affects the speed, sucess rate, and quality of enchanted items."
	experience_power = 1.8
	experience_multiplier = 4.1

//Non-class skills
/experience/skill/botany/ //No stat attached
	name = "Botany"
	id = SKILL_BOTANY
	desc = "Farming. "
	desc_extended = "Your skill in growing and harvesting plants. Affects harvested plant yield and potency."
	experience_power = 1.8
	experience_multiplier = 8.2
	counts_towards_level = FALSE