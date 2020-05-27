package steps;

import io.cucumber.java.en.*;
import io.restassured.http.ContentType;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;
import org.apache.http.HttpStatus;
import org.junit.After;
import org.junit.Before;
import utils.*;
import java.time.*;
import java.util.*;
import static org.junit.Assert.*;

public class GetExchangeRates {
    RequestSpecification getRequest;
    Response getResponse;
    String serviceURL;
    APIUtils apiUtils = new APIUtils();
    String[] currencyList = {"AUD","BGN","BRL","CAD","CHF","CNY","CYP","CZK","DKK","EEK","EUR","GBP","HKD","HRK","HUF","IDR","ILS","INR","ISK","JPY","KRW","LTL","LVL","MTL","MXN","MYR","NOK","NZD","PHP","PLN","ROL","RON","RUB","SEK","SGD","SIT","SKK","THB","TRL","TRY","USD","ZAR"};

    @Given("user populates RatesAPI request to get Latest Foreign Exchange rates with default base currency")
    public void userPopulatesRatesAPIRequestToGetLatestForeignExchangeRatesWithDefaultBaseCurrency() {
        getRequest = apiUtils.request();
        serviceURL = apiUtils.loadProperties().getProperty("service.url").concat("latest");
    }

    @Given("user populates RatesAPI request to get Foreign Exchange rates with date {string}")
    public void userPopulatesRatesAPIRequestToGetPastForeignExchangeRatesWithDate(String date) {
        getRequest = apiUtils.request().pathParam("date",date);
        serviceURL = apiUtils.loadProperties().getProperty("service.url").concat("{date}");
    }

    @Given("user populates RatesAPI request to get Latest Foreign Exchange rates with default base currency and symbols {string}")
    public void userPopulatesRatesAPIRequestToGetLatestForeignExchangeRatesWithDefaultBaseCurrencyAndSymbols(String currencyCodes) {
        getRequest = apiUtils.request().queryParam("symbols",currencyCodes);
        serviceURL = apiUtils.loadProperties().getProperty("service.url").concat("latest");
    }

    @Given("user populates RatesAPI request to get Latest Foreign Exchange rates with user provided base currency {string}")
    public void userPopulatesRatesAPIRequestToGetLatestForeignExchangeRatesWithUserProvidedBaseCurrency(String currency) {
        getRequest = apiUtils.request().queryParam("base",currency);
        serviceURL = apiUtils.loadProperties().getProperty("service.url").concat("latest");
    }

    @Given("user populates RatesAPI request to get Latest Foreign Exchange rates with user provided base currency {string} and symbols {string}")
    public void userPopulatesRatesAPIRequestToGetLatestForeignExchangeRatesWithUserProvidedBaseCurrencyAndSymbols(String currency, String currencyCodes) {
        getRequest = apiUtils.request().queryParams("base",currency,"symbols",currencyCodes);
        serviceURL = apiUtils.loadProperties().getProperty("service.url").concat("latest");
    }

    @Given("user populates RatesAPI request to get Foreign Exchange rates with date {string} and symbols {string}")
    public void userPopulatesRatesAPIRequestToGetPastForeignExchangeRatesWithDateAndSymbols(String date, String currencyCodes) {
        getRequest = apiUtils.request().pathParam("date",date).queryParam("symbols",currencyCodes);
        serviceURL = apiUtils.loadProperties().getProperty("service.url").concat("{date}");
    }

    @Given("user populates RatesAPI request to get Foreign Exchange rates with date {string} and base currency {string}")
    public void userPopulatesRatesAPIRequestToGetPastForeignExchangeRatesWithDateAndBaseCurrency(String date, String currency) {
        getRequest = apiUtils.request().pathParam("date",date).queryParam("base",currency);
        serviceURL = apiUtils.loadProperties().getProperty("service.url").concat("{date}");
    }

    @Given("user populates RatesAPI request to get Foreign Exchange rates with date {string} and base currency {string} and symbols {string}")
    public void userPopulatesRatesAPIRequestToGetPastForeignExchangeRatesWithDateAndBaseCurrencyAndSymbols(String date, String currency,String currencyCodes) {
        getRequest = apiUtils.request().pathParam("date",date).queryParams("base",currency,"symbols",currencyCodes);;
        serviceURL = apiUtils.loadProperties().getProperty("service.url").concat("{date}");
    }

    @When("user sends the RatesAPI request with valid url")
    public void userSendsTheRatesAPIRequestWithValidUrl() {
        getResponse = apiUtils.getResponse(getRequest, serviceURL);
    }

    @When("user sends the RatesAPI request with invalid url")
    public void userSendsTheRatesAPIRequestWithInvalidUrl() {
        getResponse = apiUtils.getResponse(getRequest, serviceURL.concat("/latest"));
    }

    @Then("check RatesAPI http response status code {string}")
    public void checkRatesAPIHttpResponseStatusCode(String statusCode) {
        assertEquals(String.valueOf(getResponse.statusCode()), statusCode);
        Log.info("API responded with HTTP status code 200");
    }

    /*  1. Assert response content type is JSON
        2. Assert Base Currency is EUR
        3. Assert Currency Code in the response matches predefined codes provided in the Rates API documentation
    */
    @And("check response contains mandatory parameters and matches currency {string}")
    public void checkResponseContainsMandatoryParametersAndMatchesCurrency(String defaultCurrency) {
        if(getResponse.statusCode()== HttpStatus.SC_OK){
            assertEquals(getResponse.getContentType(), ContentType.JSON.toString());
            assertEquals(getResponse.path("base"), defaultCurrency);
            Map<String, Double> map = new HashMap<>();
            if (getResponse.path("rates") != null) {
                map.putAll(getResponse.path("rates"));
            }
            for (String currency : map.keySet()) {
                assertTrue(Arrays.asList(currencyList).contains(currency));
            }
        }else {
            Log.error("API responded with HTTP status code other than 200");
        }
    }

    /*  1. Assert response content type is JSON
        2. Assert Base Currency is EUR
        3. Assert Currency Code in the response matches symbols sent in the query params
    */
    @And("check response contains mandatory parameters and matches currency {string} and symbols {string}")
    public void checkResponseContainsMandatoryParametersAndMatchesCurrencyAndSymbols(String defaultCurrency,String currencyCodes) {
        if(getResponse.statusCode()== HttpStatus.SC_OK){
            assertEquals(getResponse.getContentType(), ContentType.JSON.toString());
            assertEquals(getResponse.path("base"), defaultCurrency);
            Map<String, Double> map = new HashMap<>();
            if (getResponse.path("rates") != null) {
                map.putAll(getResponse.path("rates"));
            }
            for (String currency : currencyCodes.split(",")) {
                assertTrue(map.containsKey(currency));
            }
        }else {
            Log.error("API responded with HTTP status code other than 200");
        }
    }

    /*  1. Assert date in the response match yesterday's date if it is a weekday and before the cut off time
    16:00 Central European Time
        2. Assert date in the response matches last working date if it is a weekend
        3. Assert date in the response match current date if it is after the cut off time 16:00 CET
    */
    @And("check response date matches latest date")
    public void checkResponseDateMatchesLatestDate() {
        if(LocalDate.now().getDayOfWeek().toString().equals("SATURDAY")){
            assertEquals(getResponse.path("date"), LocalDate.now().minusDays(1).toString());
        }else if(LocalDate.now().getDayOfWeek().toString().equals("SUNDAY")){
            assertEquals(getResponse.path("date"), LocalDate.now().minusDays(2).toString());
        }else if(LocalTime.now(ZoneId.of("CET")).isBefore(LocalTime.parse("16:00"))){
            assertEquals(getResponse.path("date"), LocalDate.now().minusDays(1).toString());
        }else {
            assertEquals(getResponse.path("date"), LocalDate.now().toString());
        }
        Log.info("Date in the API response matches the expected result");
    }

    /*  1. Assert date in the response matches the date given in the request if it is a weekday
        2. Assert date in the response matches last working date if it is a weekend
    */
    @And("check response date matches the specific date {string}")
    public void checkResponseDateMatchesTheSpecificDate(String pastDate) {
        if(LocalDate.parse(pastDate).getDayOfWeek().toString().equals("SATURDAY")){
            assertEquals(getResponse.path("date"), LocalDate.parse(pastDate).minusDays(1).toString());
        }else if(LocalDate.parse(pastDate).getDayOfWeek().toString().equals("SUNDAY")){
            assertEquals(getResponse.path("date"), LocalDate.parse(pastDate).minusDays(2).toString());
        }else {
            assertEquals(getResponse.path("date"), pastDate);
        }
        Log.info("Date in the API response matches the expected result");
    }

    @And("verify error description matches {string}")
    public void verifyErrorDescriptionMatches(String errorDescription) {
        assertEquals(getResponse.path("error"),errorDescription);
        Log.info("Error Description in the API response matches the expected result");
    }
}
