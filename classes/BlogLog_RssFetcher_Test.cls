@isTest
public class BlogLog_RssFetcher_Test{

    static testmethod void testRssFetch() {
        Test.setMock(HttpCalloutMock.class, new BlogLog_RssFetcher_Test_Mock());
        
        BlogLog_RssFetcher fetcher = new BlogLog_RssFetcher();
        List<Blog_Entry__c> items = fetcher.fetch('http://sample.com/feed/');
        System.assertEquals(items.size(),1);
        
        
    }
}