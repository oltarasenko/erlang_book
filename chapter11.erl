-module (chapter11).
-compile(export_all).

-record (robot, {name, type=industrial,
                 hobbies, details=[]}).

-record (user, {id, name, group, age}).

admin_panel(#user{name=Name, group=admin}) ->
    Name ++ " is allowed";
admin_panel(#user{name=Name}) ->
    Name ++ "should go away".

adult_section(U=#user{}) when U#user.age >= 18 ->
    allowed;
adult_section(_) ->
    forbidden.

first_robot() ->
    Robot = #robot{name="Mechatron",
           type=handmade,
           details=["Moved by small man"]},
    Robot#robot.name.
