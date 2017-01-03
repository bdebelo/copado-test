global with sharing class BlogLog_Retrieve implements Schedulable {

	public BlogLog_Retrieve() {}

	global void execute(SchedulableContext c) {
        updateBlogData();
    }

    
    @future(callout=true)
    static global void updateBlogData() {
        List<Blog_Entry__c> blogEntries = new List<Blog_Entry__c>();
		for(String endpoint : BlogLog_Config.endpoints) {
            System.debug('ENDPOINT ' + endpoint);
			blogEntries.addAll(BlogLog_Retrieve.getXMLFeed(BlogLog_Config.rss_endpoint + endpoint));		
		}
        List<String> titles = new List<String>();
        List<Blog_Entry__c> entriesToAdd = new List<Blog_Entry__c>();
        String listOfBlogs = '';
        
        System.Debug('# OF ENTRIES FOUND:' +blogEntries.size());
        for(Blog_Entry__c bp : blogEntries) {
            titles.add(bp.Title__c);
        }
        
        List<Blog_Entry__c> blogs = [SELECT Id, Wordpress__c, Title__c, Author__c from Blog_Entry__c WHERE Title__c IN :titles];
        for(Blog_Entry__c blogEntry : blogEntries) {
            Boolean added = false;
			for(Blog_Entry__c blog : blogs) {
                if(blog.Title__c == blogEntry.Title__c) { added = true; }
            }
            if(!added) { entriesToAdd.add(blogEntry); System.debug(blogEntry.Title__c); }
        }
        
        insert entriesToAdd;

        if(entriesToAdd.size() > 0) { 
            for(Blog_Entry__c blogEntry : entriesToAdd) {
                listOfBlogs += '<BR/><a href="'+blogEntry.Link__c+'"><strong>'+blogEntry.Title__c+'</strong></a>,&nbsp;'+blogEntry.Author__c+''+ + '<BR />';
                listofBlogs += '<a href="http://twitter.com/?status='+EncodingUtil.urlEncode(blogEntry.Title__c +', '+blogEntry.Link__c, 'UTF-8')+'">Tweet This</a><BR /><HR />';
            }
            //BlogLog_Retrieve.sendEmailNotice(listOfBlogs,BlogLog_Config.new_notify); 
            }
    
    }



    static global List<Blog_Entry__c> getXMLFeed(string URL) {
        
        return new BlogLog_RssFetcher().fetch(URL);

        
    }
	


	
 
}