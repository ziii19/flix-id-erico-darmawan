import 'dart:io';

import '../../entities/user.dart';

class UploadPpParam {
  final File imageFile;
  final User user;

  UploadPpParam({required this.imageFile, required this.user});
}
