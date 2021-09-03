### Kubectl commands

    # get list of pods
    kubectl get pods

    # create pod with image
    kubectl run nginx --image=nginx

    # describe pod
    kubectl describe pod nginx

    root@controlplane:~# kubectl describe pod nginx        
    Name:         nginx
    Namespace:    default
    Priority:     0
    Node:         controlplane/10.23.37.6
    Start Time:   Thu, 02 Sep 2021 11:49:53 +0000
    Labels:       run=nginx
    Annotations:  <none>
    Status:       Running
    IP:           10.244.0.4
    IPs:
    IP:  10.244.0.4
    Containers:
    nginx:
        Container ID:   docker://e20c5b2994a78a8fdd27940803150fd19405fdca47a8997a36accf7c84e9f962
        Image:          nginx
        Image ID:       docker-pullable://nginx@sha256:4d4d96ac750af48c6a551d757c1cbfc071692309b491b70b2b8976e102dd3fef
        Port:           <none>
        Host Port:      <none>
        State:          Running
        Started:      Thu, 02 Sep 2021 11:50:14 +0000
        Ready:          True
        Restart Count:  0
        Environment:    <none>
        Mounts:
        /var/run/secrets/kubernetes.io/serviceaccount from default-token-c2glv (ro)
    Conditions:
    Type              Status
    Initialized       True 
    Ready             True 
    ContainersReady   True 
    PodScheduled      True 
    Volumes:
    default-token-c2glv:
        Type:        Secret (a volume populated by a Secret)
        SecretName:  default-token-c2glv
        Optional:    false
    QoS Class:       BestEffort
    Node-Selectors:  <none>
    Tolerations:     node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                    node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
    Events:
    Type    Reason     Age    From               Message
    ----    ------     ----   ----               -------
    Normal  Scheduled  4m36s  default-scheduler  Successfully assigned default/nginx to controlplane
    Normal  Pulling    4m34s  kubelet            Pulling image "nginx"
    Normal  Pulled     4m16s  kubelet            Successfully pulled image "nginx" in 17.808003809s
    Normal  Created    4m16s  kubelet            Created container nginx
    Normal  Started    4m15s  kubelet            Started container nginx

    # Delete pod
    kubectl delete pod webapp

    # Create pod using yaml definition file.
    kubectl create -f pod-definition.yaml