import 'package:flutter_bloc/flutter_bloc.dart';

class PageCubit extends Cubit<int> {
  PageCubit() : super(0); // Initial state

  void setPage(int pageIndex) {
    emit(pageIndex);
  }
}
