class InsertInitialFlavors < ActiveRecord::Migration[6.1]
  def change
    flavors = [
      "レモン",
      "グレープ",
      "アップル",
      "ピーチ",
      "マスカット",
      "グレープフルーツ",
      "みかん",
      "キウイ",
      "ラズベリー",
      "チェリー",
      "スイカ",
      "パイナップル",
      "なし",
      "洋ナシ",
      "うめ",
      "オレンジ",
      "ストロベリー",
      "グリーンアップル",
      "ライチ",
      "マンゴー",
      "コーラ",
      "ソーダ",
      "サイダー",
      "エナジードリンク",
      "ホワイトソーダ",
      "ラムネ",
      "メロンソーダ",
      "グレープソーダ",
      "レモンソーダ",
      "乳酸菌ドリンク",
      "不明",
    ]

    flavors.each do |flavor|
      Flavor.create(name: flavor)
    end
  end
end
