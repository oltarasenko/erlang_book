-module (chapter04).
-compile(export_all).

greet(male, Name) ->
    io:format("Hello Mr. ~s", [Name]);
greet(female, Name) ->
    io:format("Hello Mrs. ~s", [Name]);
greet(_, Name) ->
    io:format("Hello someone ~s", [Name]).

head([H|_]) -> H.
second([_, X|_]) -> X.
third([_, _, X]) -> X.

same(X, X) -> true;
same(_, _) -> false.

valid_time({Date = {Y,M,D}}) ->
    io:format('The Date tuple (~p): ~p, ~p, ~p', [Date, Y, M, D]);
valid_time(_) ->
    io:format('Wrong data').

old_enough(X) when X > 16 -> true;
old_enough(_) -> false.

heh_fine() ->
    if 1 =:= 1 ->
        works
    end,
    if 1 =:= 2; 1=:=1 ->
        works
    end,
    if 1 =:= 2, 1 =:= 1 ->
        fails
    end
    .

help_me(Animal) ->
    Talk = if Animal == cat  -> "meow";
    Animal == beef -> "mooo";
    Animal == dog  -> "bark";
    Animal == tree -> "bark";
    true -> "fgdadfgna"
    end,
    {Animal, "says " ++ Talk ++ "!"}.

beach(Temperature) ->
    case Temperature of
        {celsius, N} when N >= 20, N =< 45 ->
            'favorable';
        {kelvin, N} when N >= 293, N =< 318 ->
            'scientifically favorable';
        {fahrenheit, N} when N >= 68, N =< 113 ->
            'favorable in the US';
        _ ->
        'avoid beach'
    end.