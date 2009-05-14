#include "string_echo.h"

void echo_string(ETERM* args)
{
  ETERM *pathp = erl_element(1, args); // alloc path
  char *path = erl_iolist_to_string(pathp);
 
  // Build response
  byte buf[100];
  ETERM *resp = erl_mk_string(path); // alloc resp
  erl_encode(resp, buf);
  write_cmd(buf, erl_term_len(resp));
  erl_free_term(resp); // free resp
}

void echo_binary(ETERM* args)
{
  ETERM *pathp = erl_element(1, args);
  int pathLen = ERL_BIN_SIZE(pathp);
  void *path = ERL_BIN_PTR(pathp);
  
  // Build response
  byte buf[100];
  ETERM *resp = erl_mk_binary(path, pathLen);; // alloc resp
  erl_encode(resp, buf);
  write_cmd(buf, erl_term_len(resp));
  erl_free_term(resp); // free resp
}

