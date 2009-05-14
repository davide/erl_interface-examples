-module(string_echo).
-export([start/1, stop/0, init/1]).
-export([echo_string/1, echo_binary/1, call_port/2]).

start(msvc) ->
    start("msvc/Release/" ++ ?MODULE_STRING ++ ".exe");
start(mingw) ->
    start("mingw/" ++ ?MODULE_STRING ++ ".exe");
start(mingw_vc) ->
    start("mingw_vc/" ++ ?MODULE_STRING ++ ".exe");
start(gcc) ->
    start("gcc/" ++ ?MODULE_STRING);
start(ExtPrg) ->
    spawn(?MODULE, init, [ExtPrg]).

stop() ->
    ?MODULE ! stop.

%% -------------------------------------------------------------------------
%%                            Test functions
%% -------------------------------------------------------------------------

% Echoes strings captured using erl_iolist_to_string.
% Notice: will fail when given Unicode strings!
echo_string(Arg) when is_list(Arg)  ->
    call_port(echo_string, {Arg}).

% Echoes strings passed/and captured as a binary.
% Should have no problems dealing with Unicode values.
echo_binary(Arg) when is_list(Arg) ->
    Bin = unicode:characters_to_binary(Arg),
    case call_port(echo_binary, {Bin}) of
	Resp when is_binary(Resp) ->
	    Str = unicode:characters_to_list(Resp),
	    io:format("~ts~n", [Str]);
	Other -> Other
    end.

call_port(Func, Args) ->
    ?MODULE ! {call, self(), Func, Args},
    receive
    	{?MODULE, timeout, _} ->
	    timeout;
        {?MODULE, Result} ->
	    {ok, Result}
    end.

init(ExtPrg) ->
    register(?MODULE, self()),
    process_flag(trap_exit, true),
    Port = open_port({spawn, ExtPrg}, [{packet, 2}, binary, exit_status]),
    Timeout = 5000,
%    loop(Port, Timeout) % Comment out for PRD
    try loop(Port, Timeout)
    catch
	T:Err ->
	    error_logger:error_msg("catch: ~p:~p~n", [T, Err])
    end.

loop(Port, Timeout) ->
    receive
        {call, Caller, _Func, Args} when not is_tuple(Args) ->
	    Caller ! invalid_args;
	{call, Caller, Func, Args} ->
	    Binary = term_to_binary({Func, Args}),
	    io:format("sending to port: ~p~n", [{Func, Args}]),
	    erlang:port_command(Port, Binary),
	    receive
		{Port, {data, undef}} ->
		    Caller ! undefined_function;
		{Port, {data, Data}} ->
		    Caller ! {?MODULE, binary_to_term(Data)};
		{Port, {exit_status, Status}} when Status > 128 ->
		    exit({port_terminated, Status});
		{Port, {exit_status, Status}} ->
		    exit({port_terminated, Status});
		{'EXIT', Port, Reason} ->
		    exit(Reason);
		%%   following two lines used for development and testing only
		Other ->
		    io:format("received: ~p~n", [Other])
	    after Timeout ->
		    Caller ! {?MODULE, timeout, Timeout},
		    loop(Port, Timeout)
	    end,
            loop(Port, Timeout);
        stop ->
            erlang:port_close(Port),
            exit(normal);
        {'EXIT', Port, _Reason} ->
            exit(port_terminated);
	{Port, {data, Data}} ->
	    handle_port_message(binary_to_term(Data)),
	    loop(Port, Timeout);
	_Other ->
	    io:format("received (unexpected): ~s~n", [_Other]),
	    loop(Port, Timeout)
    end.

% Add valid message handlers here
%handle_port_message(Msg) ->
% ;
handle_port_message(Msg) ->
	io:format("unknown port message: ~w~n", [Msg]),
	ok.
