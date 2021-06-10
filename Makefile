.PHONY: default test clean all
default: test

# Installs pre-commit hooks
.PHONY: install-hooks
install-hooks:
	pre-commit install --install-hooks

.PHONY: test
test:
	pre-commit run --all-files

.PHONY: docker-build
docker-build:
	docker build . -t devenv-$(USER)
