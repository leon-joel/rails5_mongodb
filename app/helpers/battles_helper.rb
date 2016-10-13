module BattlesHelper

  def convert_refreshed_time(refreshed_time)
    if refreshed_time.nil?
      nil
    else
      refreshed_time.strftime("%H:%M:%S")
    end
  end

  def convert_reserved_datetime_string(dt)
    dt.strftime("%1m月%1d日 %H:%M")
  end
end
