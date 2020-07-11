.PHONY: all cypress parallel prodbuild yml report open-cov
CUR_DIR = $(pwd)

all: cypress

cypress:
		docker-compose --file docker-compose-e2e.yml build
		docker-compose --file docker-compose-e2e.yml up --abort-on-container-exit --exit-code-from e2e

parallel:
		RAILS_ENV=test dip rake parallel:setup
		dip spec

prodbuild:
		docker-compose --file docker-compose-e2e.yml up --build --abort-on-container-exit --exit-code-from prodbuild prodbuild

yml:
		docker run --rm -ti -v $(CUR_DIR):/workdir giantswarm/yamllint -d relaxed .

report:
		dip report
		xdg-open ./frontend/dist/report.html

open-cov:
		xdg-open ./backend/coverage/index.html
