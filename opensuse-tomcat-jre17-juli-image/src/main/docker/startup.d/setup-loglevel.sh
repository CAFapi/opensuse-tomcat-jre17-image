# This script replaces the log level value in logging.properties if environment variable CAF_LOG_LEVEL is set
#
#Declare and initialize associative array. This is a mapping of log4j2 levels with that of java.util.logging
declare -A LOG4J2TOJAVAmap=([FATAL]=SEVERE [ERROR]=SEVERE [WARN]=WARNING [DEBUG]=FINE [TRACE]=FINEST)
if [ -n "${CAF_LOG_LEVEL}" ]
then
    #if CAF_LOG_LEVEL is not set right we default it to INFO
    LOGLEVEL=INFO
    if [ -n "${LOG4J2TOJAVAmap[${CAF_LOG_LEVEL^^}]}" ]
    then
        LOGLEVEL=${LOG4J2TOJAVAmap[${CAF_LOG_LEVEL^^}]}
    fi
    echo "Environment log level variable set CAF_LOG_LEVEL:${CAF_LOG_LEVEL}"
    echo "Replacing log level in $CATALINA_HOME/conf/logging.properties with equivalent log level:${LOGLEVEL}"
    sed -i "/org\.apache\.catalina\.core\.ContainerBase\.\[Catalina\]\.\[localhost\]\.level =/ s/=.*/= ${LOGLEVEL}/" \
        $CATALINA_HOME/conf/logging.properties
fi
