#include "erl_interface.h"
#include "ei.h"
#include "erl_comm.h"
#include "complex.h"
#ifdef __WIN32__
#include <fcntl.h>
#endif

int main() {
  ETERM *tuplep, *intp;
  ETERM *fnp, *argp;
  int res;
  byte buf[100];

#ifdef __WIN32__
  /* Attention Windows programmers: you need [to pay Serge Aleynikov a
   * beer because he's the one who figured out how to get this to work
   * on windows :)] explicitly set mode of stdin/stdout to binary or
   * else the port program won't work.
   */
  _setmode(_fileno(stdout), O_BINARY);
  _setmode(_fileno(stdin), O_BINARY);
#endif


  erl_init(NULL, 0);

  while (read_cmd(buf) > 0) {
    tuplep = erl_decode(buf);
    fnp = erl_element(1, tuplep);
    argp = erl_element(2, tuplep);
    
    if (strncmp(ERL_ATOM_PTR(fnp), "foo", 3) == 0) {
      res = foo(ERL_INT_VALUE(argp));
    } else if (strncmp(ERL_ATOM_PTR(fnp), "bar", 17) == 0) {
      res = bar(ERL_INT_VALUE(argp));
    }

    intp = erl_mk_int(res);
    erl_encode(intp, buf);
    write_cmd(buf, erl_term_len(intp));

    erl_free_compound(tuplep);
    erl_free_term(fnp);
    erl_free_term(argp);
    erl_free_term(intp);
  }
}

