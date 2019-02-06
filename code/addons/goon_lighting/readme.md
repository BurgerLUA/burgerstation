# What is this?

This is the main lighting module, this is **not** plug and play, it requires the files in `/stubs` and `/helpers`.

# How does it work?
**Note:** This is a more technical and behind-the-scenes documentation of it, documentation for usage will be in the `/docs` folder.

First, every turf that has dynamic lighting enabled gets a single lighting overlay, the sprite of this overlay looks like this:

![](icon.png?raw=true "You would see a lighting overlay here.")

While it may be hard to see, ever corner of the 32x32 sprite has its own channel filled:

* Top right: Alpha
* Top left: Blue
* Bottom left: Red (basically unnoticable, as there is no alpha)
* Bottom right: Green

Because each corner has a different channel, each corner can have individual colours (and have them blend between the other corners) with a smart colour matrix.

The base of said colour matrix is this:

 | r | g | b | a | corner
--- | ---- | ---- | ---- | ---- | ----
r | 0 | 0 | 0 | 0 | bottom left
g | 0 | 0 | 0 | 0 | bottom right
b | 0 | 0 | 0 | 0 | top left
a | 0 | 0 | 0 | 0 | top right
c | 0 | 0 | 0 | 1 | N/A

This will result in the overlay appearing as a full black square, and as such completely obstructs the tile.

If one wants to manipulate a certain corner, one can increase the values for that color. For example, if one wants to make the **bottom left corner** of the overlay to become fully lit, the matrix turns into this:

 |r|g|b|a|corner
---|---|---|---|---|---
**r**|**1**|**1**|**1**|**0**|**bottom left**
g|0|0|0|0|bottom right
b|0|0|0|0|top left
a|0|0|0|0|top right
c|0|0|0|1| N/A
