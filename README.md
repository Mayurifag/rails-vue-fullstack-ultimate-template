# Rails/Vue full-stack template to use ideas from

![Build Status][build-badger]
[![License: LGPL v3][license-badger]][license-link]
<!-- TODO: make readme -->

## Description

The best template for Rails/Vue.js stack you may find somewhere, but I am just
too lazy to write about all the features right now.

### Prerequisites

To start development server you need latest stable versions of `git`, `docker`,
`docker-compose` and [dip][dip-link] installed.

### How to start

Do not use it. Better regenerate frontend folder via `Vite` or something and
copy docker configuration, etc.

### Entry points

* Frontend: [localhost:3333][frontend-localhost]

* Backend: [localhost:8888][backend-localhost]

## Tests

### Rspec

Just use `dip rspec` to launch `rspec` and get the spec coverage from
`simplecov`.

### Parallel tests for RSpec

If you want to use all the cores of your CPU for API specs, you may use
`make parallel`. Its not profitable due to small number of specs, though.

### Cypress

There are simple end-to-end tests, you may launch them with `make cypress`.

[build-badger]: https://github.com/Mayurifag/rails-api-vue-frontend-cypress-docker-template/workflows/CI/badge.svg
[maitainability-badger]: https://api.codeclimate.com/v1/badges/1d95ce316920a6a8228b/maintainability
[license-badger]: https://img.shields.io/badge/License-LGPL%20v3-gree.svg
[license-link]: https://www.gnu.org/licenses/lgpl-3.0
[dip-link]: https://github.com/bibendi/dip
[frontend-localhost]: http://localhost:3333
[backend-localhost]: http://localhost:8888

<!-- TODO: https://web.dev/sign-in-form-best-practices/ -->
