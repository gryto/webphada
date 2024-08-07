import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../../src/constant.dart';
import 'detail.dart';

class VideoList extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final data;
  const VideoList({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width - 0;

    if (data.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (_, index) {
            var row = data[index];
            final videoID = YoutubePlayer.convertUrlToId(row['upload_path']);
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => VideoDetail(
                      uploadDate: row['upload_date'],
                      uploadTime: row['upload_time'],
                      uploadName: row['upload_name'],
                      uploadSize: row['upload_size'],
                      uploadFile: row['upload_file'],
                      uploadPath: row['upload_path'],
                      satkerName: row['satker_name'],
                      menuName: row['menu_name'],
                    ),
                  ),
                );
              },
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
                        YoutubePlayer(
                          controller: YoutubePlayerController(
                            initialVideoId: videoID!,
                            flags: const YoutubePlayerFlags(
                              autoPlay: false,
                              controlsVisibleAtStart: true,
                              hideControls: true,
                            ),
                          ),
                          bottomActions: [
                            CurrentPosition(),
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
                        ListTile(
                          title: Text(
                            row['upload_name'],
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500),
                            maxLines: 2,
                          ),
                        ),
                        Container(
                          height: 10,
                          color: Colors.grey.shade200,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (_, index) => const SizedBox(
            height: 1,
          ),
          itemCount: data.isEmpty ? 0 : data.length,
        ),
      );
    } else {
      return Center(
        child: Column(
          children: [
            const SizedBox(
              height: 200,
            ),
            Container(
              padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
              child: const Text("No data found"),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      );
    }
  }

  imageContainer(imgPath) {
    return Image.asset(
      imgPath,
      fit: BoxFit.cover,
    );
  }
}
