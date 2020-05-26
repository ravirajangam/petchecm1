%dw 1.0
%output application/json encoding="UTF-8", skipNullOn="everywhere"
---
{
  "name": payload,
  ("details": [
   	{
      "field": flowVars.errorField,
      "issue": flowVars.errorDescription,
      "location": "body"
    }
  ]) when flowVars.errorField != null and flowVars.errorDescription != null,
  "message": flowVars.errorMessage,
  "transaction_id": flowVars.transactionId,
  "suggested_action": flowVars.suggestedAction
}