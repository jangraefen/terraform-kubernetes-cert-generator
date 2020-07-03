resource "tls_private_key" "ca_cert_private_key" {
  algorithm = "RSA"
  rsa_bits = "2048"
}

resource "tls_self_signed_cert" "ca_cert" {
  key_algorithm = "RSA"
  validity_period_hours = 8760
  early_renewal_hours = 168
  is_ca_certificate = true
  allowed_uses = [
    "cert_signing",
    "digital_signature",
    "key_encipherment"
  ]

  private_key_pem = tls_private_key.ca_cert_private_key.private_key_pem

  subject {
    common_name = "kubernetes"
  }
}

resource "tls_private_key" "client_cert_private_key" {
  algorithm = "RSA"
  rsa_bits = "2048"
}

resource "tls_cert_request" "client_cert_request" {
  key_algorithm = "RSA"
  private_key_pem = tls_private_key.client_cert_private_key.private_key_pem

  subject {
    common_name = var.admin_username
  }
}

resource "tls_locally_signed_cert" "client_cert" {
  ca_key_algorithm = "RSA"
  ca_cert_pem = tls_self_signed_cert.ca_cert.cert_pem
  ca_private_key_pem = tls_private_key.ca_cert_private_key.private_key_pem
  cert_request_pem = tls_cert_request.client_cert_request.cert_request_pem

  validity_period_hours = 8760
  early_renewal_hours = 168

  allowed_uses = [
    "digital_signature",
    "data_encipherment",
    "key_encipherment",
    "client_auth",
    "server_auth"
  ]
}