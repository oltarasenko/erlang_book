-module (chapter07).
-compile (export_all).

add(X, Y) ->
    X + Y.

fac(N) -> tail_fac(N, 1).

tail_fac(0, Acc) -> Acc;
tail_fac(N, Acc) when N > 0 ->
    tail_fac(N-1, N*Acc).

len([]) -> 0;
len([_|T]) ->
    1 + len(T).


new_len(Li) -> tail_len(Li, 0).
tail_len([], Acc) -> Acc;
tail_len([_|T], Acc) ->
    tail_len(T, Acc + 1).


duplicate(0, _) -> [];
duplicate(X, Entity) ->
    [Entity|duplicate(X-1, Entity)].


tail_duplicate(0, _, Result) -> Result;
tail_duplicate(X, Entity, Result) ->
    tail_duplicate(X - 1, Entity, [Entity|Result]).
new_dup(X, Entity) -> tail_duplicate(X, Entity, []).

reverse([]) -> [];
reverse([H|T]) -> reverse(T) ++ [H].

tail_reverse([], TmpList) -> TmpList;
tail_reverse([H|T], TmpList) ->
    tail_reverse(T, [H] ++ TmpList).
new_reverse(List) -> tail_reverse(List, []).


sublist(_, 0) -> [];
sublist([], _) -> [];
sublist([H|T], N) ->
    [H] ++ sublist(T, N-1).

tail_sublist(_, 0, TmpList) -> TmpList;
tail_sublist([], _, TmpList) -> TmpList;
tail_sublist([H|T], N, TmpList) ->
    tail_sublist(T, N-1, TmpList ++ [H]).
new_sublist(Li, N) -> tail_sublist(Li, N, []).

zip(_, []) -> [];
zip([], _) -> [];
zip([H1|T1], [H2|T2]) ->
    [{H1, H2}] ++ zip(T1, T2).

tail_zip(_, [], TmpList) -> TmpList;
tail_zip([], _, TmpList) -> TmpList;
tail_zip([H1|T1], [H2|T2], TmpList) ->
    tail_zip(T1, T2, TmpList ++ [{H1, H2}]).
new_zip(Li1, Li2) -> tail_zip(Li1, Li2, []).

quicksort([]) -> [];
quicksort([Pivot|Rest]) ->
    {Smaller, Larger} = partiotion(Pivot, Rest, [], []),
    quicksort(Smaller) ++ [Pivot] ++ quicksort(Larger).

partiotion(_, [], Smaller, Larger) -> {Smaller, Larger};
partiotion(Pivot, [H|T], Smaller, Larger) ->
    if H =< Pivot -> partiotion(Pivot, T, [H|Smaller], Larger);
        H > Pivot -> partiotion(Pivot, T, Smaller, [H|Larger])
    end.
