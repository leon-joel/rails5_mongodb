module BattlesHelper

  def convert_refreshed_time(refreshed_time)
    if refreshed_time.nil?
      nil
    else
      # refreshed_time.strftime("%H:%M:%S")     # => 03:04:05
      # refreshed_time.strftime("%-H:%-M:%-S")  # => 3:4:5
      refreshed_time.strftime("%X")   # => 03:04:05
      # refreshed_time.strftime("%-X")   # => 03:04:05
    end
  end

  def convert_reserved_datetime_string(dt)
    # I18n.l(dt)
    dt.strftime("%1m月%1d日 %H:%M")
  end
end
