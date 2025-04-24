resource "helm_release" "nginx_ingress" {
  name = "nginx-ingress-controller"

  repository = "https://helm.nginx.com/stable"
  chart      = "nginx-ingress"

  create_namespace = true
  namespace        = "ingress-controller"

}

resource "helm_release" "cert_manager" {
  name = "cert-manager"

  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"

  create_namespace = true
  namespace        = "cert-manager"

  set {
    name  = "installCRDs"
    value = true
  }

  values = [
    file("helm-values/certmanager.yml")
  ]

}

