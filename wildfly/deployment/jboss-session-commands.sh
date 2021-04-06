######################################################################

### active session count
/deployment=yourwebapp.war/subsystem=undertow:read-attribute(name=active-sessions)

### max active session count
/deployment=failovertest.war/subsystem=undertow:read-attribute(name=max-active-sessions)

### invalidate session
/deployment=failovertest.war/subsystem=undertow:invalidate-session(session-id=${SESSION_ID})
/deployment=helloWorld.ear/subdeployment=helloWorld.war/subsystem=undertow:invalidate-session(session-id=${SESSION_ID})
