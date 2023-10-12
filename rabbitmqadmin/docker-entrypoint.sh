#! /bin/sh

set -eu -o pipefail

RABBITMQ_SERVER_URI="$(echo "${CONNSTR:?}" | sed -E 's/^amqps?/https/' | sed -E 's/:[0-9]+$/:443/')"
export RABBITMQ_SERVER_URI

unset CONNSTR

mkdir -p ~/.bin
install -m 755 /dev/null ~/.bin/radm

cat << EOF > ~/.bin/radm
#! /bin/sh

set -eu

rabbitmqadmin --ssl --base-uri "\${RABBITMQ_SERVER_URI}" "\$@"
EOF

export PATH="${HOME}/.bin:${PATH}"

exec sh
