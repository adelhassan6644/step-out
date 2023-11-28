import '../../../data/dio/dio_client.dart';

class LocalizationRepo {
  final DioClient dioClient;

  LocalizationRepo({required this.dioClient});

  updateLanguage(lang) async {
    await dioClient.updateLang(lang);
  }
}
