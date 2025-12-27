package examples.posts;

import com.intuit.karate.junit5.Karate;

public class GetPostsRunner {

    @Karate.Test
    Karate getPostsTest() {
        return Karate.run("getPosts").relativeTo(getClass());
    }

}
