// Staging environment
local app = import "apachefriends.jsonnet";

app {
  host: "www.apachefriends.k.int.bitnami.net",
  stage: "staging",
  cert_provider:: "cm-dns",
  items_+: {
    ingress+: {
      local ing = self,
      metadata+: {
        annotations+:{
          "nginx.ingress.kubernetes.io/from-to-www-redirect": "true",
          "nginx.ingress.kubernetes.io/configuration-snippet": |||
            if ($host ~ ^(.+)?xampp\.k\.int\.bitnami\.net$) {
              return 301 https://www.apachefriends.k.int.bitnami.net$request_uri;
            }
            if ($host = 'apachefriends.k.int.bitnami.net' ) {
              return 301 https://www.apachefriends.k.int.bitnami.net$request_uri;
            }
          |||
        },
      },
      spec+: {
        rules+: [
          {
            host: "apachefriends.k.int.bitnami.net",
            http: {
              paths: ing.paths
            },
          },
          {
            host: "www.xampp.k.int.bitnami.net",
            http: {
              paths: ing.paths
            },
          },
          {
            host: "xampp.k.int.bitnami.net",
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

