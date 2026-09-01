// SPDX-FileCopyrightText: 2023 Zextras <https://www.zextras.com>
//
// SPDX-License-Identifier: AGPL-3.0-only

library(
    identifier: 'jenkins-lib-common@v4.10.2',
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
        buildFlags: '-ds',
        ubuntuSinglePkg: false,
        rockySinglePkg: false,
    ],
    docker: [[
        dockerfile: 'docker/tasks-db-sidecar/Dockerfile',
        imageName: 'carbonio-tasks-db-sidecar',
        platforms: ['linux/amd64', 'linux/arm64'] as Set,
        title: 'Carbonio Tasks DB Sidecar',
        description: 'Carbonio Tasks DB sidecar service',
    ]],
    reuse: [projectType: 'CE']
)
