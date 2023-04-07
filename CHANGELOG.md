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
