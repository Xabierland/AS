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
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Instalar dependencia
        run: pip install pytest
      - name: Ejecutar pruebas
        run: pytest test.py

```

## Introducir un fallo en el código
