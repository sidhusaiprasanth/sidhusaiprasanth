#!/bin/bash

: '
S.No.         Project ID        Project Name
1		  19		cicd_case-intake
2		  115		cicd_authservice
3		  129		cicd_snowflake
4		  131		cicd_druglookupservice
5		  133		cicd_docgenerationservice
6		  167		cicd_duplicatesearchservice
7		  208		cicd_redactionUI
8		  209		cicd_redactionApp
9		  261		cicd_companydruglookupservice
10		287		cicd_docpreviewerservice
11		299		cicd_casecomparison
12		313		namespace_tivpcore
13		339		cicd_element-pins-server
14		340		cicd_element-kafka-consumer-server
15		341		cicd_element-pms-server
16		452		cicd_ivp-logger-app
17		456		cicd_authcredprovider
18		458		cicd_element-mig-server
19		459		cicd_element-pts-server
20		488		cicd_fileuploadservice
21		522		cicd_regdbservice
22		527		cicd_platformeventconsumer
23		489		cicd_ivp-ephesoft-exp
24		490		cicd_ivp-box-exp
25		491		cicd_ivp-compute-exp
26		492		cicd_ivp-salesforce-exp
27		493		cicd_ivp-ephesoft-sys
28		494		cicd_ivp-compute-sys
29		495		cicd_ivp-salesforce-sys
30		498		cicd_ivp-multi-tenant-proc
31		499		cicd_ivp-snowflake-sys
32		500		cicd_ivp-box-sys
33		501		cicd_ivp-registration-sys
34		509		cicd_ivp-who-drug-proc
35		510		cicd_ivp-meddra-proc
36		511		cicd_ivp-search-proc
37		512		cicd_ivp-e2b-intake-proc
38		513		cicd_ivp-e2b-oper-proc
39		514		cicd_ivp-ocr-proc
40		515		cicd_ivp-mail-proc
41		516		cicd_ivp-transformation-app
42		517		cicd_ivp-validate-json-app
43		518		cicd_ivp-validate-xml-app
44		519		cicd_ivp-report-gen-proc
45		520		cicd_ivp-case-comp-proc
46		521		cicd_ivp-case-merge-proc
47		585		cicd_ivp-utility-app
48		637		cicd_ivp-ess-int-proc
49		640		cicd_ivp-ext-safety-exp
50		660		cicd_intakesearchservice
51		671		cicd_canvas_analytics
52    729   cicd_ivp_salesforce_deploy
52    731   cicd_ivp-kafka-exp
53    732   cicd_ivp-kafka-sys
54    994   cicd_ivp-mail-batch-proc
55    1171  email-intake-scheduler
56    1125  email-intake-read
57    1127  email-intake-process
58    1128  email-intake-box
59    1124  email-intake-integration
60    1088  cicd_pipeline-sfdc-source-connector
61    1198  cicd_docgen_aggregatereporting
62    632   cicd_kafka_job_event_consumer
63    1035  svcs-kafka_external_safety_publisher
64    1346  cicd_snow-poller-service
65    633   cicd_kafka_external_consumer
67    1407  cicd_casecomparison_2021r1
68    1419  cicd_studylookupservice_2021r1
69    1423  svcs-duplicatesearch-2021r1
70    1425  svcs-intakesearch-2021r1
71    1424  cicd_companydruglookupservice_2021r1
72    1367  cicd_docgenerationservice_2021r1
73    770   cicd_platformjobeventconsumer
74    703   i-extract-callback
75    707   i-extract-service
76    768   nlp-callback-service
77    706   nlp-service
78    705   translate-service
79    704   xml-preprocessor-service
80    1935  cicd_print_view_service
81		1268  key-rotation-service
82    277		cicd_studylookupservice
83		754		cicd_kafkaplatformlogconsumer
84		1826	cicd_druglookupservice_2021r1
85    2080  svcs-standardreportservice
86    2184  email-intake-read-graph
87    2313  cicd_salesforce_login_history
88    2220  cicd_ivp-case-manage-exp
89    2215  cicd_ivp-doc-gen-exp
90    2217  cicd_ivp-doc-manage-exp
91    2218  cicd_ivp-drug-lookup-exp
92    2216  cicd_ivp-ess-exp
93    2212  cicd_ivp-inbound-exp
94    2158  cicd_ivp-case-process-proc
95    2219  cicd_ivp-search-exp
96    2180  cicd_expedite_rule_service
97    2305  cicd_expedite_rule_salesforce_integration
98    2473  cicd_emailservice
99    2165  cicd_docgen_analytics
100   2488  cicd_ivp-intake-proc
101   2478  cicd_ivp-inbox-proc
102   2687  cicd_element-pipeline-monitor
103   189   CSM
104   34    Aggregated Reporting
105   1478  cicd_reporting
106   1315  cicd_pipeline-mongo-consumer
107   2638  cicd_canonical_consumer_service
108   2339  cicd_extintegration_service
109   2475  cicd_ext-inbound-int-service
110   2250  cicd_notifysfservice
111   2838  cicd_migrate_case_service
'

declare -a project_ids_compute=("115" "456" "522" "1171" "1125" "2184" "1127" "1128" "1124" "1268" "341" "458" "340" "459" "339" "1088" "1425" "1367" "287" "209" "208" "488" "527" "1423" "1407" "1419" "1424" "707" "704" "705" "706" "703" "768" "770" "754" "1198" "632" "1035" "633" "1826" "1935" "2080" "2313" "2180" "2305" "2473" "2165" "2687" "1315" "2638" "2339" "2475" "2250" "2838")
declare -a project_ids_mulesoft=("2215" "2217" "2218" "2220" "2216" "2212" "2219" "2158" "514" "511" "637" "519" "509" "2488" "2478" "500" "494" "499" "495" "493" "452" "585")
declare -a project_ids_snowflake=("129")
declare -a project_ids_salesforce=("19" "313" "729" "189" "34")
declare -a project_ids_looker=("1478")

if [ -z "$tag" ]
then
  tag="2021.1.65.0"
fi

if [ -z "$list" ]
then
  list="false"
fi

if [ "$list" == "true" ]
then
  for i in {500..950}
  do
    SHA=$(curl -s -N --header "PRIVATE-TOKEN: $token" https://gitlab.rwts-tools.com/api/v4/projects/$i/ | jq -r '.name')
    if [ "$SHA" != "null" ]
    then
      echo "$i" : "$SHA"
    fi
  done
else
  echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
  echo "Below is the list of COMPUTE repos along with SHA values for "$tag
  echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

  count=0
  for i in "${project_ids_compute[@]}"
  do
    count=$((count + 1))
    SHA=$(curl -s -N --header "PRIVATE-TOKEN: $token" https://gitlab.rwts-tools.com/api/v4/projects/$i/repository/tags/$tag | jq -r '.commit.id')
    var=$(curl -s -N --header "PRIVATE-TOKEN: $token" https://gitlab.rwts-tools.com/api/v4/projects/$i/repository/files/k8s%2FconfigMap%2Eyaml/raw?ref=$tag | grep -i -- '-configmap')
    echo -e ${count}"." ${SHA} ":" $(curl -s -N --header "PRIVATE-TOKEN: $token" https://gitlab.rwts-tools.com/api/v4/projects/$i/ | jq -r '.name')"\t:" ${var:8}|sed s/"-configmap"//
  done

  echo " "
  echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
  echo "Below is the list of MULESOFT repos along with SHA values for "$tag
  echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

  count=0
  echo "EXP"
  for i in "${project_ids_mulesoft[@]}"
  do
    count=$((count + 1))
    SHA=$(curl -s -N --header "PRIVATE-TOKEN: $token" https://gitlab.rwts-tools.com/api/v4/projects/$i/repository/tags/$tag | jq -r '.commit.id')
    RAW=$(curl -s -N --header "PRIVATE-TOKEN: $token" https://gitlab.rwts-tools.com/api/v4/projects/$i/)
    group=$(echo $RAW | jq -r '.path_with_namespace')
    name=$(echo $RAW | jq -r '.name')
    name2=${name#"cicd_"}
    id=$(curl -s -u $nexus_user:$nexus_password -X GET "https://nexus.edp.iqvia.com/service/rest/v1/search?repository=Test&group=/${group}&name=/${group}/${name2}-${SHA}.jar" | jq -r '.items[0].id')
    if [ "$id" == "null" ]
    then
      id=$(curl -s -u $nexus_user:$nexus_password -X GET "https://nexus.edp.iqvia.com/service/rest/v1/search?repository=Dev&group=/${group}&name=/${group}/${name2}-${SHA}.jar" | jq -r '.items[0].id')
      if [ "$id" == "null" ]
      then
        artifact="NOT found in Nexus"
      else
        artifact="Dev "
      fi
    else
      artifact="Test"
    fi
    if [ "$i" == "2158" ]
    then
      echo -e "\nPROC"
    elif [ "$i" == "500" ]
    then
      echo -e "\nSYS"
    elif [ "$i" == "452" ]
    then
      echo -e "\nAPP"
    fi
    echo -e ${count}"." ${SHA} ":" ${artifact} ":" ${name}"\t:" ${group}
  done

  echo " "
  echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
  echo "Below is the list of SALESFORCE repos along with SHA values for "$tag
  echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

  count=0
  for i in "${project_ids_salesforce[@]}"
  do
    count=$((count + 1))
    SHA=$(curl -s -N --header "PRIVATE-TOKEN: $token" https://gitlab.rwts-tools.com/api/v4/projects/$i/repository/tags/$tag | jq -r '.commit.id')
    echo ${count}"." $(curl -s -N --header "PRIVATE-TOKEN: $token" https://gitlab.rwts-tools.com/api/v4/projects/$i/ | jq -r '.name') ":" ${SHA}
  done

  echo " "
  echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
  echo "Below is the list of SNOWFLAKE repos along with SHA values for "$tag
  echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

  count=0
  for i in "${project_ids_snowflake[@]}"
  do
    count=$((count + 1))
    SHA=$(curl -s -N --header "PRIVATE-TOKEN: $token" https://gitlab.rwts-tools.com/api/v4/projects/$i/repository/tags/$tag | jq -r '.commit.id')
    echo ${count}"." $(curl -s -N --header "PRIVATE-TOKEN: $token" https://gitlab.rwts-tools.com/api/v4/projects/$i/ | jq -r '.name') ":" ${SHA}
  done

  echo " "
  echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
  echo "Below is the list of Looker repos along with SHA values for "$tag
  echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

  count=0
  for i in "${project_ids_looker[@]}"
  do
    count=$((count + 1))
    SHA=$(curl -s -N --header "PRIVATE-TOKEN: $token" https://gitlab.rwts-tools.com/api/v4/projects/$i/repository/tags/$tag | jq -r '.commit.id')
    echo ${count}"." $(curl -s -N --header "PRIVATE-TOKEN: $token" https://gitlab.rwts-tools.com/api/v4/projects/$i/ | jq -r '.name') ":" ${SHA}
  done

echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

fi

if [ -z "$wide" ]
then
  wide="false"
fi

if [ "$wide" == "true" ]
then
  echo " "
  echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
  echo "Below are the YAML files of Mulesoft repo "$tag
  echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

  count=0
  for i in "${project_ids_mulesoft[@]}"
  do
    count=$((count + 1))
    RAW=$(curl -s -N --header "PRIVATE-TOKEN: $token" https://gitlab.rwts-tools.com/api/v4/projects/$i/)
    name=$(echo $RAW | jq -r '.name')
    name2=${name#"cicd_"}
    echo " "
    echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    echo ${count}"." ${name2}".dit0.yaml"
    echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    curl -s -N --header "PRIVATE-TOKEN: $token" "https://gitlab.rwts-tools.com/api/v4/projects/$i/repository/files/src%2Fmain%2Fresources%2F${name2}%2Edit0%2Eyaml/raw?ref=${tag}"
  done
fi
