trigger ContactsonAccountTrigger on Contact (After insert, After Update, After delete, After undelete) {
      IF(Trigger.IsAfter){
        IF(Trigger.IsInsert || Trigger.IsUndelete || Trigger.IsUpdate){
            ContactsonAccount.ContactsAdded(Trigger.new);
        }
        IF(Trigger.IsDelete){
            ContactsonAccount.ContactsDeleted(Trigger.old);
        }
    }
}