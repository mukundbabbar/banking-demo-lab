//<script charset="UTF-8" type="text/javascript">
//window['adrum-start-time'] = new Date().getTime();
//(function(config){
//   config.appKey = "${APPDYNAMICS_RUM_APP_KEY}";
//    config.adrumExtUrlHttp = "http://cdn.appdynamics.com";
//    config.adrumExtUrlHttps = "https://cdn.appdynamics.com";
//    config.beaconUrlHttp = "http://${APPDYNAMICS_RUM_BEACON_URL}";
//    config.beaconUrlHttps = "https://${APPDYNAMICS_RUM_BEACON_URL}";
//    config.useHTTPSAlways = true;
//    config.resTiming = {"bufSize":200,"clearResTimingOnBeaconSend":true};
//    config.maxUrlLength = 512;
//})(window['adrum-config'] || (window['adrum-config'] = {}));
//</script>
//<script src="//cdn.appdynamics.com/adrum/adrum-${APPDYNAMICS_RUM_JS_VERSION}.js"></script>


<script charset="UTF-8" type="text/javascript">
window['adrum-start-time'] = new Date().getTime();
(function(config) {
    config.appKey = "${APPDYNAMICS_RUM_APP_KEY}";
    config.adrumExtUrlHttp = "http://cdn.appdynamics.com";
    config.adrumExtUrlHttps = "https://cdn.appdynamics.com";
    config.beaconUrlHttp = "http://${APPDYNAMICS_RUM_BEACON_URL}";
    config.beaconUrlHttps = "https://${APPDYNAMICS_RUM_BEACON_URL}";
    config.resTiming = {
        bufSize: 200,
        clearResTimingOnBeaconSend: true
    };
    config.maxUrlLength = 512;
    config.spa = {
        spa2: true
    };
})(window["adrum-config"] || (window["adrum-config"] = {}));

console.log("AGENT LOADED");

window["adrum-config"] = {
    userEventInfo: {
        Ajax: function(context) {
            if (!context.url.includes("WebFrontEnd/pgp")) {
                console.log("URL does not match pattern. Exiting.");
                return;
            }

            console.log("CALL DETECTED");

            const parsedUrl = new URL(context.url);
            const appId = parsedUrl.searchParams.get("appId");

            console.log(appId);

            return {
                userData: {
                    appId: appId,
                    amt: 1000
                }
            };
        }
    }
};
</script>
<script src="//cdn.appdynamics.com/adrum/adrum-${APPDYNAMICS_RUM_JS_VERSION}.js"></script>
