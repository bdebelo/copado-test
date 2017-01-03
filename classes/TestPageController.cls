public class TestPageController {

    public CIO__c cData {get;set;}
    public TestPageController(){
        String accID = ApexPages.currentPage().getParameters().get('Id');
        
        if(accID != null)
        {
            cData = [SELECT Id,Name,DataContent__c,Somker__c,Drinker__c FROM CIO__c WHERE Id =: accID];
        }
        else {cData = new CIO__c();}  
    }
    public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Yes','Yes'));
        options.add(new SelectOption('No','No')); 
        return options;
    }
    public Pagereference showLSDesc(){
        return null;
    }
    
}