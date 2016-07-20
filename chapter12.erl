-module (chapter12).
-compile(export_all).

add(X, Y) -> X + Y.

dolphin1() ->
    receive
        {From, do_a_flip} ->
            From ! "How about no? ~n",
            dolphin1();
        {From, fish} ->
            From ! "So long and thanks for all ~n";
        _ ->
            io:format("Heh, we're smarter!")
    end.