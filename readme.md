War of Rækidion
===============

Welcome to the repository of War of Rækidion. This game is made in Eiffel, 
with the help of SDL 2.0 and SDL Image 2.0. 

Feel free to contribute and 
leave a comment if you ever want to see a specific feature implemented into 
the project. We are still students, but we'll try to maintain this school 
assignment up to date and growing.

Installing the game
----------------------

To install the game, you only have to download the Master branch and run it. 
If you have Windows, choose the supplied "War of Rækidion.exe" file to execute the game.
For Linux, run the "War of Rækidion" executable file.

Installing the SDK
---------------------

If you want to open the code and work with it, we recommend the official Eiffel 
SDK at the following address: 

- [**Eiffel Studio website**][1]

First, create an account on the Eiffel Studio's website. Then, download the adequate 
version of Eiffel Studio and install it to your machine.

You will also have to download and install the required libraries: 

- [**SDL 2.0**][2]
- [**SDL Image 2.0**][3]

### Installing on Windows

For Windows, you will have to put your downloaded SDL 2.0 and SDL Image 2.0 
folders inside the project's directory, like this:

    War of Rækidion
      |- .git
      |- EIFGENs
      |- SDL2-2.0.x
      |- SDL2_image-2.0.0
      |- src
      |- res
      |- raekidion.ecf

You probably won't have the EIFGENs folder, as it is only used by Eiffel Studio to 
store compiled files. You will also have to create the raekidion.ecf yourself, so you 
can copy the following XML file:

	<?xml version="1.0" encoding="ISO-8859-1"?>
	<system xmlns="http://www.eiffel.com/developers/xml/configuration-1-12-0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.eiffel.com/developers/xml/configuration-1-12-0 http://www.eiffel.com/developers/xml/configuration-1-12-0.xsd" name="test-sdl" uuid="9F7C9DBB-A9BC-4B1D-A571-292288873EE4">
		<target name="raekidion">
			<root class="APPLICATION" feature="make"/>
			<option warning="true">
				<assertions precondition="true" postcondition="true" check="true" invariant="true" loop="true" supplier_precondition="true"/>
			</option>
			<setting name="console_application" value="true"/>
			<external_include location="..\..\..\..\SDL2-2.0.1\i686-w64-mingw32\include\SDL2"/>
			<external_library location="..\..\..\SDL2-2.0.1\i686-w64-mingw32\lib\libSDL2.dll.a"/>
			<precompile name="base_pre" location="$ISE_PRECOMP\base-safe.ecf"/>
			<library name="base" location="$ISE_LIBRARY\library\base\base-safe.ecf"/>
			<cluster name="raekidion" location=".\" recursive="true">
				<file_rule>
					<exclude>/EIFGENs$</exclude>
					<exclude>/CVS$</exclude>
					<exclude>/.git$</exclude>
				</file_rule>
			</cluster>
		</target>
	</system>

### Installing on Linux (Debian)

For Windows, you will have to install libsdl2-dev and libsdl2-image from the default Debian 
sid source:

	sudo apt-get install libsdl2-dev libsdl2-image

You will have to create the raekidion.ecf yourself, so you can copy the following XML file:

	<?xml version="1.0" encoding="ISO-8859-1"?>
	<system xmlns="http://www.eiffel.com/developers/xml/configuration-1-12-0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.eiffel.com/developers/xml/configuration-1-12-0 http://www.eiffel.com/developers/xml/configuration-1-12-0.xsd" name="test-sdl" uuid="9F7C9DBB-A9BC-4B1D-A571-292288873EE4">
		<target name="raekidion">
			<root class="APPLICATION" feature="make"/>
			<option warning="true">
				<assertions precondition="true" postcondition="true" check="true" invariant="true" loop="true" supplier_precondition="true"/>
			</option>
			<setting name="console_application" value="true"/>
			<external_cflag value="`sdl2-config --cflags`"/>
			<external_linker_flag value="`sdl2-config --libs`"/>
			<precompile name="base_pre" location="$ISE_PRECOMP\base-safe.ecf"/>
			<library name="base" location="$ISE_LIBRARY\library\base\base-safe.ecf"/>
			<cluster name="raekidion" location=".\" recursive="true">
				<file_rule>
					<exclude>/EIFGENs$</exclude>
					<exclude>/CVS$</exclude>
					<exclude>/.git$</exclude>
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
