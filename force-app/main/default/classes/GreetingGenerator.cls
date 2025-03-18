public with sharing class GreetingGenerator {
    

    @InvocableMethod(Label='Get Greeting')
    public static List<GreetingPhraseBook> getGreeting()
    {
        return new List<GreetingPhraseBook> {getRandomGreeting()};
    }
    public static GreetingPhraseBook getRandomGreeting()
    {
        
List<GreetingPhraseBook> possibleGreetings = new List<GreetingPhraseBook>();
GreetingPhraseBook a = new GreetingPhraseBook();
a.language = 'French';
a.howYouSayHi = 'Hi';
a.howYouSayBi = 'Bi';
system.debug('a: ' + a); // GreetingPhraseBook: [language=French,howYouSayHi=Hi,howYouSayBi=Bi]
possibleGreetings.add(a);

GreetingPhraseBook b = new GreetingPhraseBook();
b.language = 'english';
b.howYouSayHi = 'Hi1';
b.howYouSayBi = 'Bi1';
system.debug('b: ' + b); // GreetingPhraseBook: [language=French,howYouSayHi=Hi,howYouSayBi=Bi]
possibleGreetings.add(b);


GreetingPhraseBook c = new GreetingPhraseBook();
c.language = 'hindi';
c.howYouSayHi = 'Hi2';
c.howYouSayBi = 'Bi2';
system.debug('c: ' + c); // GreetingPhraseBook: [language=French,howYouSayHi=Hi,howYouSayBi=Bi]
possibleGreetings.add(c);

system.debug('possibleGreetings: ' + possibleGreetings); // (GreetingPhraseBook: [language=French,howYouSayHi=Hi,howYouSayBi=Bi])
integer randomNumber =  Math.mod(Math.abs(Crypto.getRandomLong().intValue()),possibleGreetings.size());
system.debug('randomNumber: ' + randomNumber);
GreetingPhraseBook greetingrandomObj = possibleGreetings[randomNumber];
system.debug('possibleGreetings random:' + greetingrandomObj);

 return greetingrandomObj; // GreetingPhraseBook [language=hindi,howYouSayHi=Hi2,howYouSayBi=Bi2]

    }
}