# Ecomap

Proyecto semestral, Segundo Semestre 2019.
Diseño de Aplicaciones Web y Móviles, TEL-335.

![](https://matisanh.cl/stuff/LogoEcomap128x130.png)


Requisitos
----------

Instalaciones necesarias para el proyecto:

+ Node js
+ Mongo db
+ Dart SDK
+ Flutter SDK
+ android studio
+ vscode con plugins de flutter y dart

Despliegue del Servidor
-----------------------

+ Correr mongod en una consola, mantenerla abierta para que este la base de datos funcionando
+ abrir el proyecto en vscode
+ En caso de que se haya descargado la carpeta node_modules, borrarla y ejecutar "npm install" en una consola
+ Una vez que se haya terminado, ejecutar npm run dev, esto monta el servidor y lo reinicia cada vez que se hace un cambio en el codigo.

Ejecutar aplicacion
-------------------

+ Se debe crear un dispositivo android virtual con la herramienta SDV manager, con android nougat minimo
+ Ejecutar flutter clean en una terminal para borrar el caché de la build anterior
+ Es probable que vscode le pregunte si quiere descargar paquetes faltantes, a lo que se debe responder que si
+ Abrir el archivo main de la aplicacion
+ En la barra inferior donde dice Device, se debe apretar y seleccionar el dispositivo virtual creado, este se abrira en caso de estar cerrado
+ Con el archivo main abierto, apretar f5 y esperar a que la aplicacion se ejecute.