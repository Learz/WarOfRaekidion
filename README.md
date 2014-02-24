War of Raekidion
================

Welcome to the repository of War of Raekidion. This game is made in Eiffel, 
with the help of SDL 2.0 and SDL Image 2.0. 

War of Raekidion is a "bullet hell" type top-down shooter game. It involves 
basic gameplay like dodgeing enemies' projectiles and progressing through 
the level. However, it also includes interresting new features like a 
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

You will also have to download and install the required **runtime binaries** 
and the **developement libraries** working with MinGW: 

- [**SDL 2.0**][2]
- [**SDL Image 2.0**][3]

### Installing on Windows

For Windows, you will have to put your extracted SDL 2.0 and SDL Image 2.0 
folders and files inside the project's directory, like this:

    |- War of Raekidion
		|
		|- .git
		|- EIFGENs
		|- libraries
			|- SDL2_image-2.0.0
			|- SDL2-2.0.x
			|- libpng16-16.dll
			|- SDL2.dll
			|- SDL2_image.dll
			|- zlib1.dll
		|- ressources
		|- source
		|
		|- .gitignore
		|- raekidion.ecf
		|- readme.md

You probably won't have the EIFGENs folder, as it is only used by Eiffel Studio to 
store compiled files. You will also have to create the raekidion.ecf yourself, 
so you can copy the following XML file:

	<?xml version="1.0" encoding="ISO-8859-1"?>
	<system xmlns="http://www.eiffel.com/developers/xml/configuration-1-12-0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.eiffel.com/developers/xml/configuration-1-12-0 http://www.eiffel.com/developers/xml/configuration-1-12-0.xsd" name="raekidion" uuid="9F7C9DBB-A9BC-4B1D-A571-292288873EE4">
		<target name="raekidion">
			<root class="APPLICATION" feature="make"/>
			<option warning="true">
				<assertions precondition="true" postcondition="true" check="true" invariant="true" loop="true" supplier_precondition="true"/>
			</option>
			<setting name="console_application" value="false"/>
			<external_include location="..\..\..\..\libraries\SDL2-2.0.1\i686-w64-mingw32\include\SDL2"/>
			<external_library location="..\..\..\libraries\SDL2-2.0.1\i686-w64-mingw32\lib\libSDL2.dll.a"/>
			<precompile name="base_pre" location="$ISE_PRECOMP\base-safe.ecf"/>
			<library name="base" location="$ISE_LIBRARY\library\base\base-safe.ecf"/>
			<cluster name="raekidion" location=".\" recursive="true">
				<file_rule>
					<exclude>/README.md$</exclude>
					<exclude>/.git$</exclude>
					<exclude>/.gitignore$</exclude>
					<exclude>/EIFGENs$</exclude>
					<exclude>/ressources$</exclude>
					<exclude>/releases$</exclude>
					<exclude>/libraries$</exclude>
				</file_rule>
			</cluster>
		</target>
	</system>

### Installing on Linux (Debian)

For Windows, you will have to install libsdl2-dev and libsdl2-image from the default Debian 
sid source:

	sudo apt-get install libsdl2-dev libsdl2-image-dev

You will have to create the raekidion.ecf yourself, so you can copy the following XML file:

	<?xml version="1.0" encoding="ISO-8859-1"?>
	<system xmlns="http://www.eiffel.com/developers/xml/configuration-1-12-0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.eiffel.com/developers/xml/configuration-1-12-0 http://www.eiffel.com/developers/xml/configuration-1-12-0.xsd" name="raekidion" uuid="9F7C9DBB-A9BC-4B1D-A571-292288873EE4">
		<target name="raekidion">
			<root class="APPLICATION" feature="make"/>
			<option warning="true">
				<assertions precondition="true" postcondition="true" check="true" invariant="true" loop="true" supplier_precondition="true"/>
			</option>
			<setting name="console_application" value="false"/>
			<external_cflag value="`sdl2-config --cflags`"/>
			<external_cflag value="`pkg-config --cflags SDL2_image`"/>
			<external_linker_flag value="`sdl2-config --libs`"/>
			<external_linker_flag value="`pkg-config --libs SDL2_image`"/>
			<precompile name="base_pre" location="$ISE_PRECOMP\base-safe.ecf"/>
			<library name="base" location="$ISE_LIBRARY\library\base\base-safe.ecf"/>
			<cluster name="raekidion" location=".\" recursive="true">
				<file_rule>
					<exclude>/README.md$</exclude>
					<exclude>/.git$</exclude>
					<exclude>/.gitignore$</exclude>
					<exclude>/EIFGENs$</exclude>
					<exclude>/ressources$</exclude>
					<exclude>/releases$</exclude>
					<exclude>/libraries$</exclude>
				</file_rule>
			</cluster>
		</target>
	</system>

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
