public class StringArrayTest {
    
    public StringArrayTest(){
        
    }
    
    public static List<String> generateStringArray(Integer n){
        List<String> retVal = new List<String>();
        Integer counter = 0;

        for(Integer i=0; i < n ; i++){
			retVal.add('Test ' + counter);
            counter ++;
        }

        return retVal;
    }

}