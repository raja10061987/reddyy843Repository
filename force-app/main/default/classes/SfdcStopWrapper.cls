public with sharing class SfdcStopWrapper 
{
    public class Blogs 
    {
       public string id;
       public string title;
       public string url; 
    }
    public string author;
    public List<Blogs> blogs;

    public static SfdcStopWrapper parse(string json)
    {
     return (SfdcStopWrapper)System.Json.deserialize(json, SfdcStopWrapper.class);
    }

}