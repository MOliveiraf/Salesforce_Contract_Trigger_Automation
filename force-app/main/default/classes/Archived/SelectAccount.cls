public class SelectAccount {
    
    public static List<Account> retornaContas(){
        
        return [ SELECT Id, Name, Rating, ParentId, Description,
               			NaicsDesc, BillingAddress, ShippingAddress, Fax,
               			Site, AccountSource
               FROM Account
               WHERE ID = '001aj00000avqQCAAY' ];
    }

}