REM add java11 to path on devops
ECHO "java11 home dir: %JAVA_HOME_11_X64%"
ECHO "add java11 to path"
SET "PATH=%JAVA_HOME_11_X64%\bin;%PATH%"

REM print java version
java -version

REM re-generate code
RMDIR /S /Q "src\main\java\com\azure\mgmttest"
RMDIR /S /Q "src\main\java\com\azure\mgmtlitetest"

SET AUTOREST_CORE_VERSION=3.0.6350
SET MODELERFOUR_ARGUMENTS=--pipeline.modelerfour.additional-checks=false --pipeline.modelerfour.lenient-model-deduplication=true
SET COMMON_ARGUMENTS=--java --use=../ --java.output-folder=./ %MODELERFOUR_ARGUMENTS% --azure-arm --java.license-header=MICROSOFT_MIT_SMALL
SET FLUENT_ARGUMENTS=%COMMON_ARGUMENTS% --fluent
SET FLUENTLITE_ARGUMENTS=%COMMON_ARGUMENTS% --fluent=lite --pipeline.modelerfour.flatten-payloads=false

REM fluent premium
CALL autorest --version=%AUTOREST_CORE_VERSION% %FLUENT_ARGUMENTS% --input-file=https://raw.githubusercontent.com/Azure/azure-rest-api-specs/master/specification/resources/resource-manager/Microsoft.Resources/stable/2019-08-01/resources.json --namespace=com.azure.mgmttest.resources

CALL autorest --version=%AUTOREST_CORE_VERSION% %FLUENT_ARGUMENTS% --payload-flattening-threshold=2 ./swagger/readme.storage.md --namespace=com.azure.mgmttest.storage

CALL autorest --version=%AUTOREST_CORE_VERSION% %FLUENT_ARGUMENTS% --payload-flattening-threshold=1 ./swagger/readme.network.md --namespace=com.azure.mgmttest.network

CALL autorest --version=%AUTOREST_CORE_VERSION% %FLUENT_ARGUMENTS% --payload-flattening-threshold=1 ./swagger/readme.appservice.md --namespace=com.azure.mgmttest.appservice

CALL autorest --version=%AUTOREST_CORE_VERSION% %FLUENT_ARGUMENTS% --payload-flattening-threshold=1 --input-file=https://raw.githubusercontent.com/Azure/azure-rest-api-specs/master/specification/cosmos-db/resource-manager/Microsoft.DocumentDB/stable/2019-12-12/cosmos-db.json --namespace=com.azure.mgmttest.cosmos

CALL autorest --version=%AUTOREST_CORE_VERSION% %FLUENT_ARGUMENTS% --payload-flattening-threshold=1 ./swagger/readme.containerservice.md --namespace=com.azure.mgmttest.conainterservice

CALL autorest --version=%AUTOREST_CORE_VERSION% %FLUENT_ARGUMENTS% --payload-flattening-threshold=1 --input-file=https://raw.githubusercontent.com/Azure/azure-rest-api-specs/master/specification/graphrbac/data-plane/Microsoft.GraphRbac/stable/1.6/graphrbac.json --namespace=com.azure.mgmttest.authorization

REM fluent lite
CALL autorest --version=%AUTOREST_CORE_VERSION% %FLUENTLITE_ARGUMENTS% https://raw.githubusercontent.com/Azure/azure-rest-api-specs/master/specification/resources/resource-manager/readme.md --tag=package-resources-2020-10 --java.namespace=com.azure.mgmtlitetest.resources --pom-file=pom_generated_resources.xml

CALL autorest --version=%AUTOREST_CORE_VERSION% %FLUENTLITE_ARGUMENTS% https://raw.githubusercontent.com/Azure/azure-rest-api-specs/master/specification/storage/resource-manager/readme.md --tag=package-2019-06 --java.namespace=com.azure.mgmtlitetest.storage --pom-file=pom_generated_storage.xml

CALL autorest --version=%AUTOREST_CORE_VERSION% %FLUENTLITE_ARGUMENTS% https://raw.githubusercontent.com/Azure/azure-rest-api-specs/master/specification/advisor/resource-manager/readme.md --tag=package-2020-01 --java.namespace=com.azure.mgmtlitetest.advisor --pom-file=pom_generated_advisor.xml

REM CALL autorest --version=%AUTOREST_CORE_VERSION% %FLUENTLITE_ARGUMENTS% https://raw.githubusercontent.com/Azure/azure-rest-api-specs/master/specification/network/resource-manager/readme.md --tag=package-2020-06 --java.namespace=com.azure.mgmtlitetest.network --pom-file=pom_generated_network.xml
REM CALL autorest --version=%AUTOREST_CORE_VERSION% %FLUENTLITE_ARGUMENTS% https://raw.githubusercontent.com/Azure/azure-rest-api-specs/master/specification/compute/resource-manager/readme.md --tag=package-2020-06-30 --java.namespace=com.azure.mgmtlitetest.compute --pom-file=pom_generated_compute.xml

REM delete module-info as fluent-test is on java8
DEL "src\main\java\module-info.java"
