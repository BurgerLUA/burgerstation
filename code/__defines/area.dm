#define FLAG_AREA_NONE 0x0

#define FLAG_AREA_SAVEZONE 0x1

#define FLAG_AREA_NO_CONSTRUCTION 0x2 //Objects cannot be constructed or deconstructed, either by tools or damage. This usually only applies to structures and not people.
#define FLAG_AREA_NO_DAMAGE 0x4 //All objects can't be damaged. This includes people.

#define FLAG_AREA_SINGLEPLAYER 0x8

#define FLAG_AREA_NO_ROUND_INFORMATION 0x10

#define FLAG_AREA_NO_LOYALTY 0x20 //Disable loyalty implants.
#define FLAG_AREA_NO_IFF 0x40 //Disable IFF.

#define FLAG_AREA_TUTORIAL 0x80

#define FLAG_AREA_NO_EVENTS 0x100

#define FLAG_AREA_NO_TELEPORT 0x200

#define FLAG_AREA_ALLOW_DEATHMATCH 0x400 //Allow deathmatch to occur when it is time.

#define FLAG_AREA_DIRTY 0x800

#define FLAG_AREA_NO_HORDE 0x1000

#define FLAG_AREA_NO_PVP_CHASM 0x4000

#define FLAG_AREA_IMPORTANT 0x8000

#define FLAG_AREA_COMM_SCRAMBLED 0x1
#define FLAG_AREA_COMM_DISABLED 0x2


//Lighting states.
#define ON 0x1
#define OFF 0x2
#define AUTO 0x4
