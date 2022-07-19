import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations);

  static List<String> languages() => ['en', 'es', 'de', 'it'];

  String get languageCode => locale.languageCode;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.languageCode] ?? '';

  String getVariableText({
    String enText = '',
    String esText = '',
    String deText = '',
    String itText = '',
  }) =>
      [enText, esText, deText, itText][languageIndex] ?? '';
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      FFLocalizations.languages().contains(locale.languageCode);

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // Welcome
  {
    '2och7af5': {
      'en': 'Welcome to Katnboots138',
      'de': 'Willkommen bei Katnboots138',
      'es': 'Bienvenido a Katnboots138',
      'it': 'Benvenuto in Katnboots138',
    },
    'plgi0ur7': {
      'en': 'Book your session',
      'de': 'Buchen Sie Ihre Sitzung',
      'es': 'Reserva tu sesión',
      'it': 'Prenota la tua sessione',
    },
    'kvmfdopr': {
      'en': 'Get Started',
      'de': 'Loslegen',
      'es': 'Empezar',
      'it': 'Iniziare',
    },
  },
  // Sessions
  {
    'jnt5njbj': {
      'en': 'Sessions With Kat',
      'de': '',
      'es': '',
      'it': '',
    },
    'hpkvf8t2': {
      'en': 'Humans are so much more \nthan we\'ve been told!\nRemember!!!',
      'de': '',
      'es': '',
      'it': '',
    },
    'fxphu627': {
      'en': 'Boking info here\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nEnd',
      'de': '',
      'es': '',
      'it': '',
    },
    'ezz0ky9i': {
      'en': 'Session types',
      'de': 'Sitzungstypen',
      'es': 'Tipos de sesión',
      'it': 'Tipi di sessione',
    },
    'nfr4tvql': {
      'en': 'blah',
      'de': 'bla',
      'es': 'paja',
      'it': 'bla',
    },
    'dso0bycc': {
      'en': '30 Min',
      'de': '30 Minuten',
      'es': '30 minutos',
      'it': '30 minuti',
    },
    'qow9iedr': {
      'en': 'Kat',
      'de': 'Kat',
      'es': 'Kat',
      'it': 'Kat',
    },
    'raplo1zy': {
      'en': 'blah',
      'de': 'bla',
      'es': 'paja',
      'it': 'bla',
    },
    '9lz42s37': {
      'en': '60 Min',
      'de': '60 Min',
      'es': '60 minutos',
      'it': '60 minuti',
    },
    '4nq0r17p': {
      'en': 'kat',
      'de': 'Kat',
      'es': 'gato',
      'it': 'kat',
    },
    '0xtz2o91': {
      'en': 'Blah',
      'de': 'Blah',
      'es': 'Paja',
      'it': 'Bla',
    },
    'suf7vppd': {
      'en': '120 Min',
      'de': '120 Minuten',
      'es': '120 minutos',
      'it': '120 minuti',
    },
    'yxzt5q5f': {
      'en': 'George Switzer',
      'de': 'Georg Schweizer',
      'es': 'Jorge Suiza',
      'it': 'Giorgio Svizzero',
    },
    'gwau2hkx': {
      'en': 'blah',
      'de': 'bla',
      'es': 'paja',
      'it': 'bla',
    },
    '1f7hpm0t': {
      'en': '60 Min',
      'de': '60 Min',
      'es': '60 minutos',
      'it': '60 minuti',
    },
    '5dlnvmde': {
      'en': 'Kat',
      'de': 'Kat',
      'es': 'Kat',
      'it': 'Kat',
    },
    'd976g8bb': {
      'en': 'Home',
      'de': 'Heim',
      'es': 'Hogar',
      'it': 'Casa',
    },
  },
  // schedule
  {
    't7jax0nv': {
      'en': 'Book a session',
      'de': '',
      'es': '',
      'it': '',
    },
    'y91uqary': {
      'en': 'Class Name',
      'de': 'Klassenname',
      'es': 'Nombre de la clase',
      'it': 'Nome della classe',
    },
    's75wbwy5': {
      'en':
          '30m | High Intensity | Indoor/Outdoor jljkkjjbkjbn kkn\nnk nkjn\nbjkbjlkknlnlknk',
      'de': '30m | Hohe Intensität | Drinnen draußen',
      'es': '30m | Alta Intensidad | Bajo techo, en exteriores',
      'it': '30m | Alta intensità | Dentro fuori',
    },
    '2gyttlom': {
      'en': 'Reserve',
      'de': 'Reservieren',
      'es': 'Reservar',
      'it': 'Riserva',
    },
    'blult2y7': {
      'en': 'Thursday June 22',
      'de': 'Donnerstag, 22. Juni',
      'es': 'jueves 22 de junio',
      'it': 'Giovedì 22 giugno',
    },
    'j7vn38ae': {
      'en': 'Class Name',
      'de': 'Klassenname',
      'es': 'Nombre de la clase',
      'it': 'Nome della classe',
    },
    'p8aa0ayo': {
      'en': '30m | High Intensity | Indoor/Outdoor',
      'de': '30m | Hohe Intensität | Drinnen draußen',
      'es': '30m | Alta Intensidad | Bajo techo, en exteriores',
      'it': '30m | Alta intensità | Dentro fuori',
    },
    'zitwqcg4': {
      'en': 'Reserve',
      'de': 'Reservieren',
      'es': 'Reservar',
      'it': 'Riserva',
    },
    'r6wqzcd9': {
      'en': 'Thursday June 22',
      'de': 'Donnerstag, 22. Juni',
      'es': 'jueves 22 de junio',
      'it': 'Giovedì 22 giugno',
    },
    'ukxml1sv': {
      'en': 'Class Name',
      'de': 'Klassenname',
      'es': 'Nombre de la clase',
      'it': 'Nome della classe',
    },
    'jf4vfw4r': {
      'en': '30m | High Intensity | Indoor/Outdoor',
      'de': '30m | Hohe Intensität | Drinnen draußen',
      'es': '30m | Alta Intensidad | Bajo techo, en exteriores',
      'it': '30m | Alta intensità | Dentro fuori',
    },
    'ar0h7sn7': {
      'en': 'Reserve',
      'de': 'Reservieren',
      'es': 'Reservar',
      'it': 'Riserva',
    },
    'gixrh3pi': {
      'en': 'Thursday June 22',
      'de': 'Donnerstag, 22. Juni',
      'es': 'jueves 22 de junio',
      'it': 'Giovedì 22 giugno',
    },
    'pf98v875': {
      'en': 'Class Name',
      'de': 'Klassenname',
      'es': 'Nombre de la clase',
      'it': 'Nome della classe',
    },
    'gug9t397': {
      'en': '30m | High Intensity | Indoor/Outdoor',
      'de': '30m | Hohe Intensität | Drinnen draußen',
      'es': '30m | Alta Intensidad | Bajo techo, en exteriores',
      'it': '30m | Alta intensità | Dentro fuori',
    },
    'hecre26o': {
      'en': 'Reserve',
      'de': 'Reservieren',
      'es': 'Reservar',
      'it': 'Riserva',
    },
    'kvle2d09': {
      'en': 'Thursday June 22',
      'de': 'Donnerstag, 22. Juni',
      'es': 'jueves 22 de junio',
      'it': 'Giovedì 22 giugno',
    },
    'eq6l0u7y': {
      'en': 'Class Name',
      'de': 'Klassenname',
      'es': 'Nombre de la clase',
      'it': 'Nome della classe',
    },
    'boqbxk0y': {
      'en': '30m | High Intensity | Indoor/Outdoor',
      'de': '30m | Hohe Intensität | Drinnen draußen',
      'es': '30m | Alta Intensidad | Bajo techo, en exteriores',
      'it': '30m | Alta intensità | Dentro fuori',
    },
    '76ai31g5': {
      'en': 'Reserve',
      'de': 'Reservieren',
      'es': 'Reservar',
      'it': 'Riserva',
    },
    'ijbp5xmk': {
      'en': '10:00am',
      'de': '10:00 Uhr',
      'es': '10:00 a.m',
      'it': '10:00 del mattino',
    },
    'uchvdb6w': {
      'en': 'Thursday June 22',
      'de': 'Donnerstag, 22. Juni',
      'es': 'jueves 22 de junio',
      'it': 'Giovedì 22 giugno',
    },
  },
  // Calendar
  {
    '5n0xn5g4': {
      'en': 'Page Title',
      'de': 'Seitentitel',
      'es': 'Título de la página',
      'it': 'Titolo della pagina',
    },
    'blnhahjh': {
      'en': 'Home',
      'de': 'Heim',
      'es': 'Hogar',
      'it': 'Casa',
    },
  },
].reduce((a, b) => a..addAll(b));
