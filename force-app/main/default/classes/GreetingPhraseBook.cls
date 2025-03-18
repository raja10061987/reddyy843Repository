public with sharing class GreetingPhraseBook {
    @AuraEnabled @InvocableVariable public string language;
    @AuraEnabled @InvocableVariable public string howYouSayHi;
    @AuraEnabled @InvocableVariable public String howYouSayBi;
}