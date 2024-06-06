

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_checkup_app/data/datasources/keluhan_remote_datasource.dart';

part 'add_komentar_event.dart';
part 'add_komentar_state.dart';

class AddKomentarBloc extends Bloc<AddKomentarEvent, AddKomentarState> {
  AddKomentarBloc() : super(AddKomentarInitial()) {
   on<AddKomentar>((event, emit) async {
      emit(AddKomentarLoading());
      final result = await KeluhanRemoteDatasource().updateKeluhan(
        event.keluhanId,
        event.catatan,
        event.tanggalKembali,
      );
      result.fold(
        (error) => emit(AddKomentarError(message: error)),
        (data) => emit(AddKomentarLoaded(message: data)),
      );
    });
  }
}
