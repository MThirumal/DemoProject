trigger ContactSumTrigger on Contact (After insert,After Update, After delete, After undelete) {
    Set<Id> parentIdsSet = new Set<Id>();
    List<Account> accountListToUpdate = new List<Account>();
    IF(Trigger.IsAfter){
        IF(Trigger.IsInsert || Trigger.IsUndelete || Trigger.IsUpdate){
            FOR(Contact c : Trigger.new){
                if(c.AccountId!=null && c.Active__c == true){   
                   parentIdsSet.add(c.AccountId); 
                }
            }
        }
        IF(Trigger.IsDelete){
            FOR(Contact c : Trigger.Old){
                if(c.AccountId!=null && c.Active__c == true){   
                   parentIdsSet.add(c.AccountId); 
                }
            }
        }
    }
    System.debug('#### parentIdsSet = '+parentIdsSet);
    List<Account> accountList = new List<Account>([Select id ,Name, Total_Contacts__c, (Select id, Name, Active__c From Contacts) 
                                                   from Account 
                                                   Where id in:parentIdsSet]);
    FOR(Account acc : accountList){
        List<Contact> contactList = acc.Contacts;
        acc.Total_Contacts__c = contactList.size();
        accountListToUpdate.add(acc);
        
    }
    try{
        update accountListToUpdate;
    }catch(System.Exception e){
        
    }
}