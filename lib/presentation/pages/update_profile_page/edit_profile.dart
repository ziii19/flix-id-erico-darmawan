import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../providers/router/router_prov.dart';
import '../../providers/user_data/user_data_prov.dart';
import '../../widgets/back_nav.dart';

// ignore: must_be_immutable
class EditProfile extends ConsumerStatefulWidget {
  const EditProfile({super.key});
  @override
  ConsumerState<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends ConsumerState<EditProfile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  XFile? xfile;

  @override
  void initState() {
    super.initState();
    // Set nilai awal pada _nameController saat initState
    _emailController.text = ref.read(userDataProvider).valueOrNull?.email ?? '';
    _nameController.text = ref.read(userDataProvider).valueOrNull?.name ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
            child: Column(
              children: [
                BackNav(
                  'Edit Profile',
                  onTap: () => ref.read(routerProvider).pop(),
                ),
                // verticalSpace(50),
                // GestureDetector(
                //   onTap: () async {
                //     xfile = await ImagePicker()
                //         .pickImage(source: ImageSource.gallery);
                //     setState(() {});
                //   },
                //   child: CircleAvatar(
                //     radius: 50,
                //     backgroundImage:
                //         xfile != null ? FileImage(File(xfile!.path)) : null,
                //     child: xfile != null
                //         ? null
                //         : Container(
                //             width: 100,
                //             height: 100,
                //             decoration: BoxDecoration(
                //                 shape: BoxShape.circle,
                //                 border:
                //                     Border.all(color: Colors.grey, width: 1),
                //                 image: DecorationImage(
                //                     image: ref
                //                                 .watch(userDataProvider)
                //                                 .valueOrNull
                //                                 ?.photoUrl !=
                //                             null
                //                         ? NetworkImage(ref
                //                             .watch(userDataProvider)
                //                             .valueOrNull!
                //                             .photoUrl!) as ImageProvider
                //                         : const AssetImage(
                //                             'assets/pp-placeholder.png'),
                //                     fit: BoxFit.cover)),
                //           ),
                //   ),
                // ),
                // verticalSpace(24),
                // FlixTextField(labelText: 'Name', controller: _nameController),
                // verticalSpace(24),
                // FlixTextField(
                //   labelText: 'Email',
                //   controller: _emailController,
                //   enabled: false,
                // ),
                // verticalSpace(24),
                // SizedBox(
                //     width: double.infinity,
                //     child: ElevatedButton(
                //         style: ElevatedButton.styleFrom(
                //           foregroundColor: bgColor,
                //           backgroundColor: saffron,
                //         ),
                //         onPressed: () async {

                //         },
                //         child: const Text('Edit Profile')))
              ],
            ),
          )
        ],
      ),
    );
  }
}
