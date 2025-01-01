import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatelessWidget {
  static final LatLng companyLng = LatLng(
    37.28213285247017,
    127.04280476346509,
  );

  static final Marker marker = Marker(
    markerId: MarkerId("company"),
    position: companyLng,
  );

  static final Circle circle = Circle(
    circleId: CircleId("ChoolCheckCircle"),
    center: companyLng,
    fillColor: Colors.blue.withOpacity(0.5),
    radius: 100,
    strokeColor: Colors.blue,
    strokeWidth: 1,
  );

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar(),
      body: FutureBuilder(
        future: checkPermission(),
        builder: (context, snapshot) {
          if (!snapshot.hasData &&
              snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData) {
            return Column(
              children: [
                Expanded(
                  flex: 2,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: companyLng,
                      zoom: 16,
                    ),
                    markers: Set.from([marker]),
                    circles: Set.from([circle]),
                    myLocationEnabled: true,
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.timelapse_outlined,
                        color: Colors.blue,
                        size: 50.0,
                      ),
                      const SizedBox(
                        width: 20, // height에서 width로 수정
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final curPosition =
                          await Geolocator.getCurrentPosition();
                          final distance = Geolocator.distanceBetween(
                            curPosition.latitude,
                            curPosition.longitude, // 오타 수정
                            companyLng.latitude,
                            companyLng.longitude,
                          );

                          bool canCheck = distance < 100;

                          showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                title: Text("출근하기"),
                                content: Text(
                                  canCheck
                                      ? "출근을 하시겠습니까?"
                                      : "출근할 수 없는 위치입니다.",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    child: Text("취소"),
                                  ),
                                  if (canCheck)
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(true);
                                      },
                                      child: Text("출근하기"),
                                    ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text("출근하기!"),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          return Center(
            child: Text(snapshot.data.toString()),
          );
        },
      ),
    );
  }

  AppBar renderAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        "오늘도 출첵",
        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w700),
      ),
      backgroundColor: Colors.white,
    );
  }

  Future<String> checkPermission() async {
    final isLocationEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isLocationEnabled) {
      return "위치 서비스를 활성화 해주세요";
    }

    LocationPermission checkPermission = await Geolocator.checkPermission();

    if (checkPermission == LocationPermission.denied) {
      return "위치 권한이 거부되었습니다";
    }

    if (checkPermission == LocationPermission.deniedForever) {
      return "위치 권한이 영구적으로 거부되었습니다";
    }

    return "위치 권한이 확인되었습니다";
  }
}
