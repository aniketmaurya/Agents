.PHONY: build-docs docsserve test coverage clean style push build publish-test publish-prod

build-docs:
	cp README.md docs/index.md

docsserve:
	mkdocs serve --dirtyreload --livereload

test:
	pytest

coverage:  ## Run tests with coverage
	coverage erase
	coverage run -m pytest
	coverage report -m
	coverage xml

clean:
	rm -rf dist
	find . -type f -name "*.DS_Store" -ls -delete
	find . | grep -E "(__pycache__|\.pyc|\.pyo)" | xargs rm -rf
	find . | grep -E ".pytest_cache" | xargs rm -rf
	find . | grep -E ".ipynb_checkpoints" | xargs rm -rf
	rm -f .coverage

style:
	ruff format src

push:
	git push && git push --tags

build:
	uv build
	echo "Checking dist directory contents:"
	ls -la dist || echo "dist directory does not exist or is empty"

publish-test: style clean build
	twine upload -r testpypi dist/*

publish-prod: style clean build
	twine upload dist/* --verbose
