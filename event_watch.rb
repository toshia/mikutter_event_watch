# -*- coding: utf-8 -*-

Plugin.create :event_watch do
  settings "イベントうぉっち" do
    multi "注目するキーワード", :event_watch_keywords
  end

  filter_filter_stream_track do |waching|
    [(waching.split(','.freeze) + UserConfig[:event_watch_keywords]).uniq.join(','.freeze)]
  end

  watcher = UserConfig.connect :event_watch_keywords do
    Plugin.call(:filter_stream_reconnect_request)
  end

  onunload do
    UserConfig.disconnect watcher
  end

end
