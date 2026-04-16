// SPDX-FileCopyrightText: 2023 Zextras <https://www.zextras.com>
//
// SPDX-License-Identifier: AGPL-3.0-only

library(
    identifier: 'jenkins-lib-common@dt3-migration',
    retriever: modernSCM([
        $class: 'GitSCMSource',
        credentialsId: 'jenkins-integration-with-github-account',
        remote: 'git@github.com:zextras/jenkins-lib-common.git',
    ])
)

dt3_pipeline(
    repoName: 'carbonio-tasks-db',
    packaging: [
        pkgbuildPath: 'package/PKGBUILD',
        ubuntuSinglePkg: false,
        rockySinglePkg: false,
    ],
    reuse: [projectType: 'CE'],
)
