<script>
import "video.js/dist/video-js.css";
import "@silvermine/videojs-airplay/dist/silvermine-videojs-airplay.css";
import "@silvermine/videojs-chromecast/dist/silvermine-videojs-chromecast.css";

import videojs from "video.js";

import videojsAirplay from "@silvermine/videojs-airplay";
videojsAirplay(videojs);

import videojsChromecast from "@silvermine/videojs-chromecast";
videojsChromecast(videojs);

export default {
  name: "Player",
  props: {
    streamKey: String,
  },
  data() {
    return {
      player: null,
    };
  },
  mounted() {
    this.player = videojs(this.$refs.videoPlayer, {
      autoplay: "any",
      controls: true,
      controlBar: {
        pictureInPictureToggle: false,
      },
      fill: true,
      liveui: true,
      techOrder: ["chromecast", "html5"],
      plugins: {
        airPlay: {},
        chromecast: {},
      },
      sources: [
        {
          src: window.location.origin + "/hls/" + this.streamKey + ".m3u8",
          type: "application/x-mpegURL",
        },
      ],
    });
  },
  watch: {
    streamKey: function (newValue) {
      this.player.src({
        src: window.location.origin + "/hls/" + newValue + ".m3u8",
        type: "application/x-mpegURL",
      });
    },
  },
  beforeUnmount() {
    if (this.player) {
      this.player.dispose();
    }
  },
};
</script>

<template>
  <video ref="videoPlayer" class="video-js"></video>
</template>
