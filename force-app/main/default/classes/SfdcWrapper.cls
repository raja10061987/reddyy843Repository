public class SfdcWrapper 
{
    public class Blogs
    {
        public string id;
        public string title;
        public string url;
    }
    public string author;
    public List<Blogs> blogs;
    
    public static SfdcWrapper parse(string json)
    {
             system.debug('json: ' + json);
            return (SfdcWrapper)System.JSON.deserialize(json,SfdcWrapper.class);
    }
    
}