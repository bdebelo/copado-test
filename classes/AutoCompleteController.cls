public with sharing class AutoCompleteController {
    
   public String selectedAccout{get;set;}

    public void setInputvalue(){
        System.debug(selectedAccout);
    }
    
    public list<account> getAccountList(){
        return [select id,name from account limit 25];
    }
}