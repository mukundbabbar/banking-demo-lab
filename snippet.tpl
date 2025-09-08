<script charset="UTF-8" type="text/javascript">
    window['adrum-start-time'] = new Date().getTime();

    // Initialize config object first
    window["adrum-config"] = window["adrum-config"] || {};

    // Extend with userEventInfo (add-on, not overwrite)
    window["adrum-config"].userEventInfo = {
        Ajax: function(context) {
            console.log("Checking...");
            if (!context.url.includes("WebFrontEnd/pgp")) {
                console.log("URL does not match pattern. Exiting.");
                return;
            }

            console.log("CALL DETECTED");
            const parsedUrl = new URL(context.url);
            const appId = parsedUrl.searchParams.get("appId");
            const amount = parsedUrl.searchParams.get("loanAmount");
            console.log(appId);
            console.log(amount);

            return {
                userData: {
                    appId: appId,
                    loanAmount: amount,
                    amt: 1000
                }
            };
        }
    };

    // Additional agent config
    (function(config) {
        config.appKey = "${APPDYNAMICS_RUM_APP_KEY}";
        config.adrumExtUrlHttp = "http://cdn.appdynamics.com";
        config.adrumExtUrlHttps = "https://cdn.appdynamics.com";
        config.beaconUrlHttp = "http://${APPDYNAMICS_RUM_BEACON_URL}";
        config.beaconUrlHttps = "https://${APPDYNAMICS_RUM_BEACON_URL}";
        config.useHTTPSAlways = true;
        config.resTiming = {
            bufSize: 200,
            clearResTimingOnBeaconSend: true
        };
        config.maxUrlLength = 512;
        config.spa = {
            spa2: true
        };
    })(window["adrum-config"]);

    console.log("AGENT CONFIGURED");
</script>

<!-- Load the agent last -->
<script src="//cdn.appdynamics.com/adrum/adrum-${APPDYNAMICS_RUM_JS_VERSION}.js"></script>
