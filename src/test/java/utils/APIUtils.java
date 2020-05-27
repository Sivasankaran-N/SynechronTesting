package utils;

import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;
import java.io.*;
import java.util.Properties;
import static io.restassured.RestAssured.given;

public class APIUtils {
    RequestSpecification request;
    Response response;

    // Generates RestAssured request object and returns the object reference
    public RequestSpecification request() {
        try {
            request = given()
                    .log()
                    .all();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return request;
    }

    // Generates RestAssured response object with HTTP method GET and returns the object reference
    public Response getResponse(RequestSpecification request, String url) {
        response = request
                .when()
                .get(url);
        response.then().log().all();
        return response;
    }

    // Loads predefined configuration properties from the file
    public Properties loadProperties(){
        File file = new File("src/test/resources/config.properties");
        FileInputStream fileInput = null;
        try {
            fileInput = new FileInputStream(file);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        Properties prop = new Properties();
        try {
            prop.load(fileInput);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return prop;
    }
}