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
		- port: an implementation of the following how-to:
			http://www.trapexit.org/How_to_use_ei_to_marshal_binary_terms_in_port_programs
		- ... your examples here ...

For now this is mostly this is Windows specific stuff.
Anyway, feel free to contribute back with any feedback or working examples. :)

#######################################################################################################

I've tryed to setup the sourcecode and Makefiles in a way that should make it easy to test
the building process with various methods without having to change much:

	- For Visual C++ 2008 Express Edition builds:
		- You have to edit the .vcproj files and fix these paths:
			- AdditionalIncludeDirectories
			- AdditionalLibraryDirectories
		  so that they'll point to your erl_interface dir.
		- This method uses the erl_interface.lib and ei.lib libraries.
	
	- For builds using GCC or MinGW*:
		- You have to edit build/BuildConfig.mk and set
			ERL_INTERFACE_DIR
		  so that it points to your erl_interface dir.
		
		- Run make on one of the build subdirs
			- mingw:
				Uses the liberl_interface_md.a and libei._md.a libraries
				built using MinGW to compile erl_interface
			- gcc:
				Uses the liberl_interface.a and libei.a libraries
				built using gcc to compile erl_interface
			- mingw_vc:
				Uses the .lib files that are bundled with the binary
				erlang windows distribution
				NOTICE:
					I wasn't able to get this build method to work nor
					find out if this will ever work. Feel free to try. :)
		
*This build method uses a non-recursive makefile (as seen on
http://www.xs4all.nl/~evbergen/nonrecursive-make.html) which
still needs a bit of tinkering with.

#######################################################################################################