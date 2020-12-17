
.ONESHELL:
SHELL=/bin/bash

#################################################################################
# GLOBALS                                                                       #
#################################################################################

CONDA_BASE=$(shell conda info --base)
CONDA_ENVIRONMENT = 2020-scipy-india

#################################################################################
# COMMANDS                                                                      #
#################################################################################

## Set up python interpreter environment
environment:
	conda env create -f environment.yml

## Update the environment in case of changes to dependencies
environment-update:
	mamba env update --name $(CONDA_ENVIRONMENT) --file environment.yml

## Install notebook kernel manually
kernel:
	@source "$(CONDA_BASE)/bin/activate" $(CONDA_ENVIRONMENT);\
	python -m ipykernel install --name $(CONDA_ENVIRONMENT) --user

## Initialize a git repository
git:
	git init


## Run notebooks
notebooks:
	@source "$(CONDA_BASE)/bin/activate" $(CONDA_ENVIRONMENT);\
	jupyter nbconvert --to notebook --execute --inplace --ExecutePreprocessor.timeout=-1 --ExecutePreprocessor.kernel_name=$(CONDA_ENVIRONMENT) notebooks/*.ipynb;

clear-notebooks:
	@source "$(CONDA_BASE)/bin/activate" $(CONDA_ENVIRONMENT);\
	jupyter nbconvert --ClearOutputPreprocessor.enabled=True --clear-output --ExecutePreprocessor.kernel_name=$(CONDA_ENVIRONMENT) content/*.ipynb