//Inventory sizes.
#define SIZE_0 0.5
#define SIZE_1 1
#define SIZE_2 2
#define SIZE_3 3
#define SIZE_4 4
#define SIZE_5 6
#define SIZE_6 10
#define SIZE_7 15
#define SIZE_8 25
#define SIZE_9 50
#define SIZE_10 75
#define SIZE_X 1000

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


#define SLOT_NONE         (1<<0) //No slot given.

#define SLOT_TORSO        (1<<1)  //Shirts/Uniforms
#define SLOT_TORSO_O      (1<<2)  //Coats
#define SLOT_TORSO_A      (1<<3)  //Armor
#define SLOT_TORSO_U      (1<<4)  //Torso covering underwear (undershirts)
#define SLOT_TORSO_B      (1<<5) //Backpack/Satchel
#define SLOT_TORSO_OB     (1<<6) //Overwear belt

#define SLOT_HEAD         (1<<7) //Helmets/Hats
#define SLOT_FACE         (1<<8)  //Masks
#define SLOT_EAR          (1<<9) //Headsets
#define SLOT_EYES         (1<<10) //Glasses

#define SLOT_NECK         (1<<11) //Cloaks
#define SLOT_NECK_O       (1<<12) //Necklace, Tie

#define SLOT_GROIN        (1<<13)  //Pants
#define SLOT_GROIN_O      (1<<14) //Belts, mainly
#define SLOT_GROIN_U      (1<<15) //Groin covering underwear

#define SLOT_FOOT_RIGHT   (1<<16)  //Shoes
#define SLOT_FOOT_RIGHT_U (1<<17)  //Socks
#define SLOT_FOOT_RIGHT_O (1<<18) //Magboots

#define SLOT_FOOT_LEFT    (1<<19) //Shoes
#define SLOT_FOOT_LEFT_U  (1<<20) //Socks
#define SLOT_FOOT_LEFT_O  (1<<21) //Magboots

#define SLOT_HAND_LEFT    (1<<22)  //Gloves/Gauntlets
#define SLOT_HAND_LEFT_O  (1<<23)  //Rings
#define SLOT_HAND_RIGHT   (1<<24)  //Gloves/Gauntlets
#define SLOT_HAND_RIGHT_O (1<<25)  //Rings


#define SLOT_SPECIAL      (1<<26) //Special items
#define SLOT_FACE_WRAP    (1<<27) //Face wraps, like balaclava

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
