public class TestarEmail {
    
    public static void enviarEmail(){
        
        Messaging.SingleEmailMessage criarMeuEmail = new Messaging.SingleEmailMessage();
        criarMeuEmail.setToAddresses(new List<String> {'m7oliveiraf@gmail.com'});
        criarMeuEmail.setSubject('Nos que agradecemos amigo');
        criarMeuEmail.setPlainTextBody('Foi um prazer trabalhar com vocês');
        
        Messaging.sendEmail ( new List<Messaging.SingleEmailMessage> {criarMeuEmail});
    }

}