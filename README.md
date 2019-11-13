# Swagger-ui

## Swagger integration

* import `dropwizard-assets` and `leanix-swagger-ui` library into your microservice 
* initialize the swagger-ui servlet  


Add dependencies into your project with latest version of leanix-swagger-ui:

```
        <dependency>
            <groupId>net.leanix</groupId>
            <artifactId>leanix-swagger-ui</artifactId>
            <version>0.1.10-SNAPSHOT</version>
        </dependency>
        <dependency>
            <groupId>io.dropwizard</groupId>
            <artifactId>dropwizard-assets</artifactId>
        </dependency>
```


Inside your microservice, add the assets and initialize the servlet, which serves the frontend.

EG, use the provided `ApiDocsAssetServlet` helper class and add this method inside your dropwizard `App` class:

```java
    /**
     * Adds the swagger servlet for serving swagger.json and swagger UI.
     * @param environment The dropwizard {@linkplain Environment}
     */
    private void addSwaggerServlet(Environment environment) {
        // add the servlet for static swagger UI assets (need to put leanix-swagger-ui into the classpath)
        new AssetsBundle("/swagger", "/docs", "index.html", "swagger").run(environment);

        // add the servlet serving the swagger definitions file (swagger.json)
        // swagger.json must be generated at service build time (with kong chen plugin)

        environment.servlets().addServlet(
            "api-docs",
            new ApiDocsAssetServlet("/swagger-assets", "/api-docs", "swagger.json", Charsets.UTF_8, "configureMeIfNeeded"))
            .addMapping("/api-docs/*");
    }
```
