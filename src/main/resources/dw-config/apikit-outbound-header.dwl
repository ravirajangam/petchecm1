%output application/json
%var auditTemp=flowVars.auditHeader
 when flowVars.auditHeader !=null
otherwise
{
	"creationDateTime" :  now  as :string {format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"},
	"auditTrackingID": flowVars.transactionId,
	"messageInitiator": "MULE",	
	"correlationID": flowVars.MULE_CORRELATION_ID
}


---
{
	ResponseHeader: {
		TrackingID: auditTemp.auditTrackingID,
		CreationDateTime: auditTemp.creationDateTime,
		Initiator: auditTemp.messageInitiator,
		CorrelationID: auditTemp.correlationID
		
		
}
}