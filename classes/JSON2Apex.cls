public class JSON2Apex {
	List<String> productName = new List<String>();
	public class Attributes {
		public String type;
		public String url;
	}

	public List<Facets> facets;

	public class Results {
		public String value;
		public Integer count;
		public List<Articles> articles;
	}

	public class Articles {
		public Attributes attributes;
		public String Id;
        public String Product_Service_Name_c;
	}

	public class Facets {
		public List<Results> results;
		public String name;
	}

	
	public static JSON2Apex parse(String json) {
		return (JSON2Apex) System.JSON.deserialize(json, JSON2Apex.class);
	}
    
    public void parseUntyped(String stringJSON) {
        String strJSON = '{"facets":[{"results":[],"name":"PACS_Categories__c","label":"PACS Categories"},{"results":[{"value":"laptop","count":3,"articles":[{"attributes":{"type":"Case","url":"/services/data/v33.0/sobjects/Case/500m0000002HufyAAC"},"PACS_Categories__c":"--Please Select a response--","Product_Service_Name__c":"Laptop","Id":"500m0000002HufyAAC","Topology__c":"13.1"},{"attributes":{"type":"Case","url":"/services/data/v33.0/sobjects/Case/500m0000002Xc3gAAC"},"PACS_Categories__c":"--Please Select a response--","Product_Service_Name__c":"Laptop","Id":"500m0000002Xc3gAAC","Topology__c":"13.1"},{"attributes":{"type":"Case","url":"/services/data/v33.0/sobjects/Case/500m0000002KWruAAG"},"PACS_Categories__c":"--Please Select a response--","Product_Service_Name__c":"Laptop","Id":"500m0000002KWruAAG","Topology__c":"13.1"}]}],"name":"Product_Service_Name__c","label":"Product / Service Name"},{"results":[],"name":"SuppliedName","label":"Name"},{"results":[],"name":"Topology__c","label":"Topology"},{"results":[],"name":"Type","label":"Case Type"}]}';
        Map<String, Object> root = (Map<String, Object>)JSON.deserializeUntyped(strJSON);
        System.debug('#####ROOT' + root);
        List<Object> facets = (List<Object>)root.get('facets');
        for (Object facet : facets) {
            Map<String, Object> f = (Map<String, Object>)facet;
            List<Object> results = (List<Object>)f.get('results');
            for (Object result : results)
            {
                Map<String, Object> r = (Map<String, Object>)result;
                if(!r.isEmpty())
                {
                    List<Object> articles = (List<Object>)r.get('articles');
                    for (Object article : articles) {
                        Map<String, Object> i = (Map<String, Object>)article;
                        productName.add(String.valueOf(i.get('Product_Service_Name__c')));
                        System.debug('#####' + i.get('Product_Service_Name__c'));
                    }    
                }
            }
        }
        System.debug('#####Facet' + facets);
    }
	
	public void tParse() {
		String json = '{"facets":[{"results":[],"name":"Type"},{"results":[],"name":"PACS_Categories__c"},{"results":[],"name":"Topology__c"},{"results":[],"name":"SuppliedName"},{"results":[{"value":"Laptop","count":3,"articles":[{"attributes":{"type":"Case","url":"/services/data/v33.0/sobjects/Case/500m0000002KWruAAG"},"PACS_Categories__c":"--Please Select a response--","Product_Service_Name__c":"Laptop","Id":"500m0000002KWruAAG","Topology__c":"13.1"},{"attributes":{"type":"Case","url":"/services/data/v33.0/sobjects/Case/500m0000002HufyAAC"},"PACS_Categories__c":"--Please Select a response--","Product_Service_Name__c":"Laptop","Id":"500m0000002HufyAAC","Topology__c":"13.1"},{"attributes":{"type":"Case","url":"/services/data/v33.0/sobjects/Case/500m0000002Xc3gAAC"},"PACS_Categories__c":"--Please Select a response--","Product_Service_Name__c":"Laptop","Id":"500m0000002Xc3gAAC","Topology__c":"13.1"}]}],"name":"Product_Service_Name__c"},{"results":[],"name":"Name"},{"results":[],"name":"ShippingPostalCode"},{"results":[],"name":"SicDesc"},{"results":[],"name":"AccountSource"}]}';
		JSON2Apex obj = parse(json);
        parseUntyped(json);
		System.debug('object' + obj);
        System.debug('Facets' + obj.Facets);
        //System.debug('Facets' + obj.Results);
        for(Facets facet : obj.Facets){
            for(Results r : facet.results)
            {
                if(!r.articles.isEmpty())
                {
                    Integer i = 0;
                    for(Articles a : r.articles)
                    {
                        a.Product_Service_Name_c = productName.get(i);
                        i++;
                        System.debug('Product Name' + a.Product_Service_Name_c);
                    }
                }
            }
        }
	}
}