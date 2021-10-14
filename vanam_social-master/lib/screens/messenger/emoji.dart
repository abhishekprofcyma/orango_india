import 'package:firebase_database/firebase_database.dart';

class ChatItem {
  final String message;
  final String image;
  final String video;
  final DataSnapshot snapShot;

  ChatItem(this.message, this.image, this.video, this.snapShot);
}

class EmojiGroup {
  final String name;
  final List<String> emojis;

  EmojiGroup(this.name, this.emojis);
}

List<EmojiGroup> emojis = [
  EmojiGroup("Smileys", [
    "😄",
    "😁",
    "😆",
    "😅",
    "😂",
    "🤣",
    "🥲",
    "☺️",
    "😊",
    "😇",
    "🙂",
    "🙃",
    "😉",
    "😌",
    "😍",
    "🥰",
    "😘",
    "😗",
    "😙",
    "😚",
    "😋",
    "😛",
    "😝",
    "😜",
    "🤪",
    "🤨",
    "🧐",
    "🤓",
    "😎",
    "🥸",
    "🤩",
    "🥳",
    "😏",
    "😒",
    "😞",
    "😔",
    "😟",
    "😕",
    "🙁",
    "☹️",
    "😣",
    "😖",
    "😫",
    "😩",
    "🥺",
    "😢",
    "😭",
    "😤",
    "😠",
    "😡",
    "🤬",
    "🤯",
    "😳",
    "🥵",
    "🥶",
    "😱",
    "😨",
    "😰",
    "😥",
    "😓",
    "🤗",
    "🤔",
    "🤭",
    "🤫",
    "🤥",
    "😶",
    "😐",
    "😑",
    "😬",
    "🙄",
    "😯",
    "😦",
    "😧",
    "😮",
    "😲",
    "🥱",
    "😴",
    "🤤",
    "😪",
    "😵",
    "🤐",
    "🥴",
    "🤢",
    "🤮",
    "🤧",
    "😷",
    "🤒",
    "🤕",
    "🤑",
    "🤠",
    "😈",
    "👿",
    "👹",
    "👺",
    "🤡",
    "💩",
    "👻",
    "💀",
    "☠️",
    "👽",
    "👾",
    "🤖",
    "🎃",
    "😺",
    "😸",
    "😹",
    "😻",
    "😼",
    "😽",
    "🙀",
    "😿",
    "😾"
  ]),
  EmojiGroup("People", [
    "👶",
    "👧",
    "🧒",
    "👦",
    "👩",
    "🧑",
    "👨",
    "👩‍🦱",
    "🧑‍🦱",
    "👨‍🦱",
    "👩‍🦰",
    "🧑‍🦰",
    "👨‍🦰",
    "👱‍♀️",
    "👱",
    "👱‍♂️",
    "👩‍🦳",
    "🧑‍🦳",
    "👨‍🦳",
    "👩‍🦲",
    "🧑‍🦲",
    "👨‍🦲",
    "🧔",
    "👵",
    "🧓",
    "👴",
    "👲",
    "👳‍♀️",
    "👳",
    "👳‍♂️",
    "🧕",
    "👮‍♀️",
    "👮",
    "👮‍♂️",
    "👷‍♀️",
    "👷",
    "👷‍♂️",
    "💂‍♀️",
    "💂",
    "💂‍♂️",
    "🕵️‍♀️",
    "🕵️",
    "🕵️‍♂️",
    "👩‍⚕️",
    "🧑‍⚕️",
    "👨‍⚕️",
    "👩‍🌾",
    "🧑‍🌾",
    "👨‍🌾",
    "👩‍🍳",
    "🧑‍🍳",
    "👨‍🍳",
    "👩‍🎓",
    "🧑‍🎓",
    "👨‍🎓",
    "👩‍🎤",
    "🧑‍🎤",
    "👨‍🎤",
    "👩‍🏫",
    "🧑‍🏫",
    "👨‍🏫",
    "👩‍🏭",
    "🧑‍🏭",
    "👨‍🏭",
    "👩‍💻",
    "🧑‍💻",
    "👨‍💻",
    "👩‍💼",
    "🧑‍💼",
    "👨‍💼",
    "👩‍🔧",
    "🧑‍🔧",
    "👨‍🔧",
    "👩‍🔬",
    "🧑‍🔬",
    "👨‍🔬",
    "👩‍🎨",
    "🧑‍🎨",
    "👨‍🎨",
    "👩‍🚒",
    "🧑‍🚒",
    "👨‍🚒",
    "👩‍✈️",
    "🧑‍✈️",
    "👨‍✈️",
    "👩‍🚀",
    "🧑‍🚀",
    "👨‍🚀",
    "👩‍⚖️",
    "🧑‍⚖️",
    "👨‍⚖️",
    "👰‍♀️",
    "👰",
    "👰‍♂️",
    "🤵‍♀️",
    "🤵",
    "🤵‍♂️",
    "👸",
    "🤴",
    "🥷",
    "🦸‍♀️",
    "🦸",
    "🦸‍♂️",
    "🦹‍♀️",
    "🦹",
    "🦹‍♂️",
    "🤶",
    "🧑‍🎄",
    "🎅",
    "🧙‍♀️",
    "🧙",
    "🧙‍♂️",
    "🧝‍♀️",
    "🧝",
    "🧝‍♂️",
    "🧛‍♀️",
    "🧛",
    "🧛‍♂️",
    "🧟‍♀️",
    "🧟",
    "🧟‍♂️",
    "🧞‍♀️",
    "🧞",
    "🧞‍♂️",
    "🧜‍♀️",
    "🧜",
    "🧜‍♂️",
    "🧚‍♀️",
    "🧚",
    "🧚‍♂️",
    "👼",
    "🤰",
    "🤱",
    "👩‍🍼",
    "🧑‍🍼",
    "👨‍🍼",
    "🙇‍♀️",
    "🙇",
    "🙇‍♂️",
    "💁‍♀️",
    "💁",
    "💁‍♂️",
    "🙅‍♀️",
    "🙅",
    "🙅‍♂️",
    "🙆‍♀️",
    "🙆",
    "🙆‍♂️",
    "🙋‍♀️",
    "🙋",
    "🙋‍♂️",
    "🧏‍♀️",
    "🧏",
    "🧏‍♂️",
    "🤦‍♀️",
    "🤦",
    "🤦‍♂️",
    "🤷‍♀️",
    "🤷",
    "🤷‍♂️",
    "🙎‍♀️",
    "🙎",
    "🙎‍♂️",
    "🙍‍♀️",
    "🙍",
    "🙍‍♂️",
    "💇‍♀️",
    "💇",
    "💇‍♂️",
    "💆‍♀️",
    "💆",
    "💆‍♂️",
    "🧖‍♀️",
    "🧖",
    "🧖‍♂️",
    "💅",
    "🤳",
    "💃",
    "🕺",
    "👯‍♀️",
    "👯",
    "👯‍♂️",
    "🕴",
    "👩‍🦽",
    "🧑‍🦽",
    "👨‍🦽",
    "👩‍🦼",
    "🧑‍🦼",
    "👨‍🦼",
    "🚶‍♀️",
    "🚶",
    "🚶‍♂️",
    "👩‍🦯",
    "🧑‍🦯",
    "👨‍🦯",
    "🧎‍♀️",
    "🧎",
    "🧎‍♂️",
    "🏃‍♀️",
    "🏃",
    "🏃‍♂️",
    "🧍‍♀️",
    "🧍",
    "🧍‍♂️",
    "👭",
    "🧑‍🤝‍🧑",
    "👬",
    "👫",
    "👩‍❤️‍👩",
    "💑",
    "👨‍❤️‍👨",
    "👩‍❤️‍👨",
    "👩‍❤️‍💋‍👩",
    "💏",
    "👨‍❤️‍💋‍👨",
    "👩‍❤️‍💋‍👨",
    "👪",
    "👨‍👩‍👦",
    "👨‍👩‍👧",
    "👨‍👩‍👧‍👦",
    "👨‍👩‍👦‍👦",
    "👨‍👩‍👧‍👧",
    "👨‍👨‍👦",
    "👨‍👨‍👧",
    "👨‍👨‍👧‍👦",
    "👨‍👨‍👦‍👦",
    "👨‍👨‍👧‍👧",
    "👩‍👩‍👦",
    "👩‍👩‍👧",
    "👩‍👩‍👧‍👦",
    "👩‍👩‍👦‍👦",
    "👩‍👩‍👧‍👧",
    "👨‍👦",
    "👨‍👦‍👦",
    "👨‍👧",
    "👨‍👧‍👦",
    "👨‍👧‍👧",
    "👩‍👦",
    "👩‍👦‍👦",
    "👩‍👧",
    "👩‍👧‍👦",
    "👩‍👧‍👧",
    "🗣",
    "👤",
    "👥",
    "🫂"
  ]),
  EmojiGroup("Animals & Nature", [
    "🐶",
    "🐱",
    "🐭",
    "🐹",
    "🐰",
    "🦊",
    "🐻",
    "🐼",
    "🐻‍❄️",
    "🐨",
    "🐯",
    "🦁",
    "🐮",
    "🐷",
    "🐽",
    "🐸",
    "🐵",
    "🙈",
    "🙉",
    "🙊",
    "🐒",
    "🐔",
    "🐧",
    "🐦",
    "🐤",
    "🐣",
    "🐥",
    "🦆",
    "🦅",
    "🦉",
    "🦇",
    "🐺",
    "🐗",
    "🐴",
    "🦄",
    "🐝",
    "🪱",
    "🐛",
    "🦋",
    "🐌",
    "🐞",
    "🐜",
    "🪰",
    "🪲",
    "🪳",
    "🦟",
    "🦗",
    "🕷",
    "🕸",
    "🦂",
    "🐢",
    "🐍",
    "🦎",
    "🦖",
    "🦕",
    "🐙",
    "🦑",
    "🦐",
    "🦞",
    "🦀",
    "🐡",
    "🐠",
    "🐟",
    "🐬",
    "🐳",
    "🐋",
    "🦈",
    "🐊",
    "🐅",
    "🐆",
    "🦓",
    "🦍",
    "🦧",
    "🦣",
    "🐘",
    "🦛",
    "🦏",
    "🐪",
    "🐫",
    "🦒",
    "🦘",
    "🦬",
    "🐃",
    "🐂",
    "🐄",
    "🐎",
    "🐖",
    "🐏",
    "🐑",
    "🦙",
    "🐐",
    "🦌",
    "🐕",
    "🐩",
    "🦮",
    "🐕‍🦺",
    "🐈",
    "🐈‍⬛",
    "🪶",
    "🐓",
    "🦃",
    "🦤",
    "🦚",
    "🦜",
    "🦢",
    "🦩",
    "🕊",
    "🐇",
    "🦝",
    "🦨",
    "🦡",
    "🦫",
    "🦦",
    "🦥",
    "🐁",
    "🐀",
    "🐿",
    "🦔",
    "🐾",
    "🐉",
    "🐲",
    "🌵",
    "🎄",
    "🌲",
    "🌳",
    "🌴",
    "🪵",
    "🌱",
    "🌿",
    "☘️",
    "🍀",
    "🎍",
    "🪴",
    "🎋",
    "🍃",
    "🍂",
    "🍁",
    "🍄",
    "🐚",
    "🪨",
    "🌾",
    "💐",
    "🌷",
    "🌹",
    "🥀",
    "🌺",
    "🌸",
    "🌼",
    "🌻",
    "🌞",
    "🌝",
    "🌛",
    "🌜",
    "🌚",
    "🌕",
    "🌖",
    "🌗",
    "🌘",
    "🌑",
    "🌒",
    "🌓",
    "🌔",
    "🌙",
    "🌎",
    "🌍",
    "🌏",
    "🪐",
    "💫",
    "⭐️",
    "🌟",
    "✨",
    "⚡️",
    "☄️",
    "💥",
    "🔥",
    "🌪",
    "🌈",
    "☀️",
    "🌤",
    "⛅️",
    "🌥",
    "☁️",
    "🌦",
    "🌧",
    "⛈",
    "🌩",
    "🌨",
    "❄️",
    "☃️",
    "⛄️",
    "🌬",
    "💨",
    "💧",
    "💦",
    "☔️",
    "☂️",
    "🌊",
    "🌫"
  ]),
  EmojiGroup("Food & Drink", [
    "🍏",
    "🍎",
    "🍐",
    "🍊",
    "🍋",
    "🍌",
    "🍉",
    "🍇",
    "🍓",
    "🫐",
    "🍈",
    "🍒",
    "🍑",
    "🥭",
    "🍍",
    "🥥",
    "🥝",
    "🍅",
    "🍆",
    "🥑",
    "🥦",
    "🥬",
    "🥒",
    "🌶",
    "🫑",
    "🌽",
    "🥕",
    "🫒",
    "🧄",
    "🧅",
    "🥔",
    "🍠",
    "🥐",
    "🥯",
    "🍞",
    "🥖",
    "🥨",
    "🧀",
    "🥚",
    "🍳",
    "🧈",
    "🥞",
    "🧇",
    "🥓",
    "🥩",
    "🍗",
    "🍖",
    "🦴",
    "🌭",
    "🍔",
    "🍟",
    "🍕",
    "🫓",
    "🥪",
    "🥙",
    "🧆",
    "🌮",
    "🌯",
    "🫔",
    "🥗",
    "🥘",
    "🫕",
    "🥫",
    "🍝",
    "🍜",
    "🍲",
    "🍛",
    "🍣",
    "🍱",
    "🥟",
    "🦪",
    "🍤",
    "🍙",
    "🍚",
    "🍘",
    "🍥",
    "🥠",
    "🥮",
    "🍢",
    "🍡",
    "🍧",
    "🍨",
    "🍦",
    "🥧",
    "🧁",
    "🍰",
    "🎂",
    "🍮",
    "🍭",
    "🍬",
    "🍫",
    "🍿",
    "🍩",
    "🍪",
    "🌰",
    "🥜",
    "🍯",
    "🥛",
    "🍼",
    "🫖",
    "☕️",
    "🍵",
    "🧃",
    "🥤",
    "🧋",
    "🍶",
    "🍺",
    "🍻",
    "🥂",
    "🍷",
    "🥃",
    "🍸",
    "🍹",
    "🧉",
    "🍾",
    "🧊",
    "🥄",
    "🍴",
    "🍽",
    "🥣",
    "🥡",
    "🥢",
    "🧂"
  ]),
  EmojiGroup("Activity and Sports", [
    "⚽️",
    "🏀",
    "🏈",
    "⚾️",
    "🥎",
    "🎾",
    "🏐",
    "🏉",
    "🥏",
    "🎱",
    "🪀",
    "🏓",
    "🏸",
    "🏒",
    "🏑",
    "🥍",
    "🏏",
    "🪃",
    "🥅",
    "⛳️",
    "🪁",
    "🏹",
    "🎣",
    "🤿",
    "🥊",
    "🥋",
    "🎽",
    "🛹",
    "🛼",
    "🛷",
    "⛸",
    "🥌",
    "🎿",
    "⛷",
    "🏂",
    "🪂",
    "🏋️‍♀️",
    "🏋️",
    "🏋️‍♂️",
    "🤼‍♀️",
    "🤼",
    "🤼‍♂️",
    "🤸‍♀️",
    "🤸",
    "🤸‍♂️",
    "⛹️‍♀️",
    "⛹️",
    "⛹️‍♂️",
    "🤺",
    "🤾‍♀️",
    "🤾",
    "🤾‍♂️",
    "🏌️‍♀️",
    "🏌️",
    "🏌️‍♂️",
    "🏇",
    "🧘‍♀️",
    "🧘",
    "🧘‍♂️",
    "🏄‍♀️",
    "🏄",
    "🏄‍♂️",
    "🏊‍♀️",
    "🏊",
    "🏊‍♂️",
    "🤽‍♀️",
    "🤽",
    "🤽‍♂️",
    "🚣‍♀️",
    "🚣",
    "🚣‍♂️",
    "🧗‍♀️",
    "🧗",
    "🧗‍♂️",
    "🚵‍♀️",
    "🚵",
    "🚵‍♂️",
    "🚴‍♀️",
    "🚴",
    "🚴‍♂️",
    "🏆",
    "🥇",
    "🥈",
    "🥉",
    "🏅",
    "🎖",
    "🏵",
    "🎗",
    "🎫",
    "🎟",
    "🎪",
    "🤹",
    "🤹‍♂️",
    "🤹‍♀️",
    "🎭",
    "🩰",
    "🎨",
    "🎬",
    "🎤",
    "🎧",
    "🎼",
    "🎹",
    "🥁",
    "🪘",
    "🎷",
    "🎺",
    "🪗",
    "🎸",
    "🪕",
    "🎻",
    "🎲",
    "♟",
    "🎯",
    "🎳",
    "🎮",
    "🎰",
    "🧩"
  ]),
  EmojiGroup("Travel & Places", [
    "🚗",
    "🚕",
    "🚙",
    "🚌",
    "🚎",
    "🏎",
    "🚓",
    "🚑",
    "🚒",
    "🚐",
    "🛻",
    "🚚",
    "🚛",
    "🚜",
    "🦯",
    "🦽",
    "🦼",
    "🛴",
    "🚲",
    "🛵",
    "🏍",
    "🛺",
    "🚨",
    "🚔",
    "🚍",
    "🚘",
    "🚖",
    "🚡",
    "🚠",
    "🚟",
    "🚃",
    "🚋",
    "🚞",
    "🚝",
    "🚄",
    "🚅",
    "🚈",
    "🚂",
    "🚆",
    "🚇",
    "🚊",
    "🚉",
    "✈️",
    "🛫",
    "🛬",
    "🛩",
    "💺",
    "🛰",
    "🚀",
    "🛸",
    "🚁",
    "🛶",
    "⛵️",
    "🚤",
    "🛥",
    "🛳",
    "⛴",
    "🚢",
    "⚓️",
    "🪝",
    "⛽️",
    "🚧",
    "🚦",
    "🚥",
    "🚏",
    "🗺",
    "🗿",
    "🗽",
    "🗼",
    "🏰",
    "🏯",
    "🏟",
    "🎡",
    "🎢",
    "🎠",
    "⛲️",
    "⛱",
    "🏖",
    "🏝",
    "🏜",
    "🌋",
    "⛰",
    "🏔",
    "🗻",
    "🏕",
    "⛺️",
    "🛖",
    "🏠",
    "🏡",
    "🏘",
    "🏚",
    "🏗",
    "🏭",
    "🏢",
    "🏬",
    "🏣",
    "🏤",
    "🏥",
    "🏦",
    "🏨",
    "🏪",
    "🏫",
    "🏩",
    "💒",
    "🏛",
    "⛪️",
    "🕌",
    "🕍",
    "🛕",
    "🕋",
    "⛩",
    "🛤",
    "🛣",
    "🗾",
    "🎑",
    "🏞",
    "🌅",
    "🌄",
    "🌠",
    "🎇",
    "🎆",
    "🌇",
    "🌆",
    "🏙",
    "🌃",
    "🌌",
    "🌉",
    "🌁"
  ]),
  EmojiGroup("Objects", [
    "⌚️",
    "📱",
    "📲",
    "💻",
    "⌨️",
    "🖥",
    "🖨",
    "🖱",
    "🖲",
    "🕹",
    "🗜",
    "💽",
    "💾",
    "💿",
    "📀",
    "📼",
    "📷",
    "📸",
    "📹",
    "🎥",
    "📽",
    "🎞",
    "📞",
    "☎️",
    "📟",
    "📠",
    "📺",
    "📻",
    "🎙",
    "🎚",
    "🎛",
    "🧭",
    "⏱",
    "⏲",
    "⏰",
    "🕰",
    "⌛️",
    "⏳",
    "📡",
    "🔋",
    "🔌",
    "💡",
    "🔦",
    "🕯",
    "🪔",
    "🧯",
    "🛢",
    "💸",
    "💵",
    "💴",
    "💶",
    "💷",
    "🪙",
    "💰",
    "💳",
    "💎",
    "⚖️",
    "🪜",
    "🧰",
    "🪛",
    "🔧",
    "🔨",
    "⚒",
    "🛠",
    "⛏",
    "🪚",
    "🔩",
    "⚙️",
    "🪤",
    "🧱",
    "⛓",
    "🧲",
    "🔫",
    "💣",
    "🧨",
    "🪓",
    "🔪",
    "🗡",
    "⚔️",
    "🛡",
    "🚬",
    "⚰️",
    "🪦",
    "⚱️",
    "🏺",
    "🔮",
    "📿",
    "🧿",
    "💈",
    "⚗️",
    "🔭",
    "🔬",
    "🕳",
    "🩹",
    "🩺",
    "💊",
    "💉",
    "🩸",
    "🧬",
    "🦠",
    "🧫",
    "🧪",
    "🌡",
    "🧹",
    "🪠",
    "🧺",
    "🧻",
    "🚽",
    "🚰",
    "🚿",
    "🛁",
    "🛀",
    "🧼",
    "🪥",
    "🪒",
    "🧽",
    "🪣",
    "🧴",
    "🛎",
    "🔑",
    "🗝",
    "🚪",
    "🪑",
    "🛋",
    "🛏",
    "🛌",
    "🧸",
    "🪆",
    "🖼",
    "🪞",
    "🪟",
    "🛍",
    "🛒",
    "🎁",
    "🎈",
    "🎏",
    "🎀",
    "🪄",
    "🪅",
    "🎊",
    "🎉",
    "🎎",
    "🏮",
    "🎐",
    "🧧",
    "✉️",
    "📩",
    "📨",
    "📧",
    "💌",
    "📥",
    "📤",
    "📦",
    "🏷",
    "🪧",
    "📪",
    "📫",
    "📬",
    "📭",
    "📮",
    "📯",
    "📜",
    "📃",
    "📄",
    "📑",
    "🧾",
    "📊",
    "📈",
    "📉",
    "🗒",
    "🗓",
    "📆",
    "📅",
    "🗑",
    "📇",
    "🗃",
    "🗳",
    "🗄",
    "📋",
    "📁",
    "📂",
    "🗂",
    "🗞",
    "📰",
    "📓",
    "📔",
    "📒",
    "📕",
    "📗",
    "📘",
    "📙",
    "📚",
    "📖",
    "🔖",
    "🧷",
    "🔗",
    "📎",
    "🖇",
    "📐",
    "📏",
    "🧮",
    "📌",
    "📍",
    "✂️",
    "🖊",
    "🖋",
    "✒️",
    "🖌",
    "🖍",
    "📝",
    "✏️",
    "🔍",
    "🔎",
    "🔏",
    "🔐",
    "🔒",
    "🔓"
  ]),
  EmojiGroup("Symbols", [
    "❤️",
    "🧡",
    "💛",
    "💚",
    "💙",
    "💜",
    "🖤",
    "🤍",
    "🤎",
    "💔",
    "❣️",
    "💕",
    "💞",
    "💓",
    "💗",
    "💖",
    "💘",
    "💝",
    "💟",
    "☮️",
    "✝️",
    "☪️",
    "🕉",
    "☸️",
    "✡️",
    "🔯",
    "🕎",
    "☯️",
    "☦️",
    "🛐",
    "⛎",
    "♈️",
    "♉️",
    "♊️",
    "♋️",
    "♌️",
    "♍️",
    "♎️",
    "♏️",
    "♐️",
    "♑️",
    "♒️",
    "♓️",
    "🆔",
    "⚛️",
    "🉑",
    "☢️",
    "☣️",
    "📴",
    "📳",
    "🈶",
    "🈚️",
    "🈸",
    "🈺",
    "🈷️",
    "✴️",
    "🆚",
    "💮",
    "🉐",
    "㊙️",
    "㊗️",
    "🈴",
    "🈵",
    "🈹",
    "🈲",
    "🅰️",
    "🅱️",
    "🆎",
    "🆑",
    "🅾️",
    "🆘",
    "❌",
    "⭕️",
    "🛑",
    "⛔️",
    "📛",
    "🚫",
    "💯",
    "💢",
    "♨️",
    "🚷",
    "🚯",
    "🚳",
    "🚱",
    "🔞",
    "📵",
    "🚭",
    "❗️",
    "❕",
    "❓",
    "❔",
    "‼️",
    "⁉️",
    "🔅",
    "🔆",
    "〽️",
    "⚠️",
    "🚸",
    "🔱",
    "⚜️",
    "🔰",
    "♻️",
    "✅",
    "🈯️",
    "💹",
    "❇️",
    "✳️",
    "❎",
    "🌐",
    "💠",
    "Ⓜ️",
    "🌀",
    "💤",
    "🏧",
    "🚾",
    "♿️",
    "🅿️",
    "🛗",
    "🈳",
    "🈂️",
    "🛂",
    "🛃",
    "🛄",
    "🛅",
    "🚹",
    "🚺",
    "🚼",
    "⚧",
    "🚻",
    "🚮",
    "🎦",
    "📶",
    "🈁",
    "🔣",
    "ℹ️",
    "🔤",
    "🔡",
    "🔠",
    "🆖",
    "🆗",
    "🆙",
    "🆒",
    "🆕",
    "🆓",
    "0️⃣",
    "1️⃣",
    "2️⃣",
    "3️⃣",
    "4️⃣",
    "5️⃣",
    "6️⃣",
    "7️⃣",
    "8️⃣",
    "9️⃣",
    "🔟",
    "🔢",
    "#️⃣",
    "*️⃣",
    "⏏️",
    "▶️",
    "⏸",
    "⏯",
    "⏹",
    "⏺",
    "⏭",
    "⏮",
    "⏩",
    "⏪",
    "⏫",
    "⏬",
    "◀️",
    "🔼",
    "🔽",
    "➡️",
    "⬅️",
    "⬆️",
    "⬇️",
    "↗️",
    "↘️",
    "↙️",
    "↖️",
    "↕️",
    "↔️",
    "↪️",
    "↩️",
    "⤴️",
    "⤵️",
    "🔀",
    "🔁",
    "🔂",
    "🔄",
    "🔃",
    "🎵",
    "🎶",
    "➕",
    "➖",
    "➗",
    "✖️",
    "♾",
    "💲",
    "💱",
    "™️",
    "©️",
    "®️",
    "〰️",
    "➰",
    "➿",
    "🔚",
    "🔙",
    "🔛",
    "🔝",
    "🔜",
    "✔️",
    "☑️",
    "🔘",
    "🔴",
    "🟠",
    "🟡",
    "🟢",
    "🔵",
    "🟣",
    "⚫️",
    "⚪️",
    "🟤",
    "🔺",
    "🔻",
    "🔸",
    "🔹",
    "🔶",
    "🔷",
    "🔳",
    "🔲",
    "▪️",
    "▫️",
    "◾️",
    "◽️",
    "◼️",
    "◻️",
    "🟥",
    "🟧",
    "🟨",
    "🟩",
    "🟦",
    "🟪",
    "⬛️",
    "⬜️",
    "🟫",
    "🔈",
    "🔇",
    "🔉",
    "🔊",
    "🔔",
    "🔕",
    "📣",
    "📢",
    "👁‍🗨",
    "💬",
    "💭",
    "🗯",
    "♠️",
    "♣️",
    "♥️",
    "♦️",
    "🃏",
    "🎴",
    "🀄️",
    "🕐",
    "🕑",
    "🕒",
    "🕓",
    "🕔",
    "🕕",
    "🕖",
    "🕗",
    "🕘",
    "🕙",
    "🕚",
    "🕛",
    "🕜",
    "🕝",
    "🕞",
    "🕟",
    "🕠",
    "🕡",
    "🕢",
    "🕣",
    "🕤",
    "🕥",
    "🕦",
    "🕧"
  ]),
  EmojiGroup("Flags", [
    "🏳️",
    "🏴",
    "🏁",
    "🚩",
    "🏳️‍🌈",
    "🏳️‍⚧️",
    "🏴‍☠️",
    "🇦🇫",
    "🇦🇽",
    "🇦🇱",
    "🇩🇿",
    "🇦🇸",
    "🇦🇩",
    "🇦🇴",
    "🇦🇮",
    "🇦🇶",
    "🇦🇬",
    "🇦🇷",
    "🇦🇲",
    "🇦🇼",
    "🇦🇺",
    "🇦🇹",
    "🇦🇿",
    "🇧🇸",
    "🇧🇭",
    "🇧🇩",
    "🇧🇧",
    "🇧🇾",
    "🇧🇪",
    "🇧🇿",
    "🇧🇯",
    "🇧🇲",
    "🇧🇹",
    "🇧🇴",
    "🇧🇦",
    "🇧🇼",
    "🇧🇷",
    "🇮🇴",
    "🇻🇬",
    "🇧🇳",
    "🇧🇬",
    "🇧🇫",
    "🇧🇮",
    "🇰🇭",
    "🇨🇲",
    "🇨🇦",
    "🇮🇨",
    "🇨🇻",
    "🇧🇶",
    "🇰🇾",
    "🇨🇫",
    "🇹🇩",
    "🇨🇱",
    "🇨🇳",
    "🇨🇽",
    "🇨🇨",
    "🇨🇴",
    "🇰🇲",
    "🇨🇬",
    "🇨🇩",
    "🇨🇰",
    "🇨🇷",
    "🇨🇮",
    "🇭🇷",
    "🇨🇺",
    "🇨🇼",
    "🇨🇾",
    "🇨🇿",
    "🇩🇰",
    "🇩🇯",
    "🇩🇲",
    "🇩🇴",
    "🇪🇨",
    "🇪🇬",
    "🇸🇻",
    "🇬🇶",
    "🇪🇷",
    "🇪🇪",
    "🇪🇹",
    "🇪🇺",
    "🇫🇰",
    "🇫🇴",
    "🇫🇯",
    "🇫🇮",
    "🇫🇷",
    "🇬🇫",
    "🇵🇫",
    "🇹🇫",
    "🇬🇦",
    "🇬🇲",
    "🇬🇪",
    "🇩🇪",
    "🇬🇭",
    "🇬🇮",
    "🇬🇷",
    "🇬🇱",
    "🇬🇩",
    "🇬🇵",
    "🇬🇺",
    "🇬🇹",
    "🇬🇬",
    "🇬🇳",
    "🇬🇼",
    "🇬🇾",
    "🇭🇹",
    "🇭🇳",
    "🇭🇰",
    "🇭🇺",
    "🇮🇸",
    "🇮🇳",
    "🇮🇩",
    "🇮🇷",
    "🇮🇶",
    "🇮🇪",
    "🇮🇲",
    "🇮🇱",
    "🇮🇹",
    "🇯🇲",
    "🇯🇵",
    "🎌",
    "🇯🇪",
    "🇯🇴",
    "🇰🇿",
    "🇰🇪",
    "🇰🇮",
    "🇽🇰",
    "🇰🇼",
    "🇰🇬",
    "🇱🇦",
    "🇱🇻",
    "🇱🇧",
    "🇱🇸",
    "🇱🇷",
    "🇱🇾",
    "🇱🇮",
    "🇱🇹",
    "🇱🇺",
    "🇲🇴",
    "🇲🇰",
    "🇲🇬",
    "🇲🇼",
    "🇲🇾",
    "🇲🇻",
    "🇲🇱",
    "🇲🇹",
    "🇲🇭",
    "🇲🇶",
    "🇲🇷",
    "🇲🇺",
    "🇾🇹",
    "🇲🇽",
    "🇫🇲",
    "🇲🇩",
    "🇲🇨",
    "🇲🇳",
    "🇲🇪",
    "🇲🇸",
    "🇲🇦",
    "🇲🇿",
    "🇲🇲",
    "🇳🇦",
    "🇳🇷",
    "🇳🇵",
    "🇳🇱",
    "🇳🇨",
    "🇳🇿",
    "🇳🇮",
    "🇳🇪",
    "🇳🇬",
    "🇳🇺",
    "🇳🇫",
    "🇰🇵",
    "🇲🇵",
    "🇳🇴",
    "🇴🇲",
    "🇵🇰",
    "🇵🇼",
    "🇵🇸",
    "🇵🇦",
    "🇵🇬",
    "🇵🇾",
    "🇵🇪",
    "🇵🇭",
    "🇵🇳",
    "🇵🇱",
    "🇵🇹",
    "🇵🇷",
    "🇶🇦",
    "🇷🇪",
    "🇷🇴",
    "🇷🇺",
    "🇷🇼",
    "🇼🇸",
    "🇸🇲",
    "🇸🇦",
    "🇸🇳",
    "🇷🇸",
    "🇸🇨",
    "🇸🇱",
    "🇸🇬",
    "🇸🇽",
    "🇸🇰",
    "🇸🇮",
    "🇬🇸",
    "🇸🇧",
    "🇸🇴",
    "🇿🇦",
    "🇰🇷",
    "🇸🇸",
    "🇪🇸",
    "🇱🇰",
    "🇧🇱",
    "🇸🇭",
    "🇰🇳",
    "🇱🇨",
    "🇵🇲",
    "🇻🇨",
    "🇸🇩",
    "🇸🇷",
    "🇸🇿",
    "🇸🇪",
    "🇨🇭",
    "🇸🇾",
    "🇹🇼",
    "🇹🇯",
    "🇹🇿",
    "🇹🇭",
    "🇹🇱",
    "🇹🇬",
    "🇹🇰",
    "🇹🇴",
    "🇹🇹",
    "🇹🇳",
    "🇹🇷",
    "🇹🇲",
    "🇹🇨",
    "🇹🇻",
    "🇻🇮",
    "🇺🇬",
    "🇺🇦",
    "🇦🇪",
    "🇬🇧",
    "🏴󠁧󠁢󠁥󠁮󠁧󠁿",
    "🏴󠁧󠁢󠁳󠁣󠁴󠁿",
    "🏴󠁧󠁢󠁷󠁬󠁳󠁿",
    "🇺🇳",
    "🇺🇸",
    "🇺🇾",
    "🇺🇿",
    "🇻🇺",
    "🇻🇦",
    "🇻🇪",
    "🇻🇳",
    "🇼🇫",
    "🇪🇭",
    "🇾🇪",
    "🇿🇲",
    "🇿🇼"
  ])
];