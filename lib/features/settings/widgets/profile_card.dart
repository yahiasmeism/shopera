import 'dart:io';
import 'package:flutter/material.dart';
import '../../../core/utils/image_cached_manager.dart';
import '../../authentication/presentation/pages/update_user_page.dart';

class ProfileCardWidget extends StatelessWidget {
  final String name;
  final String email;
  final String? image;

  const ProfileCardWidget({super.key, 
    required this.name,
    required this.email,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            FutureBuilder<File>(
              future: ImageCacheManager.getImagePath(image ?? ''),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return CircleAvatar(
                    radius: 30,
                    backgroundImage: FileImage(snapshot.data!),
                  );
                } else {
                  return const CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.person, size: 40),
                  );
                }
              },
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                // navigate to update page
                Navigator.of(context).pushNamed(UpdateUserPage.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
