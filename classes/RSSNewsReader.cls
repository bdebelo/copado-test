public class RSSNewsReader {
     
    public String rssQuery {get;set;}
    private String rssURL {get;set;}
    private boolean iBlog = false;
    private RSS.channel result;
    private list<RSS_StreamReader.item> results;
    public static String objName {get;set;}
    public static MetadataService.MetadataPort service;

    public RSSNewsReader() {
         
        rssURL = 'https://cio.gov/category/blogs/feed/';
    }     
    public list<RSS_StreamReader.item> getRSSFeed() {
        iBlog = true;
        //result = RSS.getRSSData(rssURL);
        results = RSS_StreamReader.getRSSData(rssURL);
        return results;
    }
    public void createObjects() {
			createObject();
            	createField('Title', 'Text', 255);
                createField('Link', 'Text', 255);
                createField('Description', 'LongTextArea', 131072);
                createField('PublicationDate', 'Text', 255);
                createField('Category', 'Text', 255);
                createField('DataContent', 'LongTextArea', 131072);
            	createField('Source', 'Text', 255);   
    }
    public void insertBlogs() {
        
        try{
			
            String cObjName = objName + '__c'; 
    		       SObject s = Database.query('SELECT Name FROM ' +  cObjName + ' LIMIT 1');
					s.put('Title__c', 'Test');
                    s.put('Link__c', 'Test');
                    s.put('Description__c', 'Test');
                    s.put('PublicationDate__c', 'Test');
                    s.put('Category__c', 'Test');
                    s.put('DataContent__c', 'Test');
                    s.put('Source__c', 'Test');
            }
            
        catch(DMLException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, 'Error exporting data'));
        }
    }
    
    public static void createObject(){       
        MetadataService.CustomObject customeObject = new MetadataService.CustomObject();       
        service = createService();       
        customeObject.fullName = objName + '__c';       
        customeObject.label = objName;       
        customeObject.pluralLabel = objName + 's';       
        customeObject.nameField = new MetadataService.customField();       
        customeObject.nameField.type_x = 'Text';       
        customeObject.nameField.label = 'Sample Record';       
        customeObject.deploymentStatus = 'Deployed';       
        customeObject.sharingModel = 'ReadWrite';       
        List<MetadataService.SaveResult> results = service.createMetadata (new MetadataService.Metadata[] { customeObject });       
    }
    
    public static void createField(String fieldName, String type, Integer length)
	{
		service = createService();		
		MetadataService.CustomField customField = new MetadataService.CustomField();
		customField.fullName = objName + '__c.' + fieldName + '__c';
		customField.label = fieldName;
		customField.type_x = type;
        if(type == 'LongTextArea' || type == 'RichTextArea')
        {
            customField.visibleLines = 3;
        }
		customField.length = length;
		List<MetadataService.SaveResult> results = 		
			service.createMetadata(
				new MetadataService.Metadata[] { customField });				
	}
    
    public static MetadataService.MetadataPort createService() {            
        service = new MetadataService.MetadataPort();             
        service.SessionHeader = new MetadataService.SessionHeader_element();             
        service.SessionHeader.sessionId = UserInfo.getSessionId();             
        return service;         
     }
}