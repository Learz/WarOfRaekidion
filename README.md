War of Raekidion
================

Welcome to the repository of War of Raekidion. This game is made in Eiffel, 
with the help of SDL 2. 

War of Raekidion is a bullet hell type online multiplayer top-down shooter game 
inspired from Touhou. It involves basic gameplay like dodging enemies' projectiles 
and progressing through the level. However, it also includes interesting new 
features like a simple to use modding format, which allows to add enemy ships 
and projectile types through XML files. Also, the main feature of this game 
consists of a online multiplayer mode making one player control the ship and 
progressing normally through the level, while the other sends enemies and attacks 
to his opponent.

Installing the game
----------------------

To install the game, you only have to download the appropriate binary file from 
the download page on the website or from the download branch on the repository page. 
All content and libraries are included within the installer. To launch the game on 
Windows, simply click on the shortcut on your desktop, or in the Start menu. For 
Linux, run the "raekidion" executable file from a terminal or, if you have the 
Debian menu or equivalent, you will find it under the Games category. A desktop 
file should also be created, along with an entry for the Unity menu.

Compiling the source
---------------------

You must first download the source from the repo at:

- [**War of Raekidion repository**][1]

If you want to open the code and work with it, we recommend the official Eiffel 
IDE at the following address: 

- [**Eiffel Studio website**][2]

First, create an account on the Eiffel Studio's website. Then, download the adequate 
version of Eiffel Studio and install it to your machine.

You will also have to download and install the required **development libraries**: 

- [**SDL 2.0.1**][3]
- [**SDL Image 2.0.0**][4]
- [**SDL Mixer 2.0.0**][5]
- [**SDL TTF 2.0.12**][6]

### Installing on Windows

For Windows, you will have to put your extracted SDL 2.0.1 and SDL Image 2.0.0 
folders inside the project's directory, like this:

    |+ War of Raekidion
		|- .git
		|+ libraries
			|+ SDL2-2.0.1
			|+ SDL2_image-2.0.0
			|+ SDL2_mixer-2.0.0
			|+ SDL2_ttf-2.0.12
		|- resources
		|- source
		|
		|- .gitignore
		|- raekidion.ecf
		|- raekidion.rc
		|- README.md
		
Then, you will need to go into inside of these folders and copy all the dll files from 
the bin folders into the War of Raekidion folder. It goes like this: 

	War of Raekidion\libraries\SDL2-2.0.1\<YOUR ARCHITECTURE>\bin\SDL2.dll
	War of Raekidion\libraries\SDL2_image-2.0.0\<YOUR ARCHITECTURE>\bin\libpng16_16.dll
	War of Raekidion\libraries\SDL2_image-2.0.0\<YOUR ARCHITECTURE>\bin\zlib1.dll
	War of Raekidion\libraries\SDL2_image-2.0.0\<YOUR ARCHITECTURE>\bin\SDL2_image.dll
	War of Raekidion\libraries\SDL2_mixer-2.0.0\<YOUR ARCHITECTURE>\bin\libogg-0.dll
	War of Raekidion\libraries\SDL2_mixer-2.0.0\<YOUR ARCHITECTURE>\bin\libvorbis-0.dll
	War of Raekidion\libraries\SDL2_mixer-2.0.0\<YOUR ARCHITECTURE>\bin\libvorbisfile-3.dll
	War of Raekidion\libraries\SDL2_mixer-2.0.0\<YOUR ARCHITECTURE>\bin\SDL2_mixer.dll
	War of Raekidion\libraries\SDL2_ttf-2.0.12\<YOUR ARCHITECTURE>\bin\libfreetype-6.dll
	War of Raekidion\libraries\SDL2_ttf-2.0.12\<YOUR ARCHITECTURE>\bin\SDL2_ttf.dll
	
All these files go into
	
	War of Raekidion\libogg-0.dll
	War of Raekidion\libfreetype-6.dll
	War of Raekidion\libpng16_16.dll
	War of Raekidion\libvorbis-0.dll
	War of Raekidion\libvorbisfile-3.dll
	War of Raekidion\SDL2.dll 
	War of Raekidion\SDL2_image.dll
	War of Raekidion\SDL2_mixer.dll
	War of Raekidion\SDL2_ttf.dll
	War of Raekidion\zlib1.dll
	
Finally, you will need a patch to make SQLite3 work on Windows with mingw. The patch can 
be downloaded here:

- [**SQLite3 Windows Fix**][7]

The folder must be extracted into your Eiffel Studio installation folder, normally:

	C:\Program Files\Eiffel Software\EiffelStudio 13.11 GPL\<SQLITE3 FIX FOLDER>

### Installing on Linux (Debian)

For Linux, you will have to install the following packages from the Debian Sid repository 
or the latest Ubuntu version (currently Trusty Tahr) repositories:

	sudo apt-get install libsdl2-dev libsdl2-image-dev libsdl2-mixer-dev libsdl2-ttf-dev

Final words
-----------

We would like to thank our teacher, Louis (GitHub: [**tioui**][8]), for teaching us 
Eiffel and Object Oriented Programming. Also, this project could not have been 
possible without all the team behind SDL and SDL2.

This project is distributed under the GPL-3.0 license. We would only like some 
credits if you use our project somewhere else. 

Enjoy!

[1]:  http://www.bitbucket.org/Learz/raekidion
[2]:  http://www.eiffel.com/
[3]:  http://www.libsdl.org/release/SDL2-devel-2.0.1-mingw.tar.gz
[4]:  http://www.libsdl.org/projects/SDL_image/release/SDL2_image-devel-2.0.0-mingw.tar.gz
[5]:  http://www.libsdl.org/projects/SDL_ttf/release/SDL2_ttf-devel-2.0.12-mingw.tar.gz
[6]:  http://www.libsdl.org/projects/SDL_mixer/release/SDL2_mixer-devel-2.0.0-mingw.tar.gz
[7]:  http://www.raekidion.sml.name/files/sqlite3_winfix.7z
[8]:  http://www.github.com/tioui
