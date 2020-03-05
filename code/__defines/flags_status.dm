#define FLAG_STATUS_NONE 0x0
//All status: Cannot dodge, parry, block, and you have a 100% chance to be hit.

#define FLAG_STATUS_STUN 0x1
//Disarms weapons on stun.
//Move delay multiplied by 3.
//Cannot dodge, parry, block, and you have a 100% chance to be hit.
//Cannot use items.

#define FLAG_STATUS_SLEEP 0x2
//Health, Stamina, Mana regenerates 5 times faster.
//Cannot attack or use items.
//Cannot move.
//Cannot dodge, parry, block, and you have a 100% chance to be hit.
//Taking health damage removes this status effect. (TODO)

#define FLAG_STATUS_PARALYZE 0x4
//Cannot attack or use items.
//Cannot move.
//Cannot dodge, parry, block, and you have a 100% chance to be hit.

#define FLAG_STATUS_FATIGUE 0x8
//Removes initial stamina regeneration delay.
//Stamina regenrates 5 times faster.
//Move delay multiplied by 4.
//Cannot dodge, parry, block, and you have a 100% chance to be hit.


#define FLAG_STATUS_STAGGER 0x10
//Cannot dodge, parry, block, and you have a 100% chance to be hit.
//Cannot move.
//Moves 1 step away from the stagger source.

#define FLAG_STATUS_CONFUSED 0x20
//Random movement.


#define FLAG_STATUS_CRIT 0x40
//Cannot dodge, parry, block, and you have a 100% chance to be hit.
//Move very slow.

#define FLAG_STATUS_ADRENALINE 0x80
//Prevents death by reducing the death threshold relative the the current value.
//Move faster.

#define FLAG_STATUS_REST 0x100
//Move delay multiplied by 4.
//Cannot dodge, parry, block, and you have a 100% chance to be hit.
