#######################################################################################################
                                     erl_interface examples
#######################################################################################################

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

For now this is mostly this is Windows specific stuff.
Anyway, feel free to contribute back with any feedback or working examples. :)

#######################################################################################################

Currently only two build methods are supported:

	- Using Visual C++ 2008 Express Edition
	
		- You have to edit the .vcproj files and fix these paths:
			- AdditionalIncludeDirectories
			- AdditionalLibraryDirectories
		  so that they'll point to your erl_interface dir.
		
		- This method uses the erl_interface.lib and ei.lib libraries.
	
	- Using MinGW
	
		- You have to edit mingw/Rules.mk and set
			ERL_INTERFACE_DIR
		  so that it points to your erl_interface dir.
		
		- To use this method you have to build erl_interface using MinGW to produce the
		erl_interface_md.a and ei._md.a libraries.
		
		- This build method uses a non-recursive makefile (as seen
		  on http://www.xs4all.nl/~evbergen/nonrecursive-make.html) which might still
		  need a bit of tinkering with.

#######################################################################################################