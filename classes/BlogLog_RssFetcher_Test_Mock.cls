global class BlogLog_RssFetcher_Test_Mock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest req) {

        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'text/xml');
        res.setBody(BlogLog_RssReader_Test.sample);
        res.setStatusCode(200);
        return res;
        
    }
}