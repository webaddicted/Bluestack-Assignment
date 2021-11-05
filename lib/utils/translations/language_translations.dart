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
          StringConst.tournaments_played: 'トーナメン\nプレイ済み',
          StringConst.tournaments_won: 'トーナメン\n勝ちました',
          StringConst.winning_percentage: '勝つ\nパーセンテ',
          StringConst.recommended_for_you: "あなたにおすす",
          StringConst.eloRating: 'イロレーティング'
        }
      };
}
