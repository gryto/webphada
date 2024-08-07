import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../../src/constant.dart';

class VideoDetail extends StatelessWidget {
  final int uploadSize;
  final String uploadDate,
      uploadTime,
      uploadName,
      uploadPath,
      uploadFile,
      satkerName,
      menuName;

  const VideoDetail({
    Key? key,
    required this.uploadDate,
    required this.uploadTime,
    required this.uploadName,
    required this.uploadPath,
    required this.uploadFile,
    required this.uploadSize,
    required this.satkerName,
    required this.menuName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final videoID = YoutubePlayer.convertUrlToId(uploadPath);

    var controller = YoutubePlayerController(
      initialVideoId: videoID!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
      ),
    );

    double w = MediaQuery.of(context).size.width - 0;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: clrPrimary,
        title: const Text("File Video"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                width: w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Container(
                              width: w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2.0),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    uploadName,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  YoutubePlayer(
                                    controller: controller,
                                    showVideoProgressIndicator: true,
                                    onReady: () => debugPrint('Ready'),
                                    bottomActions: [
                                      //CurrentPosition(),
                                      ProgressBar(
                                        isExpanded: true,
                                        colors: const ProgressBarColors(
                                          playedColor: clrPrimary,
                                          handleColor: clrPrimary,
                                        ),
                                      ),
                                      const PlaybackSpeedButton(),
                                      RemainingDuration(),
                                      FullScreenButton(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            ListTile(
                              leading: const Icon(Icons.date_range),
                              title: const Text(
                                "Tanggal",
                                style: TextStyle(fontSize: 10),
                              ),
                              subtitle: Text(
                                '$uploadDate $uploadTime',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            ListTile(
                              leading: const Icon(Icons.account_circle),
                              title: const Text(
                                "Satuan Kerja",
                                style: TextStyle(fontSize: 10),
                              ),
                              subtitle: Text(
                                satkerName,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            ListTile(
                              leading: const Icon(Icons.menu),
                              title: const Text(
                                "Halaman Menu",
                                style: TextStyle(fontSize: 10),
                              ),
                              subtitle: Text(
                                menuName,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
