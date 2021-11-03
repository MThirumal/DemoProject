public class ContactsonAccount {
    public static void ContactsAdded(List<Contact> newContacts){
      Set<Id> parentIdsSet = new Set<Id>();
      List<Account> accountListToUpdate = new List<Account>();
            for(Contact c : newContacts){
                if(c.AccountId!=null && c.Active__c == true){   
                   parentIdsSet.add(c.AccountId); 
                }
            } 
      List<Account> accountList = new List<Account>([Select id ,Name, Total_Contacts__c, (Select id, Name, Active__c From Contacts) 
                                                   from Account 
                                                   Where id in:parentIdsSet]);
   	    for(Account acc : accountList){
        List<Contact> contactList = acc.Contacts;
        acc.Total_Contacts__c = contactList.size();
        accountListToUpdate.add(acc);
        
    }
    try{
        update accountListToUpdate;
    }catch(System.Exception e){
        
    }
  }
    public static void ContactsDeleted(List<Contact> oldContacts){
      Set<Id> parentIdsSet = new Set<Id>();
      List<Account> accountListToUpdate = new List<Account>();
            for(Contact c : oldContacts){
                if(c.AccountId!=null && c.Active__c == true){   
                   parentIdsSet.add(c.AccountId); 
                }
            } 
      List<Account> accountList = new List<Account>([Select id ,Name, Total_Contacts__c, (Select id, Name, Active__c From Contacts) 
                                                   from Account 
                                                   Where id in:parentIdsSet]);
   	    for(Account acc : accountList){
        List<Contact> contactList = acc.Contacts;
        acc.Total_Contacts__c = contactList.size();
        accountListToUpdate.add(acc);
        
    }
    try{
        update accountListToUpdate;
    }catch(System.Exception e){
        
    }
  }
  
}