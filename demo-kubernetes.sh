echo '#Cluster Nodes'
echo --------------
echo kubectl get nodes
kubectl get nodes
read -p "Press enter to continue" pause
echo

echo '#List of all pods'
echo -----------------
echo kubectl get pods --all-namespaces
kubectl get pods --all-namespaces
read -p "Press enter to continue" pause
echo

echo '#List of all services'
echo -----------------------
echo kubectl get svc --all-namespaces
kubectl get svc --all-namespaces
read -p "Press enter to continue" pause
echo

echo '#List of all namespaces'
echo -----------------------
echo kubectl get namespaces
kubectl get namespaces
read -p "Press enter to continue" pause
echo

echo '#Contrail containers'
echo -----------------------
echo 'docker ps | grep contrail'
docker ps | grep contrail
read -p "Press enter to continue" pause
echo

echo '#Creation of a web service in the default namespace'
echo -----------------------------------------------------
echo kubectl create -f default-pod-service/contrail-frontend.yaml
kubectl create -f default-pod-service/contrail-frontend.yaml
read -p "Press enter to continue" pause
echo

echo '#Check pods, cluster IP, service IP and external IP'
echo ----------------------------------------------------
read -p "Press enter to continue" pause
echo


echo '#Check Contrail FIP assignment - MX routing table - External access'
echo ---------------------------------------------------------------------
read -p "Press enter to continue" pause
echo

echo '#Questions ???'
echo -----------------------------------------------------------
read -p "Press enter to continue" pause
echo

echo '#Creation of an isolated namespace'
echo ------------------------------------
kubectl create -f isolated-ns/isolated-ns.yaml
read -p "Press enter to continue" pause
echo

echo '#Creation of a web service in this isolated namespace'
echo -------------------------------------------------------
kubectl create -f isolated-ns/nginx-server-isolated-ns.yaml -n isolated-ns
read -p "Press enter to continue" pause
echo

echo '#Check connectivity to this pod in the isolated namespace'
echo -----------------------------------------------------------
read -p "Press enter to continue" pause
echo

echo '#Creation of an ubuntu app in the isolated namespace'
echo -------------------------------------------------------
kubectl create -f isolated-ns/ubuntu.yaml -n isolated-ns
read -p "Press enter to continue" pause
echo

echo '#Check connectivity inside the isolated namespace'
echo -----------------------------------------------------------
read -p "Press enter to continue" pause
echo

echo '#Annotate isolated namespace to deny all traffic between pods'
echo -----------------------------------------------------------
echo 'kubectl annotate ns isolated-ns "net.beta.kubernetes.io/network-policy={\"ingress\": {\"isolation\": \"DefaultDeny\"}}"'
kubectl annotate ns isolated-ns "net.beta.kubernetes.io/network-policy={\"ingress\": {\"isolation\": \"DefaultDeny\"}}"
read -p "Press enter to continue" pause
echo

echo '#Check connectivity inside the isolated namespace'
echo -----------------------------------------------------------
read -p "Press enter to continue" pause
echo

echo '#Apply network policy to allow traffic between ubuntupapp and web-servers in isolated ns'
echo ------------------------------------------------------------------------------------------
echo 'kubectl create -f isolated-ns/network-policy.yaml -n isolated-ns'
kubectl create -f isolated-ns/network-policy.yaml -n isolated-ns
read -p "Press enter to continue" pause
echo

echo '#Check connectivity inside the isolated namespace'
echo -----------------------------------------------------------
read -p "Press enter to continue" pause
echo

echo '#Questions ???'
echo -----------------------------------------------------------
read -p "Press enter to continue" pause
echo

echo '#Creation of a Dev Web Server '
echo -----------------------------------------------------------
echo 'kubectl create -f ingress-services/web-app-rc-dev.yaml'
echo 'kubectl create -f ingress-services/web-app-svc-dev.yaml'
kubectl create -f ingress-services/web-app-rc-dev.yaml
kubectl create -f ingress-services/web-app-svc-dev.yaml
read -p "Press enter to continue" pause
echo

echo '#Creation of a QA Web Server '
echo -----------------------------------------------------------
echo 'kubectl create -f ingress-services/web-app-rc-qa.yaml'
echo 'kubectl create -f ingress-services/web-app-svc-qa.yaml'
kubectl create -f ingress-services/web-app-rc-qa.yaml
kubectl create -f ingress-services/web-app-svc-qa.yaml
read -p "Press enter to continue" pause
echo

echo '#Creation of a Fanout Ingress Service for Dev & QA Web Servers '
echo -----------------------------------------------------------------
echo 'kubectl create -f ingress-services/web-app-fanout-ingress.yaml'
kubectl create -f ingress-services/web-app-fanout-ingress.yaml
read -p "Press enter to continue" pause
echo

echo '#Test access to both Web Servers (Dev & QA) based on URL (/dev & /qa)'
echo -----------------------------------------------------------------------
read -p "Press enter to continue" pause
echo

echo '#Questions ???'
echo -----------------------------------------------------------
read -p "Press enter to continue" pause
echo

echo '#Cleanup of the objects created during the demo'
echo ---------------------------------------------------------------------
kubectl delete -f default-pod-service/contrail-frontend.yaml
kubectl delete -f isolated-ns/network-policy.yaml -n isolated-ns
kubectl delete -f isolated-ns/nginx-server-isolated-ns.yaml -n isolated-ns
kubectl delete -f isolated-ns/ubuntu.yaml -n isolated-ns
kubectl delete -f isolated-ns/isolated-ns1.yaml
kubectl delete -f ingress-services/web-app-fanout-ingress.yaml
kubectl delete -f ingress-services/web-app-svc-qa.yaml
kubectl delete -f ingress-services/web-app-rc-qa.yaml
kubectl delete -f ingress-services/web-app-svc-dev.yaml
kubectl delete -f ingress-services/web-app-rc-dev.yaml

echo '#Done with the demo'

