@RatesAPI
Feature: Rates API Test Scenarios

  # TC #1 - Happy Path Scenario to check response code of Rates API- Acceptance Criteria - # 1
  Scenario: Get Latest Foreign Exchange rates with default base currency
    Given user populates RatesAPI request to get Latest Foreign Exchange rates with default base currency
    When user sends the RatesAPI request with valid url
    Then check RatesAPI http response status code "200"

  # TC #2 - Happy Path Scenario to test Rates API's Latest Foreign Exchange rates - Acceptance Criteria - # 2
  Scenario Outline: Get Latest Foreign Exchange rates with default base currency
    Given user populates RatesAPI request to get Latest Foreign Exchange rates with default base currency
    When user sends the RatesAPI request with valid url
    Then check RatesAPI http response status code "<StatusCode>"
    And check response contains mandatory parameters and matches currency "<DefaultCurrency>"
    And check response date matches latest date
    Examples:
      | DefaultCurrency | StatusCode  |
      | EUR             | 200         |

  # TC #3 - Negative Scenario to test Rates API's with Invalid URL - Acceptance Criteria - # 3
  Scenario: Get Latest Foreign Exchange rates with invalid url
    Given user populates RatesAPI request to get Latest Foreign Exchange rates with default base currency
    When user sends the RatesAPI request with invalid url
    Then check RatesAPI http response status code "404"

  # TC #4 - Happy Path Scenario to check response code of Rates API with past date - Acceptance Criteria - # 4
  Scenario Outline: Get Past Foreign Exchange rates with default base currency
    Given user populates RatesAPI request to get Foreign Exchange rates with date "<PastDate>"
    When user sends the RatesAPI request with valid url
    Then check RatesAPI http response status code "<StatusCode>"
    Examples:
      | PastDate    | StatusCode  |
      | 2019-10-10  | 200         |

  # TC #5 - Happy Path Scenario to test Rates API's Past Foreign Exchange rates - Acceptance Criteria - # 5
  Scenario Outline: Get Past Foreign Exchange rates with default base currency
    Given user populates RatesAPI request to get Foreign Exchange rates with date "<PastDate>"
    When user sends the RatesAPI request with valid url
    Then check RatesAPI http response status code "<StatusCode>"
    And check response contains mandatory parameters and matches currency "<DefaultCurrency>"
    And check response date matches the specific date "<PastDate>"
    Examples:
      | PastDate    | DefaultCurrency | StatusCode  |
      | 2010-10-10  | EUR             | 200         |

  # TC #6 -Happy Path Scenario to test Rates API Foreign Exchange rates with future date - Acceptance Criteria - 6
  Scenario Outline: Get future dated foreign exchange rates with default base currency
    Given user populates RatesAPI request to get Foreign Exchange rates with date "<FutureDate>"
    When user sends the RatesAPI request with valid url
    Then check RatesAPI http response status code "<StatusCode>"
    And check response contains mandatory parameters and matches currency "<DefaultCurrency>"
    And check response date matches latest date
    Examples:
      | FutureDate |  DefaultCurrency | StatusCode  |
      | 2020-10-10 |  EUR             | 200         |

  # TC #7 - Edge Case - Query Exchange Rate before the year 1999
  Scenario Outline: Get exchange rate for historic dates before the year 1999
    Given user populates RatesAPI request to get Foreign Exchange rates with date "<HistoricDate>"
    When user sends the RatesAPI request with valid url
    Then check RatesAPI http response status code "<StatusCode>"
    And verify error description matches "<ErrorDescription>"
    Examples:
      | HistoricDate |  StatusCode  | ErrorDescription                                  |
      | 1998-12-31   |  400         | There is no data for dates older then 1999-01-04. |

  # TC #8 - Happy Path Scenario to test Rates API's Latest Foreign Exchange rates with default currency and currency code filter
  Scenario Outline: Get Latest Foreign Exchange rates with default currency and currency code filter
    Given user populates RatesAPI request to get Latest Foreign Exchange rates with default base currency and symbols "<Symbols>"
    When user sends the RatesAPI request with valid url
    Then check RatesAPI http response status code "<StatusCode>"
    And check response contains mandatory parameters and matches currency "<DefaultCurrency>" and symbols "<Symbols>"
    And check response date matches latest date
    Examples:
      | Symbols | StatusCode  | DefaultCurrency   |
      | USD,GBP | 200         | EUR               |

  # TC #9 - Happy Path Scenario to test Rates API's Latest Foreign Exchange rates with user provided base currency
  Scenario Outline: Get Latest Foreign Exchange rates with user provided base currency
    Given user populates RatesAPI request to get Latest Foreign Exchange rates with user provided base currency "<Currency>"
    When user sends the RatesAPI request with valid url
    Then check RatesAPI http response status code "<StatusCode>"
    And check response contains mandatory parameters and matches currency "<Currency>"
    And check response date matches latest date
    Examples:
      | Currency | StatusCode  |
      | USD      | 200         |

 # TC #10 - Happy Path Scenario to test Rates API's Latest Foreign Exchange rates with user provided base currency and currency codes
  Scenario Outline: Get Latest Foreign Exchange rates with user provided base currency and currency code filter
    Given user populates RatesAPI request to get Latest Foreign Exchange rates with user provided base currency "<Currency>" and symbols "<Symbols>"
    When user sends the RatesAPI request with valid url
    Then check RatesAPI http response status code "<StatusCode>"
    And check response contains mandatory parameters and matches currency "<Currency>" and symbols "<Symbols>"
    And check response date matches latest date
    Examples:
      | Symbols | Currency | StatusCode  |
      | EUR,GBP | USD      | 200         |

  # TC #11 - Happy Path Scenario to test Rates API's Past Foreign Exchange rates with default currency and currency code filter
  Scenario Outline: Get Past Foreign Exchange rates with default currency and currency code filter
    Given user populates RatesAPI request to get Foreign Exchange rates with date "<PastDate>" and symbols "<Symbols>"
    When user sends the RatesAPI request with valid url
    Then check RatesAPI http response status code "<StatusCode>"
    And check response contains mandatory parameters and matches currency "<DefaultCurrency>" and symbols "<Symbols>"
    And check response date matches the specific date "<PastDate>"
    Examples:
      | PastDate    | Symbols  |  DefaultCurrency | StatusCode  |
      | 2010-10-10  | USD,GBP  |  EUR             | 200         |

  # TC #12 - Happy Path Scenario to test Rates API's Past Foreign Exchange rates with user provided base currency
  Scenario Outline: Get Past Foreign Exchange rates with user provided base currency
    Given user populates RatesAPI request to get Foreign Exchange rates with date "<PastDate>" and base currency "<Currency>"
    When user sends the RatesAPI request with valid url
    Then check RatesAPI http response status code "<StatusCode>"
    And check response contains mandatory parameters and matches currency "<Currency>"
    And check response date matches the specific date "<PastDate>"
    Examples:
      | PastDate    | Currency | StatusCode  |
      | 2010-10-10  | USD      | 200         |

  # TC #13 - Happy Path Scenario to test Rates API's Past Foreign Exchange rates with user provided base currency and currency codes
  Scenario Outline: Get Past Foreign Exchange rates with user provided base currency and currency codes
    Given user populates RatesAPI request to get Foreign Exchange rates with date "<PastDate>" and base currency "<Currency>" and symbols "<Symbols>"
    When user sends the RatesAPI request with valid url
    Then check RatesAPI http response status code "<StatusCode>"
    And check response contains mandatory parameters and matches currency "<Currency>" and symbols "<Symbols>"
    And check response date matches the specific date "<PastDate>"
    Examples:
      | PastDate    | Symbols  | Currency | StatusCode  |
      | 2010-10-10  | EUR,GBP  | USD      | 200         |

  # TC #14 - Edge Case to test Rates API's Latest Foreign Exchange rates with default currency and invalid currency code filter
  Scenario Outline: Get Latest Foreign Exchange rates with default currency and invalid currency code filter
    Given user populates RatesAPI request to get Latest Foreign Exchange rates with default base currency and symbols "<Symbols>"
    When user sends the RatesAPI request with valid url
    Then check RatesAPI http response status code "<StatusCode>"
    Examples:
      | Symbols | StatusCode  |
      | USA,GBP | 400         |

  # TC #15 - Edge Case to test Rates API's Latest Foreign Exchange rates with invalid base currency
  Scenario Outline: Get Latest Foreign Exchange rates with invalid base currency
    Given user populates RatesAPI request to get Latest Foreign Exchange rates with user provided base currency "<Currency>"
    When user sends the RatesAPI request with valid url
    Then check RatesAPI http response status code "<StatusCode>"
    Examples:
      | Currency | StatusCode  |
      | USA      | 400         |

  # TC #16 - Edge Case to test Rates API's Latest Foreign Exchange rates with invalid base currency and currency codes
  Scenario Outline: Get Latest Foreign Exchange rates with invalid base currency and invalid currency code filter
    Given user populates RatesAPI request to get Latest Foreign Exchange rates with user provided base currency "<Currency>" and symbols "<Symbols>"
    When user sends the RatesAPI request with valid url
    Then check RatesAPI http response status code "<StatusCode>"
    Examples:
      | Symbols | Currency | StatusCode  |
      | EUR,GBP | USA      | 400         |
      | EUA,GBP | USD      | 400         |

  # TC #17 - Edge Case to test Rates API's Past Foreign Exchange rates with default currency and invalid currency code filter
  Scenario Outline: Get Past Foreign Exchange rates with default currency and invalid currency code filter
    Given user populates RatesAPI request to get Foreign Exchange rates with date "<PastDate>" and symbols "<Symbols>"
    When user sends the RatesAPI request with valid url
    Then check RatesAPI http response status code "<StatusCode>"
    Examples:
      | PastDate    | Symbols  | StatusCode  |
      | 2010-10-10  | USA,GBP  | 400         |

  # TC #18 - Edge Case to test Rates API's Past Foreign Exchange rates with invalid base currency
  Scenario Outline: Get Past Foreign Exchange rates with invalid base currency
    Given user populates RatesAPI request to get Foreign Exchange rates with date "<PastDate>" and base currency "<Currency>"
    When user sends the RatesAPI request with valid url
    Then check RatesAPI http response status code "<StatusCode>"
    Examples:
      | PastDate    | Currency | StatusCode  |
      | 2010-10-10  | USA      | 400         |

  # TC #19 - Edge Case to test Rates API's Past Foreign Exchange rates with user provided base currency and currency codes
  Scenario Outline: Get Past Foreign Exchange rates with invalid base currency and invalid currency codes
    Given user populates RatesAPI request to get Foreign Exchange rates with date "<PastDate>" and base currency "<Currency>" and symbols "<Symbols>"
    When user sends the RatesAPI request with valid url
    Then check RatesAPI http response status code "<StatusCode>"
    Examples:
      | PastDate    | Symbols  | Currency | StatusCode  |
      | 2010-10-10  | EUR,GBP  | USA      | 400         |
      | 2010-10-10  | EUA,GBP  | USD      | 400         |

