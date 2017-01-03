/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class SignatureController {
    global Date Dat {
        get;
        set;
    }
    global Datetime Dat1 {
        get;
        set;
    }
    global Date Dat2 {
        get;
        set;
    }
    global String DateHidden {
        get;
        set;
    }
    global String DateHidden2 {
        get;
        set;
    }
    global static String errMsg {
        get;
        set;
    }
    global Id parentId {
        get;
        set;
    }
    global static String ParentObjectName;
    global signature__Signature__c signVf {
        get;
        set;
    }
    global SignatureController(ApexPages.StandardController controller) {

    }
    @RemoteAction
    global static signature.SignatureController.RemoteSaveResult saveFile(Id trashId, String imageData, String SignName, String SignName2, String City, String State, String dt, String dt2, String legaltext, String parentRecordId) {
        return null;
    }
    @RemoteAction
    global static signature.SignatureController.RemoteSaveResult saveFile1(Id trashId, String imageData, List<String> fields, String legaltext, String parentRecordId) {
        return null;
    }
global class RemoteSaveResult {
    global Id attachmentId;
    global String errorMessage;
    global Id signId;
    global Boolean success;
    global RemoteSaveResult() {

    }
}
}
