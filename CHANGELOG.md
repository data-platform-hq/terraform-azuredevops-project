## [1.5.4](https://github.com/data-platform-hq/terraform-azuredevops-project/compare/v1.5.3...v1.5.4) (2024-07-29)


### Bug Fixes

* added security KICS scan action ([6c42941](https://github.com/data-platform-hq/terraform-azuredevops-project/commit/6c429419a25bd714f908300cf06e5d0ef0ca8f42))
* corrected documentation.yml location ([3852b7e](https://github.com/data-platform-hq/terraform-azuredevops-project/commit/3852b7ed27d17e473a19b2d7232bfe1641c85906))
* replaced pre-commit repo docs creation/update by GH Actions ([fcb36dd](https://github.com/data-platform-hq/terraform-azuredevops-project/commit/fcb36dde3595b3a26ac44e7cd2cd29f9e6ec4eef))
* support feed creation ([7531d06](https://github.com/data-platform-hq/terraform-azuredevops-project/commit/7531d061c3df6a07ab49f819722a14aacb1b513d))

## [1.5.3](https://github.com/data-platform-hq/terraform-azuredevops-project/compare/v1.5.2...v1.5.3) (2024-02-23)


### Bug Fixes

* build service name fix ([c5d9555](https://github.com/data-platform-hq/terraform-azuredevops-project/commit/c5d9555d720bfd71981ea4c7a5affe09fc9de275))
* removed unused data ([ea6759a](https://github.com/data-platform-hq/terraform-azuredevops-project/commit/ea6759ad63fedd71dc7b6a18840d3c566eac9e26))
* version update ([08b6156](https://github.com/data-platform-hq/terraform-azuredevops-project/commit/08b61564a3a6ec00a50fec15e108302eeee580ce))

## [1.5.2](https://github.com/data-platform-hq/terraform-azuredevops-project/compare/v1.5.1...v1.5.2) (2024-01-06)


### Bug Fixes

* builder service permissions support ([2af2534](https://github.com/data-platform-hq/terraform-azuredevops-project/commit/2af25346f9806021f802921e0186a09ab24bc7d9))

## [1.5.1](https://github.com/data-platform-hq/terraform-azuredevops-project/compare/v1.5.0...v1.5.1) (2023-11-28)


### Bug Fixes

* service connection name output updated to nonsensitive ([2ff7468](https://github.com/data-platform-hq/terraform-azuredevops-project/commit/2ff74688b56996622490fdafc66a32cfd8a5f2c5))

# [1.5.0](https://github.com/data-platform-hq/terraform-azuredevops-project/compare/v1.4.1...v1.5.0) (2023-09-18)


### Features

* pipeline definitions support ([b436561](https://github.com/data-platform-hq/terraform-azuredevops-project/commit/b4365610bfaee4b7a00359f5190d42b13c4d0b60))

## [1.4.1](https://github.com/data-platform-hq/terraform-azuredevops-project/compare/v1.4.0...v1.4.1) (2023-07-25)


### Bug Fixes

* update vars ([f7bd03b](https://github.com/data-platform-hq/terraform-azuredevops-project/commit/f7bd03b7145077ba21727d5dd5f01290d3967e40))

# [1.4.0](https://github.com/data-platform-hq/terraform-azuredevops-project/compare/v1.3.2...v1.4.0) (2023-07-24)


### Features

* self hosted agent pool ([8af92b4](https://github.com/data-platform-hq/terraform-azuredevops-project/commit/8af92b4d3ca48df084f71fea5ff4332165a4eec7))

## [1.3.2](https://github.com/data-platform-hq/terraform-azuredevops-project/compare/v1.3.1...v1.3.2) (2023-06-26)


### Bug Fixes

* added nonsensitive func to secrets for successful for_each ([11afc5d](https://github.com/data-platform-hq/terraform-azuredevops-project/commit/11afc5de4a90b0a04ac1489ddf085555a767d7a8))
* switched to local variable ([a867307](https://github.com/data-platform-hq/terraform-azuredevops-project/commit/a8673072fe72e7693ae614cdc093b32c41be0961))

## [1.3.1](https://github.com/data-platform-hq/terraform-azuredevops-project/compare/v1.3.0...v1.3.1) (2023-06-22)


### Bug Fixes

* var group condition ([5524c5b](https://github.com/data-platform-hq/terraform-azuredevops-project/commit/5524c5b7774907f1cd418b706eff2a8d614671b9))

# [1.3.0](https://github.com/data-platform-hq/terraform-azuredevops-project/compare/v1.2.0...v1.3.0) (2023-04-07)


### Features

* added variable_group lifecycle to ignore changes in variables ([9981c70](https://github.com/data-platform-hq/terraform-azuredevops-project/commit/9981c7092f7ee839117bb7a790f6de77ee0ea160))

# [1.2.0](https://github.com/data-platform-hq/terraform-azuredevops-project/compare/v1.1.0...v1.2.0) (2023-03-24)


### Bug Fixes

* fixed variable validation ([ed4806e](https://github.com/data-platform-hq/terraform-azuredevops-project/commit/ed4806ebdd59084d6781d38b2d8f242dc2ac83c1))


### Features

* added service endpoint environment argument ([f7c9d09](https://github.com/data-platform-hq/terraform-azuredevops-project/commit/f7c9d09fc2a40353e922cb3098021d3e7361ac30))
* updated provider version, added environment argument for service connection ([62e6153](https://github.com/data-platform-hq/terraform-azuredevops-project/commit/62e615312cc2d0cefc4321d87705796779a0f001))

# [1.1.0](https://github.com/data-platform-hq/terraform-azuredevops-project/compare/v1.0.0...v1.1.0) (2023-03-23)


### Features

* added creation of multiple service connections, added boolean flag to disable service endpoint creation, moved custom service endpoint name to service endpoint args ([707b156](https://github.com/data-platform-hq/terraform-azuredevops-project/commit/707b156a058d9c857e411de08a63fd4700ebb69e))
* changed default service connection name to format {subscription_name}({service_principal_id}) ([9009184](https://github.com/data-platform-hq/terraform-azuredevops-project/commit/90091840b8004e5bae3ac0ae6d9a7a1441d8b00f))

# 1.0.0 (2023-03-14)


### Bug Fixes

* fixed formatting ([d4cd202](https://github.com/data-platform-hq/terraform-azuredevops-project/commit/d4cd202a1d7d25d2a70cfdc04ea2d460873f8de1))
* removed unused tags var ([14f3f67](https://github.com/data-platform-hq/terraform-azuredevops-project/commit/14f3f673c6830d643eafb0a433bca34bc81c369a))


### Features

* added ADO project .tf files ([98ce166](https://github.com/data-platform-hq/terraform-azuredevops-project/commit/98ce1664f1303119ee509e30a80dc2e1fae2c4e6))
* added condition for var group creation ([c241caf](https://github.com/data-platform-hq/terraform-azuredevops-project/commit/c241caf8d6bd18cd7171266e99baa0a3d91a08ba))
* added empty lines after count ([1eccf62](https://github.com/data-platform-hq/terraform-azuredevops-project/commit/1eccf6268872f5b40c548de298aeb92cb9a1036a))
* moved name variables to locals ([a5f26c4](https://github.com/data-platform-hq/terraform-azuredevops-project/commit/a5f26c44adee181283fb94ace6d996a95f01a244))
* non secret value for variables in variable group ([8cee289](https://github.com/data-platform-hq/terraform-azuredevops-project/commit/8cee2894f53117312aeb3e975926afe5604f718f))
