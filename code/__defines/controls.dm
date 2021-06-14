#define CONTROL_MOD_THROW 0x1 //R
#define CONTROL_MOD_DROP 0x2 //Q
#define CONTROL_MOD_BLOCK 0x4 //C
#define CONTROL_MOD_LEFT 0x8
#define CONTROL_MOD_RIGHT 0x10
#define CONTROL_MOD_GRAB 0x20 //Ctrl
#define CONTROL_MOD_DISARM 0x40 //Alt
#define CONTROL_MOD_SELF 0x80
#define CONTROL_MOD_OWNER 0x100
#define CONTROL_MOD_KICK 0x200 //Space

#define MOVEMENT_NORMAL 0x0
#define MOVEMENT_CRAWLING 0x1
#define MOVEMENT_CROUCHING 0x2
#define MOVEMENT_WALKING 0x4
#define MOVEMENT_RUNNING 0x8

#define CLICK_LEFT 0x1
#define CLICK_RIGHT 0x2
#define CLICK_MIDDLE 0x4

#define FLAG_INTERACTION_NONE 0x0
#define FLAG_INTERACTION_LIVING 0x1
#define FLAG_INTERACTION_DEAD 0x2
#define FLAG_INTERACTION_NO_HORIZONTAL 0x4 //Disallow horizontal users.
#define FLAG_INTERACTION_NO_DISTANCE 0x8 //Ignore distance checks.
#define FLAG_INTERACTION_NO_TURF_CHECKING 0x10 //Ignore turf checks.
#define FLAG_INTERACTION_CLICK 0x20 //Use Click() instead of MouseDown() for interaction.

#define INTENT_HELP "help"
#define INTENT_DISARM "disarm"
#define INTENT_GRAB "grab"
#define INTENT_HARM "harm"