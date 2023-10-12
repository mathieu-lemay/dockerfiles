#!/bin/bash

[[ -n "${DEBUG:-}" ]] && set -x
set -eu -o pipefail

declare -a PGCLI_OPTS=()

[[ -n "${PG_CONNSTR:-}" ]] && PGCLI_OPTS+=("${PG_CONNSTR}")

mkdir -p ~/.config/pgcli
cat > ~/.config/pgcli/config << EOF
[main]
destructive_warning = ${PGCLI_DESTRUCTIVE_WARNING:-True}
enable_pager = ${PGCLI_ENABLE_PAGER:-True}
key_bindings = ${PGCLI_KEY_BINDINGS:-emacs}
less_chatty = ${PGCLI_LESS_CHATTY:-True}
multi_line = ${PGCLI_MULTI_LINE:-False}
prompt = '${PGCLI_PROMPT:-"\\u@\\h:\\d> "}'
prompt_continuation = '${PGCLI_PROMPT_CONTINUATION:-"->"}'
smart_completion = ${PGCLI_SMART_COMPLETION:-True}
syntax_style = ${PGCLI_SYNTAX_STYLE:-trac}
table_format = ${PGCLI_TABLE_FORMAT:-ascii}
timing = ${PGCLI_TIMING:-True}
EOF

if command -v "$1" &>/dev/null && [[ "${1}" != "pgcli" ]]; then
    exec "$@"
else
    [[ "${1:-pgcli}" = "pgcli" ]] && shift
    [[ 0 -lt "$#" ]] && PGCLI_OPTS+=("$@")
    [[ 0 -eq "${#PGCLI_OPTS[@]}" ]] && PGCLI_OPTS=(--help)
    exec pgcli "${PGCLI_OPTS[@]}"
fi
