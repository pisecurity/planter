## Legal disclaimer

This repository contains the source code of Planter platform v2020 edition.

This software, as well as the hardware part, is meant to be used only by police officers, special agents,
or other eligible entities. Its usage is always a subject to local legislation, and its user is solely
responsible for all potential law infringements and/or misfeasances of duties. Intention of this product,
is not an incitement for a crime. Rather, Planter is mainly intended to be used in countries, where using
such tools is legal, or at most, can be a subject to possible disciplinary action between the end user
and his/her employer.

## How does it work

Planter recognizes connected USB devices, tries to auto-mount them and start:

- copying data from them to "target" drives (belonging to end user)
- executing special crafted code against them (eg. to plant evidence)

There are 4 types of devices:

- evidence storage (copy destination, later called "target")
- seized/captured drive (copy source)
- ignored drive
- plant source storage (attachable drives with additional software/payload, not being part of Planter distribution; called "source")

Evidence storage drive has to have created one of 3 directory schemes:

- `.support/.files`
- `.files/.data`
- `files/data`

Otherwise, or if evidence storage is not connected, all data from seized drives are copied to
`/media/fallback` fallback directory on local MicroSD card.

## Installing

Run `install.sh` script as root.

## Dependencies

Planter requires Pimoroni Blinkt! device, and any Blinkt!-compatible version of Raspberry Pi. It is
tested to work on Raspbian Jessie or Stretch.

## License

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
