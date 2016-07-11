-module (chapter09).
-compile (export_all).

return_error() -> erlang:error(bad_thing_happened).

throws(F) ->
    try F() of
        _ -> ok
    catch
        Throw -> {throw, caugth, Throw}
    end.

sword(1) -> throw(slice);
sword(2) -> erlang:error(cut_arm);
sword(3) -> exit(cut_leg);
sword(4) -> throw(punch);
sword(5) -> exit(cross_bridge).

black_knight(Attack) when is_function(Attack, 0) ->
    try Attack() of
        _ -> "None shall pass."
    catch
        throw:slice -> "No worries";
        error:cut_arm -> "Wow...hurtns";
        exit:cut_leg -> "Ajajaj";
        _:_ -> "Pain in near"
    end.

%% chapter09:black_knight(fun() -> chapter09:sword(1) end).