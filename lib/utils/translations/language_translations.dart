import 'package:get/get.dart';
import 'package:tournament/utils/constant/string_const.dart';

class LanguageTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          StringConst.flyingWolf: 'FlyingWolf',
          StringConst.deepakSharma: 'Deepak Sharma',
          StringConst.tournaments_played: 'Tournaments\nplayed',
          StringConst.tournaments_won: 'Tournaments\nnwon',
          StringConst.winning_percentage: 'Winning\npercentage',
          StringConst.recommended_for_you: "Recommended for you",
          StringConst.eloRating: 'Elo rating'
        },
        'ja_JP': {
          StringConst.flyingWolf: 'FlyingWolf',
          StringConst.deepakSharma: 'ディーパックシャルマ',
          StringConst.tournaments_played: 'トーナメント\nプレイ済み',
          StringConst.tournaments_won: 'トーナメント\n勝ちました',
          StringConst.winning_percentage: '勝つ\nパーセンテージ',
          StringConst.recommended_for_you: "あなたにおすすめ",
          StringConst.eloRating: 'イロレーティング'
        },
        'en_US': {
          'appTitle': 'GetX Multi Lingual Support',
          'title': 'Easy Language Translations',
          'subtitle':
              'This text will automatically be translated into the appropriate language',
          'button1': 'Switch language',
          'chooseLanguage': 'Choose your language'
        },
        'ur_PK': {
          'appTitle': 'GetX کثیر لسانی معاونت',
          'title': 'آسان زبان کے ترجمے',
          'subtitle': 'یہ متن خود بخود مناسب زبان میں ترجمہ ہو جائے گا',
          'button1': 'زبان تبدیل کریں',
          'chooseLanguage': 'اپنی زبان کا انتخاب کریں'
        },
        'sd_PK': {
          'appTitle': 'GetX گھڻ لساني سپورٽ',
          'title': 'آسان ترجمو',
          'subtitle': 'ھي متن خود بخود مناسب وليءَ ۾ ترجمو ٿي ويندو',
          'button1': 'ولي تبديل ڪريو',
          'chooseLanguage': 'پنھنجي ولي چونڊيو'
        },
      };
}
