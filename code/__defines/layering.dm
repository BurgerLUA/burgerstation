#define LAYER_FLOOR                 1
#define LAYER_FLOOR_ROCK			(LAYER_FLOOR + 0.11)
#define LAYER_FLOOR_GRAVEL			(LAYER_FLOOR + 0.12)
#define LAYER_FLOOR_DIRT			(LAYER_FLOOR + 0.13)
#define LAYER_FLOOR_SAND			(LAYER_FLOOR + 0.14)
#define LAYER_FLOOR_GRASS			(LAYER_FLOOR + 0.15)
#define LAYER_FLOOR_GRASS_DENSE		(LAYER_FLOOR + 0.16)

#define LAYER_FLOOR_PLATING         (LAYER_FLOOR + 0.2)
#define LAYER_FLOOR_PIPE			(LAYER_FLOOR + 0.3)
#define LAYER_FLOOR_TILE            (LAYER_FLOOR + 0.4)
#define LAYER_FLOOR_DECAL			(LAYER_FLOOR + 0.5)
#define LAYER_FLOOR_WEATHER			(LAYER_FLOOR + 0.6)
#define LAYER_FLOOR_CONVEYOR		(LAYER_FLOOR + 0.7)
#define LAYER_FLOOR_SCENERY			(LAYER_FLOOR + 0.8)
#define LAYER_FLOOR_EFFECTS			(LAYER_FLOOR + 0.9)

#define LAYER_WALL 3
#define LAYER_WALL_DECAL (LAYER_WALL + 0.1)

#define LAYER_TABLE 4


#define LAYER_OBJ_DOOR_OPEN    (LAYER_OBJ - 0.2)
#define LAYER_OBJ_CRATE        (LAYER_OBJ - 0.1)
#define LAYER_OBJ              5
#define LAYER_OBJ_GRILLE 	   (LAYER_OBJ + 0.1)
#define LAYER_OBJ_WINDOW 	   (LAYER_OBJ + 0.2)
#define LAYER_OBJ_DOOR_CLOSED  (LAYER_OBJ + 0.3)
#define LAYER_OBJ_ITEM         (LAYER_OBJ + 0.4)

#define LAYER_BLOOD            (LAYER_MOB_SWIMMING - 0.1)

#define LAYER_MOB_SWIMMING     6

#define LAYER_MOB_DEAD         7

#define LAYER_OBJ_AIRLOCK      8

#define LAYER_MOB_BELOW        (LAYER_MOB - 0.1)
#define LAYER_MOB              9

#define LAYER_MOB_FIRE         10

#define LAYER_MOB_ABOVE        11

#define LAYER_MOB_WATER        12

#define LAYER_MOB_FLYING       13

#define LAYER_PROJECTILE       14

#define LAYER_EFFECT           15

#define LAYER_LARGE_OBJ        16

#define LAYER_GHOST            17

#define LAYER_AREA 20 //Weather

#define LAYER_LIGHTING 50
#define LAYER_LIGHTING_DYNAMIC 51

#define LAYER_SCREEN_BLOOD 99

#define LAYER_HUD 100
#define LAYER_HUD_ITEMS 101



//Clothing
#define LAYER_MOB_NONE                 (FLOAT_LAYER + 0.01)
#define LAYER_MOB_WINGS_BEHIND         (FLOAT_LAYER + 0.02)
#define LAYER_MOB_TAIL_BEHIND          (FLOAT_LAYER + 0.03)
#define LAYER_MOB_WINGS_ADJACENT       (FLOAT_LAYER + 0.04)
#define LAYER_MOB_TORSO                (FLOAT_LAYER + 0.05)

#define LAYER_MOB_CLOTHING_UNDERSHIRT  (FLOAT_LAYER + 0.11)
#define LAYER_MOB_ANTENNAE_BEHIND      (FLOAT_LAYER + 0.12)
#define LAYER_MOB_HEAD                 (FLOAT_LAYER + 0.13)
#define LAYER_MOB_EAR                  (FLOAT_LAYER + 0.14)
#define LAYER_MOB_EYE                  (FLOAT_LAYER + 0.15)
#define LAYER_MOB_CLOTHING_EAR         (FLOAT_LAYER + 0.16)

#define LAYER_MOB_CLOTHING_HEADWRAP    (FLOAT_LAYER + 0.21)
#define LAYER_MOB_CLOTHING_EYE         (FLOAT_LAYER + 0.22)
#define LAYER_MOB_GROIN                (FLOAT_LAYER + 0.23)
#define LAYER_MOB_ARMS                 (FLOAT_LAYER + 0.24)

#define LAYER_MOB_LEGS                 (FLOAT_LAYER + 0.31)
#define LAYER_MOB_FEET                 (FLOAT_LAYER + 0.32)
#define LAYER_MOB_CLOTHING_UNDERWEAR   (FLOAT_LAYER + 0.32)
#define LAYER_MOB_CLOTHING_SOCKS       (FLOAT_LAYER + 0.34)
#define LAYER_MOB_CLOTHING_SHOES       (FLOAT_LAYER + 0.35)

#define LAYER_MOB_CLOTHING_PANTS       (FLOAT_LAYER + 0.41)
#define LAYER_MOB_CLOTHING_UNIFORM     (FLOAT_LAYER + 0.42)
#define LAYER_MOB_CLOTHING_NECK_UNDER  (FLOAT_LAYER + 0.43)
#define LAYER_MOB_CLOTHING_BELT        (FLOAT_LAYER + 0.44)
#define LAYER_MOB_CLOTHING_ARMOR       (FLOAT_LAYER + 0.45)

#define LAYER_MOB_INJURY               (FLOAT_LAYER + 0.51)
#define LAYER_MOB_HANDS                (FLOAT_LAYER + 0.52)
#define LAYER_MOB_CLOTHING_RING        (FLOAT_LAYER + 0.53)
#define LAYER_MOB_CLOTHING_GLOVES      (FLOAT_LAYER + 0.54)
#define LAYER_MOB_INJURY_HANDS         (FLOAT_LAYER + 0.55)

#define LAYER_MOB_CLOTHING_HARDSUIT    (FLOAT_LAYER + 0.61)
#define LAYER_MOB_CLOTHING_COAT        (FLOAT_LAYER + 0.62)
#define LAYER_MOB_CLOTHING_COAT_OVER   (FLOAT_LAYER + 0.63)
#define LAYER_MOB_CLOTHING_NECK_OVER   (FLOAT_LAYER + 0.64)
#define LAYER_MOB_TAIL_FRONT           (FLOAT_LAYER + 0.65)
#define LAYER_MOB_WINGS_FRONT          (FLOAT_LAYER + 0.66)
#define LAYER_MOB_CLOTHING_BACK        (FLOAT_LAYER + 0.67)

#define LAYER_MOB_ANTENNAE_FRONT       (FLOAT_LAYER + 0.71)
#define LAYER_MOB_HAIR_FACE            (FLOAT_LAYER + 0.72)
#define LAYER_MOB_HAIR_HEAD            (FLOAT_LAYER + 0.73)
#define LAYER_MOB_HAIR_ABOVE           (FLOAT_LAYER + 0.74)
#define LAYER_MOB_CLOTHING_MASK        (FLOAT_LAYER + 0.75)
#define LAYER_MOB_CLOTHING_HELMET      (FLOAT_LAYER + 0.76)
#define LAYER_MOB_CLOTHING_ALL         (FLOAT_LAYER + 0.77)
#define LAYER_MOB_BLOB                 (FLOAT_LAYER + 0.78)

#define LAYER_MOB_HELD                 (FLOAT_LAYER + 0.81)

