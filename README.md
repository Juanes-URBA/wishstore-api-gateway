# WishStore API Gateway

API Gateway del proyecto **WishStore**, desarrollado con Spring Cloud Gateway. Es el punto de entrada único de toda la aplicación: el frontend Angular nunca se comunica directamente con los microservicios, siempre pasa a través de este Gateway.

## Integrante

- **Juan Esteban Urrego** — Líder del API Gateway

## Arquitectura


El Gateway se limita a **recibir solicitudes y redireccionarlas** hacia el microservicio correspondiente según el path de la URL. No contiene lógica de negocio, base de datos, ni comunicación entre microservicios.

## Tecnologías

| Tecnología | Versión |
|---|---|
| Java | 21 |
| Spring Boot | 3.5.11 |
| Spring Cloud Gateway | 2025.0.2 (Server WebFlux) |
| Maven | (via Maven Wrapper) |
| Docker | Multi-stage build |

## Dependencias utilizadas

- `spring-cloud-starter-gateway-server-webflux`
- `spring-boot-starter-webflux`
- `spring-boot-starter-actuator`
- `lombok`

> El proyecto **no** utiliza Spring Data JPA, bases de datos, OpenFeign, Spring MVC, Security ni JWT. El Gateway solo enruta peticiones.

## Rutas configuradas

| ID | Path | Destino |
|---|---|---|
| `catalog-service` | `/api/products/**` | `http://localhost:8081` |
| `wishlist-service` | `/api/wishlist/**` | `http://localhost:8082` |
| `history-service` | `/api/history/**` | `http://localhost:8083` |

## CORS

El Gateway permite peticiones únicamente desde el frontend Angular:

- **Origen permitido:** `http://localhost:4200`
- **Métodos permitidos:** GET, POST, PUT, DELETE, PATCH
- **Headers:** todos (`*`)
- **Credenciales:** habilitadas

## Health Check

El Gateway expone un endpoint de salud v ía Spring Boot Actuator: