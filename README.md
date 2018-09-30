# MC3ETQ
MS-DOS Label Library Manager and Editor developed with Clipper Summer'87 and Turbo "C" v2.0

![MC3ETQ - Main Screen](https://github.com/lvcabral/MC3ETQ/blob/master/mc3etq.png?raw=true)

## Project History
This tool was developed in 1991/1992, as a side project, when I was a programmer for the Brazilian Army. At the time in Brazil to print labels on dot matrix printers to put on school books and notebooks was a "thing", so I decided to create a tool that would convert icons from famous DOS programs like the ["Print Master"](https://winworldpc.com/product/print-master/20) and also allow edit new icons to use on labels. As most of my "hobby" projects, this was meant to be a learning exercise, where I could learn DOS 2D graphics, how to use a mouse among other things.

The package has several tools (see details below) and it relies on two main file types, the .fig that contains icons library and .etq that stores a label configuration.

The name of the tool is based on my fathers company at the time (MC3 Informática) concatenated with the abbreviation of the portuguese word for label (etiqueta).

![MC3ETQ - Main Screen](https://github.com/lvcabral/MC3ETQ/blob/master/Images/MC3ETQ-Main%20Screen.png?raw=true)

## The Tools

- **MC3ETQ.EXE** - Main application where you can load an icon library and create your labels (image above), you can also print a [report with the library of icons](https://github.com/lvcabral/MC3ETQ/blob/master/Images/MC3ETQ-Printed%20Icon%20List.png);
- **MC3EDT.EXE** - Icon editor where you could edit existing icons or create your own. See screenshots of the [main screen](https://github.com/lvcabral/MC3ETQ/blob/master/Images/MC3EDT-Main%20Screen.png) and [editor screen](https://github.com/lvcabral/MC3ETQ/blob/master/Images/MC3EDT-Editor%20Screen.png)
- **MC3SEL.EXE** - Tool to visually select icons from a library and save to a new file;
- **FIGSEP.EXE** - Command line tool to split a .fig file into two separate files;
- **FIG2SHP.EXE** and **SHP2FIG.EXE** - Tools to convert to and from ["Print Master"](https://winworldpc.com/product/print-master/20) libraries to the .fig format, the repository has a **SHP** folder with some sample files;


## The Source Code
This repository has the tools source code under the **PRG** folder, these are CLipper Summer'87 programs, and under the **LIB** folder you will found the functions library source code in Assembly, C and Clipper with generic functions I used on my projects, not all library fuctions was developed by me, some were copied from books or BBS. This PROGRAPH.LIB library is a newer version than the one used on the binaries of this repository, unfortunately I lost the code when the library was called MC3.LIB. The folder **DOC** contains a basic docummentation of the library functions (in portuguese).

To edit the source code, I recommend use NotePad++ selecting the Encoding **OEM 860 - Portuguese**.

## The Author
- My website is [https://lvcabral.com](https://lvcabral.com)
- My twitter is [@lvcabral](https://twitter.com/twitter)
- My podcast is [PODebug Podcast](http://podebug.com)
- Check my other [GitHub repositories ](https://github.com/lvcabral)

## License

Copyright (C) Marcelo Lv Cabral. All rights reserved.

Licensed under [MIT](https://github.com/lvcabral/MC3ETQ/blob/master/LICENSE) License.





