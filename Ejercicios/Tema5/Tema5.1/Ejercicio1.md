# Ejercicio 1

## Crear un repositorio

mkdir AS-Tema5.1-Ej1
git clone https://github.com/ulopeznovoa/AS-CI-CD-ej1

## Crear un workflow

```bash
mkdir .github/workflows
touch .github/workflows/main.yml
```

```yml
name: Prueba Python

on: push

jobs:
  test-python:
    runs-on: python:slim
    steps:
      - uses: actions/checkout@v2
      - name: Install dependencies
        run: pip install pytest
      - name: Run tests
        run: pytest test.py
```

## Introducir un fallo en el código
