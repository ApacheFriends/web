// Production environment
local app = import "apachefriends.jsonnet";

app {
  host: "www.apachefriends.org",
  stage: "production",
  replicas: 3,
  blackbox_monitoring: true,
  cert_provider:: "cm-dns",
  items_+: {
    ingress+: {
      local ing = self,
      metadata+: {
        annotations+:{
          "nginx.ingress.kubernetes.io/from-to-www-redirect": "true",
          "nginx.ingress.kubernetes.io/configuration-snippet": |||
            if ($host ~ ^(.+)?xampp\.org$) {
              return 301 https://www.apachefriends.org$request_uri;
            }
            if ($host = 'apachefriends.org' ) {
              return 301 https://www.apachefriends.org$request_uri;
            }
          |||
        },
      },
      spec+: {
        rules+: [
          {
            host: "apachefriends.org",
            http: {
              paths: ing.paths
            },
          },
          {
            host: "www.xampp.org",
            http: {
              paths: ing.paths
            },
          },
          {
            host: "xampp.org",
            http: {
              paths: ing.paths
            },
          },
        ],
      },
    },
  },
  cpu: "3m",
  cpuLimit: "7m",
  memory: "30Mi",
  memoryLimit: "70Mi"
}
