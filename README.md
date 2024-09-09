# 🔐 Script de Fuerza Bruta con `rsync`

Este script de Bash realiza un ataque de fuerza bruta contra un servidor `rsync` utilizando una lista de palabras para identificar carpetas o archivos en el servidor. El script prueba cada palabra del diccionario, mostrando los resultados de `rsync` cuando encuentra una coincidencia válida. Además, permite salir del script limpiamente con `Ctrl+C`.

## 🚀 Características

- **💥 Manejo de Ctrl+C:** El script puede interrumpirse con `Ctrl+C`, deteniendo el proceso de forma segura.
- **📂 Pruebas con `rsync`:** Prueba una lista de palabras contra un servidor `rsync`, buscando carpetas o archivos accesibles.
- **🔍 Validación de Parámetros:** Asegura que tanto la dirección IP como el diccionario sean proporcionados, y verifica si el archivo del diccionario existe.

## 💡 Uso

```bash
./rsync_brute_force.sh -i <ip> -w <wordlist>
```

- `-i <ip>`: Dirección IP del servidor `rsync` objetivo.
- `-w <wordlist>`: Ruta al archivo con la lista de palabras a probar.

### 🌟 Ejemplo:

```bash
./rsync_brute_force.sh -i 192.168.1.100 -w /ruta/a/diccionario.txt
```

## 🔑 Recomendaciones sobre Diccionarios

- Utiliza diccionarios optimizados para descubrir directorios y archivos. Algunos ejemplos de diccionarios recomendados son:
  - **SecLists**: Proyectos como [SecLists](https://github.com/danielmiessler/SecLists) contienen listas de directorios comunes que pueden ser útiles.
  - **FuzzDB**: Otro recurso útil es [FuzzDB](https://github.com/fuzzdb-project/fuzzdb), que ofrece listas para ataques de fuerza bruta en diversas aplicaciones.
- **Filtro de palabras especiales**: Es recomendable limpiar tu diccionario eliminando palabras que contengan caracteres que `rsync` no soporte para este tipo de ataque.

### ❗ Caracteres No Soportados por `rsync`

Al realizar el ataque de fuerza bruta, ten en cuenta que `rsync` no puede manejar correctamente los siguientes caracteres especiales en las palabras del diccionario:

- Espacios (` `)
- Asteriscos (`*`)
- Comillas simples (`'`)
- Comillas dobles (`"`)
- Carácter de retroceso o barra invertida (`\`)

Si tu diccionario contiene palabras con estos caracteres, el ataque podría fallar o generar errores inesperados.

## 🛠️ Salida

- Muestra la dirección IP del servidor y el nombre del diccionario de palabras utilizado.
- Indica el número total de palabras que serán probadas.
- Para cada palabra, intenta listar el contenido de la carpeta en el servidor `rsync`. Si encuentra una coincidencia válida, muestra la palabra y el resultado de la operación.
- Si no se encuentra ninguna coincidencia, indica que no se encontró ninguna carpeta o archivo accesible.


## 🛡️ Ejemplo de Ejecución

```bash
[+] Target IP: 192.168.1.100
[+] Wordlist: diccionario.txt
[+] Total number of words in the wordlist: 5000

[-] Testing word: backup
[-] Testing word: public
[-] Testing word: confidential
[+] Password found: public

[+] Output:
rsync://192.168.1.100/public/
    -rw-r--r--  1 user group 1234 Jan 1 12:00 file.txt
```

## 📋 Licencia

Este proyecto está bajo la [Licencia MIT](LICENSE).

---

### Autor: [1NCO6N1TO](https://github.com/1NCO6N1TO)

---


