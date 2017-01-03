<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>signature__Signature_Required</fullName>
        <description>Signature Required</description>
        <protected>false</protected>
        <recipients>
            <field>signature__Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>signature__Simple_Signature/signature__EmailSignature</template>
    </alerts>
    <fieldUpdates>
        <fullName>signature__Emailed_Date</fullName>
        <field>signature__Emailed__c</field>
        <formula>Now()</formula>
        <name>Emailed Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>signature__Status</fullName>
        <field>signature__Status__c</field>
        <literalValue>Emailed</literalValue>
        <name>Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>signature__Send Email</fullName>
        <actions>
            <name>signature__Signature_Required</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>signature__Emailed_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>signature__Status</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>signature__Signature__c.signature__Status__c</field>
            <operation>equals</operation>
            <value>Requested</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
