default: install install-dev

# Show summary of make commands.
h help:
	@echo 'Print lines that are not indented (targets and comments) or empty, plus any indented echo lines.'
	@egrep '(^\S)|(^$$)|\s+@echo' Makefile


install:
	python -m pip install --upgrade pip
	pip install -r requirements.txt

install-dev:
	pip install -r requirements-dev.txt


# Apply Black formatting to Python files.
fmt:
	black .
# Print diff only.
fmt-diff:
	black --diff .
# Return error code if any changes are needed.
fmt-check:
	black --check .


# Lint with flake8.
flint:
	# Stop the build if there are Python syntax errors or undefined names.
	flake8 . --count --select=E9,F63,F7,F82 --show-source --statistics
	# Exit-zero treats all errors as warnings. The GitHub editor is 127 chars wide.
	flake8 . --count --exit-zero --max-complexity=10 --max-line-length=127 --statistics

# Lint with Pylint.
# Don't do in root otherwise it does venv.
pylint:
	pylint twitterlib

lint: flint pylint


# TODO: How do not get error on dir? for now cd. what args?
sort:
	cd twitterlib && isort
