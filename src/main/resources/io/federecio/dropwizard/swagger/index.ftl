
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Swagger UI</title>
  <link rel="icon" type="image/png" href="${swaggerAssetsPath}/images/favicon.ico" />
  <link href='${swaggerAssetsPath}/css/typography.css' media='screen' rel='stylesheet' type='text/css'/>
  <link href='${swaggerAssetsPath}/css/reset.css' media='screen' rel='stylesheet' type='text/css'/>
  <link href='${swaggerAssetsPath}/css/screen.css' media='screen' rel='stylesheet' type='text/css'/>
  <link href='${swaggerAssetsPath}/css/reset.css' media='print' rel='stylesheet' type='text/css'/>
  <link href='${swaggerAssetsPath}/css/print.css' media='print' rel='stylesheet' type='text/css'/>
  <script src='${swaggerAssetsPath}/lib/jquery-1.8.0.min.js' type='text/javascript'></script>
  <script src='${swaggerAssetsPath}/lib/jquery.slideto.min.js' type='text/javascript'></script>
  <script src='${swaggerAssetsPath}/lib/jquery.wiggle.min.js' type='text/javascript'></script>
  <script src='${swaggerAssetsPath}/lib/jquery.ba-bbq.min.js' type='text/javascript'></script>
  <script src='${swaggerAssetsPath}/lib/handlebars-2.0.0.js' type='text/javascript'></script>
  <script src='${swaggerAssetsPath}/lib/underscore-min.js' type='text/javascript'></script>
  <script src='${swaggerAssetsPath}/lib/backbone-min.js' type='text/javascript'></script>
  <script src='${swaggerAssetsPath}/swagger-ui.js' type='text/javascript'></script>
  <script src='${swaggerAssetsPath}/lib/highlight.7.3.pack.js' type='text/javascript'></script>
  <script src='${swaggerAssetsPath}/lib/jsoneditor.min.js' type='text/javascript'></script>
  <script src='${swaggerAssetsPath}/lib/marked.js' type='text/javascript'></script>
  <script src='${swaggerAssetsPath}/lib/swagger-oauth.js' type='text/javascript'></script>

  <!-- Some basic translations -->
  <!-- <script src='${swaggerAssetsPath}/lang/translator.js' type='text/javascript'></script> -->
  <!-- <script src='${swaggerAssetsPath}/lang/ru.js' type='text/javascript'></script> -->
  <!-- <script src='${swaggerAssetsPath}/lang/en.js' type='text/javascript'></script> -->

  <script type="text/javascript">
    $(function () {
      // Pre load translate...
      if(window.SwaggerTranslator) {
        window.SwaggerTranslator.translate();
      }
      window.swaggerUi = new SwaggerUi({
        url: "${contextPath}/swagger.json",
        <#if validatorUrl??>
        validatorUrl: "${validatorUrl}",
        <#else>
        validatorUrl: null,
        </#if>
        dom_id: "swagger-ui-container",
        supportedSubmitMethods: ['get', 'post', 'put', 'delete', 'patch'],
        onComplete: function(swaggerApi, swaggerUi){
          if(typeof initOAuth == "function") {
          /*  DIL commented out as before
            initOAuth({
              clientId: "your-client-id",
              clientSecret: "your-client-secret-if-required",
              realm: "your-realms",
              appName: "your-app-name", 
              scopeSeparator: ",",
              additionalQueryStringParams: {}
            });
          */
          }

          if(window.SwaggerTranslator) {
            window.SwaggerTranslator.translate();
          }

          $('pre code').each(function(i, e) {
            hljs.highlightBlock(e)
          });

          addApiKeyAuthorization();
        },
        onFailure: function(data) {
          log("Unable to Load SwaggerUI");
        },
        docExpansion: "none",
        jsonEditor: false,
        apisSorter: "alpha",
        defaultModelRendering: 'schema',
        showRequestHeaders: false
      });

      function addApiKeyAuthorization(){
        var key = encodeURIComponent($('#input_accessToken')[0].value);
        if(key && key.trim() != "") {
            var apiKeyAuth = new SwaggerClient.ApiKeyAuthorization("api_key", key, "query");
            window.swaggerUi.api.clientAuthorizations.add("api_key", apiKeyAuth);
            log("added key " + key);
        }
      }

      /* DIL added as before in dropwizard-swagger */
      function addAuthorizationHeader() {
        var key = $('#input_authHeader')[0].value;
        if(key && key.trim() != "") {
            var headerAuth = new SwaggerClient.ApiKeyAuthorization("Authorization", key, "header");
            window.swaggerUi.api.clientAuthorizations.add("Custom Authorization", headerAuth);
            log("added key " + key);
        }
      }
      /* end DIL */

      $('#input_accessToken').change(addApiKeyAuthorization);

      /* DIL added as before in dropwizard-swagger */
      $('#input_authHeader').change(addAuthorizationHeader);
      $('#input_headerSelect').change(function() {
        var toShow = $( this ).val();
        $('#header_'+toShow).show();
        var toHide = (Number(toShow)+1)%2;
        $('#header_'+toHide).hide();
      });
      /* end DIL */

      // if you have an apiKey you would like to pre-populate on the page for demonstration purposes...
      /*
        var apiKey = "myApiKeyXXXX123456789";
        $('#input_accessToken').val(apiKey);
      */

      window.swaggerUi.load();

      function log() {
        if ('console' in window) {
          console.log.apply(console, arguments);
        }
      }
  });
  </script>
</head>

<body class="swagger-section">
<div id='header'>
  <div class="swagger-ui-wrap">
    <img src="${swaggerAssetsPath}/images/logo.png"/>
    <form id='api_selector'>
      <div class='input'>
        <input placeholder="http://example.com/api" id="input_baseUrl" name="baseUrl" type="text"/>
      </div>
      <div class='input' id="header_0">
        <input placeholder="Access Token" id="input_accessToken" name="accessToken" type="text"/>
      </div>
      <div class='input'>
        <a id="explore" href="#" data-sw-translate>Explore</a>
      </div>
    </form>
  </div>
</div>

<div id="message-bar" class="swagger-ui-wrap" data-sw-translate>&nbsp;</div>
<div id="swagger-ui-container" class="swagger-ui-wrap"></div>
</body>
</html>
