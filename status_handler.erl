-module(status_handler).

-export([init/2,
         terminate/3]).

init(Req, State) ->
    handle(Req, State),
    {ok, Req, State}.

handle(Req, State) ->
    NewReq = cowboy_req:reply(200, #{<<"Content-Type">> => <<"application/json">>},
        jsx:encode(status_response()), Req),

    {ok, NewReq, State}.

terminate(_, _, _) -> ok.

status_response() ->
    [{<<"stats">>, <<"Up">>}].
