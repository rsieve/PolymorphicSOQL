public with sharing class ctrl_polymorphicSOQL {
	public List<polyTask> polytasks {get;set;}
	
	public ctrl_polymorphicSOQL(){
		updateTasks();
	}
	
	
	public void updateTasks(){
		List<Task> tasks = [SELECT subject, activityDate,
					  TYPEOF What
					    WHEN Account THEN name, AccountNumber, website, phone
					    WHEN Opportunity THEN name, Amount, CloseDate, probability
					    WHEN Case THEN casenumber, subject, priority
					    ELSE Name
					  END

				FROM Task
			  	WHERE What.Type IN ('Account', 'Opportunity', 'Case')
				];
		polytasks = new List<polyTask>(); 	
	  	for(Task t : tasks){
	  		polyTasks.add(new polyTask(t));
	  	}
	}
	
	public class polyTask{
		public Task t {get;set;}
		public string whatType {get;set;}
		public Account a {get;set;}
		public Opportunity o {get;set;}
		public Case c {get;set;}
		public string recName {get;set;}
		
		public polyTask(Task tmpTask){
			t = tmpTask;
			if(t.what instanceOf Account){
				whatType = 'Account';
				a = (Account)t.what;
			}
			else if(t.what instanceOf Opportunity){
				whatType = 'Opportunity';
				o = (Opportunity)t.what;
			}
			else if(t.what instanceOf Case){
				whatType = 'Case';
				c = (Case)t.what;
			}
			else{
				whatType = 'Other';
				recName = t.what.name;
			}
		}
	}
}