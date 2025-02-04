%% The contents of this file are subject to the Mozilla Public License
%% Version 1.1 (the "License"); you may not use this file except in
%% compliance with the License. You may obtain a copy of the License
%% at https://www.mozilla.org/MPL/
%%
%% Software distributed under the License is distributed on an "AS IS"
%% basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See
%% the License for the specific language governing rights and
%% limitations under the License.
%%
%% The Original Code is RabbitMQ.
%%
%% The Initial Developer of the Original Code is GoPivotal, Inc.
%% Copyright (c) 2007-2017 Pivotal Software, Inc.  All rights reserved.
%%

-module(rabbit_auth_backend_dummy).
-include("rabbit.hrl").

-behaviour(rabbit_authn_backend).
-behaviour(rabbit_authz_backend).

-export([user/0]).
-export([user_login_authentication/2, user_login_authorization/2,
         check_vhost_access/3, check_resource_access/4, check_topic_access/4]).

-spec user() -> rabbit_types:user().

%% A user to be used by the direct client when permission checks are
%% not needed. This user can do anything AMQPish.
user() -> #user{username       = <<"none">>,
                tags           = [],
                authz_backends = [{?MODULE, none}]}.

%% Implementation of rabbit_auth_backend

user_login_authentication(_, _) ->
    {refused, "cannot log in conventionally as dummy user", []}.

user_login_authorization(_, _) ->
    {refused, "cannot log in conventionally as dummy user", []}.

check_vhost_access(#auth_user{}, _VHostPath, _AuthzData) -> true.
check_resource_access(#auth_user{}, #resource{}, _Permission, _Context) -> true.
check_topic_access(#auth_user{}, #resource{}, _Permission, _Context) -> true.
