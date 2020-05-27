$(document).ready(function() {var formatter = new CucumberHTML.DOMFormatter($('.cucumber-report'));formatter.uri("file:src/test/resources/features/RatesAPI.feature");
formatter.feature({
  "name": "Rates API Test Scenarios",
  "description": "",
  "keyword": "Feature",
  "tags": [
    {
      "name": "@RatesAPI"
    }
  ]
});
formatter.scenarioOutline({
  "name": "Get Latest Foreign Exchange rates with default base currency",
  "description": "",
  "keyword": "Scenario Outline"
});
formatter.step({
  "name": "user populates RatesAPI request to get Latest Foreign Exchange rates with default base currency",
  "keyword": "Given "
});
formatter.step({
  "name": "user sends the RatesAPI request with valid url",
  "keyword": "When "
});
formatter.step({
  "name": "check RatesAPI http response status code \"\u003cStatusCode\u003e\"",
  "keyword": "Then "
});
formatter.step({
  "name": "check response contains mandatory parameters and matches default currency \"\u003cDefaultCurrency\u003e\"",
  "keyword": "And "
});
formatter.examples({
  "name": "",
  "description": "",
  "keyword": "Examples",
  "rows": [
    {
      "cells": [
        "DefaultCurrency",
        "StatusCode"
      ]
    },
    {
      "cells": [
        "EUR",
        "200"
      ]
    }
  ]
});
formatter.scenario({
  "name": "Get Latest Foreign Exchange rates with default base currency",
  "description": "",
  "keyword": "Scenario Outline",
  "tags": [
    {
      "name": "@RatesAPI"
    }
  ]
});
formatter.step({
  "name": "user populates RatesAPI request to get Latest Foreign Exchange rates with default base currency",
  "keyword": "Given "
});
formatter.match({
  "location": "steps.GetLatestExchangeRates.userPopulatesRatesAPIRequestToGetLatestForeignExchangeRatesWithDefaultBaseCurrency()"
});
formatter.result({
  "status": "passed"
});
formatter.step({
  "name": "user sends the RatesAPI request with valid url",
  "keyword": "When "
});
formatter.match({
  "location": "steps.GetLatestExchangeRates.userSendsTheRatesAPIRequestWithValidUrl()"
});
formatter.result({
  "status": "passed"
});
formatter.step({
  "name": "check RatesAPI http response status code \"200\"",
  "keyword": "Then "
});
formatter.match({
  "location": "steps.GetLatestExchangeRates.checkRatesAPIHttpResponseStatusCode(java.lang.String)"
});
formatter.result({
  "status": "passed"
});
formatter.step({
  "name": "check response contains mandatory parameters and matches default currency \"EUR\"",
  "keyword": "And "
});
formatter.match({
  "location": "steps.GetLatestExchangeRates.checkResponseContainsMandatoryParametersAndMatchesDefaultCurrency(java.lang.String)"
});
formatter.result({
  "status": "passed"
});
formatter.scenario({
  "name": "Get Latest Foreign Exchange rates with default base currency",
  "description": "",
  "keyword": "Scenario",
  "tags": [
    {
      "name": "@RatesAPI"
    }
  ]
});
formatter.step({
  "name": "user populates RatesAPI request to get Latest Foreign Exchange rates with default base currency",
  "keyword": "Given "
});
formatter.match({
  "location": "steps.GetLatestExchangeRates.userPopulatesRatesAPIRequestToGetLatestForeignExchangeRatesWithDefaultBaseCurrency()"
});
formatter.result({
  "status": "passed"
});
formatter.step({
  "name": "user sends the RatesAPI request with invalid url",
  "keyword": "When "
});
formatter.match({
  "location": "steps.GetLatestExchangeRates.userSendsTheRatesAPIRequestWithInvalidUrl()"
});
formatter.result({
  "status": "passed"
});
formatter.step({
  "name": "check RatesAPI http response status code \"404\"",
  "keyword": "Then "
});
formatter.match({
  "location": "steps.GetLatestExchangeRates.checkRatesAPIHttpResponseStatusCode(java.lang.String)"
});
formatter.result({
  "status": "passed"
});
});