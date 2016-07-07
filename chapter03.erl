-module(chapter03).
-export ([add/2, say_hello/0, say_hello_and_add/2]).

add(A, B) ->
    A + B.

say_hello() ->
    io:format("Said hello ~n").

say_hello_and_add(A, B) ->
    say_hello(),
    add(A, B).
