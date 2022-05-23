// Submodule with the webdev.libsonnet library
local webdev = import "./lib/webdev.libsonnet";

// Define the static deployment
webdev.StaticSiteDeployment("apachefriends", "webdev") {
  namespace: "static-sites",
  image: std.extVar("DEPLOYMENT_IMAGE"),
  items_+: {
    deployment+: {
      spec+: {
        template+: {
          spec+:{
            containers_+: {
              app_container+: {
                livenessProbe+: {
                  httpGet+: {
                    path: "/index.html"
                  },
                },
              },
            },
          },
        },
      },
    },
  },
}
