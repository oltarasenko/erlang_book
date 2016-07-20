-module (chapter14).
-compile(export_all).

myproc() ->
    timer:sleep(5000),
    exit(reason).

%% Link sample
chain(0) ->
    receive
        _ -> ok
    after 2000 ->
        exit("Chain died")
    end;
chain(N) ->
    Pid = spawn(fun() -> chain(N - 1) end),
    link(Pid),
    receive
        _ -> ok
    end.

% System process sample
system_process() ->
    process_flag(trap_exit, true),
    spawn_link(fun() -> chapter14:chain(3) end),
    receive
        X -> X
    after 5000
        -> ok
    end.


% Monitors sample
monitor_process() ->
    erlang:monitor(
        process,
        spawn(fun() -> timer:sleep(500) end)).

% Naming Processes
start_critic() ->
    spawn(?MODULE, critic, []).

start_critic2() ->
    spawn(?MODULE, restarter, []).

restarter() ->
    process_flag(trap_exit, true),
    Pid = spawn_link(?MODULE, critic, []),
    receive
        {'EXIT', Pid, normal} -> % Not a crash
            ok;
        {'EXIT', Pid, shutdown} -> % Manual term, ignore
            ok;
        {'EXIT', Pid, _} ->
            restarter()
    end.

judge(Pid, Band, Album) ->
    Pid ! {self(), {Band, Album}},
    receive
        {Pid, Criticism} -> Criticism
    after 4000 ->
        timeout
    end.
critic() ->
    receive
        {From, {"Range against Turning Machine", "Unit"}} ->
            From ! {self(), "They are great"};
        {From, {"System of Downtime", "Memoize"}} ->
            From ! {self(), "Not too good"};
        {From, {"Jonny Crash", "The Token Ring"}} ->
            From ! {self(), "Simply incredible"};
        {From, {_, _}} ->
            From ! {self(), "Terrible"}
    end,
    critic().

% use_name_process() ->
%     CriticPid = chapter14:start_critic(),
%     chapter14:judge(CriticPid, "Geneis", "Hate them"),
%     exit(CriticPid, solar_storm),
%     chapter14:judge(CriticPid, "Genesis", "Lol").

use_name_process2() ->
    CriticPid = chapter14:start_critic2(),
    chapter14:judge(CriticPid, "Geneis", "Hate them").
    % exit(CriticPid, solar_storm),
    % chapter14:judge(CriticPid, "Genesis", "Lol").

% register register(critic, Pid),

