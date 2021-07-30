class InsertInitialMakers < ActiveRecord::Migration[6.1]
  def change
    makers = [
      "UHA味覚糖",
      "KANRO カンロ",
      "明治 meiji",
      "カバヤ",
      "ブルボン",
      "春日井製菓",
      "不二家",
      "アサヒグループ食品 Asahi",
      "ノーベル",
      "Trolli",
      "ナリスアップコスメティックス NARIS UP",
      "ロッテ LOTTE",
      "エイム",
      "クリート",
      "フルタ製菓",
      "扇雀飴本舗 センジャクアメホンポ",
      "クラシエフーズ",
      "森永製菓",
      "ハリボー",
      "やおきん",
      "サンスマイル sun smile",
      "養命酒製造",
      "グリコ",
      "アサヒフード＆ヘルスケア 三ツ矢サイダー ミツヤサイダー",
      "ライオン菓子",
      "旺旺ジャパン",
      "ユニマットリケン",
      "ケイズコーポレーション",
      "ノットギルティー",
      "サンコー thanko",
      "創健社",
      "バヤリース Bireleys",
      "サンコー",
      "明治チューインガム メイジチューインガム",
      "オリオン",
      "ミントスタイル",
      "サクマ製菓",
      "富士高フーヅ",
      "ケニーズキャンディー",
      "モントワール",
      "カッチェス Katjes",
      "Twizzlers",
      "Amos",
      "BEBETO"
    ]
    makers.each do |maker|
      Maker.create(name: maker)
    end
  end
end
