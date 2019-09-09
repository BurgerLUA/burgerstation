/experience/skill/
	experience_power = 1
	experience_multiplier = 1
	default_level = SKILL_STARTING_NONE
	chargen_min_level = 5
	chargen_max_level = 25
	associated_classes = list(
		//STR
			//PURE
			"Security Officer" = 0,
			"Cargo Technician"= 0,

			//INT
			"Engineer"= 0,
			"Botanist"= 0,
			"Quartermaster"=0,
			//AGI
			"Cook"= 0,
			"Janitor"= 0,
			"Shaft Miner"= 0,

		//INT
			//PURE
			"Scientist"= 0,
			"Lawyer"= 0,

			//STR
			"Chaplain"= 0,
			"Roboticist"= 0,
			"Geneticist"= 0,

			//AGI
			"Atmospheric Technician"= 0,
			"Chemist"= 0,
			"Virologist"= 0,

		//AGI
			//PURE
			"Mime"= 0,
			"Clown"= 0,

			//STR
			"Warden"= 0,
			"Bartender"= 0,
			"Ninja"= 0,

			//INT
			"Detective"= 0,
			"Curator"= 0.5,
			"Medical Doctor"= 0,

		"Assistant"= 0
	)


//Rogue 5
/experience/skill/ranged/ //AGILITY
	name = "Ranged Weapons"
	id = SKILL_RANGED
	desc = "Your skill in performing attacks with ranged weapons. Affects the damage and accuracy of bows, crossbows, guns, and throwing objects."
	experience_power = 1.9
	experience_multiplier = 2.5
	//Each point of damage dealt = 1xp
	combat_level_mul = 1
	associated_classes = list(
		//STR
			//PURE
			"Security Officer" = 1,
			"Cargo Technician"= 1,

			//INT
			"Engineer"= 0,
			"Botanist"= 0,
			"Quartermaster"= 1,
			//AGI
			"Cook"= 0,
			"Janitor"= 0,
			"Shaft Miner"= 1,

		//INT
			//PURE
			"Scientist"= 0,
			"Lawyer"= 0,

			//STR
			"Chaplain"= 0,
			"Roboticist"= 0,
			"Geneticist"= 0,

			//AGI
			"Atmospheric Technician"= 0,
			"Chemist"= 0,
			"Virologist"= 0,

		//AGI
			//PURE
			"Mime"= 0,
			"Clown"= -1,

			//STR
			"Warden"= 1,
			"Bartender"= 1,
			"Ninja"= 0,

			//INT
			"Detective"= 1,
			"Curator"= 0.5,
			"Medical Doctor"= 0,

		"Assistant"= 0
	)

/experience/skill/dodge/ //AGILITY
	name = "Dodge"
	id = SKILL_DODGE
	desc = "Your skill in dodging incoming attacks. Affects the chance of a successful dodge from melee weapons, ranged weapons, and magic."
	//Each point of damage dodged = 1xp, rounded up.
	experience_power = 1.5
	experience_multiplier = 3.1
	combat_level_mul = 0.75
	associated_classes = list(
		//STR
			//PURE
			"Security Officer" = 0,
			"Cargo Technician"= 0,

			//INT
			"Engineer"= 0,
			"Botanist"= 0,
			"Quartermaster"=0,
			//AGI
			"Cook"= 0,
			"Janitor"= 0,
			"Shaft Miner"= 1,

		//INT
			//PURE
			"Scientist"= 0,
			"Lawyer"= 0,

			//STR
			"Chaplain"= 0,
			"Roboticist"= 0,
			"Geneticist"= 0,

			//AGI
			"Atmospheric Technician"= 0,
			"Chemist"= 0,
			"Virologist"= 0,

		//AGI
			//PURE
			"Mime"= 1,
			"Clown"= 1,

			//STR
			"Warden"= 0,
			"Bartender"= 0,
			"Ninja"= 1,

			//INT
			"Detective"= 0,
			"Curator"= 0.5,
			"Medical Doctor"= 0,

		"Assistant"= 0
	)

/experience/skill/stealth/ //DEXTERITY
	name = "Stealth"
	id = SKILL_STEALTH
	desc = "Your skill in blending in with your surroundings. Affects how well you can be conceled in your enviroment when sneaking."
	//Each successful tile stepped unnoticed with others around = 1xp
	//Each successful sneak attack = 10xp
	experience_power = 1.7
	experience_multiplier = 0.7
	combat_level_mul = 0.5
	associated_classes = list(
		//STR
			//PURE
			"Security Officer" = 0,
			"Cargo Technician"= 0,

			//INT
			"Engineer"= 0,
			"Botanist"= 0,
			"Quartermaster"=0,
			//AGI
			"Cook"= 0,
			"Janitor"= 0,
			"Shaft Miner"= 0,

		//INT
			//PURE
			"Scientist"= 0,
			"Lawyer"= 1,

			//STR
			"Chaplain"= 0,
			"Roboticist"= 0,
			"Geneticist"= 0,

			//AGI
			"Atmospheric Technician"= 0,
			"Chemist"= 0,
			"Virologist"= 0,

		//AGI
			//PURE
			"Mime"= 1,
			"Clown"= -1,

			//STR
			"Warden"= 0,
			"Bartender"= 0,
			"Ninja"= 1,

			//INT
			"Detective"= 1,
			"Curator"= 0.5,
			"Medical Doctor"= 0,

		"Assistant"= 0
	)

/experience/skill/parry/ //DEXTERITY
	name = "Parrying"
	id = SKILL_PARRY
	desc = "Your skill in parrying incoming attacks. Affects the chance of a successful counter-attack from melee weapons, ranged weapons, and magic."
	//Each point of damage parried = 1xp, rounded up.
	experience_power = 1.5
	experience_multiplier = 3.1
	combat_level_mul = 1
	associated_classes = list(
		//STR
			//PURE
			"Security Officer" = 1,
			"Cargo Technician"= 0,

			//INT
			"Engineer"= 0,
			"Botanist"= 0,
			"Quartermaster"=0,
			//AGI
			"Cook"= 1,
			"Janitor"= 1,
			"Shaft Miner"= 0,

		//INT
			//PURE
			"Scientist"= 0,
			"Lawyer"= 0,

			//STR
			"Chaplain"= 0,
			"Roboticist"= 0,
			"Geneticist"= 0,

			//AGI
			"Atmospheric Technician"= 0,
			"Chemist"= 0,
			"Virologist"= 0,

		//AGI
			//PURE
			"Mime"= 0,
			"Clown"= 1,

			//STR
			"Warden"= 0,
			"Bartender"= 0,
			"Ninja"= 1,

			//INT
			"Detective"= 0,
			"Curator"= 0.5,
			"Medical Doctor"= 0,

		"Assistant"= 0
	)



/experience/skill/athletics //ENDURANCE
	name = "Athletics"
	id = SKILL_ATHLETICS
	desc = "Your skill in walking, running, jumping, climbing, and swimming. Affects your movement speed when performing these actions."
	desc_extended = "You can level this skill by walking, running, climbing, swimming, and jumping."
	experience_power = 1.5
	experience_multiplier = 5
	combat_level_mul = 0.75
	//Each tile traveled = 1xp
	associated_classes = list(
		//STR
			//PURE
			"Security Officer" = 1,
			"Cargo Technician"= 1,

			//INT
			"Engineer"= 0,
			"Botanist"= 0,
			"Quartermaster"=0,
			//AGI
			"Cook"= 0,
			"Janitor"= 0,
			"Shaft Miner"= 1,

		//INT
			//PURE
			"Scientist"= 0,
			"Lawyer"= 0,

			//STR
			"Chaplain"= 0,
			"Roboticist"= 0,
			"Geneticist"= 0,

			//AGI
			"Atmospheric Technician"= 0,
			"Chemist"= 0,
			"Virologist"= 0,

		//AGI
			//PURE
			"Mime"= 0,
			"Clown"= 1,

			//STR
			"Warden"= 0,
			"Bartender"= 0,
			"Ninja"= 1,

			//INT
			"Detective"= 0,
			"Curator"= 0.5,
			"Medical Doctor"= 0,

		"Assistant"= 0
	)

/experience/skill/athletics/get_power()
	//return (get_current_level() ** 2) * (1/(max_level*100))
	return log(10,get_current_level()+1)*0.5

/experience/skill/instinct //ENDURANCE
	name = "Instincts"
	id = SKILL_INSTINCTS
	desc = "Your skill in using your survival instincts. Affects your ability to identify threats such as traps, ambushes, player karma levels, and investigative skills."
	desc_extended = "You can level this skill by walking, running, climbing, swimming, and jumping."
	experience_power = 1.7
	experience_multiplier = 2
	combat_level_mul = 0.25
	associated_classes = list(
		//STR
			//PURE
			"Security Officer" = 1,
			"Cargo Technician"= 0,

			//INT
			"Engineer"= 1,
			"Botanist"= 1,
			"Quartermaster"=0,
			//AGI
			"Cook"= 0,
			"Janitor"= 0,
			"Shaft Miner"= 0,

		//INT
			//PURE
			"Scientist"= 1,
			"Lawyer"= 1,

			//STR
			"Chaplain"= 1,
			"Roboticist"= 1,
			"Geneticist"= 1,

			//AGI
			"Atmospheric Technician"= 1,
			"Chemist"= 1,
			"Virologist"= 1,

		//AGI
			//PURE
			"Mime"= 0,
			"Clown"= 0,

			//STR
			"Warden"= 1,
			"Bartender"= 0,
			"Ninja"= 1,

			//INT
			"Detective"= 1,
			"Curator"= 0.5,
			"Medical Doctor"= 0,

		"Assistant"= 0
	)



	//Each tile traveled = 1xp

//Warrior 5

/experience/skill/melee/ //STRENGTH
	name = "Melee Weapons"
	id = SKILL_MELEE
	desc = "Your skill in performing attacks with melee weapons. Affects the damage of swords, clubs, and even a toolbox."
	//Each successful blow = 1xp
	experience_power = 1.9
	experience_multiplier = 2.5
	combat_level_mul = 1
	associated_classes = list(
		//STR
			//PURE
			"Security Officer" = 1,
			"Cargo Technician"= 0,

			//INT
			"Engineer"= 1,
			"Botanist"= 1,
			"Quartermaster"=0,
			//AGI
			"Cook"= 1,
			"Janitor"= 1,
			"Shaft Miner"= 0,

		//INT
			//PURE
			"Scientist"= 0,
			"Lawyer"= 0,

			//STR
			"Chaplain"= 0,
			"Roboticist"= 0,
			"Geneticist"= 0,

			//AGI
			"Atmospheric Technician"= 1,
			"Chemist"= 0,
			"Virologist"= 0,

		//AGI
			//PURE
			"Mime"= 0,
			"Clown"= 1,

			//STR
			"Warden"= 1,
			"Bartender"= 0,
			"Ninja"= 1,

			//INT
			"Detective"= 0,
			"Curator"= 0.5,
			"Medical Doctor"= 0,

		"Assistant"= 0
	)


/experience/skill/block/ //STRENGTH
	name = "Blocking"
	id = SKILL_BLOCK
	desc = "Your skill in blocking attacks with a weapon or a shield. Affects the chance of a successful block of swords, bucklers, or even your fists."
	//Each point of damage blocked = 1xp, rounded up.
	experience_power = 1.5
	experience_multiplier = 3.1
	combat_level_mul = 0.75
	associated_classes = list(
		//STR
			//PURE
			"Security Officer" = 1,
			"Cargo Technician"= 0,

			//INT
			"Engineer"= 1,
			"Botanist"= 0,
			"Quartermaster"=0,
			//AGI
			"Cook"= 0,
			"Janitor"= 0,
			"Shaft Miner"= 0,

		//INT
			//PURE
			"Scientist"= 0,
			"Lawyer"= 0,

			//STR
			"Chaplain"= 0,
			"Roboticist"= 0,
			"Geneticist"= 0,

			//AGI
			"Atmospheric Technician"= 0,
			"Chemist"= 0,
			"Virologist"= 0,

		//AGI
			//PURE
			"Mime"= 0,
			"Clown"= 1,

			//STR
			"Warden"= 1,
			"Bartender"= 0,
			"Ninja"= 1,

			//INT
			"Detective"= 0,
			"Curator"= 0.5,
			"Medical Doctor"= 0,

		"Assistant"= 0
	)




/experience/skill/unarmed/ //VITALITY
	name = "Unarmed"
	id = SKILL_UNARMED
	desc = "Your skill in performing attacks with your fists. Affects the damage of your bare hands, brass knuckles, or power fists."
	//Each point of damage dealt = 1xp
	experience_power = 2
	experience_multiplier = 1
	combat_level_mul = 0.75
	associated_classes = list(
		//STR
			//PURE
			"Security Officer" = 1,
			"Cargo Technician"= 1,

			//INT
			"Engineer"= 0,
			"Botanist"= 0,
			"Quartermaster"=0,
			//AGI
			"Cook"= 0,
			"Janitor"= 0,
			"Shaft Miner"= 0,

		//INT
			//PURE
			"Scientist"= 0,
			"Lawyer"= 0,

			//STR
			"Chaplain"= 0,
			"Roboticist"= 0,
			"Geneticist"= 0,

			//AGI
			"Atmospheric Technician"= 0,
			"Chemist"= 0,
			"Virologist"= 0,

		//AGI
			//PURE
			"Mime"= 2,
			"Clown"= 1,

			//STR
			"Warden"= 1,
			"Bartender"= 0,
			"Ninja"= 1,

			//INT
			"Detective"= 1,
			"Curator"= 0.5,
			"Medical Doctor"= 1,

		"Assistant"= 0
	)

/experience/skill/prayer/ //VITALITY
	name = "Prayer"
	id = SKILL_PRAYER
	desc = "Your skill in praying to the gods. Affects the strength, speed, and success rate of casting prayer-based spells and abilities."
	//Each point of power in a spell successfully casted = 1xp
	experience_power = 1.8
	experience_multiplier = 4.1
	combat_level_mul = 0.75
	associated_classes = list(
		//STR
			//PURE
			"Security Officer" = 0,
			"Cargo Technician"= 0,

			//INT
			"Engineer"= 0,
			"Botanist"= 0,
			"Quartermaster"=0,
			//AGI
			"Cook"= 0,
			"Janitor"= 0,
			"Shaft Miner"= 0,

		//INT
			//PURE
			"Scientist"= 0,
			"Lawyer"= 0,

			//STR
			"Chaplain"= 2,
			"Roboticist"= 0,
			"Geneticist"= 0,

			//AGI
			"Atmospheric Technician"= 0,
			"Chemist"= 0,
			"Virologist"= 0,

		//AGI
			//PURE
			"Mime"= 0,
			"Clown"= 1,

			//STR
			"Warden"= 0,
			"Bartender"= 0,
			"Ninja"= 0,

			//INT
			"Detective"= 0,
			"Curator"= 0.5,
			"Medical Doctor"= 0,

		"Assistant"= 0
	)

/experience/skill/armor/ //FORTITUDE
	name = "Armor"
	id = SKILL_ARMOR
	desc = "Your skill in wearing armor. Affects the protection rate of armor, as well as how much armor negatively affects you."
	//Each point of damage absorbed = 1xp, rounded up.
	experience_power = 1.5
	experience_multiplier = 4.8
	combat_level_mul = 0.75
	associated_classes = list(
		//STR
			//PURE
			"Security Officer" = 1,
			"Cargo Technician"= 1,

			//INT
			"Engineer"= 1,
			"Botanist"= 0,
			"Quartermaster"=0,
			//AGI
			"Cook"= 0,
			"Janitor"= 0,
			"Shaft Miner"= 1,

		//INT
			//PURE
			"Scientist"= 1,
			"Lawyer"= 0,

			//STR
			"Chaplain"= 0,
			"Roboticist"= 2,
			"Geneticist"= 0,

			//AGI
			"Atmospheric Technician"= 1,
			"Chemist"= 0,
			"Virologist"= 0,

		//AGI
			//PURE
			"Mime"= 0,
			"Clown"= 0,

			//STR
			"Warden"= 1,
			"Bartender"= 0,
			"Ninja"= 0,

			//INT
			"Detective"= 0,
			"Curator"= 0.5,
			"Medical Doctor"= 0,

		"Assistant"= 0
	)


/experience/skill/recovery/ //FORTITUDE
	name = "Recovery"
	id = SKILL_RECOVERY
	desc = "Your skill in recovering from wounds. Affects the natural rate of which wounds heal."
	//Each point of health recovered = 1xp
	experience_power = 1.5
	experience_multiplier = 4.8
	combat_level_mul = 0.5
	associated_classes = list(
		//STR
			//PURE
			"Security Officer" = 1,
			"Cargo Technician"= 0,

			//INT
			"Engineer"= 0,
			"Botanist"= 1,
			"Quartermaster"=0,
			//AGI
			"Cook"= 0,
			"Janitor"= 0,
			"Shaft Miner"= 0,

		//INT
			//PURE
			"Scientist"= 0,
			"Lawyer"= 0,

			//STR
			"Chaplain"= 0,
			"Roboticist"= 0,
			"Geneticist"= 1,

			//AGI
			"Atmospheric Technician"= 0,
			"Chemist"= 1,
			"Virologist"= 1,

		//AGI
			//PURE
			"Mime"= 0,
			"Clown"= 0,

			//STR
			"Warden"= 0,
			"Bartender"= 0,
			"Ninja"= 0,

			//INT
			"Detective"= 0,
			"Curator"= 0.5,
			"Medical Doctor"= 2,

		"Assistant"= 0
	)


//Mage 5
/experience/skill/medicine/ //INTELLIGENCE
	name = "Medicine"
	id = SKILL_MEDICINE
	desc = "Your skill in treating wounds through medicine. Affects the rate in which treated wounds heal, as well as the strength of treating wounds."
	//Each point of health recovered = 1xp
	experience_power = 1.5
	experience_multiplier = 4.8
	combat_level_mul = 0.5
	associated_classes = list(
		//STR
			//PURE
			"Security Officer" = 0,
			"Cargo Technician"= 0,

			//INT
			"Engineer"= 0,
			"Botanist"= 1,
			"Quartermaster"=0,
			//AGI
			"Cook"= 0,
			"Janitor"= 0,
			"Shaft Miner"= 0,

		//INT
			//PURE
			"Scientist"= 1,
			"Lawyer"= 0,

			//STR
			"Chaplain"= 1,
			"Roboticist"= 1,
			"Geneticist"= 1,

			//AGI
			"Atmospheric Technician"= 0,
			"Chemist"= 1,
			"Virologist"= 1,

		//AGI
			//PURE
			"Mime"= 0,
			"Clown"= 0,

			//STR
			"Warden"= 0,
			"Bartender"= 0,
			"Ninja"= 0,

			//INT
			"Detective"= 0,
			"Curator"= 0.5,
			"Medical Doctor"= 3,

		"Assistant"= 0
	)

/experience/skill/offensive_magic/ //INTELLIGENCE
	name = "Subjugation Magic"
	id = SKILL_MAGIC_OFFENSIVE
	desc = "Your skill in casting damage-dealing subjugation magic such as fireball, lightning bolt, and frostwave. Affects the damage and mana cost of subjugation magic."
	//Each successful spell = 1xp
	//Each point of power in a spell successfully casted = 1xp
	experience_power = 1.8
	experience_multiplier = 4.1
	combat_level_mul = 1
	associated_classes = list(
		//STR
			//PURE
			"Security Officer" = 0,
			"Cargo Technician"= 0,

			//INT
			"Engineer"= 0,
			"Botanist"= 0,
			"Quartermaster"=0,
			//AGI
			"Cook"= 0,
			"Janitor"= 0,
			"Shaft Miner"= 0,

		//INT
			//PURE
			"Scientist"= 1,
			"Lawyer"= 1,

			//STR
			"Chaplain"= 2,
			"Roboticist"= 1,
			"Geneticist"= 1,

			//AGI
			"Atmospheric Technician"= 1,
			"Chemist"= 1,
			"Virologist"= 1,

		//AGI
			//PURE
			"Mime"= 0,
			"Clown"= 1,

			//STR
			"Warden"= 0,
			"Bartender"= 0,
			"Ninja"= 0,

			//INT
			"Detective"= 0,
			"Curator"= 2,
			"Medical Doctor"= 0,

		"Assistant"= 0
	)


/experience/skill/supportive_magic/ //RESOLVE
	name = "Reclamation Magic"
	id = SKILL_MAGIC_SUPPORT
	desc = "Your skill in casting damage-reversing reclamation magic such as restore flesh, cure self, and revive other."
	//Each successful spell = 1xp
	//Each point of power in a spell successfully casted = 1xp
	experience_power = 1.8
	experience_multiplier = 4.1
	combat_level_mul = 0.75
	associated_classes = list(
		//STR
			//PURE
			"Security Officer" = 0,
			"Cargo Technician"= 0,

			//INT
			"Engineer"= 0,
			"Botanist"= 1,
			"Quartermaster"=0,
			//AGI
			"Cook"= 0,
			"Janitor"= 0,
			"Shaft Miner"= 0,

		//INT
			//PURE
			"Scientist"= 1,
			"Lawyer"= 1,

			//STR
			"Chaplain"= 2,
			"Roboticist"= 1,
			"Geneticist"= 1,

			//AGI
			"Atmospheric Technician"= 1,
			"Chemist"= 1,
			"Virologist"= 1,

		//AGI
			//PURE
			"Mime"= 0,
			"Clown"= 0,

			//STR
			"Warden"= 0,
			"Bartender"= 0,
			"Ninja"= 0,

			//INT
			"Detective"= 0,
			"Curator"= 2,
			"Medical Doctor"= 1,

		"Assistant"= 0
	)


/experience/skill/defensive_magic/ //RESOLVE
	name = "Deterrence Magic"
	id = SKILL_MAGIC_DEFENSIVE
	desc = "Your skill in casting damage-warding deterrence magic such as raise barrier, conjure armor, and reflect spell."
	//Each successful spell = 1xp
	//Each point of power in a spell successfully casted = 1xp
	experience_power = 1.8
	experience_multiplier = 4.1
	combat_level_mul = 0.75
	associated_classes = list(
		//STR
			//PURE
			"Security Officer" = 0,
			"Cargo Technician"= 0,

			//INT
			"Engineer"= 1,
			"Botanist"= 0,
			"Quartermaster"=0,
			//AGI
			"Cook"= 0,
			"Janitor"= 0,
			"Shaft Miner"= 0,

		//INT
			//PURE
			"Scientist"= 2,
			"Lawyer"= 1,

			//STR
			"Chaplain"= 1,
			"Roboticist"= 1,
			"Geneticist"= 1,

			//AGI
			"Atmospheric Technician"= 1,
			"Chemist"= 1,
			"Virologist"= 1,

		//AGI
			//PURE
			"Mime"= 0,
			"Clown"= 0,

			//STR
			"Warden"= 0,
			"Bartender"= 0,
			"Ninja"= 0,

			//INT
			"Detective"= 0,
			"Curator"= 2,
			"Medical Doctor"= 0,

		"Assistant"= 0
	)

/experience/skill/reality_magic/ //WILLPOWER
	name = "Corporeality Magic"
	id = SKILL_MAGIC_REALITY
	desc = "Your skill in casting damage-tricking corporeality magic such as summon illusion, hallucinate other, and invisibility."
	//Each successful spell = 1xp
	//Each point of power in a spell successfully casted = 1xp
	experience_power = 1.8
	experience_multiplier = 4.1
	combat_level_mul = 0.75
	associated_classes = list(
		//STR
			//PURE
			"Security Officer" = 0,
			"Cargo Technician"= 0,

			//INT
			"Engineer"= 0,
			"Botanist"= 0,
			"Quartermaster"=0,
			//AGI
			"Cook"= 0,
			"Janitor"= 0,
			"Shaft Miner"= 0,

		//INT
			//PURE
			"Scientist"= 2,
			"Lawyer"= 1,

			//STR
			"Chaplain"= 1,
			"Roboticist"= 1,
			"Geneticist"= 1,

			//AGI
			"Atmospheric Technician"= 1,
			"Chemist"= 1,
			"Virologist"= 1,

		//AGI
			//PURE
			"Mime"= 3,
			"Clown"= 1,

			//STR
			"Warden"= 0,
			"Bartender"= 0,
			"Ninja"= 0,

			//INT
			"Detective"= 0,
			"Curator"= 2,
			"Medical Doctor"= 0,

		"Assistant"= 0
	)


/experience/skill/chaos_magic/ //WILLPOWER
	name = "Chaos Magic"
	id = SKILL_MAGIC_CHAOS
	desc = "Your skill in casting chaos related magic such as summon demon, ruin luck, and random banish."
	//Each successful spell = 1xp
	//Each point of power in a spell successfully casted = 1xp
	experience_power = 1.8
	experience_multiplier = 4.1
	combat_level_mul = 0.75
	associated_classes = list(
		//STR
			//PURE
			"Security Officer" = 0,
			"Cargo Technician"= 0,

			//INT
			"Engineer"= 0,
			"Botanist"= 0,
			"Quartermaster"=0,
			//AGI
			"Cook"= 0,
			"Janitor"= 0,
			"Shaft Miner"= 0,

		//INT
			//PURE
			"Scientist"= 2,
			"Lawyer"= 1,

			//STR
			"Chaplain"= 1,
			"Roboticist"= 1,
			"Geneticist"= 1,

			//AGI
			"Atmospheric Technician"= 1,
			"Chemist"= 1,
			"Virologist"= 1,

		//AGI
			//PURE
			"Mime"= 0,
			"Clown"= 3,

			//STR
			"Warden"= 0,
			"Bartender"= 0,
			"Ninja"= 0,

			//INT
			"Detective"= 0,
			"Curator"= 2,
			"Medical Doctor"= 0,

		"Assistant"= 0
	)
//Crafting
/experience/skill/alchemy/ //Int
	name = "Alchemy"
	id = SKILL_ALCHEMY
	desc = "Your skill in mixing potions. Affects the speed, sucess rate, and quality of potions."
	experience_power = 1.8
	experience_multiplier = 4.1
	counts_towards_level = FALSE
	combat_level_mul = 0
	associated_classes = list(
		//STR
			//PURE
			"Security Officer" = 0,
			"Cargo Technician"= 0,

			//INT
			"Engineer"= 0,
			"Botanist"= 2,
			"Quartermaster"=0,
			//AGI
			"Cook"= 1,
			"Janitor"= 0,
			"Shaft Miner"= 0,

		//INT
			//PURE
			"Scientist"= 1,
			"Lawyer"= 0,

			//STR
			"Chaplain"= 0,
			"Roboticist"= 0,
			"Geneticist"= 0,

			//AGI
			"Atmospheric Technician"= 0,
			"Chemist"= 4,
			"Virologist"= 0,

		//AGI
			//PURE
			"Mime"= 0,
			"Clown"= 0,

			//STR
			"Warden"= 0,
			"Bartender"= 2,
			"Ninja"= 0,

			//INT
			"Detective"= 0,
			"Curator"= 0.5,
			"Medical Doctor"= 0,

		"Assistant"= 0
	)

/experience/skill/enchanting/ //Int
	name = "Enchanting"
	id = SKILL_ENCHANTING
	desc = "Your skill in enchanting objects. Affects the speed, sucess rate, and quality of enchanted items."
	experience_power = 1.8
	experience_multiplier = 4.1
	counts_towards_level = FALSE
	combat_level_mul = 0
	associated_classes = list(
		//STR
			//PURE
			"Security Officer" = 0,
			"Cargo Technician"= 0,

			//INT
			"Engineer"= 0,
			"Botanist"= 0,
			"Quartermaster"=0,
			//AGI
			"Cook"= 0,
			"Janitor"= 0,
			"Shaft Miner"= 0,

		//INT
			//PURE
			"Scientist"= 1,
			"Lawyer"= 0,

			//STR
			"Chaplain"= 2,
			"Roboticist"= 0,
			"Geneticist"= 0,

			//AGI
			"Atmospheric Technician"= 0,
			"Chemist"= 0,
			"Virologist"= 0,

		//AGI
			//PURE
			"Mime"= 0,
			"Clown"= 0,

			//STR
			"Warden"= 0,
			"Bartender"= 0,
			"Ninja"= 0,

			//INT
			"Detective"= 0,
			"Curator"= 4,
			"Medical Doctor"= 0,

		"Assistant"= 0
	)

/experience/skill/cooking/ //Str
	name = "Cooking"
	id = SKILL_COOKING
	desc = "Your skill in cooking food. Affects the speed, success rate, and quality of cooking new items."
	experience_power = 1.8
	experience_multiplier = 4.1
	counts_towards_level = FALSE
	combat_level_mul = 0
	associated_classes = list(
		//STR
			//PURE
			"Security Officer" = 0,
			"Cargo Technician"= 0,

			//INT
			"Engineer"= 0,
			"Botanist"= 2,
			"Quartermaster"=0,
			//AGI
			"Cook"= 4,
			"Janitor"= 0,
			"Shaft Miner"= 0,

		//INT
			//PURE
			"Scientist"= 0,
			"Lawyer"= 0,

			//STR
			"Chaplain"= 0,
			"Roboticist"= 0,
			"Geneticist"= 0,

			//AGI
			"Atmospheric Technician"= 0,
			"Chemist"= 0,
			"Virologist"= 0,

		//AGI
			//PURE
			"Mime"= 1,
			"Clown"= 1,

			//STR
			"Warden"= 0,
			"Bartender"= 1,
			"Ninja"= 0,

			//INT
			"Detective"= 0,
			"Curator"= 0.5,
			"Medical Doctor"= 0,

		"Assistant"= 0
	)

/experience/skill/crafting //Str
	name = "Crafting"
	id = SKILL_CRAFTING
	desc = "Your skill in crafting items. Affects the speed and success rate of crafting items."
	experience_power = 1.8
	experience_multiplier = 4.1
	counts_towards_level = FALSE
	combat_level_mul = 0
	associated_classes = list(
		//STR
			//PURE
			"Security Officer" = 0,
			"Cargo Technician"= 2,

			//INT
			"Engineer"= 4,
			"Botanist"= 0,
			"Quartermaster"=1,
			//AGI
			"Cook"= 0,
			"Janitor"= 2,
			"Shaft Miner"= 2,

		//INT
			//PURE
			"Scientist"= 2,
			"Lawyer"= 0,

			//STR
			"Chaplain"= 0,
			"Roboticist"= 2,
			"Geneticist"= 0,

			//AGI
			"Atmospheric Technician"= 2,
			"Chemist"= 1,
			"Virologist"= 0,

		//AGI
			//PURE
			"Mime"= 0,
			"Clown"= 0,

			//STR
			"Warden"= 0,
			"Bartender"= 0,
			"Ninja"= 0,

			//INT
			"Detective"= 0,
			"Curator"= 0.5,
			"Medical Doctor"= 0,

		"Assistant"= 0
	)