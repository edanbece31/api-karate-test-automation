package examples.pets;

import com.intuit.karate.junit5.Karate;

public class CreatePetsRunner {

    @Karate.Test
    Karate testCreatePets() {
        return Karate.run("createPets").relativeTo(getClass());
    }

}
