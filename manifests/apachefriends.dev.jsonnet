// Development environment
local app = import "apachefriends.jsonnet";

app {
  host: "www.apachefriends.k.dev.bitnami.net",
  stage: "development",
  items_+: {
    ingress+: {
      local ing = self,
      metadata+: {
        annotations+:{
          "nginx.ingress.kubernetes.io/from-to-www-redirect": "true",
          "nginx.ingress.kubernetes.io/configuration-snippet": |||
            if ($host ~ ^(.+)?xampp\.k\.dev\.bitnami\.net$) {
              return 301 https://www.apachefriends.k.dev.bitnami.net$request_uri;
            }
            if ($host = 'apachefriends.k.dev.bitnami.net' ) {
              return 301 https://www.apachefriends.k.dev.bitnami.net$request_uri;
            }
          |||
        },
      },
      spec+: {
        rules+: [
          {
            host: "apachefriends.k.dev.bitnami.net",
            http: {
              paths: ing.paths
            },
          },
          {
            host: "www.xampp.k.dev.bitnami.net",
            http: {
              paths: ing.paths
            },
          },
          {
            host: "xampp.k.dev.bitnami.net",
            http: {
              paths: ing.paths
            },
          },
        ],
      },
    },
  },
  cpu: "1m",
  cpuLimit: "2m",
  memory: "5Mi",
  memoryLimit: "30Mi"
}
