public with sharing class HTTPMockFactory implements HttpCalloutMock
{
    protected integer code;
    protected string status;
    protected string body;
    protected Map<String,String> responseHeaders;

    public HTTPMockFactory(integer code,string status,string body,Map<String,String> responseHeaders)
    {
        this.code = code;
        this.status = status;
        this.body = body;
        this.responseHeaders = responseHeaders;
        system.debug('code:' + this.code);
        system.debug('status: ' + this.status);
        system.debug('body: ' + this.body);
        system.debug('responseHeaders: ' + this.responseHeaders);
        system.debug('responseheaderKeySet: ' + this.responseHeaders.keyset());

    }
    public HTTPResponse respond(HTTPRequest request)
    {
        HTTPResponse response = new HTTPResponse();
        for(String key:this.responseHeaders.keyset())
        {
            response.setHeader(key,this.responseHeaders.get(key));

        }
        response.setBody(this.body);
        response.setStatusCode(this.code);
        response.setStatus(this.status);
        system.debug('response: ' + response);
        return response;

    }
   
}