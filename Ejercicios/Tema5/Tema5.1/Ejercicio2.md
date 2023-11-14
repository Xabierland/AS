# Ejercicio 2

## Crear un repositorio con un fichero de codigo Python

```python
def suma(a,b):
    return a+b
a=5
b=6
print(suma(a,b))
```

## Crear un worklow

```yaml
name: Prueba Python

on: push

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

## Comprobar el resultado
