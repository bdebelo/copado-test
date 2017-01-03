public class parseJSONString {
    public List<Results> results {get;set;}
    
    public List<Facets> facets {get; set;}
    
    public class Facets {
		public List<Results> results;
		public String name;
		
		Public Facets(List<Results> result, String names){
			results = result.clone();
			name = names;
		}
	}
	public class Results {
		public String value {get;set;}
		public Integer count {get;set;}
		public List<Articles> articles {get; set;}
	}
	public class Articles {
		public Attributes attributes{get;set;}
		
	}
	public class Attributes {
		public String type{get;set;}
		public String url{get;set;}
	}
    
    public void parser(){
        String js = '{"facets":[{"results":[],"name":"Type"},{"results":[],"name":"PACS_Categories__c"},{"results":[],"name":"Topology__c"},{"results":[],"name":"SuppliedName"},{"results":[{"value":"Laptop","count":3,"articles":[{"attributes":{"type":"Case","url":"/services/data/v33.0/sobjects/Case/500m0000002KWruAAG"},"PACS_Categories__c":"--Please Select a response--","Product_Service_Name__c":"Laptop","Id":"500m0000002KWruAAG","Topology__c":"13.1"},{"attributes":{"type":"Case","url":"/services/data/v33.0/sobjects/Case/500m0000002HufyAAC"},"PACS_Categories__c":"--Please Select a response--","Product_Service_Name__c":"Laptop","Id":"500m0000002HufyAAC","Topology__c":"13.1"},{"attributes":{"type":"Case","url":"/services/data/v33.0/sobjects/Case/500m0000002Xc3gAAC"},"PACS_Categories__c":"--Please Select a response--","Product_Service_Name__c":"Laptop","Id":"500m0000002Xc3gAAC","Topology__c":"13.1"}]}],"name":"Product_Service_Name__c"},{"results":[],"name":"Name"},{"results":[],"name":"ShippingPostalCode"},{"results":[],"name":"SicDesc"},{"results":[],"name":"AccountSource"}]}';
        JSONParser parser = JSON.createParser(js);
    //while (parser.nextToken() != null) {
        // Start at the array of invoices. 
    
        //if (parser.getCurrentToken() == JSONToken.START_ARRAY) {
            //while (parser.nextToken() != null) {
                // Advance to the start object marker to 
    
                //  find next invoice statement object. 
    
                //if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
                    // Read entire invoice object, including its array of line items. 
    
                    Map<String, Object> inv = (Map<String, Object>)JSON.deserializeUntyped(js);
                    //system.debug('Facet Name: ' + inv.name);
                    
                    system.debug('Size: ' + inv);
                    
    					
        			List<Object>  lstObject = (List<Object>)inv.get('facets');
       				 if(lstObject.size() > 0){
                        for(Object result :lstObject) {
                          Map<String,Object> mpParsed = (Map<String,Object>)result;
                          
                          system.debug('Serialized invoice: ' + mpParsed.get('results'));  
                        }
                     }
        			
                    String s = JSON.serialize(inv);
                    system.debug('Serialized invoice: ' + s);

    				//facets.add(inv);
                    parser.skipChildren();
                //}
            //}
        //}
    //}
    }
}