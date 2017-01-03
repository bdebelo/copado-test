@isTest
public class BlogLog_Retrieve_Test{

    static testmethod void testGetURL() {
        Test.setMock(HttpCalloutMock.class, new BlogLog_RssFetcher_Test_Mock());
        
        List<Blog_Entry__c> items = BlogLog_Retrieve.getXMLFeed('http://sample.com/feed/');
        System.assertEquals(items.size(),1);        
    }
}