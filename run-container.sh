docker run -e KEYCLOAK_PASSWORD=password -e KEYCLOAK_USER=admin -p 8080:8080 --name my-keycloak --detach jboss/keycloak
docker cp create-kc.sh my-keycloak:/tmp/create-kc.sh
