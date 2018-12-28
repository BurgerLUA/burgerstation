#!/usr/bin/env python
from __future__ import print_function, division
import re
import argparse
import os
import os.path

upscale_re = re.compile("pixel_(x|y|z|w) = (-?\d+)")
args = None

def main():
    global args
    parser = argparse.ArgumentParser(prog="Upscale_map.py", description="Multiplies (or divides) all pixel offsets in a BYOND DMM map file by a specified factor.", version="0.1")
    parser.add_argument("mapfile", help="The DMM mapfile to scale.", nargs="*", type=argparse.FileType('r+'))
    parser.add_argument("-r", "--recurse", help="In conjunction with taking in map files, makes the script also recurse through the provided directory to find DMM files.")
    parser.add_argument("--factor", nargs="?", default=2, help="The factor with which to multiply the pixel_x or pixel_y values in the map file.", type=int)
    parser.add_argument("-d", "--divide", action="store_true", help="Divide the pixel offsets instead of multiplying them.")
    args = parser.parse_args()
    # print(args)

    for dirpath, dirnames, filenames in os.walk(args.recurse):
        for filename in filenames:
            if (filename[-3:] != "dmm"):
                continue

            fullpath = os.path.join(dirpath, filename)
            args.mapfile.append(open(fullpath, "r+"))

    if len(args.mapfile) < 1:
        print("Unable to find any mapfiles to upscale.")
        exi()

    for mapfile in args.mapfile:
        upscaled, count = upscale_re.subn(replace, mapfile.read())
        mapfile.seek(0)
        mapfile.truncate()
        mapfile.write(upscaled)
        print("Updated %s pixel offsets." % (count))
        mapfile.close()


def replace(match):
    #print(match.group(1), match.group(2))
    offset_type = match.group(1)
    amount = 0
    try:
        if args.divide:
            amount = int(match.group(2)) // args.factor
        else:
            amount = int(match.group(2)) * args.factor
    except:
        print("Error attempting to read pixel_%s offset '%s': can not convert to integer." % (offset_type, match.group(2)))
        return "pixel_%s = %s" % (offset_type, match.group(2))
    
    # print(offset_type, amount)
    return "pixel_%s = %s" % (offset_type, amount)

if __name__ == "__main__":
    main()
    