// SPDX-FileCopyrightText: 2023 Zextras <https://www.zextras.com>
//
// SPDX-License-Identifier: AGPL-3.0-only

services {
  checks = [
    {
      tcp      = "127.0.0.1:5432"
      timeout  = "1s"
      interval = "5s"
    },
    {
      "id": "check_db_existence"
      "name": "Database existence check"
      "args": ["/usr/bin/check_db_existence.sh"]
      "interval": "5s"
    }
  ]
  connect {
    sidecar_service {}
  }
  name    = "carbonio-tasks-db"
  port    = 5432
}
