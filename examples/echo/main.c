#include "erl_interface.h"
#include "ei.h"
#include "erl_comm.h"
#include "echo.h"

int main(int argc, char* argv[])
{ 
	ETERM *tuplep;
	ETERM *fnp;
	ETERM *args;
	byte buf[1024];
	const char* func_name;

	erl_init(NULL, 0);

	while (read_cmd(buf) > 0) {
		tuplep = erl_decode(buf);
		fnp = erl_element(1, tuplep);

		func_name =  (const char*)ERL_ATOM_PTR(fnp);
		args = erl_element(2, tuplep);

		// MATCH FIRST! -> REMEMBER THAT!
		if (strncmp(func_name, "echo_atom", 9) == 0)
		{
			echo_atom(args);
		}
		else if (strncmp(func_name, "echo", 4) == 0)
		{
			echo(args);
		}
		else
		{
			byte buf[100];
			int return_arr_size = 2;
			ETERM *return_arr[2];
			ETERM *return_tuple;
			return_arr[0] = erl_mk_atom("undef");
			return_arr[1] = erl_copy_term(fnp);
			return_tuple = erl_mk_tuple(return_arr, 2);
			erl_encode(return_tuple, buf);
			write_cmd(buf, erl_term_len(return_tuple));
			// free memory
			erl_free_array(return_arr, 2);
			// TODO: check if this is freeing the array contents again
			erl_free_term(return_tuple);
		}
		erl_free_compound(tuplep);
		erl_free_compound(tuplep);
		erl_free_term(fnp);
	}
	return 0;
}
