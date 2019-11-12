
## Swagger integration

* initialize the swagger-ui servlet  
* configure the maven swagger plugin to store the specs under /api-docs

Here is an example how to initialize the swagger ui inside the microservices:

```java
    /**
     * Adds the swagger servlet for serving swagger.json and swagger UI.
     * @param environment Environment
     */
    public void addSwaggerServlet(Environment environment) {
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
