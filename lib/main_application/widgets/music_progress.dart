import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/controllers/spotify_controller.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class MusicProgress extends StatelessWidget {
  final Animation martinTop;
  final Animation openMusic;
  final SpotifyController controller;

  MusicProgress(this.martinTop, this.openMusic, this.controller);

  @override
  Widget build(BuildContext context) {
    if (controller.musicPlaying.value.durationMs.isNull) return Container();
    return Opacity(
        opacity: openMusic.value,
        child: Transform.translate(
          offset: Offset(
              0,
              -(martinTop.value * Get.height * 0.6) +
                  (openMusic.value * (Get.height * 0.33))),
          child: Stack(
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                width: Get.width * 0.8 + ((Get.width * 0.1) * openMusic.value),
                height: Get.height / 2,
                margin: EdgeInsets.only(
                    left: Get.width * 0.10 -
                        (Get.width * 0.05) * openMusic.value),
                child: SfRadialGauge(
                  axes: <RadialAxis>[
                    RadialAxis(
                        isInversed: true,
                        showLabels: false,
                        showTicks: false,
                        startAngle: 40,
                        endAngle: 140,
                        minimum: 0,
                        maximum: 100,
                        radiusFactor: 1,
                        axisLineStyle: AxisLineStyle(
                            color: Colors.grey[300],
                            thicknessUnit: GaugeSizeUnit.factor,
                            thickness: 0.03),
                        pointers: [
                          MarkerPointer(
                            value: 30,
                            //cornerStyle: CornerStyle.bothCurve,
                            enableAnimation: true,
                            animationDuration: 1200,
                            animationType: AnimationType.ease,
                            //sizeUnit: GaugeSizeUnit.factor,
                            color: Colors.black,
                            //width: 0.03
                          ),
                        ])
                  ],
                ),
              ),
              Container(
                  alignment: Alignment.bottomCenter,
                  width:
                      Get.width * 0.8 + ((Get.width * 0.1) * openMusic.value),
                  height: Get.height / 2,
                  margin: EdgeInsets.only(
                      top: 0,
                      left: Get.width * 0.10 -
                          (Get.width * 0.05) * openMusic.value),
                  child: Text(Get.find<SpotifyController>().getDuration(
                      Duration(
                          milliseconds:
                              controller.musicPlaying.value.durationMs))))
            ],
          ),
        ));
  }
}
