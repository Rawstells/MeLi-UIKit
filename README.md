# MeLi-UIKit

## Installation
Run git clone to download proyect

```ruby
git clone https://github.com/Rawstells/MeLi-UIKit.git
```

#### Funcionalidades
- La pantalla principal cuenta con una barra de búsqueda, cuando se realiza la búsqueda se realiza el llamado al servicio de manera automática.
- La pantalla principal consta de un listado de productos traídos de la API de Mercado Libre.
- Cuando se selecciona un producto se va al detalle del producto
- La pantalla del detalle cuenta con un botón de ver más, esté lleva a un web view con el sitio web del producto en mercado libre.
- Se muestra mensaje de error cuando el servicio falla o no hay conexión a internet.
- Hay un loading que se muestra cada vez que se hace la petición al servicio web.

#### Funcionalidades técnicas:
- La aplicación está desarrollada en Swift 5, con UIKit, Async/Await y Combine.
- La aplicación tiene cómo patron de diseño arquitectónico MVVM.
- La aplicación usa programación reactiva (Combine).
- La aplicación implementa diferentes patrones de diseño (Repository, Factory entre otros).
- La aplicación no usa librerías de terceros.
- La aplicación usa una capa genérica con URLSession para hacer los llamados a los servicios.  
- La aplicación usa Codable para el mapeo de JSON a objetos. 
- La aplicación contiene un .gitignore para no subir archivos innecesarios.

#### Arquitectura
Se implementó MVVM como arquitectura, con las siguientes capas:
1) View: Contiene las View de UIKit
2) Presentation: Contiene los ViewModels
4) Model: Contiene las entidades
5) Repository: Contiene el patrón repository para obtener los datos de una API
