//Inventory sizes.
#define SIZE_0 0.5
#define SIZE_1 1
#define SIZE_2 2
#define SIZE_3 3
#define SIZE_4 4
#define SIZE_5 5
#define SIZE_6 6
#define SIZE_7 7
#define SIZE_8 8
#define SIZE_9 10
#define SIZE_X 100

//Inventory weights
#define WEIGHT_0 0.5
#define WEIGHT_1 1
#define WEIGHT_2 3
#define WEIGHT_3 5
#define WEIGHT_4 10
#define WEIGHT_5 20
#define WEIGHT_6 50
#define WEIGHT_7 75
#define WEIGHT_8 100
#define WEIGHT_X 1000

//Clothing flags
#define FLAG_CLOTHING_NONE 0x0
#define FLAG_CLOTHING_NOBEAST_FEET 0x1
#define FLAG_CLOTHING_NOBEAST_HEAD 0x2

#define RARITY_BROKEN "broken"
#define RARITY_COMMON "common"
#define RARITY_UNCOMMON "uncommon"
#define RARITY_RARE "rare"
#define RARITY_MYTHICAL "mythical"
#define RARITY_LEGENDARY "legendary"


#define SLOT_NONE         0x0 //No slot given.

#define SLOT_TORSO        0x1  //Shirts/Uniforms
#define SLOT_TORSO_O      0x2  //Coats
#define SLOT_TORSO_A      0x4  //Armor
#define SLOT_TORSO_U      0x8  //Torso covering underwear (undershirts)
#define SLOT_TORSO_B      0x10 //Backpack/Satchel
#define SLOT_TORSO_OB     0x20 //Overwear belt

#define SLOT_HEAD         0x40  //Helmets/Hats
#define SLOT_FACE         0x80  //Masks
#define SLOT_EAR          0x100 //Headsets
#define SLOT_EYES         0x200 //Glasses
#define SLOT_NECK         0x400 //Neck

#define SLOT_GROIN        0x800  //Pants
#define SLOT_GROIN_O      0x1000 //Belts, mainly
#define SLOT_GROIN_U      0x2000 //Groin covering underwear

#define SLOT_FOOT_RIGHT   0x4000  //Shoes
#define SLOT_FOOT_RIGHT_U 0x8000  //Socks
#define SLOT_FOOT_RIGHT_O 0x10000 //Magboots

#define SLOT_FOOT_LEFT    0x20000 //Shoes
#define SLOT_FOOT_LEFT_U  0x40000 //Socks
#define SLOT_FOOT_LEFT_O  0x80000 //Magboots

#define SLOT_HAND_LEFT    0x100000  //Gloves/Gauntlets
#define SLOT_HAND_RIGHT   0x200000  //Gloves/Gauntlets


#define SLOT_SPECIAL      0x400000 //Special items
#define SLOT_FACE_WRAP    0x800000 //Face wraps, like balaclava


//Tools
#define FLAG_TOOL_NONE 0x0
#define FLAG_TOOL_SCREWDRIVER 0x1
#define FLAG_TOOL_WRENCH 0x2
#define FLAG_TOOL_CROWBAR 0x4
#define FLAG_TOOL_WELDER 0x8
#define FLAG_TOOL_WIRECUTTER 0x10
#define FLAG_TOOL_MULTITOOL 0x20

#define FLAG_TOOL_PICKAXE 0x40
#define FLAG_TOOL_SHOVEL 0x80