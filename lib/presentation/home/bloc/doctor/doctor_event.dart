abstract class DoctorEvent {}

class DoctorFetchAll extends DoctorEvent {}

class DoctorFetchTop extends DoctorEvent {}

class DoctorSearch extends DoctorEvent {
  final String keyword;
  
  DoctorSearch(this.keyword);
}

class DoctorFetchById extends DoctorEvent {
  final int id;
  
  DoctorFetchById(this.id);
}