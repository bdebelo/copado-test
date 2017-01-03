<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Notify_Applicant_Application_has_been_approved</fullName>
        <description>Notify Applicant Application has been approved</description>
        <protected>false</protected>
        <recipients>
            <field>SubmittedBy__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Applicant_Notification_for_Tax_Credit_Application</template>
    </alerts>
    <fieldUpdates>
        <fullName>Update_Application_Status</fullName>
        <field>ApplicationStatus__c</field>
        <literalValue>Approved</literalValue>
        <name>Update Application Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
</Workflow>
