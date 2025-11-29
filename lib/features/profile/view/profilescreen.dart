import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:streamsync_lite/core/di/dependencyinjection.dart';
import 'package:streamsync_lite/core/globals/globals.dart';
import 'package:streamsync_lite/core/utils/themeprovider.dart';
import 'package:streamsync_lite/features/authentication/view/signInscreen.dart';
import 'package:streamsync_lite/features/profile/services/apiProfileServices.dart';

class AdminFCMPage extends StatefulWidget {
  const AdminFCMPage({super.key});

  @override
  State<AdminFCMPage> createState() => _AdminFCMPageState();
}

class _AdminFCMPageState extends State<AdminFCMPage> {
  final titleCtrl = TextEditingController();
  final bodyCtrl = TextEditingController();

  String? selectedVideoId;

  final videoIDs = [
    "2_svIJnfrBY",
    "ZKQsZh2i5bc",
    "zIqf_R68LdY",
    "ZIajob1UI6g",
    "yR5N6OSN8JQ",
  ];

  bool loadingAdmin = false;
  bool loadingSelf = false;

  final api = ProfileAPi();

  Future<void> sendNotification() async {
    if (selectedVideoId == null ||
        titleCtrl.text.isEmpty ||
        bodyCtrl.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Fill all fields")));
      return;
    }

    setState(() => loadingAdmin = true);

    final response = await api.sendAdminPush(
      userId: currentuser!.id,
      title: titleCtrl.text,
      body: bodyCtrl.text,
      videoId: selectedVideoId!,
    );

    setState(() => loadingAdmin = false);

    if (response["success"] == true) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Admin FCM sent!")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response["error"] ?? "Failed to send")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("Admin FCM", style: TextStyle()),
        // backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          ThemeToggleButton(),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.red),
            tooltip: "Logout",
            onPressed: () async {
              await _logout(context);
            },
          ),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // USER INFO
          Center(
            child: Column(
              children: [
                Text(
                  currentuser!.name!,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  currentuser!.email,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // DROPDOWN
          const Text(
            "Select Video ID",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: DropdownButton<String>(
              value: selectedVideoId,
              isExpanded: true,
              underline: const SizedBox(),
              hint: const Text("Choose video ID"),
              items: videoIDs.map((id) {
                return DropdownMenuItem(value: id, child: Text(id));
              }).toList(),
              onChanged: (v) {
                setState(() {
                  selectedVideoId = v;
                });
              },
            ),
          ),

          const SizedBox(height: 20),

          // TITLE
          const Text("Title", style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          TextField(
            controller: titleCtrl,
            decoration: InputDecoration(
              hintText: "Enter push title",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // BODY
          const Text("Body", style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          TextField(
            controller: bodyCtrl,
            decoration: InputDecoration(
              hintText: "Enter push body",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          const SizedBox(height: 30),

          // BUTTON
          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: loadingAdmin ? null : sendNotification,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade600,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: loadingAdmin
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      "Admin FCM",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
            ),
          ),
          const SizedBox(height: 16),

          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: loadingSelf ? null : sendSelfTest,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: loadingSelf
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      "Self Test FCM",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> sendSelfTest() async {
    if (titleCtrl.text.isEmpty || bodyCtrl.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Enter title & body")));
      return;
    }

    setState(() => loadingSelf = true);

    final res = await api.sendSelfTestFCM(
      userId: currentuser!.id,
      title: titleCtrl.text,
      body: bodyCtrl.text,
    );

    setState(() => loadingSelf = false);

    if (res["success"] == true) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Self Test FCM sent!")));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(res["error"] ?? "Failed")));
    }
  }

  Future<void> _logout(BuildContext context) async {
    // Clear in-memory user object
    currentuser= null;

    final sharedPreferences = getIt<SharedPreferences>();
    await sharedPreferences.remove("user"); 

    Navigator.of(context).pushAndRemoveUntil(
      CupertinoPageRoute(builder: (context) => SignInScreen()),
      (Route<dynamic> route) => false,
    );
  }
}
