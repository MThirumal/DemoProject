public class OptyUpdateDelete {
    Public void callme(){
        User u = [select id from user where alias='arish'];
        List<opportunity> optylist=[Select Id from opportunity
                                    where ownerid=:u.id];
        for(opportunity op : optylist){
            
        op.StageName='Closed Won';
        op.CloseDate=system.today()+15;
        }
        update optylist;
    }
     Public void showme(){
        User u = [select id from user where alias='arish'];
        List<opportunity> optylist=[Select Id from opportunity
                                    where ownerid=:u.id];
       
        delete optylist;
    }
}