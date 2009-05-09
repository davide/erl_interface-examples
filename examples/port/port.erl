-module(port).

% API
-export([start/1, stop/0, test/1, add/2, multiply/2, divide/2]).
% Internal exports
-export([init/1]).

start(msvc) ->
    start("msvc/Release/" ++ ?MODULE_STRING ++ ".exe");
start(mingw) ->
    start("mingw/" ++ ?MODULE_STRING ++ ".exe");
start(mingw_vc) ->
    start("mingw_vc/" ++ ?MODULE_STRING ++ ".exe");
start(gcc) ->
    start("gcc/" ++ ?MODULE_STRING);
start(ExtPrg) ->
    spawn_link(?MODULE, init, [ExtPrg]).
stop() ->
    ?MODULE ! stop.

test(ExtPrg) ->
    ?MODULE:start(ExtPrg),
    add(1,2),
    multiply(2,2),
    divide(10,5),
    ok.

add(X, Y) ->
    call_port({add, X, Y}).
multiply(X, Y) ->
    call_port({multiply, X, Y}).
divide(X, Y) ->
    call_port({divide, X, Y}).

call_port(Msg) ->
    ?MODULE ! {call, self(), Msg},
    receive
    Result ->
        Result
    end.

init(ExtPrg) ->
    register(?MODULE, self()),
    process_flag(trap_exit, true),
    Port = open_port({spawn, ExtPrg}, [{packet, 2}, binary, exit_status]),
    loop(Port).

loop(Port) ->
    receive
    {call, Caller, Msg} ->
        io:format("Calling port with ~p~n", [Msg]),
        erlang:port_command(Port, term_to_binary(Msg)),
        receive
        {Port, {data, Data}} ->
            Caller ! binary_to_term(Data);
        {Port, {exit_status, Status}} when Status > 128 ->
            io:format("Port terminated with signal: ~p~n", [Status-128]),
            exit({port_terminated, Status});
        {Port, {exit_status, Status}} ->
            io:format("Port terminated with status: ~p~n", [Status]),
            exit({port_terminated, Status});
        {'EXIT', Port, Reason} ->
            exit(Reason)
        end,
        loop(Port);
    stop ->
        erlang:port_close(Port),
        exit(normal)
    end.
