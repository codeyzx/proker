import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:proker/src/core/config/router/app_router.dart';
import 'package:proker/src/core/config/themes/app_colors.dart';
import 'package:proker/src/core/constants/app_constants.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

final liveStateNotifier =
    ValueNotifier<ZegoLiveStreamingState>(ZegoLiveStreamingState.idle);

@RoutePage()
class StreamingRoomPage extends StatefulWidget {
  const StreamingRoomPage(
      {super.key,
      required this.isHost,
      required this.userName,
      required this.userID,
      required this.liveID});

  final bool isHost;
  // userName
  // userID
  // liveID
  final String userName;
  final String userID;
  final String liveID;

  @override
  State<StreamingRoomPage> createState() => _LivestreamRoomState();
}

class _LivestreamRoomState extends State<StreamingRoomPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltLiveStreaming(
        appID: AppConstants.zegoCloudAppId,
        appSign: AppConstants.zegoCloudAppSign,
        liveID: widget.liveID,
        userID: widget.userID,
        userName: widget.userName,
        events: ZegoUIKitPrebuiltLiveStreamingEvents(
          duration: ZegoLiveStreamingDurationEvents(
            onUpdated: (Duration duration) {
              if (duration.inSeconds >= 5 * 60) {
                ZegoUIKitPrebuiltLiveStreamingController().leave(context);
              }
            },
          ),
          onLeaveConfirmation: (
            ZegoLiveStreamingLeaveConfirmationEvent event,
            Future<bool> Function() defaultAction,
          ) async {
            return await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: const Color(0xFFF5F5F5),
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                        child: Icon(
                          Icons.tv_off,
                          color: AppColors.primary,
                          size: 50,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: 'Apakah Anda yakin ingin ',
                                style: TextStyle(
                                  color: AppColors.textDark,
                                  fontSize: 16,
                                ),
                              ),
                              TextSpan(
                                text: 'keluar',
                                style: TextStyle(
                                  color: AppColors.textDark,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: ' dari ruang streaming?',
                                style: TextStyle(
                                  color: AppColors.textDark,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              context.router.maybePop();
                            },
                            style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                side: BorderSide(color: AppColors.primary)),
                            child: Text(
                              'Batal',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: FilledButton(
                            onPressed: () {
                              context.router.replaceAll([const HomeRoute()]);
                            },
                            style: FilledButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                backgroundColor: AppColors.primary),
                            child: const Text(
                              'Ya, Keluar',
                              style: TextStyle(
                                color: AppColors.textWhite,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                );
              },
            );
          },
          onEnded: (
            ZegoLiveStreamingEndEvent event,
            VoidCallback defaultAction,
          ) {
            if (ZegoLiveStreamingEndReason.hostEnd == event.reason) {
              if (event.isFromMinimizing) {
                ZegoUIKitPrebuiltLiveStreamingController().minimize.hide();
              } else {
                context.router.replaceAll([const HomeRoute()]);
              }
            } else {
              defaultAction.call();
            }
          },
        ),
        config: widget.isHost
            ? ZegoUIKitPrebuiltLiveStreamingConfig.host()
            : ZegoUIKitPrebuiltLiveStreamingConfig.audience()
          ..foreground = ValueListenableBuilder<ZegoLiveStreamingState>(
            valueListenable: liveStateNotifier,
            builder: (context, state, child) {
              return const Stack(
                children: [],
              );
            },
          )
          // ..preview.showPreviewForHost = false
          // ..duration.isVisible = true
          // ..audioVideoView.showAvatarInAudioMode = false
          // ..audioVideoView.showSoundWavesInAudioMode = true
          // ..turnOnCameraWhenJoining = false
          // ..audioVideoView.showAvatarInAudioMode = true
          // ..innerText.startLiveStreamingButton = 'Mulai Live'
          // ..innerText.noHostOnline = 'Pembimbing tidak online'
          // ..showBackgroundTips = true
          // ..avatarBuilder = (BuildContext context, Size size,
          //     ZegoUIKitUser? user, Map extraInfo) {
          //   return user != null
          //       ? Container(
          //           decoration: BoxDecoration(
          //             shape: BoxShape.circle,
          //             image: DecorationImage(
          //               image: Image.asset('assets/images/default-avatar.webp')
          //                   .image,
          //             ),
          //           ),
          //         )
          //       : const SizedBox();
          // }
          ..topMenuBar.buttons = [
            ZegoLiveStreamingMenuBarButtonName.minimizingButton
          ]
          // ..bottomMenuBar.hostButtons = [
          //   ZegoLiveStreamingMenuBarButtonName.toggleMicrophoneButton
          // ]
          ..confirmDialogInfo = widget.isHost
              ? ZegoLiveStreamingDialogInfo(
                  title: "Stop the live",
                  message: "Apakah Anda yakin ingin menghentikan live?",
                  cancelButtonName: "Batal",
                  confirmButtonName: "Hentikan",
                )
              : null,
      ),
    );
  }
}
