part of '../more_page.dart';

Widget userInfo(User user) => Center(
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey, width: 1),
              image: const DecorationImage(
                image: AssetImage('assets/images/default-profile-image.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          verticalSpaces(20),
          Text(
            user.name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            user.email ?? '',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
