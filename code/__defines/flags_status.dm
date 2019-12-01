#define FLAG_STATUS_NONE 0x0
//All status: Cannot dodge, parry, block, and you have a 100% chance to be hit.

#define FLAG_STATUS_CRIT 0x1 //Applies to advanced mobs only.
//Removes initial health regeneration delay.
//Health regenerates 5 times faster.
//Move delay multiplied by 2.
//Cannot dodge, parry, block, and you have a 100% chance to be hit. (TODO: REMOVE THIS)

#define FLAG_STATUS_STUN 0x2
//Disarms weapons on stun.
//Move delay multiplied by 3.
//Cannot dodge, parry, block, and you have a 100% chance to be hit.

#define FLAG_STATUS_SLEEP 0x4
//Health, Stamina, Mana regenerates 5 times faster.
//Cannot attack or use items.
//Cannot move.
//Cannot dodge, parry, block, and you have a 100% chance to be hit.
//Taking health damage removes this status effect. (TODO)

#define FLAG_STATUS_PARALYZE 0x8
//Cannot attack or use items.
//Cannot move.
//Cannot dodge, parry, block, and you have a 100% chance to be hit.

#define FLAG_STATUS_FATIGUE 0x10
//Removes initial stamina regeneration delay.
//Stamina regenrates 5 times faster.
//Move delay multiplied by 4.
//Cannot dodge, parry, block, and you have a 100% chance to be hit.






