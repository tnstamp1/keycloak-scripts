KEYCLOAK_ADMIN=admin
KEYCLOAK_PASSWORD=password
REALM_NAME=newrealm

/opt/jboss/keycloak/bin/kcadm.sh config credentials \
--server http://localhost:8080/auth \
--realm master \
--user $KEYCLOAK_ADMIN \
--password $KEYCLOAK_PASSWORD

/opt/jboss/keycloak/bin/kcadm.sh create realms \
-s realm=$REALM_NAME \
-s enabled=true 

/opt/jboss/keycloak/bin/kcadm.sh create clients \
-r $REALM_NAME \
-s clientId=new-client \
-s enabled=true \
-s standardFlowEnabled=true \
-s implicitFlowEnabled=true \
-s directAccessGrantsEnabled=true \
-s serviceAccountsEnabled=true \
-s rootUrl="http://localhost:8080" \
-s redirectUris='["http://localhost:8080"]' \
-s baseUrl="http://localhost:8080" 

/opt/jboss/keycloak/bin/kcadm.sh \
create users \
-r $REALM_NAME \
-s username=johndoe \
-s email='john.doe@johndoe.com' \
-s lastname=doe \
-s firstname=john \
-s enabled=true
