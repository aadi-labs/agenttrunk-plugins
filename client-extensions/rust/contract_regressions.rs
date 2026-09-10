use agenttrunk::prelude::*;

#[test]
fn billing_accepts_boolean_metering_state() {
    for enabled in [false, true] {
        let wire = serde_json::json!({"plan":"free","accesses":0,"includedAccesses":1000,"spendLimitCents":0,"meteringActive":enabled,"canManage":true});
        assert!(serde_json::from_value::<GetBillingResponse>(wire).is_ok());
    }
}

#[test]
fn first_note_serializes_required_null() {
    let request = PutProvenanceContextsRequest {revision_id:"a".repeat(64), text:"Reviewed".into(), expected_notes_commit_sha:None};
    let wire = serde_json::to_value(request).unwrap();
    assert_eq!(wire.get("expectedNotesCommitSha"), Some(&serde_json::Value::Null));
}
