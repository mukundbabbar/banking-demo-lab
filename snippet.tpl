<script charset="UTF-8" type="text/javascript">
window['adrum-start-time'] = new Date().getTime();
(function(config){
    config.appKey = "${APPDYNAMICS_RUM_APP_KEY}";
    config.adrumExtUrlHttp = "http://cdn.appdynamics.com";
    config.adrumExtUrlHttps = "https://cdn.appdynamics.com";
    config.beaconUrlHttp = "http://${APPDYNAMICS_RUM_BEACON_URL}";
    config.beaconUrlHttps = "https://${APPDYNAMICS_RUM_BEACON_URL}";
    config.useHTTPSAlways = true;
    config.resTiming = {"bufSize":200,"clearResTimingOnBeaconSend":true};
    config.maxUrlLength = 512;
})(window['adrum-config'] || (window['adrum-config'] = {}));
</script>
<script src="//cdn.appdynamics.com/adrum/adrum-${APPDYNAMICS_RUM_JS_VERSION}.js"></script>