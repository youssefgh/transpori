part of controller;

@Controller(selector: '[station-suggestion-ctrl]', publishAs: 'ctrl')
@deprecated
class StationSuggestionController {

  WSStationSuggestion webService;
  
  StationSuggestionController(this.webService);
  
  
  
}