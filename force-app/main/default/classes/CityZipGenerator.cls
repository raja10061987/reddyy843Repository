public with sharing class CityZipGenerator 
{
    private static Pattern spaceInJSONKey = pattern.compile('(?<="[a-z]+) (?=[a-z]+": )');
    @InvocableMethod(label='Get City Zip Codes' description='get city zip code trugh API call')
    public static List<CityZip> getcityZip()
    {
        
List<CityZip> cityZipsList = new List<cityZip>(); // ()
CityZip cityZipObj = new CityZip();
    
    system.debug('spaceInJSONKey: ' + spaceInJSONKey);

Http http = new Http();
HttpRequest request = new HttpRequest(); // system.httpRequest:[endpoint=null,method=null]
request.setEndPoint('https://api.zippopotam.us/us/mn/mankato');
request.setMethod('GET'); // // system.httpRequest:[endpoint=https://api.zippopotam.us/us/mn/mankato,method=GET]
HttpResponse response= http.send(request);
system.debug('response: ' + response); // system.httpResponse: [status=OK,statusCode=200]
string jsonResponse = response.getBody();
system.debug('jsonResponse: ' + jsonResponse);
string jsonresponse1 = spaceInJSONKey.matcher(jsonResponse).replaceAll('');
system.debug('jsonresponse1: ' + jsonresponse1);
cityZipObj = (CityZip)JSON.deserialize(jsonresponse1,CityZip.class);
system.debug('cityZipObj: ' + cityZipObj); // cityZip: [countryabbreviation=US,country=United States,placename=Mankato,state=Minnesota,stateabbreviation=MN,places=(place:[latitude=,longitude=,placename=,postcode=],place:[latitude=,longitude=,placename=,postcode=])]
cityZipsList.add(cityZipObj); // (cityZip: [[countryabbreviation=US,country=United States,placename=Mankato,state=Minnesota,stateabbreviation=MN,places=(place:[latitude=,longitude=,placename=,postcode=],place:[latitude=,longitude=,placename=,postcode=])])
system.debug('cityZipsList: ' + cityZipsList);
     return cityZipsList;
    }
    
}