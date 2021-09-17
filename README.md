# Deprecated

Planter 3rd generation has been replaced with Drive Badger project:

- [product page](https://drivebadger.com/)
- [main repository](https://github.com/drivebadger/drivebadger)
- [wiki](https://github.com/drivebadger/drivebadger/wiki)

# Overview

This is a core repository for 3rd generation of Planter product, also known as Harry.
You can visit its homepage for more details: https://payload.pl/harry/

This software, as well as the hardware part, is meant to be used only by police officers, special agents,
or other eligible entities. Its usage is always a subject to local legislation, and its user is solely
responsible for all potential law infringements and/or misfeasances of duties. Intention of this product,
is not an incitement for a crime. Rather, Planter is mainly intended to be used in countries, where using
such tools is legal, or at most, can be a subject to possible disciplinary action between the end user
and his/her employer.

# How does it work

Planter recognizes 4 types of connected USB storage devices:

- target drive (copy destination, drive owned by law enforcement officer)
- victim drive (copy source)
- ignored drive
- payload drive (attachable drives with additional software, not being part of this repository)

The idea is very simple:

1. If any payload drive is already connected, then connecting victim drive will cause running the payload
against newly connected drive (it will be mounted, and the mountpoint will be passed to the payload as
argument - so payload will be able to drop any content into it, eg. "cheese pizza" photos).

2. If no payload drive is connected, then connecting victim drive will simply trigger copying its contents
to a subdirectory on target drive.

Details regarding how individual drives are recognized, paths etc., can be found here:
https://github.com/pisecurity/planter-drives

# Setup

1. Assemble your Raspberry Pi hardware. Prepare SD card with minimal version of Raspbian. Remember to put
empty "ssh" file in the first partition before first boot, to trigger installing ssh server.

2. Log in to working Raspbian and close this repository as `/opt/planter`.

3. Run `install.sh` script as root. Depending on your hardware type, you may need to install display driver
separately from this script.

# License

|                      |                                          |
|:---------------------|:-----------------------------------------|
| **Author:**          | Tomasz Klim (<opensource@tomaszklim.pl>) |
| **Copyright:**       | Copyright 2017-2020 Tomasz Klim          |
| **License:**         | MIT                                      |

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
