# Initialisation sentry 
kubectl exec -it <sentry-web-pod> -- sentry upgrade
kubectl exec -it <sentry-web-pod> -- sentry createuser
