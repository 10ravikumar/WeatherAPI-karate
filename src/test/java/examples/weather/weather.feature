Feature: As a MetaWeather API client, I want to retrieve weather forecast history for a particular location & day.

  Background: 
    * url 'https://www.metaweather.com/api/'
    * def DateValue =
      """
      function(args) {
        var DateField = Java.type('examples.weather.DateField');
        var dS = new DateField ();
        return dS.getDateFormatValue(args);
      }
      """

  Scenario Outline: Retrieve the weather forecast history for a particular location & day.
  
    Given path 'location/search/'
    And param <Query> = '<Value>'
    When method get
    Then status 200
    
    * def earthId = response[0].woeid
    * def date = call DateValue '<Day>'
    
    Given path 'location',earthId,date
    When method get
    Then status 200

    Examples: 
      | Query    | Value         | Day        |
      | query    | Nottingham    | tomorrows  |
      | query    | London        | tomorrows  |
      | lattlong | 50.068,-5.316 | 2021/02/18 |
      | query    | Nottingham    | 2021/02/19 |

  Scenario: Retrieve the weather forecast history for a particular location & day.
  
    Given path 'location/search/'
    And param query = 'Nottingham'
    When method get
    Then status 200
    
    * def earthId = response[0].woeid
    * def date = call DateValue 'tomorrows'
    
    Given path 'location',earthId,date
    When method get
    Then status 200
