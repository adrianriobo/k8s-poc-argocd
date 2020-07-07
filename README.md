# k8s-poc-argocd
PoC for gitops approach based on argocd

# Usage  
  
```
docker run -d --name k8s-poc-argocd \
           -v /var/run/docker.sock:/var/run/docker.sock \
           --network=host \
           adrianriobo/k8s-poc-argocd:1.5.4
```
