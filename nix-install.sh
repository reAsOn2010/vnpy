#!/usr/bin/env bash

python=$1
pypi_index=$2
shift 2

[[ -z $python ]] && python=python3
[[ -z $pypi_index ]] && pypi_index=https://pypi.vnpy.com

$python -m pip install --upgrade pip wheel --index $pypi_index

# ta-lib and ta-lib-python is managed by nix
$python -m pip install ta-lib==0.6.3

# Install VeighNa
$python -m pip install . --index $pypi_index
