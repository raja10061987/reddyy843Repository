public with sharing class GetData {
    
    @InvocableMethod(label='get My Data' description='getting data through API')
    public static List<Data> getMyData()
    {
        List<Data> dataList = new List<Data>();
        Data dataObj = new Data();
        HTTP http = new HTTP();
        HttpRequest request = new HttpRequest();
        request.setEndPoint('http://geodb-free-service.wirefreethought.com/v1/geo/cities?hateoasMode=off');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        if(response.getStatusCode() == 200)
        {
            string responsBody = response.getBody();
            dataObj = (Data)JSON.deserialize(responsBody,Data.class);
            System.debug('dataObj: ' + dataObj); // Data:[data=(datas:[city=,lattude=longitude=],datas:[city=,lattude=longitude=])]
            dataList.add(dataObj); // (Data:[data=(datas:[city=longitude=latitude=],datas:[city=longitude=latitude=])])
            System.debug('dataList: ' + dataList);

        }
        return dataList;
    }
}