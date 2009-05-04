#include "echo.h"

void echo(ETERM *args)
{
  ETERM *something = erl_element(1, args);

  // reply with a copy of what was received
  ETERM *copy = erl_copy_term(something);
  byte buf[500];
  erl_encode(copy, buf);
  write_cmd(buf, erl_term_len(copy));
  erl_free_term(copy);
}


void echo_atom(ETERM *args)
{
  ETERM *atom = erl_element(1, args);
  const char* atom_name = (const char*)ERL_ATOM_PTR(atom);

  byte buf[100];
  ETERM *atomp = erl_mk_atom(atom_name); // alloc atomp
  erl_encode(atomp, buf);
  write_cmd(buf, erl_term_len(atomp));
  erl_free_term(atomp); // free atomp
}


