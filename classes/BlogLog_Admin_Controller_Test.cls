@istest
public class BlogLog_Admin_Controller_Test{

    static testmethod void testUpdate() {

        Test.setMock(HttpCalloutMock.class, new BlogLog_RssFetcher_Test_Mock());

        List<Blog_Entry__c> items = [Select Id From Blog_Entry__c];
        System.assertEquals(0, items.size());
        
        Test.startTest();
        
        BlogLog_Retrieve.updateBlogData();
        
        Test.stopTest();
        
        //should be five b/c we get 5 different URLS
        items = [Select Id From Blog_Entry__c];
        System.assertEquals(4, items.size());
        
    }
    
}