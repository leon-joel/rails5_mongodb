require 'rails_helper'

RSpec.describe Battle, type: :model do

  describe "Timeクラスのテスト" do
    it "test" do
      tz_old = ENV['TZ']
      p tz_old                # => [Windowsの場合は] nil
      begin
        # ★★★ 出力結果は Windows8.1 + Ruby2.3.1 + Rails5 + RSpec3 でのもの ★★★

        # 現在時刻を固定して実験する
        Timecop.freeze(Time.utc(2016, 1, 1)) do
          ENV['TZ'] = 'EST+5'   # Windowsの場合、ESTの後ろに +5 のようなシフト時間(?)を入れないと正しく(?)認識してくれない。
          p ENV['TZ']

          puts "=== Time.now ==="
          time_now = Time.now           # Timeクラス
          l time_now                    # => 2015-12-31 19:00:00 -0500, EST, Time
          # l time_now.localtime

          puts "=== Time.current ==="
          time_current = Time.current   # ActiveSupport::TimeWithZone クラス
          l time_current                # => 2016-01-01 09:00:00 +0900, JST, ActiveSupport::TimeWithZone
          # p time_current

          # time_now_in_time_zone = Time.now.in_time_zone   # ActiveSupport::TimeWithZone クラス
          # l time_now_in_time_zone
          # p time_now_in_time_zone

          str = '2016-01-02 03:04:05'

          puts "=== Time.parse (オフセットなし) ==="
          l Time.parse(str)             # => 2016-01-02 03:04:05 -0500, EST, Time
          l str.to_time                 # => 2016-01-02 03:04:05 -0500, Time ※Zone情報なし

          puts "=== Time.zone.parse (オフセットなし) ==="
          l Time.zone.parse(str)        # => 2016-01-02 03:04:05 +0900, JST, ActiveSupport::TimeWithZone
          # l str.in_time_zone          # 同上

          str = '2016-01-02 03:04:05 +0100'
          puts "=== Time.parse (オフセット有り) ==="
          l Time.parse(str)             # => 2016-01-02 03:04:05 +0100, Time ※Zone情報なし
          # l str.to_time               # 同上

          puts "=== Time.zone.parse (オフセット有り) ==="
          l Time.zone.parse(str)        # => 2016-01-02 11:04:05 +0900, JST, ActiveSupport::TimeWithZone

          puts "=== Time.new ==="
          l Time.new(2016, 1, 2, 3, 4, 5)       # => 2016-01-02 03:04:05 -0500, EST, Time

          puts "=== Time.utc ==="
          l Time.utc(2016, 1, 2, 3, 4, 5)       # => 2016-01-02 03:04:05 UTC, UTC, Time

          puts "=== Time.local ==="
          l Time.local(2016, 1, 2, 3, 4, 5)       # => 2016-01-02 03:04:05 -0500, EST, Time

          puts "=== Time.zone.local ==="
          l Time.zone.local(2016, 1, 2, 3, 4, 5)  # => 2016-01-02 03:04:05 +0900, JST, ActiveSupport::TimeWithZone

          puts "### 経過時間（時刻の差） ###"
          elapsed = Time.current - Time.zone.local(2016, 1, 1)
          puts elapsed                          # => 32400.0
          puts "#{(elapsed / 3600).to_i} 時間"  # => 9時間
        end

      ensure
        puts
        puts "=== ensure ==="
        ENV['TZ'] = tz_old
        puts ENV['TZ']
      end
    end
  end

  describe "time差分のテスト" do
    it 'test' do
      time1 = Time.new(2016, 1, 1, 0, 0, 0)
      time2 = Time.new(2016, 1, 1, 1, 0, 0)
      time3 = Time.new(2016, 1, 1, 1, 59, 59)


      elapsed = time2 - time1
      expect(elapsed).to eq 3600.0
      expect((elapsed / 3600).to_i).to eq 1

      elapsed = time3 - time2
      expect(elapsed).to eq 3599.0
      expect((elapsed / 3600).to_i).to eq 0
    end
  end


  # 結果出力用メソッド
  # 参考: http://qiita.com/jnchito/items/cae89ee43c30f5d6fa2c
  def l(object)
    # フォーマット用の関数（ラムダ）
    # format = ->(date_or_time) { [I18n.l(date_or_time), date_or_time.try(:zone), date_or_time.class].compact.join(', ') }
    format = ->(date_or_time) { [date_or_time, date_or_time.try(:zone), date_or_time.class].compact.join(', ') }
    str = if object.is_a?(Range)
            # Rangeが渡された場合
            [object.first, object.last].map{|date_or_time| format.call(date_or_time)}.join('..')
          else
            # Range以外（Date, Time, DateTimeなど何でもOK）が渡された場合
            format.call(object)
          end
    puts "=> #{str}"
  end
end
