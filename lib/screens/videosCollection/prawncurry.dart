import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:receipes/themes/colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
class PrawnCurryVideo extends StatefulWidget {
  @override
  _PrawnCurryVideoState createState() => _PrawnCurryVideoState();
}

class _PrawnCurryVideoState extends State<PrawnCurryVideo> {
  String videoURL = "https://www.youtube.com/watch?v=WCKAzBooEK8";
  YoutubePlayerController _controller;
  PlayerState _playerState;
  double _volume = 100;
  bool _muted =false;
  bool _isPlayerReady = false;
  @override
  void initState(){
    _controller = YoutubePlayerController(initialVideoId: YoutubePlayer.convertUrlToId(videoURL),
      flags: YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
          // hideControls: false,
          // controlsVisibleAtStart: false,
          // hideThumbnail: false,
          // disableDragSeek: false,
          // enableCaption: true,
          // captionLanguage: 'en',
          // loop: false,
          // forceHD: false,
          startAt: 0,
          controlsVisibleAtStart: true,
          endAt: 125
      ),
    )..addListener(listener);
    _playerState=PlayerState.unknown;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  OrientationBuilder(builder:
        (BuildContext context, Orientation orientation) {
      if (orientation == Orientation.landscape) {
        return Scaffold(
          body: youtubeVideo(),
        );
      } else {
        return Scaffold(
          appBar:  AppBar(
            leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.white,),onPressed: (){
              Navigator.pop(context);
            },),
            title: Text('Prawn curry',style: TextStyle(fontFamily: 'TypeWriter'),),
            backgroundColor: AppColor.denim,
          ),
          body: youtubeVideo(),
        );
      }
    }
    );
  }
  youtubeVideo() {
    return  Container(
        child: YoutubePlayerBuilder(
            onExitFullScreen: (){
              SystemChrome.setPreferredOrientations(DeviceOrientation.values);
            },
            player: YoutubePlayer(
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.blueAccent,
              controller: _controller,
              progressColors: ProgressBarColors(
                  playedColor: Colors.red,
                  handleColor: Colors.pink
              ),
              onReady: (){
                _isPlayerReady = true;
              },
              bottomActions: [
                CurrentPosition(),
                ProgressBar(isExpanded: true),
              ],
            ),
            builder: (context, player){
              return Column(
                children: [
                  player,
                  Padding(padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                                icon: Icon(
                                  _controller.value.isPlaying?Icons.pause:Icons.play_arrow,
                                ),
                                onPressed: _isPlayerReady?(){
                                  _controller.value.isPlaying? _controller.pause():_controller.play();
                                  setState(() {

                                  });
                                }:null
                            ),
                            SizedBox(
                              width: 55.0,
                            ),
                            IconButton(
                              icon:  Icon(_muted? Icons.volume_off:Icons.volume_up),
                              onPressed: _isPlayerReady?(){
                                _muted? _controller.unMute():_controller.mute();
                                setState(() {
                                  _muted = !_muted;
                                });
                              }:null,
                            ),
                            SizedBox(
                              width: 55.0,
                            ),
                            FullScreenButton(
                              controller: _controller,
                              color: Colors.black,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("Volume",style: TextStyle(
                                fontFamily: 'TypeWriter',fontWeight: FontWeight.bold
                            ),),
                            Expanded(
                              child: Slider(
                                  inactiveColor: Colors.transparent,
                                  value: _volume,
                                  min: 0.0,
                                  max: 100,
                                  divisions: 10,
                                  label: '${_volume.round()}',
                                  onChanged: _isPlayerReady?(value){
                                    setState(() {
                                      _volume = value;
                                    });
                                    _controller.setVolume(_volume.round());
                                  }:null
                              ),
                            )
                          ],
                        ),
                      ],
                    ),)
                ],
              );
            }),
    );
  }

  void listener() {
    if(_isPlayerReady && mounted && !_controller.value.isFullScreen){
      setState(() {
        _playerState = _controller.value.playerState;
      });

      @override
      void deactivate(){
        _controller.pause();
        super.deactivate();
      }
      @override
      void dispose(){
        _controller.dispose();
        super.dispose();
      }
    }
  }
}

