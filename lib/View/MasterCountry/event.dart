abstract class MasterCountryEvent {}

class FetchDataEvent extends MasterCountryEvent {
  final String countryName;
  FetchDataEvent(this.countryName);
}
