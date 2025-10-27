#  Menu de gestion de carpetas en PowerShell

##  Descripcion

Este script en **PowerShell** permite **gestionar carpetas dentro de un workspace local** de forma interactiva.  
Crea un menu con opciones para **crear, listar, renombrar y eliminar carpetas**, todo dentro de una carpeta de trabajo controlada.

---

##  Funcionamiento general

- Al iniciar, el script crea (si no existe) una carpeta de trabajo en:

## C:\tmp\tp_carpetas_$env:UserName

donde `$env:UserName` corresponde al nombre del usuario actual de Windows.

- Dentro de ese workspace se realizan todas las operaciones de forma segura y aislada.

---

##  Comandos usados

| Cmdlet | Funcion principal |
|:--------|:------------------|
| `New-Item` | Crear nuevas carpetas |
| `Get-ChildItem` | Listar carpetas existentes |
| `Rename-Item` | Renombrar carpetas |
| `Remove-Item` | Eliminar carpetas |

---

## Logica del menu

El script usa estructuras de control basicas para mantener el menu interactivo:

- `while ($true)` = mantiene el menu en ejecucion hasta que el usuario elige salir.  
- `switch ($op)` = selecciona que bloque ejecutar segun la opcion elegida.  
- `Read-Host` = lee la entrada del usuario desde la consola.

---

## Opciones disponibles



| 1 | Crear carpeta | Pide un nombre y crea una nueva carpeta dentro del workspace. |
| 2 | Listar carpetas | Muestra todas las carpetas actuales. |
| 3 | Renombrar carpeta | Cambia el nombre de una carpeta existente. |
| 4 | Eliminar carpeta | Borra una carpeta (vacia o con confirmacion si tiene contenido). |
| 5 | Salir | Finaliza el programa limpiamente. |

---

## Validaciones y seguridad

- Se evita el uso de nombres vacios o peligrosos (`/`, `\`, `..`).
- Se muestran mensajes claros en caso de error:
- Carpeta ya existente.
- Carpeta no encontrada.
- Carpeta no vacia (con opcion a forzar eliminacion).
- Se usa el workspace para evitar modificar otras areas del sistema.

---

## Ejecucion

1. Guardar el script con el nombre `menu_carpetas.ps1`.
2. Abrir PowerShell y navegar hasta el directorio donde se encuentra el archivo.
3. Ejecutar:

 ```powershell
 ./menu_carpetas.ps1


