######################################################################

file ${JAVA_HOME}/lib/security/cacerts
file ${JAVA_HOME}/jre/lib/security/cacerts

######################################################################

keytool -printcert -v -file example.com.crt

######################################################################

# default password: changeit

keytool -list -keystore ${JAVA_HOME}/lib/security/cacerts
keytool -list -v -keystore ${JAVA_HOME}/lib/security/cacerts

keytool -list -keystore ${JAVA_HOME}/jre/lib/security/cacerts
keytool -list -v -keystore ${JAVA_HOME}/jre/lib/security/cacerts

keytool -list -v -alias example -keystore keystore.jks

######################################################################

keytool -import -trustcacerts -alias example -file example.com.crt -keystore keystore.jks

######################################################################

keytool -delete -alias example -keystore keystore.jks
