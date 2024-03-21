#!/bin/bash

# SPDX-FileCopyrightText: 2023 Zextras <https://www.zextras.com>
#
# SPDX-License-Identifier: AGPL-3.0-only

MAIN_SERVICE_NAME="carbonio-tasks"
CONSUL_TOKEN_PATH="/etc/carbonio/tasks-db/service-discover/token"

function get_kv_consul() {
  set +e
  result=$(consul kv get -token-file="${CONSUL_TOKEN_PATH}" "${MAIN_SERVICE_NAME}/$1")
  set -e
  echo "$result";
}

DATABASE_NAME=$(get_kv_consul "db-name")
DATABASE_USERNAME=$(get_kv_consul "db-username")
DATABASE_PASSWORD=$(get_kv_consul "db-password")

POSTGRES_HOST=""
POSTGRES_PORT=""

if [ -z "${POSTGRES_HOST}" ]; then
  POSTGRES_HOST="localhost";
fi

if [ -z "${POSTGRES_PORT}" ]; then
  POSTGRES_PORT="5432";
fi

echo "HOST: $POSTGRES_HOST"
echo "PORT: $POSTGRES_PORT"
echo "DATABASE_USERNAME: $DATABASE_USERNAME"
echo "DATABASE_NAME: $DATABASE_NAME"
echo "DATABASE_PASSWORD: $DATABASE_PASSWORD"

# ============================
# Check if the database exists
# ============================
set +e

QUERY_RESULT=$(PGPASSWORD="${DATABASE_PASSWORD}" psql -h "${POSTGRES_HOST}" -p "${POSTGRES_PORT}" -d "${DATABASE_NAME}" -U "${DATABASE_USERNAME}" -tAq 2>/dev/null <<EOF
SELECT 1 FROM pg_database WHERE datname = 'carbonio-tasks-db';
EOF
)

PSQL_EXIT_CODE="$?" #is this really needed?

if [ "$PSQL_EXIT_CODE" == "0" ] && [ "$QUERY_RESULT" == "1" ]; then
  echo "Database exists!"
  exit 0
else
  echo "Error: Database does not exist or encountered an error."
  exit 1
fi

set -e
