
keytool -genkey -keystore server-side-keystore.jks -storepass secureexample -keypass secureexample -dname "CN=ActiveMQ Artemis Server, OU=Artemis, O=ActiveMQ, L=AMQ, S=AMQ, C=AMQ" -keyalg RSA
keytool -export -keystore server-side-keystore.jks -file activemq-jks.cer -storepass secureexample
keytool -import -keystore client-side-truststore.jks -file activemq-jks.cer -storepass secureexample -keypass secureexample -noprompt
rm activemq-jks.cer


keytool -genkey -keystore client-side-keystore.jks -storepass secureexample -keypass secureexample -dname "CN=ActiveMQ Artemis Client, OU=Artemis, O=ActiveMQ, L=AMQ, S=AMQ, C=AMQ" -keyalg RSA
keytool -export -keystore client-side-keystore.jks -file activemq-jks.cer -storepass secureexample
keytool -import -keystore server-side-truststore.jks -file activemq-jks.cer -storepass secureexample -keypass secureexample -noprompt
rm activemq-jks.cer


keytool -importkeystore \
    -srckeystore client-side-keystore.jks \
    -srcstorepass secureexample \
    -destkeystore client-side-keystore.p12 \
    -deststoretype PKCS12 \
    -deststorepass secureexample \
    -destkeypass secureexample


openssl pkcs12 -in client-side-keystore.p12  -nodes -nocerts -out client-side-keystore.key
openssl pkcs12 -in client-side-keystore.p12  -nokeys -out client-side-keystore.crt
