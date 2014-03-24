War of Raekidion
================

Welcome to the repository of War of Raekidion. This game is made in Eiffel, 
with the help of SDL 2.0 and SDL Image 2.0. 

War of Raekidion is a "bullet hell" type top-down shooter game. It involves 
basic gameplay like dodging enemies' projectiles and progressing through 
the level. However, it also includes interesting new features like a 
simple to use modding format, which allows to add enemy ships and projectile 
types through XML files. Also, the main feature of this game consists of a 
online multiplayer mode making one player control the ship and progressing 
normally through the level, while the other sends enemies and attacks to his 
opponent.

Installing the game
----------------------

To install the game, you only have to download the appropriate binary file from 
the "**release**" folder. All content and libraries are included inside the archive. 
To launch the game on Windows, choose the "raekidion.exe" file. For Linux, run 
the "raekidion" executable file.

Installing the SDK
---------------------

If you want to open the code and work with it, we recommend the official Eiffel 
SDK at the following address: 

- [**Eiffel Studio website**][1]

First, create an account on the Eiffel Studio's website. Then, download the adequate 
version of Eiffel Studio and install it to your machine.

You will also have to download and install the required **development libraries** 
working with MinGW: 

- [**SDL 2.0.1**][2]
- [**SDL Image 2.0.0**][3]

### Installing on Windows

For Windows, you will have to put your extracted SDL 2.0.1 and SDL Image 2.0.0 
folders inside the project's directory, like this:

    |+ War of Raekidion
		|
		|- .git
		|+ libraries
			|+ SDL2_image-2.0.0
			|+ SDL2-2.0.1
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
	War of Raekidion\libraries\SDL2_image-2.0.0\<YOUR ARCHITECTURE>\bin\SDL2_image.dll
	War of Raekidion\libraries\SDL2_image-2.0.0\<YOUR ARCHITECTURE>\bin\zlib1.dll
	War of Raekidion\libraries\SDL2_image-2.0.0\<YOUR ARCHITECTURE>\bin\linpng16_16.dll
	
All these files go into
	
	War of Raekidion\SDL2.dll 
	War of Raekidion\SDL2_image.dll
	War of Raekidion\zlib1.dll
	War of Raekidion\linpng16_16.dll

### Installing on Linux (Debian)

For Linux, you will have to install libsdl2-dev and libsdl2-image from the default Debian 
sid source:

	sudo apt-get install libsdl2-dev libsdl2-image-dev

Final words
-----------

We would like to thank our teacher, Louis (GitHub: [**tioui**][4]), for teaching us 
Eiffel and Object Oriented Programming. Also, this project could not have been 
possible without all the team behind SDL and SDL2.

This project is distributed under the GPL-3.0 license. We would only like some 
credits if you use our project somewhere else. 

Enjoy!

[1]:  http://www.eiffel.com/
[2]:  http://www.libsdl.org/download-2.0.php
[3]:  http://www.libsdl.org/projects/SDL_image/
[4]:  http://github.com/tioui
