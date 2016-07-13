-module (chapter10).
-compile(export_all).

rpn_calculator(Input) ->
    List = string:tokens(Input, " "),
    [Res] = lists:foldl(fun rpn/2, [], List),
    Res.


read(N) ->
    case string:to_float(N) of
        {error,no_float} -> list_to_integer(N);
        {F, _} -> F
    end.

rpn("+", [N1, N2|S]) ->
    % io:format("Formatting: ~p ~p\n", [N1, N2]),
    [N2 + N1|S];
rpn(X, Stack) -> [read(X)|Stack].


main() ->
    File = "road.txt",
    {ok, Bin} = file:read_file(File),
    parse_map(Bin),
    io:format("~p", ["Something"]),
    erlang:halt().

parse_map(Bin) when is_binary(Bin) ->
    parse_map(binary_to_list(Bin));
parse_map(Str) when is_list(Str) ->
    Values = [list_to_integer(X) || X <- string:tokens(Str, "\r\n\t")],
    group_vals(Values, []).

group_vals([], Acc) ->
    lists:reverse(Acc);
group_vals([A,B,X|Rest], Acc) ->
    group_vals(Rest, [{A, B, X} | Acc]).

% erlc chapter10.erl
% erl -noshell -run chapter10 main
