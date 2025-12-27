package examples.authentication;

import com.intuit.karate.junit5.Karate;

public class AuthenticaticationRunner {

    @Karate.Test
    Karate testAuthentication() {
        return Karate.run("authentication").relativeTo(getClass());
    }
    
}
