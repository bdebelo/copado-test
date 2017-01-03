public class RSS_StreamReader {
     
    public class item {
        public String title {get;set;}
        public String guid {get;set;}
        public String link {get;set;}
        public String description {get;set;}
        public String content {get; set;}
        public DateTime pubDate {get;set;}
        public String source {get;set;}
    }
    
    
    public static list<RSS_StreamReader.item> getRSSData(string feedURL) {
        
        List<RSS_StreamReader.item> items = new List<RSS_StreamReader.item>();
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint(feedURL);
        req.setMethod('GET');
         
        Dom.Document doc = new Dom.Document();
        
        Http h = new Http();
        XmlStreamReader reader; 
         
        if (!Test.isRunningTest()){
            HttpResponse res = h.send(req);
            doc = res.getBodyDocument();
            reader = new XmlStreamReader(res.getBody());
        } else {
            //doc.load(xmlString);
        }
                  
        boolean isSafeToGetNextXmlItem = true;
        
        while(isSafeToGetNextXmlItem) {
            if (reader.getEventType() == XmlTag.START_ELEMENT) {
                System.debug('^^^^' + reader.getLocalName());
                if ('item' == reader.getLocalName()) {
                    Rss_StreamReader.item item = parseItem(reader);
                    items.add(item);
                }
            }
            
             if (reader.hasNext()) {
                reader.next();
            } else {
                isSafeToGetNextXmlItem = false;
                break;
            }
         }
        return items;
    }
    
    public static Rss_StreamReader.item parseItem(XmlStreamReader reader)
    {
        boolean isSafeToGetNextXmlElement = true;
        RSS_StreamReader.item rssItem = new RSS_StreamReader.item();
        
        System.debug(reader);

        while(isSafeToGetNextXmlElement) {
                if (reader.getEventType() == XmlTag.END_ELEMENT &&
                   'item' == reader.getLocalName()) {
                    isSafeToGetNextXmlElement = false;  
                       break;
                }
                if (reader.getEventType() == XmlTag.START_ELEMENT) {
                    System.debug('****' + reader.getLocalName() + '~~~~' + reader.getNamespace());
                    if ('title' == reader.getLocalName() && reader.getNamespace() == null) {
                            rssItem.title = parseString(reader);
                    }
                    if ('link' == reader.getLocalName() && reader.getNamespace() == null) {
                            rssItem.link = parseString(reader);
                    }
                    if ('description' == reader.getLocalName()) {
                            rssItem.description = parseString(reader);
                    }
                    if ('content' == reader.getLocalName()) {
                            rssItem.content = parseString(reader);
                    } 
                    if ('pubDate' == reader.getLocalName() ) {
                            rssItem.pubDate = convertRSSDateStringToDate(parseString(reader));
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
        return rssItem;
    }
    
     public static String parseString(XmlStreamReader reader) {
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
    
    public static DateTime convertRSSDateStringToDate(String s) {
        String months = 'January,February,March,April,May,June,July,August,September,October,November,December';
        String monthsShort = 'Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec';
        
        String m,d,y;
        
        String[] dateArray = s.split(' ');
        d = dateArray[1];
        y = dateArray[3];
        String[] t = dateArray[4].split(':');
        
        if( monthsShort.indexOf(dateArray[2]) >= 0 ) {
            String[] monthsArray = monthsShort.split(',');
            String mString = dateArray[2];
            for(Integer i = 0; i < monthsArray.size(); i++) {
                if(mString == monthsArray[i]) {
                    m = String.valueOf(i + 1);
                }
            }
        }
        String postfix = (Integer.valueOf(t[0])>12) ? 'PM' : 'AM';
        return DateTime.newInstance(Integer.valueOf(y),Integer.valueOf(m),
                                    Integer.valueOf(d),
                                    Integer.valueOf(t[0]),
                                    Integer.valueOf(t[1]),
                                    Integer.valueOf(t[2]));
            
    }    
}