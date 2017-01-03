public class BlogLog_RssFetcher{
    
    public List<Blog_Entry__c> fetch(string URL) {
        List<Blog_Entry__c> blog_posts = new List<Blog_Entry__c>();

        Http h = new Http();
        HttpRequest req = new HttpRequest();
    
        req.setEndpoint(url);
        req.setMethod('GET');
        HttpResponse res = h.send(req);
        
        BlogLog_RssReader rssReader = new BlogLog_RssReader();
        
        List<Blog_Entry__c> items = rssReader.read(res.getBody());
        
        return items;
        

    }    
    
}