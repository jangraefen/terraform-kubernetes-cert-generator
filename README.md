# Kubernetes Certificates Generator

A terraform module, intended to bootstrap a root CA certificate, that is compatible to the Kubernetes root CA and
can be used as such. Additionally a certificate, signed by that exact root CA, is generated for user authentication.

Use this module while bootstrapping cluster, e.g. with kubeadm.