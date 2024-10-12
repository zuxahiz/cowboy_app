%%%-------------------------------------------------------------------
%% @doc cowboy_app public API
%% @end
%%%-------------------------------------------------------------------

-module(cowboy_app_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    Dispatch = cowboy_router:compile([
        {'_', [
            {"/v1/status", status_handler, []}
        ]}
    ]),
    RanchOptions = #{
        socket_opts => [{port, 8000}],
        max_connections => 100},
    CowboyOptions = #{
        env => #{
            dispatch => Dispatch},
        request_timeout => 10 * 1000,
        idle_timeout    => 10,
        inactivity_timeout => 10 * 1000,
        stream_handlers => [cowboy_stream_h],
        middlewares => [cowboy_router, cowboy_handler]},
        cowboy:start_clear(http_listener, RanchOptions, CowboyOptions).

stop(_State) ->
    cowboy_app:stop(http_listener).

%% internal functions
