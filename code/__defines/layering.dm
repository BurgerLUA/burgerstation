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
#define LAYER_MOB              10




#define LAYER_MOB_FIRE         20

#define LAYER_MOB_ABOVE        21

#define LAYER_MOB_WATER        22

#define LAYER_MOB_FLYING       23

#define LAYER_PROJECTILE       24

#define LAYER_EFFECT           25

#define LAYER_LARGE_OBJ        26

#define LAYER_GHOST            27

#define LAYER_AREA             30 //Weather

#define LAYER_LIGHTING 50
#define LAYER_LIGHTING_DYNAMIC 51

#define LAYER_SCREEN_BLOOD 99

#define LAYER_HUD 100
#define LAYER_HUD_ITEMS 101



//Clothing
#define LAYER_MOB_NONE                 (LAYER_MOB + 0.1)
#define LAYER_MOB_WINGS_BEHIND         (LAYER_MOB + 0.2)
#define LAYER_MOB_TAIL_BEHIND          (LAYER_MOB + 0.3)
#define LAYER_MOB_WINGS_ADJACENT       (LAYER_MOB + 0.4)
#define LAYER_MOB_TORSO                (LAYER_MOB + 0.5)

#define LAYER_MOB_CLOTHING_UNDERSHIRT  (LAYER_MOB + 1.0)
#define LAYER_MOB_ANTENNAE_BEHIND      (LAYER_MOB + 1.1)
#define LAYER_MOB_HEAD                 (LAYER_MOB + 1.2)
#define LAYER_MOB_EAR                  (LAYER_MOB + 1.3)
#define LAYER_MOB_EYE                  (LAYER_MOB + 1.4)
#define LAYER_MOB_CLOTHING_EAR         (LAYER_MOB + 1.5)

#define LAYER_MOB_CLOTHING_HEADWRAP    (LAYER_MOB + 2.0)
#define LAYER_MOB_CLOTHING_EYE         (LAYER_MOB + 2.1)
#define LAYER_MOB_GROIN                (LAYER_MOB + 2.2)
#define LAYER_MOB_ARMS                 (LAYER_MOB + 2.3)

#define LAYER_MOB_LEGS                 (LAYER_MOB + 3.0)
#define LAYER_MOB_FEET                 (LAYER_MOB + 3.1)
#define LAYER_MOB_CLOTHING_UNDERWEAR   (LAYER_MOB + 3.2)
#define LAYER_MOB_CLOTHING_SOCKS       (LAYER_MOB + 3.3)
#define LAYER_MOB_CLOTHING_SHOES       (LAYER_MOB + 3.4)

#define LAYER_MOB_CLOTHING_PANTS       (LAYER_MOB + 4.0)
#define LAYER_MOB_CLOTHING_UNIFORM     (LAYER_MOB + 4.1)
#define LAYER_MOB_CLOTHING_NECK_UNDER  (LAYER_MOB + 4.2)
#define LAYER_MOB_CLOTHING_BELT        (LAYER_MOB + 4.3)
#define LAYER_MOB_CLOTHING_ARMOR       (LAYER_MOB + 4.4)

#define LAYER_MOB_INJURY               (LAYER_MOB + 5.0)
#define LAYER_MOB_HANDS                (LAYER_MOB + 5.1)
#define LAYER_MOB_CLOTHING_RING        (LAYER_MOB + 5.2)
#define LAYER_MOB_CLOTHING_GLOVES      (LAYER_MOB + 5.3)
#define LAYER_MOB_INJURY_HANDS         (LAYER_MOB + 5.4)

#define LAYER_MOB_CLOTHING_HARDSUIT    (LAYER_MOB + 6.0)
#define LAYER_MOB_CLOTHING_COAT        (LAYER_MOB + 6.1)
#define LAYER_MOB_CLOTHING_COAT_OVER   (LAYER_MOB + 6.2)
#define LAYER_MOB_CLOTHING_NECK_OVER   (LAYER_MOB + 6.3)
#define LAYER_MOB_TAIL_FRONT           (LAYER_MOB + 6.4)
#define LAYER_MOB_WINGS_FRONT          (LAYER_MOB + 6.5)
#define LAYER_MOB_CLOTHING_BACK        (LAYER_MOB + 6.6)

#define LAYER_MOB_ANTENNAE_FRONT       (LAYER_MOB + 7.1)
#define LAYER_MOB_HAIR_FACE            (LAYER_MOB + 7.2)
#define LAYER_MOB_HAIR_HEAD            (LAYER_MOB + 7.3)
#define LAYER_MOB_HAIR_ABOVE           (LAYER_MOB + 7.4)
#define LAYER_MOB_CLOTHING_MASK        (LAYER_MOB + 7.5)
#define LAYER_MOB_CLOTHING_HELMET      (LAYER_MOB + 7.6)
#define LAYER_MOB_CLOTHING_ALL         (LAYER_MOB + 7.7)
#define LAYER_MOB_BLOB                 (LAYER_MOB + 7.8)

#define LAYER_MOB_HELD                 (LAYER_MOB + 7.9)

