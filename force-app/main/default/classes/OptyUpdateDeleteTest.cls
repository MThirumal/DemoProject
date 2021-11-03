@isTest
public class OptyUpdateDeleteTest {
	@Testsetup
    static void create(){
    User u = [select id from user where alias='arish'];
        opportunity op= new opportunity();
        op.Name='Testing';
        op.StageName='Qualification';
        op.CloseDate=system.today();
        insert op;
    }
    @isTest
    static void test1(){
        OptyUpdateDelete oud= new OptyUpdateDelete();
        oud.callme();
        User u = [select id from user where alias='arish'];
        List<Opportunity> optylist=[Select id, name, Stagename, Closedate from opportunity where ownerid=:u.id];
        for(opportunity opty : optylist){
        system.assertEquals('Closed Won', opty.Stagename);
        system.assertEquals(system.today()+15, opty.closedate);
        }
    }
    @isTest
    static void test2(){
        OptyUpdateDelete oud= new OptyUpdateDelete();
        oud.showme();
        User u = [select id from user where alias='arish'];
        Integer count =[Select count() from opportunity where ownerid=:u.id];
        
        system.assertEquals(0, count);
        
    }
}