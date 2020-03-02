#define ATTACK_THROW 0x1
#define ATTACK_DROP 0x2
#define ATTACK_KICK 0x4
#define ATTACK_HELD_LEFT 0x8
#define ATTACK_HELD_RIGHT 0x10
#define ATTACK_GRAB 0x20
#define ATTACK_SELF 0x40
#define ATTACK_OWNER 0x80

#define DODGE_MISS 0x1
#define DODGE_BLOCK 0x2
#define DODGE_PARRY 0x4
#define DODGE_DODGE 0x8 //I really need to rename this

#define ATTACK_TYPE_MELEE "melee"
#define ATTACK_TYPE_RANGED "ranged"
#define ATTACK_TYPE_MAGIC "ranged"