#!/usr/bin/env bash

if ! serviceaccount="$(/kubectl get po $hostname -o=jsonpath='{.items[0].spec.serviceAccount}' 2>/dev/null)"; then
    echo "serviceaccount not found." >&2
    exit 2
fi

if ! secret="$(/kubectl get serviceaccount "$serviceaccount" -o 'jsonpath={.secrets[0].name}' 2>/dev/null)"; then
  echo "serviceaccounts \"$serviceaccount\" not found." >&2
  exit 2
fi

# token
ca_crt_data="$(/kubectl get secret "$secret" -o "jsonpath={.data.ca\.crt}" | openssl enc -d -base64 -A)"
namespace="$(/kubectl get secret "$secret" -o "jsonpath={.data.namespace}" | openssl enc -d -base64 -A)"
token="$(/kubectl get secret "$secret" -o "jsonpath={.data.token}" | openssl enc -d -base64 -A)"

cluster="dev"
context="dev"
server="https://$KUBERNETES_SERVICE_HOST"

export KUBECONFIG="/kube/config"
/kubectl config set-credentials "$serviceaccount" --token="$token"
ca_crt="$(mktemp)"; echo "$ca_crt_data" > $ca_crt
/kubectl config set-cluster "$cluster" --server="$server" --certificate-authority="$ca_crt" --embed-certs
/kubectl config set-context "$context" --cluster="$cluster" --namespace="$namespace" --user="$serviceaccount"
/kubectl config use-context "$context"