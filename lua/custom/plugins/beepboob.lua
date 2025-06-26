return {
  {
    "EggbertFluffle/beepboop.nvim",
    opts = {
      audio_player = "ffplay",
      max_sounds = 20,
      sound_map = {
        { auto_command = "BufWritePost",                               sound = "notification.mp3" },
        { key_map = { mode = "n", key_chord = "q", blocking = false }, sound = "success.mp3" },
      }
    }
  }
}
