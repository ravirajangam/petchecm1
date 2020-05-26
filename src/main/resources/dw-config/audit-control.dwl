%output application/json
%var auditTemp=flowVars.auditHeader
 when flowVars.auditHeader !=null
otherwise
{
	"creationDateTime" :  now  as :string {format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"},
	"auditTrackingID": flowVars.transactionId,
	"messageInitiator": "MULE",
	"correlationID":  flowVars.MULE_CORRELATION_ID
	
}
---
{
	AuditBlock: {
		StageIndicator: {
		EventName: flowVars.auditLogLocation
		},
		Initiator: {
			System: auditTemp.messageInitiator,
			CorrelationID: auditTemp.correlationID
		},
		Trace: {
			AuditTrackingID: auditTemp.auditTrackingID,
			CreationDateTime: auditTemp.creationDateTime
		}
	},  
	
	Identifiers:[
		{
			IdentifierName: 'Transaction ID',
			IdentifierValue: flowVars.transactionId
		}
	],
	(Status: {
		OutcomeCode: 'Success'
	}) when flowVars.auditLogLocation == 'EndAudit',
	(Status: {
		Checkpoint: flowVars.checkpoint,
		OutcomeCode: 'Intermediate'
	}) when flowVars.auditLogLocation == 'IntermediateAudit' and flowVars.checkpoint !=null,
	(Status: {
		ErrorDetails: flowVars.exceptionDetails,
		OutcomeCode: 'Failure'
	}) when flowVars.auditLogLocation == 'ErrorAudit'
}