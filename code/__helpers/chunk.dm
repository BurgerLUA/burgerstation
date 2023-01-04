#define GET_CHUNK_X(T) (CEILING(T.x/CHUNK_SIZE,1))
#define GET_CHUNK_Y(T) (CEILING(T.y/CHUNK_SIZE,1))
#define GET_CHUNK_Z(T) (T.z)

#define CHUNK_XYZ(x,y,z) SSchunk.chunks[z][x][y]


#define CHUNK(T) SSchunk.chunks[GET_CHUNK_Z(T)][GET_CHUNK_X(T)][GET_CHUNK_Z(T)]

