public class BlogLog_RssReader{
    public List<Blog_Entry__c> read(String document) {
        List<Blog_Entry__c> ret = new List<Blog_Entry__c>();
        boolean isSafeToGetNextXmlElement = true;
        
        XmlStreamReader reader = new XmlStreamReader(document);
        
        while(isSafeToGetNextXmlElement) {
            if (reader.getEventType() == XmlTag.START_ELEMENT) {
                System.debug('^^^^' + reader.getLocalName());
                if ('item' == reader.getLocalName()) {
                    Blog_Entry__c item = parseItem(reader);
                    ret.add(item);
                }
            }
            // Always use hasNext() before calling next() to confirm 
            // that we have not reached the end of the stream
            if (reader.hasNext()) {
                reader.next();
            } else {
                isSafeToGetNextXmlElement = false;
                break;
            }
        }        
        
        return ret;
    }
    
    Blog_Entry__c parseItem(XmlStreamReader reader) {

        Blog_Entry__c ret = new Blog_Entry__c();
        boolean isSafeToGetNextXmlElement = true;
        
        while(isSafeToGetNextXmlElement) {
            if (reader.getEventType() == XmlTag.END_ELEMENT &&
               'item' == reader.getLocalName()) {
                isSafeToGetNextXmlElement = false;  
                   break;
            }
            if (reader.getEventType() == XmlTag.START_ELEMENT) {
                System.debug('****' + reader.getLocalName() + '~~~~' + reader.getNamespace());
                if ('title' == reader.getLocalName() && reader.getNamespace() == null) {
                        String title = parseString(reader);
                        ret.Title__c = title;
                }
                if ('link' == reader.getLocalName() && reader.getNamespace() == null) {
                        String link = parseString(reader);
                        ret.Link__c = link;
                }
                if ('origLink' == reader.getLocalName()) {
                        String link = parseString(reader);
                        ret.Link__c = link;
                }
                if ('creator' == reader.getLocalName() ) {
                        String author = parseString(reader);
                        ret.Author__c = author;
                } 
                if ('category' == reader.getLocalName() ) {
                        String category = parseString(reader);
                    if (ret.Category__c != null) {
                        ret.Category__c = ret.Category__c + ', ' + category;
                    } else {
                        ret.Category__c = category;
                    }
                    if (ret.Category__c.length() > 250) {
                        ret.Category__c = ret.Category__c.substring(0,249);
                    }
                }  
                if ('pubDate' == reader.getLocalName() ) {
                        String pubDate = parseString(reader);
                        ret.Published__c = convertRSSDateStringToDate(pubDate);
                } 
                if ('description' == reader.getLocalName() ) {
                        String description = parseString(reader);
                        ret.Lead_Copy__c = description;
                }                 

                
                
            }
            // Always use hasNext() before calling next() to confirm 
            // that we have not reached the end of the stream
            if (reader.hasNext()) {
                reader.next();
            } else {
                isSafeToGetNextXmlElement = false;
                break;
            }
        }        
        
        return ret;
        
    }
    
    String parseString(XmlStreamReader reader) {
        String ret = '';
        
        boolean isSafeToGetNextXmlElement = true;
        while(isSafeToGetNextXmlElement) {
            System.debug('****EVENTTYPE' + reader.getEventType());
            if (reader.getEventType() == XmlTag.END_ELEMENT) {
                break;
            } else if (reader.getEventType() == XmlTag.CHARACTERS) {
                System.debug('****Characters |' + reader.getText() + '|');
                ret = ret + reader.getText();
            } else if (reader.getEventType() == XmlTag.CDATA) {
                System.debug('****CDATA');
                ret = reader.getText();
            }
            // Always use hasNext() before calling next() to confirm 
            // that we have not reached the end of the stream
            if (reader.hasNext()) {
                reader.next();
            } else {
                isSafeToGetNextXmlElement = false;
                break;
            }
        }
        return ret.trim();
    }    
    
    public Date convertRSSDateStringToDate(String s) {
        String months = 'January,February,March,April,May,June,July,August,September,October,November,December';
        String monthsShort = 'Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec';
        
        String m,d,y;
        
        String[] dateArray = s.split(' ');
        d = dateArray[1];
        y = dateArray[3];
        if( monthsShort.indexOf(dateArray[2]) >= 0 ) {
            String[] monthsArray = monthsShort.split(',');
            String mString = dateArray[2];
            for(Integer i = 0; i < monthsArray.size(); i++) {
                if(mString == monthsArray[i]) {
                    m = String.valueOf(i + 1);
                }
            }
        }
        
        return Date.parse(m+'/'+d+'/'+y);
            
    }    
}