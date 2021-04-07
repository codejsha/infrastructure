######################################################################

file ${JAVA_HOME}/lib/security/cacerts
file ${JAVA_HOME}/jre/lib/security/cacerts

######################################################################

### list
### default password: changeit

keytool -list -keystore ${JAVA_HOME}/lib/security/cacerts
keytool -list -v -keystore ${JAVA_HOME}/lib/security/cacerts

keytool -list -keystore ${JAVA_HOME}/jre/lib/security/cacerts
keytool -list -v -keystore ${JAVA_HOME}/jre/lib/security/cacerts

keytool -list -v -alias example -keystore keystore.jks

######################################################################

keytool -printcert -v -file example.com.crt

######################################################################

keytool -import -trustcacerts -alias example -file example.com.crt -keystore keystore.jks

######################################################################

### create self-signed certificate
keytool -genkey -keyalg RSA -alias example -keystore keystore.jks -storepass changeit -validity 365 -keysize 4096 -storetype pkcs12

######################################################################

keytool -delete -alias example -keystore keystore.jks
