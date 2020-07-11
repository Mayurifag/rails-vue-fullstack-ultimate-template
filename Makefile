.PHONY: all cypress parallel yml report open-cov
CUR_DIR = $(CURDIR)

all: cypress

cypress:
		docker build -t e2e-cypress-runner ./e2e/
		docker run --rm --name e2e -v $(CUR_DIR)/e2e/cypress:/app/cypress -v $(CUR_DIR)/e2e/cypress.json:/app/cypress.json -e CYPRESS_baseUrl=http://frontend:8080 --network application-network e2e-cypress-runner cypress run --browser chrome

parallel:
		RAILS_ENV=test dip rake parallel:setup
		dip spec

yml:
		docker run --rm -ti -v $(CUR_DIR):/workdir giantswarm/yamllint -d relaxed .

report:
		dip report
		xdg-open ./frontend/dist/report.html

open-cov:
		xdg-open ./backend/coverage/index.html
