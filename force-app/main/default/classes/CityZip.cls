public with sharing class CityZip {
    @AuraEnabled @InvocableVariable public string countryabbreviation;
    @AuraEnabled @InvocableVariable public string country;
    @AuraEnabled @InvocableVariable public string placename;
    @AuraEnabled @InvocableVariable public string state;
    @AuraEnabled @InvocableVariable public string stateabbreviation;
    @AuraEnabled @InvocableVariable public List<Place1> places;
    
}