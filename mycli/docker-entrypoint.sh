#!/bin/bash

[[ -n "${DEBUG:-}" ]] && set -x
set -eu -o pipefail

declare -a MYCLI_OPTS=()

if [[ -n "${MYSQL_ROOT_PASSWORD:-}" ]]; then
    MYSQL_USER=root
    MYSQL_PASSWORD="$MYSQL_ROOT_PASSWORD"
fi

[[ -n "${MYSQL_HOST:-}" ]] && MYCLI_OPTS+=(--host "$MYSQL_HOST")
[[ -n "${MYSQL_USER:-}" ]] && MYCLI_OPTS+=(--user "$MYSQL_USER")
[[ -n "${MYSQL_PASSWORD:-}" ]] && MYCLI_OPTS+=(--password "$MYSQL_PASSWORD")
[[ -n "${MYSQL_DATABASE:-}" ]] && MYCLI_OPTS+=("$MYSQL_DATABASE")

mkdir -p ~/.config/mycli
cat > ~/.config/mycli/myclirc << EOF
[main]
destructive_warning = ${MYCLI_DESTRUCTIVE_WARNING:-True}
enable_pager = ${MYCLI_ENABLE_PAGER:-True}
key_bindings = ${MYCLI_KEY_BINDINGS:-emacs}
less_chatty = ${MYCLI_LESS_CHATTY:-True}
multi_line = ${MYCLI_MULTI_LINE:-False}
prompt = '${MYCLI_PROMPT:-"\\t \\u@\\h:\\d> "}'
prompt_continuation = '${MYCLI_PROMPT_CONTINUATION:-"->"}'
smart_completion = ${MYCLI_SMART_COMPLETION:-True}
syntax_style = ${MYCLI_SYNTAX_STYLE:-default}
table_format = ${MYCLI_TABLE_FORMAT:-ascii}
timing = ${MYCLI_TIMING:-True}
EOF

if command -v "$1" &>/dev/null && [[ "${1}" != "mycli" ]]; then
    exec "$@"
else
    [[ "${1:-}" = "mycli" ]] && shift
    [[ 0 -lt "$#" ]] && MYCLI_OPTS+=("$@")
    [[ 0 -eq "${#MYCLI_OPTS[@]}" ]] && MYCLI_OPTS=(--help)
    exec /usr/local/bin/mycli "${MYCLI_OPTS[@]}"
fi
