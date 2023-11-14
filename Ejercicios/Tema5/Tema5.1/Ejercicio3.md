# Ejercicio 3

## Utilizar el repositorio 1

## Crear 2 workspaces

```yaml
name: Run Tests on Push

on:
  push:
    branches:
      - main

jobs:
  test:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v4
      - name: Instalar dependencia
        run: pip install pytest
      - name: Ejecutar pruebas
        run: pytest test.py
```

```yaml
name: Run tests on Pull Request

on: pull_request

jobs:
  test-python:
    runs-on: ubuntu-latest
    permissions:
      security-events: write
    steps:
      - uses: advanced-security/python-lint-code-scanning-action@v1
        with:
          linter: pylint
```

## Crear una nueva rama y añadir en el código

```python
class Wallet:
    def __init__(self, balance):
        self.balance = balance

    def set_balance(self, val):
        self.balance = self.balance + val

    def get_balance(self):
        return self.balance

    def remove_balance(self, val):
        self.balance = self.balance - val

    def set_balance1000(self):
        self.balance = 1000

```

```python	
from wallet import Wallet

def test_getbalance():
    obj = Wallet(0)
    obj.set_balance(20)
    assert obj.get_balance() == 20

def test_removebalance():
    obj = Wallet(50)
    obj.remove_balance(20)
    assert obj.get_balance() == 30

def test_setbalance():
    obj = Wallet(0)
    obj.set_balance(40)
    assert obj.get_balance() == 40

def test_setbalance1000():
    obj = Wallet(0)
    obj.set_balance1000()
    assert obj.get_balance() == 1000
```

## Hacer una Pull Request para juntar la rama con main
