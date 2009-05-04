#####################################################
                                     erl_interface examples
#####################################################

This repository contains:

	- documentation on
		- how to build erlang on windows
		- how to build erl_interface using MinGW
		- how to setup Visual C++ 2008 Express Edition to build ports using erl_interface
		- how to use MinGW to build against .lib files (bundled in the erlang windows distribution)
			- This one is not finished yet. :P

	- code examples on using erl_interface
		- complex: the example problem (http://erlang.org/doc/tutorial/erl_interface.html)
		- echo: an echo program I'm using to debug an issue with erl_interface
		- ... your examples here ...
		
Feel free to contribute back with any feedback or working examples. :)

#####################################################

Currently there are two build methods:

	- Using Visual C++ 2008 Express Edition
		You have to edit the .vcproj files and fix these paths:
			- AdditionalIncludeDirectories
			- AdditionalLibraryDirectories
		so that they'll point to your erl_interface dir.
	
	- Using the MinGW
		You have to edit mingw/Rules.mk and set
			ERL_INTERFACE_DIR
		so that it points to your erl_interface dir.
		
		This build method uses a non-recursive makefile (which I haven't fully mastered yet).

#####################################################