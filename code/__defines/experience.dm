#define ENABLE_XP TRUE
#define ENABLE_XP_SAVING TRUE
#define LEVEL_CAP 100 //This is the highest possible OVERALL level someone can get.


#define ATTRIBUTE_STAT 0x1
#define ATTRIBUTE_DAMAGE 0x2
#define ATTRIBUTE_RESISTANCE 0x4
#define ATTRIBUTE_REGEN 0x8
#define ATTRIBUTE_NO_DIFFICULTY_XP_MUL 0x20


#define ATTRIBUTE_DEFAULT 15

//RED
#define ATTRIBUTE_STRENGTH "strength" //Damage
#define ATTRIBUTE_CONSTITUTION "constitution" //Resistance
#define ATTRIBUTE_FORTITUDE "fortitude" //Regen

#define ATTRIBUTE_VITALITY "vitality" //Maximum

//GREEN
#define ATTRIBUTE_DEXTERITY "dexterity" //Damage
#define ATTRIBUTE_RESILIENCE "resilience" // Resistance
#define ATTRIBUTE_AGILITY "agility" // Regen

#define ATTRIBUTE_ENDURANCE "endurance" // Maximum

//BLUE
#define ATTRIBUTE_WILLPOWER "willpower" //Damage
#define ATTRIBUTE_SOUL "soul" //Resistance
#define ATTRIBUTE_INTELLIGENCE "intelligence" //Regen

#define ATTRIBUTE_WISDOM "wisdom" //Maximum

//WHITE
#define ATTRIBUTE_LUCK "luck"


#define SKILL_DEFAULT 1

//STRENGTH
#define SKILL_MELEE "melee" //Completed. ATTRIBUTE_STRENGTH. (Damage)
#define SKILL_PRAYER "prayer" //Completed. ATTRIBUTE_CONSTITUTION. (Resistance)
#define SKILL_BLOCK "block" //Completed. ATTRIBUTE_FORTITUDE. (Regen)
#define SKILL_ARMOR "armor" //Completed. ATTRIBUTE_FORTITUDE. (Regen)

//DEXTERITY
#define SKILL_RANGED "ranged" //Completed. ATTRIBUTE_DEXTERITY. (Damage)
#define SKILL_EVASION "evasion" //Completed. ATTRIBUTE_AGILITY. (Resistance)
#define SKILL_UNARMED "unarmed" //Completed. ATTRIBUTE_RESILIENCE. (Regen)
#define SKILL_SURVIVAL "survival" // ATTRIBUTE_RESILIENCE. (Regen)

//INTELLIGENCE
#define SKILL_MAGIC "magic" //Completed. Used and gained. ATTRIBUTE_WILLPOWER. (Damage)
#define SKILL_SUMMONING "summoning" //Completed. Used and gained. ATTRIBUTE_SOUL. (Resistance)
#define SKILL_MEDICINE "medicine" //Completed. Used and gained. ATTRIBUTE_INTELLIGENCE. (Regen)
#define SKILL_PRECISION "precision" //Completed. Used and gained. ATTRIBUTE_INTELLIGENCE. (Regen)



