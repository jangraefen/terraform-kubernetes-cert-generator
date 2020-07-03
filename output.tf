output "ca_cert" {
  description = "The certificate and private key PEMs that represent the CA of the Kubernetes cluster."
  value = {
    cert_pem = tls_self_signed_cert.ca_cert.cert_pem
    private_key_pem = tls_private_key.ca_cert_private_key.private_key_pem
  }
}

output "client_cert" {
  description = "The certificate and private key PEMs that represent the admin user account of the Kubernetes cluster."
  value = {
    cert_pem = tls_locally_signed_cert.client_cert.cert_pem
    private_key_pem = tls_private_key.client_cert_private_key.private_key_pem
  }
}