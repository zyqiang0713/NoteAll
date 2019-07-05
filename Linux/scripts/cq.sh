#curl -c cookies http://ukgil-ww01.europe.delphiauto.net/cqweb/
#curl -l http://ukgil-ww01.europe.delphiauto.net/cqweb/cqlogin.cq?action=DoLogin HTTP/1.1 
curl -c cookies --user-agent Mozilla/5.0 -d "loginId=zhaoy2&password=iamnew2cq&repository=8.0.0&tzOffset=GMT%2B8%3A00&tzFilters=1546272000000%2C-480&loadAllRequiredInfo=true" "http://ukgil-ww01.europe.delphiauto.net/cqweb/cqlogin.cq?action=DoLogin" | tee log
curl -b cookies -c cookies --user-agent Mozilla/5.0 -d "userDb=GV&loadAllRequiredInfo=true" "http://ukgil-ww01.europe.delphiauto.net/cqweb/cqlogin.cq?action=DoConnect HTTP/1.1" | tee -a log

pwd
cquid=`grep -i "cquid" log | awk -F\' '{print $2}'` 
echo "cquid:${cquid}"
# echo $fetch_url | sed 's/{/%7B/g;s/}/%7D/g;s/:/%3A/g;s/\"/%22/g;s/,/%2C/g;s/:/%3A/g;s/\//%2F/g;s/@/%40/g'
# echo $fetch_url | sed 's/%7B/{/g;s/%7D/}/g;s/%3A/:/g;s/%22/\"/g;s/%2C/,/g;s/%3A/:/g;s/%2F/\//g;s/%40/@/g'
#get resourceId
recordId="276012"
curl -b cookies -c cookies -o log -H "cquid:${cquid}" --referer http://ukgil-ww01.europe.delphiauto.net/cqweb/ --user-agent Mozilla/5.0  "http://ukgil-ww01.europe.delphiauto.net/cqweb/cqfind.cq?action=DoFindRecord&recordId=${recordId}&searchType=BY_RECORD_ID HTTP/1.1"

# get resourceId from previous response
resourceId=`grep -o -e "id:'.*'" log | awk -F\' '{print $2}'` 
echo "resourceId: ${resourceId}"

resourceId_url=`echo $resourceId | sed 's/%7B/{/g;s/%7D/}/g;s/%3A/:/g;s/%22/\"/g;s/%2C/,/g;s/%3A/:/g;s/%2F/\//g;s/%40/@/g'`
echo "resourceId_url: ${resourceId_url}"

curl -b cookies -c cookies -o response -H "cquid:${cquid}"  --user-agent Mozilla/5.0  "http://ukgil-ww01.europe.delphiauto.net/cqweb/cqartifactdetails.cq?action=GetCQRecordDetails&resourceId=${resourceId_url}&state=VIEW&tabIndex=0&acceptAllTabsData=true&dojo.preventCache=1558674299377 HTTP/1.1"





# SPEC CQ



curl -c cookies --user-agent Mozilla/5.0   "http://frblo-ap20.europe.delphiauto.net/cqweb/" | tee log
cquid=`grep -i "cquidstring" log | awk -F\" '{print $2}'` 
echo "cquid:${cquid}"

#login SPEC CQ
curl -b cookies -c cookies -o log -H "cquid:${cquid}"  --user-agent Mozilla/5.0 -d "loginId=asia%5Cbjq5dl&password=11111111&repository=CQ_TCBL&tzOffset=GMT%2B8%3A00&tzFilters=1546272000000%2C-480&loadAllRequiredInfo=true&manualOverrideSSO=false&reAuthentication=false" "http://frblo-ap20.europe.delphiauto.net/cqweb/cqlogin.cq?action=DoLogin"
tmp=`grep -i "cquid" log | awk -F\' '{print $2}'` 
if [ $tmp ]; then
  cquid=${tmp}
fi


curl -b cookies -c cookies -H "cquid:${cquid}"  --user-agent Mozilla/5.0  "http://frblo-ap20.europe.delphiauto.net/cqweb/scripts/dds/FileDownload.jsp?file=reports/B8515308_3.0.pdf&contentDisp=attachment"


