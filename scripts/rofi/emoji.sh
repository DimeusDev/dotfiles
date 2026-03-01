#!/bin/bash
# rofi emoji selector - wl-copy to clipboard

if pgrep -x "rofi" >/dev/null; then
    pkill rofi
    exit 0
fi

if ! command -v rofi &> /dev/null || ! command -v wl-copy &> /dev/null; then
    notify-send -u critical "Emoji" "missing: rofi or wl-copy"
    exit 1
fi

selected_emoji=$(sed '1,/^# # DATA # #$/d' "$0" | \
    rofi \
    -dmenu \
    -i \
    -theme ~/.config/rofi/config.rasi \
    -no-show-icons \
    -font "Noto Color Emoji 11, JetBrainsMono Nerd Font 11" \
    -p "🫠 Emoji" \
    -kb-custom-1 "Alt+c" \
    -mesg "<i>Hit Enter to copy</i>" \
    | awk '{print $1}')

if [ -n "$selected_emoji" ]; then
    # -n: no trailing newline
    echo -n "$selected_emoji" | wl-copy
    
    notify-send "Emoji" "$selected_emoji" -t 1000
fi

exit 0

# # DATA # #
😀	face	face | grin | grinning face
😃	face with big eyes	face | grinning face with big eyes | mouth | open | smile
😄	face with smiling eyes	eye | face | grinning face with smiling eyes | mouth | open | smile
😁	face with smiling eyes	beaming face with smiling eyes | eye | face | grin | smile
😆	squinting face	face | grinning squinting face | laugh | mouth | satisfied | smile
😅	face with sweat	cold | face | grinning face with sweat | open | smile | sweat
🤣	on the floor laughing	face | floor | laugh | rofl | rolling | rolling on the floor laughing | rotfl
😂	with tears of joy	face | face with tears of joy | joy | laugh | tear
🙂	smiling face	face | slightly smiling face | smile
🙃	face	face | upside-down | upside down | upside-down face
🫠	face	disappear | dissolve | liquid | melt | melting face
😉	face	face | wink | winking face
😊	face with smiling eyes	blush | eye | face | smile | smiling face with smiling eyes
😇	face with halo	angel | face | fantasy | halo | innocent | smiling face with halo
🥰	face with hearts	adore | crush | hearts | in love | smiling face with hearts
😍	face with heart-eyes	eye | face | love | smile | smiling face with heart-eyes | smiling face with heart eyes
🤩	eyes | face | grinning | star | star-struck
😘	blowing a kiss	face | face blowing a kiss | kiss
😗	face	face | kiss | kissing face
☺️	face	
☺	face	face | outlined | relaxed | smile | smiling face
😚	face with closed eyes	closed | eye | face | kiss | kissing face with closed eyes
😙	face with smiling eyes	eye | face | kiss | kissing face with smiling eyes | smile
🥲	face with tear	grateful | proud | relieved | smiling | smiling face with tear | tear | touched
😋	face-tongue	savoring food	delicious | face | face savoring food | savouring | smile | yum | face savouring food | savoring
😛	face-tongue	with tongue	face | face with tongue | tongue
😜	face-tongue	face with tongue	eye | face | joke | tongue | wink | winking face with tongue
🤪	face-tongue	face	eye | goofy | large | small | zany face
😝	face-tongue	face with tongue	eye | face | horrible | squinting face with tongue | taste | tongue
🤑	face-tongue	face	face | money | money-mouth face | mouth
🤗	face with open hands	face | hug | hugging | open hands | smiling face | smiling face with open hands
🤭	with hand over mouth	face with hand over mouth | whoops | embarrassed | oops
🫢	with open eyes and hand over mouth	amazement | awe | disbelief | embarrass | face with open eyes and hand over mouth | scared | surprise
🫣	with peeking eye	captivated | face with peeking eye | peep | stare
🤫	face	quiet | shush | shushing face | shooshing face
🤔	face	face | thinking
🫡	face	OK | salute | saluting face | sunny | troops | yes
🤐	face	face | mouth | zip | zipper | zipper-mouth face | zip-mouth face
🤨	with raised eyebrow	distrust | face with raised eyebrow | skeptic | sceptic
😐	face	deadpan | face | meh | neutral
😑	face	expressionless | face | inexpressive | meh | unexpressive
😶	without mouth	face | face without mouth | mouth | quiet | silent
🫥	line face	depressed | disappear | dotted line face | hide | introvert | invisible | dotted-line face
😶‍🌫️	in clouds	
😶‍🌫	in clouds	absentminded | face in clouds | face in the fog | head in clouds | absent-minded
😏	face	face | smirk | smirking face
😒	face	face | unamused | unhappy
🙄	with rolling eyes	eyeroll | eyes | face | face with rolling eyes | rolling
😬	face	face | grimace | grimacing face
😮‍💨	exhaling	exhale | face exhaling | gasp | groan | relief | whisper | whistle
🤥	face	face | lie | lying face | pinocchio | Pinocchio
🫨	face	earthquake | face | shaking | shock | vibrate
🙂‍↔️	shaking horizontally	
🙂‍↔	shaking horizontally	head shaking horizontally | no | shake
🙂‍↕️	shaking vertically	
🙂‍↕	shaking vertically	head shaking vertically | nod | yes
😌	face | relieved
😔	dejected | face | pensive
😪	face | good night | sleep | sleepy face
🤤	drooling | face
😴	face | good night | sleep | sleeping face | ZZZ
😷	face-unwell	with medical mask	cold | doctor | face | face with medical mask | mask | sick | ill | medicine | poorly
🤒	face-unwell	with thermometer	face | face with thermometer | ill | sick | thermometer
🤕	face-unwell	with head-bandage	bandage | face | face with head-bandage | hurt | injury | face with head bandage
🤢	face-unwell	face	face | nauseated | vomit
🤮	face-unwell	vomiting	face vomiting | puke | sick | vomit
🤧	face-unwell	face	face | gesundheit | sneeze | sneezing face | bless you
🥵	face-unwell	face	feverish | heat stroke | hot | hot face | red-faced | sweating | flushed
🥶	face-unwell	face	blue-faced | cold | cold face | freezing | frostbite | icicles
🥴	face-unwell	face	dizzy | intoxicated | tipsy | uneven eyes | wavy mouth | woozy face
😵	face-unwell	with crossed-out eyes	crossed-out eyes | dead | face | face with crossed-out eyes | knocked out
😵‍💫	face-unwell	with spiral eyes	dizzy | face with spiral eyes | hypnotized | spiral | trouble | whoa | hypnotised
🤯	face-unwell	head	exploding head | mind blown | shocked
🤠	face-hat	hat face	cowboy | cowgirl | face | hat | face with cowboy hat
🥳	face-hat	face	celebration | hat | horn | party | partying face
🥸	face-hat	face	disguise | disguised face | face | glasses | incognito | nose
😎	face-glasses	face with sunglasses	bright | cool | face | smiling face with sunglasses | sun | sunglasses
🤓	face-glasses	face	face | geek | nerd
🧐	face-glasses	with monocle	face | face with monocle | monocle | stuffy
😕	face-concerned	face	confused | face | meh
🫤	face-concerned	with diagonal mouth	disappointed | face with diagonal mouth | meh | skeptical | unsure | sceptical
😟	face-concerned	face	face | worried
🙁	face-concerned	frowning face	face | frown | slightly frowning face
☹️	face-concerned	face	
☹	face-concerned	face	face | frown | frowning face
😮	face-concerned	with open mouth	face | face with open mouth | mouth | open | sympathy
😯	face-concerned	face	face | hushed | stunned | surprised
😲	face-concerned	face	astonished | face | shocked | totally
😳	face-concerned	face	dazed | face | flushed
🥺	face-concerned	face	begging | mercy | pleading face | puppy eyes
🥹	face-concerned	holding back tears	angry | cry | face holding back tears | proud | resist | sad
😦	face-concerned	face with open mouth	face | frown | frowning face with open mouth | mouth | open
😧	face-concerned	face	anguished | face
😨	face-concerned	face	face | fear | fearful | scared
😰	face-concerned	face with sweat	anxious face with sweat | blue | cold | face | rushed | sweat
😥	face-concerned	but relieved face	disappointed | face | relieved | sad but relieved face | whew
😢	face-concerned	face	cry | crying face | face | sad | tear
😭	face-concerned	crying face	cry | face | loudly crying face | sad | sob | tear
😱	face-concerned	screaming in fear	face | face screaming in fear | fear | munch | scared | scream | Munch
😖	face-concerned	face	confounded | face
😣	face-concerned	face	face | persevere | persevering face
😞	face-concerned	face	disappointed | face
😓	face-concerned	face with sweat	cold | downcast face with sweat | face | sweat
😩	face-concerned	face	face | tired | weary
😫	face-concerned	face	face | tired
🥱	face-concerned	face	bored | tired | yawn | yawning face
😤	face-negative	with steam from nose	face | face with steam from nose | triumph | won | angry | frustration
😡	face-negative	face	angry | enraged | face | mad | pouting | rage | red
😠	face-negative	face	anger | angry | face | mad
🤬	face-negative	with symbols on mouth	face with symbols on mouth | swearing
😈	face-negative	face with horns	face | fairy tale | fantasy | horns | smile | smiling face with horns | devil
👿	face-negative	face with horns	angry face with horns | demon | devil | face | fantasy | imp
💀	face-negative		death | face | fairy tale | monster | skull
☠️	face-negative	and crossbones	
☠	face-negative	and crossbones	crossbones | death | face | monster | skull | skull and crossbones
💩	face-costume	of poo	dung | face | monster | pile of poo | poo | poop
🤡	face-costume	face	clown | face
👹	face-costume		creature | face | fairy tale | fantasy | monster | ogre
👺	face-costume		creature | face | fairy tale | fantasy | goblin | monster
👻	face-costume		creature | face | fairy tale | fantasy | ghost | monster
👽	face-costume		alien | creature | extraterrestrial | face | fantasy | ufo | ET | UFO
👾	face-costume	monster	alien | creature | extraterrestrial | face | monster | ufo | ET | UFO
🤖	face-costume		face | monster | robot
😺	cat-face	cat	cat | face | grinning | mouth | open | smile
😸	cat-face	cat with smiling eyes	cat | eye | face | grin | grinning cat with smiling eyes | smile
😹	cat-face	with tears of joy	cat | cat with tears of joy | face | joy | tear
😻	cat-face	cat with heart-eyes	cat | eye | face | heart | love | smile | smiling cat with heart-eyes | smiling cat face with heart eyes
😼	cat-face	with wry smile	cat | cat with wry smile | face | ironic | smile | wry
😽	cat-face	cat	cat | eye | face | kiss | kissing cat
🙀	cat-face	cat	cat | face | oh | surprised | weary
😿	cat-face	cat	cat | cry | crying cat | face | sad | tear
😾	cat-face	cat	cat | face | pouting
🙈	monkey-face	monkey	evil | face | forbidden | monkey | see | see-no-evil monkey
🙉	monkey-face	monkey	evil | face | forbidden | hear | hear-no-evil monkey | monkey
🙊	monkey-face	monkey	evil | face | forbidden | monkey | speak | speak-no-evil monkey
💌	heart	letter	heart | letter | love | mail
💘	heart	with arrow	arrow | cupid | heart with arrow
💝	heart	with ribbon	heart with ribbon | ribbon | valentine
💖	heart	heart	excited | sparkle | sparkling heart
💗	heart	heart	excited | growing | growing heart | nervous | pulse
💓	heart	heart	beating | beating heart | heartbeat | pulsating
💞	heart	hearts	revolving | revolving hearts
💕	heart	hearts	love | two hearts
💟	heart	decoration	heart | heart decoration
❣️	heart	exclamation	
❣	heart	exclamation	exclamation | heart exclamation | mark | punctuation
💔	heart	heart	break | broken | broken heart
❤️‍🔥	heart	on fire	
❤‍🔥	heart	on fire	burn | heart | heart on fire | love | lust | sacred heart
❤️‍🩹	heart	heart	
❤‍🩹	heart	heart	healthier | improving | mending | mending heart | recovering | recuperating | well
❤️	heart	heart	
❤	heart	heart	heart | red heart
🩷	heart	heart	cute | heart | like | love | pink
🧡	heart	heart	orange | orange heart
💛	heart	heart	yellow | yellow heart
💚	heart	heart	green | green heart
💙	heart	heart	blue | blue heart
🩵	heart	blue heart	cyan | heart | light blue | light blue heart | teal
💜	heart	heart	purple | purple heart
🤎	heart	heart	brown | heart
🖤	heart	heart	black | black heart | evil | wicked
🩶	heart	heart	gray | grey heart | heart | silver | slate | grey
🤍	heart	heart	heart | white
💋	emotion	mark	kiss | kiss mark | lips
💯	emotion	points	100 | full | hundred | hundred points | score | hundred percent | one hundred
💢	emotion	symbol	anger symbol | angry | comic | mad
💥	emotion		boom | collision | comic
💫	emotion		comic | dizzy | star
💦	emotion	droplets	comic | splashing | sweat | sweat droplets
💨	emotion	away	comic | dash | dashing away | running
🕳️	emotion		
🕳	emotion		hole
💬	emotion	balloon	balloon | bubble | comic | dialog | speech | dialogue
👁️‍🗨️	emotion	in speech bubble	
👁️‍🗨	emotion	in speech bubble	
👁‍🗨	emotion	in speech bubble	balloon | bubble | eye | eye in speech bubble | speech | witness
🗨️	emotion	speech bubble	
🗨	emotion	speech bubble	balloon | bubble | dialog | left speech bubble | speech | dialogue
🗯️	emotion	anger bubble	
🗯	emotion	anger bubble	angry | balloon | bubble | mad | right anger bubble
💭	emotion	balloon	balloon | bubble | comic | thought
💤	emotion		comic | good night | sleep | ZZZ
👋	hand	hand | wave | waving
👋🏻	hand: light skin tone	hand | light skin tone | wave | waving | waving hand: light skin tone
👋🏼	hand: medium-light skin tone	hand | medium-light skin tone | wave | waving | waving hand: medium-light skin tone
👋🏽	hand: medium skin tone	hand | medium skin tone | wave | waving | waving hand: medium skin tone
👋🏾	hand: medium-dark skin tone	hand | medium-dark skin tone | wave | waving | waving hand: medium-dark skin tone
👋🏿	hand: dark skin tone	dark skin tone | hand | wave | waving | waving hand: dark skin tone
🤚	back of hand	backhand | raised | raised back of hand
🤚🏻	back of hand: light skin tone	backhand | light skin tone | raised | raised back of hand | raised back of hand: light skin tone
🤚🏼	back of hand: medium-light skin tone	backhand | medium-light skin tone | raised | raised back of hand | raised back of hand: medium-light skin tone
🤚🏽	back of hand: medium skin tone	backhand | medium skin tone | raised | raised back of hand | raised back of hand: medium skin tone
🤚🏾	back of hand: medium-dark skin tone	backhand | medium-dark skin tone | raised | raised back of hand | raised back of hand: medium-dark skin tone
🤚🏿	back of hand: dark skin tone	backhand | dark skin tone | raised | raised back of hand | raised back of hand: dark skin tone
🖐️	with fingers splayed	
🖐	with fingers splayed	finger | hand | hand with fingers splayed | splayed
🖐🏻	with fingers splayed: light skin tone	finger | hand | hand with fingers splayed | hand with fingers splayed: light skin tone | light skin tone | splayed
🖐🏼	with fingers splayed: medium-light skin tone	finger | hand | hand with fingers splayed | hand with fingers splayed: medium-light skin tone | medium-light skin tone | splayed
🖐🏽	with fingers splayed: medium skin tone	finger | hand | hand with fingers splayed | hand with fingers splayed: medium skin tone | medium skin tone | splayed
🖐🏾	with fingers splayed: medium-dark skin tone	finger | hand | hand with fingers splayed | hand with fingers splayed: medium-dark skin tone | medium-dark skin tone | splayed
🖐🏿	with fingers splayed: dark skin tone	dark skin tone | finger | hand | hand with fingers splayed | hand with fingers splayed: dark skin tone | splayed
✋	hand	hand | high 5 | high five | raised hand
✋🏻	hand: light skin tone	hand | high 5 | high five | light skin tone | raised hand | raised hand: light skin tone
✋🏼	hand: medium-light skin tone	hand | high 5 | high five | medium-light skin tone | raised hand | raised hand: medium-light skin tone
✋🏽	hand: medium skin tone	hand | high 5 | high five | medium skin tone | raised hand | raised hand: medium skin tone
✋🏾	hand: medium-dark skin tone	hand | high 5 | high five | medium-dark skin tone | raised hand | raised hand: medium-dark skin tone
✋🏿	hand: dark skin tone	dark skin tone | hand | high 5 | high five | raised hand | raised hand: dark skin tone
🖖	salute	finger | hand | spock | vulcan | vulcan salute | Vulcan salute | Spock | Vulcan
🖖🏻	salute: light skin tone	finger | hand | light skin tone | spock | vulcan | vulcan salute | vulcan salute: light skin tone | Vulcan salute | Vulcan salute: light skin tone | Spock | Vulcan
🖖🏼	salute: medium-light skin tone	finger | hand | medium-light skin tone | spock | vulcan | vulcan salute | vulcan salute: medium-light skin tone | Vulcan salute | Vulcan salute: medium-light skin tone | Spock | Vulcan
🖖🏽	salute: medium skin tone	finger | hand | medium skin tone | spock | vulcan | vulcan salute | vulcan salute: medium skin tone | Vulcan salute | Vulcan salute: medium skin tone | Spock | Vulcan
🖖🏾	salute: medium-dark skin tone	finger | hand | medium-dark skin tone | spock | vulcan | vulcan salute | vulcan salute: medium-dark skin tone | Vulcan salute | Vulcan salute: medium-dark skin tone | Spock | Vulcan
🖖🏿	salute: dark skin tone	dark skin tone | finger | hand | spock | vulcan | vulcan salute | vulcan salute: dark skin tone | Vulcan salute | Vulcan salute: dark skin tone | Spock | Vulcan
🫱	hand	hand | right | rightward | rightwards hand | rightwards
🫱🏻	hand: light skin tone	hand | light skin tone | right | rightward | rightwards hand | rightwards hand: light skin tone | rightward hand: light skin tone | rightwards
🫱🏼	hand: medium-light skin tone	hand | medium-light skin tone | right | rightward | rightwards hand | rightwards hand: medium-light skin tone | rightward hand: medium-light skin tone | rightwards
🫱🏽	hand: medium skin tone	hand | medium skin tone | right | rightward | rightwards hand | rightwards hand: medium skin tone | rightward hand: medium skin tone | rightwards
🫱🏾	hand: medium-dark skin tone	hand | medium-dark skin tone | right | rightward | rightwards hand | rightwards hand: medium-dark skin tone | rightward hand: medium-dark skin tone | rightwards
🫱🏿	hand: dark skin tone	dark skin tone | hand | right | rightward | rightwards hand | rightwards hand: dark skin tone | rightward hand: dark skin tone | rightwards
🫲	hand	hand | left | leftward | leftwards hand | leftwards
🫲🏻	hand: light skin tone	hand | left | leftward | leftwards hand | leftwards hand: light skin tone | light skin tone | leftward hand: light skin tone | leftwards
🫲🏼	hand: medium-light skin tone	hand | left | leftward | leftwards hand | leftwards hand: medium-light skin tone | medium-light skin tone | leftward hand: medium-light skin tone | leftwards
🫲🏽	hand: medium skin tone	hand | left | leftward | leftwards hand | leftwards hand: medium skin tone | medium skin tone | leftward hand: medium skin tone | leftwards
🫲🏾	hand: medium-dark skin tone	hand | left | leftward | leftwards hand | leftwards hand: medium-dark skin tone | medium-dark skin tone | leftward hand: medium-dark skin tone | leftwards
🫲🏿	hand: dark skin tone	dark skin tone | hand | left | leftward | leftwards hand | leftwards hand: dark skin tone | leftward hand: dark skin tone | leftwards
🫳	down hand	dismiss | drop | palm down hand | shoo | palm-down hand
🫳🏻	down hand: light skin tone	dismiss | drop | light skin tone | palm down hand | palm down hand: light skin tone | shoo | palm-down hand | palm-down hand: light skin tone
🫳🏼	down hand: medium-light skin tone	dismiss | drop | medium-light skin tone | palm down hand | palm down hand: medium-light skin tone | shoo | palm-down hand | palm-down hand: medium-light skin tone
🫳🏽	down hand: medium skin tone	dismiss | drop | medium skin tone | palm down hand | palm down hand: medium skin tone | shoo | palm-down hand | palm-down hand: medium skin tone
🫳🏾	down hand: medium-dark skin tone	dismiss | drop | medium-dark skin tone | palm down hand | palm down hand: medium-dark skin tone | shoo | palm-down hand | palm-down hand: medium-dark skin tone
🫳🏿	down hand: dark skin tone	dark skin tone | dismiss | drop | palm down hand | palm down hand: dark skin tone | shoo | palm-down hand | palm-down hand: dark skin tone
🫴	up hand	beckon | catch | come | offer | palm up hand | palm-up hand
🫴🏻	up hand: light skin tone	beckon | catch | come | light skin tone | offer | palm up hand | palm up hand: light skin tone | palm-up hand | palm-up hand: light skin tone
🫴🏼	up hand: medium-light skin tone	beckon | catch | come | medium-light skin tone | offer | palm up hand | palm up hand: medium-light skin tone | palm-up hand | palm-up hand: medium-light skin tone
🫴🏽	up hand: medium skin tone	beckon | catch | come | medium skin tone | offer | palm up hand | palm up hand: medium skin tone | palm-up hand | palm-up hand: medium skin tone
🫴🏾	up hand: medium-dark skin tone	beckon | catch | come | medium-dark skin tone | offer | palm up hand | palm up hand: medium-dark skin tone | palm-up hand | palm-up hand: medium-dark skin tone
🫴🏿	up hand: dark skin tone	beckon | catch | come | dark skin tone | offer | palm up hand | palm up hand: dark skin tone | palm-up hand | palm-up hand: dark skin tone
🫷	pushing hand	high five | leftward | leftwards pushing hand | push | refuse | stop | wait | leftward-pushing hand
🫷🏻	pushing hand: light skin tone	high five | leftward | leftwards pushing hand | leftwards pushing hand: light skin tone | light skin tone | push | refuse | stop | wait | leftward-pushing hand | leftward-pushing hand: light skin tone
🫷🏼	pushing hand: medium-light skin tone	high five | leftward | leftwards pushing hand | leftwards pushing hand: medium-light skin tone | medium-light skin tone | push | refuse | stop | wait | leftward-pushing hand | leftward-pushing hand: medium-light skin tone
🫷🏽	pushing hand: medium skin tone	high five | leftward | leftwards pushing hand | leftwards pushing hand: medium skin tone | medium skin tone | push | refuse | stop | wait | leftward-pushing hand | leftward-pushing hand: medium skin tone
🫷🏾	pushing hand: medium-dark skin tone	high five | leftward | leftwards pushing hand | leftwards pushing hand: medium-dark skin tone | medium-dark skin tone | push | refuse | stop | wait | leftward-pushing hand | leftward-pushing hand: medium-dark skin tone
🫷🏿	pushing hand: dark skin tone	dark skin tone | high five | leftward | leftwards pushing hand | leftwards pushing hand: dark skin tone | push | refuse | stop | wait | leftward-pushing hand | leftward-pushing hand: dark skin tone
🫸	pushing hand	high five | push | refuse | rightward | rightwards pushing hand | stop | wait | rightward-pushing hand
🫸🏻	pushing hand: light skin tone	high five | light skin tone | push | refuse | rightward | rightwards pushing hand | rightwards pushing hand: light skin tone | stop | wait | rightward-pushing hand | rightward-pushing hand: light skin tone
🫸🏼	pushing hand: medium-light skin tone	high five | medium-light skin tone | push | refuse | rightward | rightwards pushing hand | rightwards pushing hand: medium-light skin tone | stop | wait | rightward-pushing hand | rightward-pushing hand: medium-light skin tone
🫸🏽	pushing hand: medium skin tone	high five | medium skin tone | push | refuse | rightward | rightwards pushing hand | rightwards pushing hand: medium skin tone | stop | wait | rightward-pushing hand | rightward-pushing hand: medium skin tone
🫸🏾	pushing hand: medium-dark skin tone	high five | medium-dark skin tone | push | refuse | rightward | rightwards pushing hand | rightwards pushing hand: medium-dark skin tone | stop | wait | rightward-pushing hand | rightward-pushing hand: medium-dark skin tone
🫸🏿	pushing hand: dark skin tone	dark skin tone | high five | push | refuse | rightward | rightwards pushing hand | rightwards pushing hand: dark skin tone | stop | wait | rightward-pushing hand | rightward-pushing hand: dark skin tone
👌	hand	hand | OK | perfect
👌🏻	hand: light skin tone	hand | light skin tone | OK | OK hand: light skin tone | perfect
👌🏼	hand: medium-light skin tone	hand | medium-light skin tone | OK | OK hand: medium-light skin tone | perfect
👌🏽	hand: medium skin tone	hand | medium skin tone | OK | OK hand: medium skin tone | perfect
👌🏾	hand: medium-dark skin tone	hand | medium-dark skin tone | OK | OK hand: medium-dark skin tone | perfect
👌🏿	hand: dark skin tone	dark skin tone | hand | OK | OK hand: dark skin tone | perfect
🤌	fingers	fingers | hand gesture | interrogation | pinched | sarcastic
🤌🏻	fingers: light skin tone	fingers | hand gesture | interrogation | light skin tone | pinched | pinched fingers: light skin tone | sarcastic
🤌🏼	fingers: medium-light skin tone	fingers | hand gesture | interrogation | medium-light skin tone | pinched | pinched fingers: medium-light skin tone | sarcastic
🤌🏽	fingers: medium skin tone	fingers | hand gesture | interrogation | medium skin tone | pinched | pinched fingers: medium skin tone | sarcastic
🤌🏾	fingers: medium-dark skin tone	fingers | hand gesture | interrogation | medium-dark skin tone | pinched | pinched fingers: medium-dark skin tone | sarcastic
🤌🏿	fingers: dark skin tone	dark skin tone | fingers | hand gesture | interrogation | pinched | pinched fingers: dark skin tone | sarcastic
🤏	hand	pinching hand | small amount
🤏🏻	hand: light skin tone	light skin tone | pinching hand | pinching hand: light skin tone | small amount
🤏🏼	hand: medium-light skin tone	medium-light skin tone | pinching hand | pinching hand: medium-light skin tone | small amount
🤏🏽	hand: medium skin tone	medium skin tone | pinching hand | pinching hand: medium skin tone | small amount
🤏🏾	hand: medium-dark skin tone	medium-dark skin tone | pinching hand | pinching hand: medium-dark skin tone | small amount
🤏🏿	hand: dark skin tone	dark skin tone | pinching hand | pinching hand: dark skin tone | small amount
✌️	hand	
✌	hand	hand | v | victory
✌🏻	hand: light skin tone	hand | light skin tone | v | victory | victory hand: light skin tone
✌🏼	hand: medium-light skin tone	hand | medium-light skin tone | v | victory | victory hand: medium-light skin tone
✌🏽	hand: medium skin tone	hand | medium skin tone | v | victory | victory hand: medium skin tone
✌🏾	hand: medium-dark skin tone	hand | medium-dark skin tone | v | victory | victory hand: medium-dark skin tone
✌🏿	hand: dark skin tone	dark skin tone | hand | v | victory | victory hand: dark skin tone
🤞	fingers	cross | crossed fingers | finger | hand | luck | good luck
🤞🏻	fingers: light skin tone	cross | crossed fingers | crossed fingers: light skin tone | finger | hand | light skin tone | luck | good luck
🤞🏼	fingers: medium-light skin tone	cross | crossed fingers | crossed fingers: medium-light skin tone | finger | hand | luck | medium-light skin tone | good luck
🤞🏽	fingers: medium skin tone	cross | crossed fingers | crossed fingers: medium skin tone | finger | hand | luck | medium skin tone | good luck
🤞🏾	fingers: medium-dark skin tone	cross | crossed fingers | crossed fingers: medium-dark skin tone | finger | hand | luck | medium-dark skin tone | good luck
🤞🏿	fingers: dark skin tone	cross | crossed fingers | crossed fingers: dark skin tone | dark skin tone | finger | hand | luck | good luck
🫰	with index finger and thumb crossed	expensive | hand with index finger and thumb crossed | heart | love | money | snap
🫰🏻	with index finger and thumb crossed: light skin tone	expensive | hand with index finger and thumb crossed | hand with index finger and thumb crossed: light skin tone | heart | light skin tone | love | money | snap
🫰🏼	with index finger and thumb crossed: medium-light skin tone	expensive | hand with index finger and thumb crossed | hand with index finger and thumb crossed: medium-light skin tone | heart | love | medium-light skin tone | money | snap
🫰🏽	with index finger and thumb crossed: medium skin tone	expensive | hand with index finger and thumb crossed | hand with index finger and thumb crossed: medium skin tone | heart | love | medium skin tone | money | snap
🫰🏾	with index finger and thumb crossed: medium-dark skin tone	expensive | hand with index finger and thumb crossed | hand with index finger and thumb crossed: medium-dark skin tone | heart | love | medium-dark skin tone | money | snap
🫰🏿	with index finger and thumb crossed: dark skin tone	dark skin tone | expensive | hand with index finger and thumb crossed | hand with index finger and thumb crossed: dark skin tone | heart | love | money | snap
🤟	gesture	hand | ILY | love-you gesture | love you gesture
🤟🏻	gesture: light skin tone	hand | ILY | light skin tone | love-you gesture | love-you gesture: light skin tone | love you gesture
🤟🏼	gesture: medium-light skin tone	hand | ILY | love-you gesture | love-you gesture: medium-light skin tone | medium-light skin tone | love you gesture
🤟🏽	gesture: medium skin tone	hand | ILY | love-you gesture | love-you gesture: medium skin tone | medium skin tone | love you gesture
🤟🏾	gesture: medium-dark skin tone	hand | ILY | love-you gesture | love-you gesture: medium-dark skin tone | medium-dark skin tone | love you gesture
🤟🏿	gesture: dark skin tone	dark skin tone | hand | ILY | love-you gesture | love-you gesture: dark skin tone | love you gesture
🤘	of the horns	finger | hand | horns | rock-on | sign of the horns | rock on
🤘🏻	of the horns: light skin tone	finger | hand | horns | light skin tone | rock-on | sign of the horns | sign of the horns: light skin tone | rock on
🤘🏼	of the horns: medium-light skin tone	finger | hand | horns | medium-light skin tone | rock-on | sign of the horns | sign of the horns: medium-light skin tone | rock on
🤘🏽	of the horns: medium skin tone	finger | hand | horns | medium skin tone | rock-on | sign of the horns | sign of the horns: medium skin tone | rock on
🤘🏾	of the horns: medium-dark skin tone	finger | hand | horns | medium-dark skin tone | rock-on | sign of the horns | sign of the horns: medium-dark skin tone | rock on
🤘🏿	of the horns: dark skin tone	dark skin tone | finger | hand | horns | rock-on | sign of the horns | sign of the horns: dark skin tone | rock on
🤙	me hand	call | call me hand | hand | hang loose | Shaka | call-me hand | shaka
🤙🏻	me hand: light skin tone	call | call me hand | call me hand: light skin tone | hand | hang loose | light skin tone | Shaka | call-me hand | shaka | call-me hand: light skin tone
🤙🏼	me hand: medium-light skin tone	call | call me hand | call me hand: medium-light skin tone | hand | hang loose | medium-light skin tone | Shaka | call-me hand | shaka | call-me hand: medium-light skin tone
🤙🏽	me hand: medium skin tone	call | call me hand | call me hand: medium skin tone | hand | hang loose | medium skin tone | Shaka | call-me hand | shaka | call-me hand: medium skin tone
🤙🏾	me hand: medium-dark skin tone	call | call me hand | call me hand: medium-dark skin tone | hand | hang loose | medium-dark skin tone | Shaka | call-me hand | shaka | call-me hand: medium-dark skin tone
🤙🏿	me hand: dark skin tone	call | call me hand | call me hand: dark skin tone | dark skin tone | hand | hang loose | Shaka | call-me hand | shaka | call-me hand: dark skin tone
👈	index pointing left	backhand | backhand index pointing left | finger | hand | index | point
👈🏻	index pointing left: light skin tone	backhand | backhand index pointing left | backhand index pointing left: light skin tone | finger | hand | index | light skin tone | point
👈🏼	index pointing left: medium-light skin tone	backhand | backhand index pointing left | backhand index pointing left: medium-light skin tone | finger | hand | index | medium-light skin tone | point
👈🏽	index pointing left: medium skin tone	backhand | backhand index pointing left | backhand index pointing left: medium skin tone | finger | hand | index | medium skin tone | point
👈🏾	index pointing left: medium-dark skin tone	backhand | backhand index pointing left | backhand index pointing left: medium-dark skin tone | finger | hand | index | medium-dark skin tone | point
👈🏿	index pointing left: dark skin tone	backhand | backhand index pointing left | backhand index pointing left: dark skin tone | dark skin tone | finger | hand | index | point
👉	index pointing right	backhand | backhand index pointing right | finger | hand | index | point
👉🏻	index pointing right: light skin tone	backhand | backhand index pointing right | backhand index pointing right: light skin tone | finger | hand | index | light skin tone | point
👉🏼	index pointing right: medium-light skin tone	backhand | backhand index pointing right | backhand index pointing right: medium-light skin tone | finger | hand | index | medium-light skin tone | point
👉🏽	index pointing right: medium skin tone	backhand | backhand index pointing right | backhand index pointing right: medium skin tone | finger | hand | index | medium skin tone | point
👉🏾	index pointing right: medium-dark skin tone	backhand | backhand index pointing right | backhand index pointing right: medium-dark skin tone | finger | hand | index | medium-dark skin tone | point
👉🏿	index pointing right: dark skin tone	backhand | backhand index pointing right | backhand index pointing right: dark skin tone | dark skin tone | finger | hand | index | point
👆	index pointing up	backhand | backhand index pointing up | finger | hand | point | up
👆🏻	index pointing up: light skin tone	backhand | backhand index pointing up | backhand index pointing up: light skin tone | finger | hand | light skin tone | point | up
👆🏼	index pointing up: medium-light skin tone	backhand | backhand index pointing up | backhand index pointing up: medium-light skin tone | finger | hand | medium-light skin tone | point | up
👆🏽	index pointing up: medium skin tone	backhand | backhand index pointing up | backhand index pointing up: medium skin tone | finger | hand | medium skin tone | point | up
👆🏾	index pointing up: medium-dark skin tone	backhand | backhand index pointing up | backhand index pointing up: medium-dark skin tone | finger | hand | medium-dark skin tone | point | up
👆🏿	index pointing up: dark skin tone	backhand | backhand index pointing up | backhand index pointing up: dark skin tone | dark skin tone | finger | hand | point | up
🖕	finger	finger | hand | middle finger
🖕🏻	finger: light skin tone	finger | hand | light skin tone | middle finger | middle finger: light skin tone
🖕🏼	finger: medium-light skin tone	finger | hand | medium-light skin tone | middle finger | middle finger: medium-light skin tone
🖕🏽	finger: medium skin tone	finger | hand | medium skin tone | middle finger | middle finger: medium skin tone
🖕🏾	finger: medium-dark skin tone	finger | hand | medium-dark skin tone | middle finger | middle finger: medium-dark skin tone
🖕🏿	finger: dark skin tone	dark skin tone | finger | hand | middle finger | middle finger: dark skin tone
👇	index pointing down	backhand | backhand index pointing down | down | finger | hand | point
👇🏻	index pointing down: light skin tone	backhand | backhand index pointing down | backhand index pointing down: light skin tone | down | finger | hand | light skin tone | point
👇🏼	index pointing down: medium-light skin tone	backhand | backhand index pointing down | backhand index pointing down: medium-light skin tone | down | finger | hand | medium-light skin tone | point
👇🏽	index pointing down: medium skin tone	backhand | backhand index pointing down | backhand index pointing down: medium skin tone | down | finger | hand | medium skin tone | point
👇🏾	index pointing down: medium-dark skin tone	backhand | backhand index pointing down | backhand index pointing down: medium-dark skin tone | down | finger | hand | medium-dark skin tone | point
👇🏿	index pointing down: dark skin tone	backhand | backhand index pointing down | backhand index pointing down: dark skin tone | dark skin tone | down | finger | hand | point
☝️	pointing up	
☝	pointing up	finger | hand | index | index pointing up | point | up
☝🏻	pointing up: light skin tone	finger | hand | index | index pointing up | index pointing up: light skin tone | light skin tone | point | up
☝🏼	pointing up: medium-light skin tone	finger | hand | index | index pointing up | index pointing up: medium-light skin tone | medium-light skin tone | point | up
☝🏽	pointing up: medium skin tone	finger | hand | index | index pointing up | index pointing up: medium skin tone | medium skin tone | point | up
☝🏾	pointing up: medium-dark skin tone	finger | hand | index | index pointing up | index pointing up: medium-dark skin tone | medium-dark skin tone | point | up
☝🏿	pointing up: dark skin tone	dark skin tone | finger | hand | index | index pointing up | index pointing up: dark skin tone | point | up
🫵	pointing at the viewer	index pointing at the viewer | point | you
🫵🏻	pointing at the viewer: light skin tone	index pointing at the viewer | index pointing at the viewer: light skin tone | light skin tone | point | you
🫵🏼	pointing at the viewer: medium-light skin tone	index pointing at the viewer | index pointing at the viewer: medium-light skin tone | medium-light skin tone | point | you
🫵🏽	pointing at the viewer: medium skin tone	index pointing at the viewer | index pointing at the viewer: medium skin tone | medium skin tone | point | you
🫵🏾	pointing at the viewer: medium-dark skin tone	index pointing at the viewer | index pointing at the viewer: medium-dark skin tone | medium-dark skin tone | point | you
🫵🏿	pointing at the viewer: dark skin tone	dark skin tone | index pointing at the viewer | index pointing at the viewer: dark skin tone | point | you
👍	up	+1 | hand | thumb | thumbs up | up
👍🏻	up: light skin tone	+1 | hand | light skin tone | thumb | thumbs up | thumbs up: light skin tone | up
👍🏼	up: medium-light skin tone	+1 | hand | medium-light skin tone | thumb | thumbs up | thumbs up: medium-light skin tone | up
👍🏽	up: medium skin tone	+1 | hand | medium skin tone | thumb | thumbs up | thumbs up: medium skin tone | up
👍🏾	up: medium-dark skin tone	+1 | hand | medium-dark skin tone | thumb | thumbs up | thumbs up: medium-dark skin tone | up
👍🏿	up: dark skin tone	+1 | dark skin tone | hand | thumb | thumbs up | thumbs up: dark skin tone | up
👎	down	-1 | down | hand | thumb | thumbs down
👎🏻	down: light skin tone	-1 | down | hand | light skin tone | thumb | thumbs down | thumbs down: light skin tone
👎🏼	down: medium-light skin tone	-1 | down | hand | medium-light skin tone | thumb | thumbs down | thumbs down: medium-light skin tone
👎🏽	down: medium skin tone	-1 | down | hand | medium skin tone | thumb | thumbs down | thumbs down: medium skin tone
👎🏾	down: medium-dark skin tone	-1 | down | hand | medium-dark skin tone | thumb | thumbs down | thumbs down: medium-dark skin tone
👎🏿	down: dark skin tone	-1 | dark skin tone | down | hand | thumb | thumbs down | thumbs down: dark skin tone
✊	fist	clenched | fist | hand | punch | raised fist
✊🏻	fist: light skin tone	clenched | fist | hand | light skin tone | punch | raised fist | raised fist: light skin tone
✊🏼	fist: medium-light skin tone	clenched | fist | hand | medium-light skin tone | punch | raised fist | raised fist: medium-light skin tone
✊🏽	fist: medium skin tone	clenched | fist | hand | medium skin tone | punch | raised fist | raised fist: medium skin tone
✊🏾	fist: medium-dark skin tone	clenched | fist | hand | medium-dark skin tone | punch | raised fist | raised fist: medium-dark skin tone
✊🏿	fist: dark skin tone	clenched | dark skin tone | fist | hand | punch | raised fist | raised fist: dark skin tone
👊	fist	clenched | fist | hand | oncoming fist | punch
👊🏻	fist: light skin tone	clenched | fist | hand | light skin tone | oncoming fist | oncoming fist: light skin tone | punch
👊🏼	fist: medium-light skin tone	clenched | fist | hand | medium-light skin tone | oncoming fist | oncoming fist: medium-light skin tone | punch
👊🏽	fist: medium skin tone	clenched | fist | hand | medium skin tone | oncoming fist | oncoming fist: medium skin tone | punch
👊🏾	fist: medium-dark skin tone	clenched | fist | hand | medium-dark skin tone | oncoming fist | oncoming fist: medium-dark skin tone | punch
👊🏿	fist: dark skin tone	clenched | dark skin tone | fist | hand | oncoming fist | oncoming fist: dark skin tone | punch
🤛	fist	fist | left-facing fist | leftwards | leftward
🤛🏻	fist: light skin tone	fist | left-facing fist | left-facing fist: light skin tone | leftwards | light skin tone | leftward
🤛🏼	fist: medium-light skin tone	fist | left-facing fist | left-facing fist: medium-light skin tone | leftwards | medium-light skin tone | leftward
🤛🏽	fist: medium skin tone	fist | left-facing fist | left-facing fist: medium skin tone | leftwards | medium skin tone | leftward
🤛🏾	fist: medium-dark skin tone	fist | left-facing fist | left-facing fist: medium-dark skin tone | leftwards | medium-dark skin tone | leftward
🤛🏿	fist: dark skin tone	dark skin tone | fist | left-facing fist | left-facing fist: dark skin tone | leftwards | leftward
🤜	fist	fist | right-facing fist | rightwards | rightward
🤜🏻	fist: light skin tone	fist | light skin tone | right-facing fist | right-facing fist: light skin tone | rightwards | rightward
🤜🏼	fist: medium-light skin tone	fist | medium-light skin tone | right-facing fist | right-facing fist: medium-light skin tone | rightwards | rightward
🤜🏽	fist: medium skin tone	fist | medium skin tone | right-facing fist | right-facing fist: medium skin tone | rightwards | rightward
🤜🏾	fist: medium-dark skin tone	fist | medium-dark skin tone | right-facing fist | right-facing fist: medium-dark skin tone | rightwards | rightward
🤜🏿	fist: dark skin tone	dark skin tone | fist | right-facing fist | right-facing fist: dark skin tone | rightwards | rightward
👏	hands	clap | clapping hands | hand
👏🏻	hands: light skin tone	clap | clapping hands | clapping hands: light skin tone | hand | light skin tone
👏🏼	hands: medium-light skin tone	clap | clapping hands | clapping hands: medium-light skin tone | hand | medium-light skin tone
👏🏽	hands: medium skin tone	clap | clapping hands | clapping hands: medium skin tone | hand | medium skin tone
👏🏾	hands: medium-dark skin tone	clap | clapping hands | clapping hands: medium-dark skin tone | hand | medium-dark skin tone
👏🏿	hands: dark skin tone	clap | clapping hands | clapping hands: dark skin tone | dark skin tone | hand
🙌	hands	celebration | gesture | hand | hooray | raised | raising hands | woo hoo | yay
🙌🏻	hands: light skin tone	celebration | gesture | hand | hooray | light skin tone | raised | raising hands | raising hands: light skin tone | woo hoo | yay
🙌🏼	hands: medium-light skin tone	celebration | gesture | hand | hooray | medium-light skin tone | raised | raising hands | raising hands: medium-light skin tone | woo hoo | yay
🙌🏽	hands: medium skin tone	celebration | gesture | hand | hooray | medium skin tone | raised | raising hands | raising hands: medium skin tone | woo hoo | yay
🙌🏾	hands: medium-dark skin tone	celebration | gesture | hand | hooray | medium-dark skin tone | raised | raising hands | raising hands: medium-dark skin tone | woo hoo | yay
🙌🏿	hands: dark skin tone	celebration | dark skin tone | gesture | hand | hooray | raised | raising hands | raising hands: dark skin tone | woo hoo | yay
🫶	hands	heart hands | love
🫶🏻	hands: light skin tone	heart hands | heart hands: light skin tone | light skin tone | love
🫶🏼	hands: medium-light skin tone	heart hands | heart hands: medium-light skin tone | love | medium-light skin tone
🫶🏽	hands: medium skin tone	heart hands | heart hands: medium skin tone | love | medium skin tone
🫶🏾	hands: medium-dark skin tone	heart hands | heart hands: medium-dark skin tone | love | medium-dark skin tone
🫶🏿	hands: dark skin tone	dark skin tone | heart hands | heart hands: dark skin tone | love
👐	hands	hand | open | open hands
👐🏻	hands: light skin tone	hand | light skin tone | open | open hands | open hands: light skin tone
👐🏼	hands: medium-light skin tone	hand | medium-light skin tone | open | open hands | open hands: medium-light skin tone
👐🏽	hands: medium skin tone	hand | medium skin tone | open | open hands | open hands: medium skin tone
👐🏾	hands: medium-dark skin tone	hand | medium-dark skin tone | open | open hands | open hands: medium-dark skin tone
👐🏿	hands: dark skin tone	dark skin tone | hand | open | open hands | open hands: dark skin tone
🤲	up together	palms up together | prayer
🤲🏻	up together: light skin tone	light skin tone | palms up together | palms up together: light skin tone | prayer
🤲🏼	up together: medium-light skin tone	medium-light skin tone | palms up together | palms up together: medium-light skin tone | prayer
🤲🏽	up together: medium skin tone	medium skin tone | palms up together | palms up together: medium skin tone | prayer
🤲🏾	up together: medium-dark skin tone	medium-dark skin tone | palms up together | palms up together: medium-dark skin tone | prayer
🤲🏿	up together: dark skin tone	dark skin tone | palms up together | palms up together: dark skin tone | prayer
🤝	agreement | hand | handshake | meeting | shake
🤝🏻	light skin tone	agreement | hand | handshake | handshake: light skin tone | light skin tone | meeting | shake
🤝🏼	medium-light skin tone	agreement | hand | handshake | handshake: medium-light skin tone | medium-light skin tone | meeting | shake
🤝🏽	medium skin tone	agreement | hand | handshake | handshake: medium skin tone | medium skin tone | meeting | shake
🤝🏾	medium-dark skin tone	agreement | hand | handshake | handshake: medium-dark skin tone | medium-dark skin tone | meeting | shake
🤝🏿	dark skin tone	agreement | dark skin tone | hand | handshake | handshake: dark skin tone | meeting | shake
🫱🏻‍🫲🏼	light skin tone, medium-light skin tone	agreement | hand | handshake | handshake: light skin tone, medium-light skin tone | light skin tone | medium-light skin tone | meeting | shake
🫱🏻‍🫲🏽	light skin tone, medium skin tone	agreement | hand | handshake | handshake: light skin tone, medium skin tone | light skin tone | medium skin tone | meeting | shake
🫱🏻‍🫲🏾	light skin tone, medium-dark skin tone	agreement | hand | handshake | handshake: light skin tone, medium-dark skin tone | light skin tone | medium-dark skin tone | meeting | shake
🫱🏻‍🫲🏿	light skin tone, dark skin tone	agreement | dark skin tone | hand | handshake | handshake: light skin tone, dark skin tone | light skin tone | meeting | shake
🫱🏼‍🫲🏻	medium-light skin tone, light skin tone	agreement | hand | handshake | handshake: medium-light skin tone, light skin tone | light skin tone | medium-light skin tone | meeting | shake
🫱🏼‍🫲🏽	medium-light skin tone, medium skin tone	agreement | hand | handshake | handshake: medium-light skin tone, medium skin tone | medium skin tone | medium-light skin tone | meeting | shake
🫱🏼‍🫲🏾	medium-light skin tone, medium-dark skin tone	agreement | hand | handshake | handshake: medium-light skin tone, medium-dark skin tone | medium-dark skin tone | medium-light skin tone | meeting | shake
🫱🏼‍🫲🏿	medium-light skin tone, dark skin tone	agreement | dark skin tone | hand | handshake | handshake: medium-light skin tone, dark skin tone | medium-light skin tone | meeting | shake
🫱🏽‍🫲🏻	medium skin tone, light skin tone	agreement | hand | handshake | handshake: medium skin tone, light skin tone | light skin tone | medium skin tone | meeting | shake
🫱🏽‍🫲🏼	medium skin tone, medium-light skin tone	agreement | hand | handshake | handshake: medium skin tone, medium-light skin tone | medium skin tone | medium-light skin tone | meeting | shake
🫱🏽‍🫲🏾	medium skin tone, medium-dark skin tone	agreement | hand | handshake | handshake: medium skin tone, medium-dark skin tone | medium skin tone | medium-dark skin tone | meeting | shake
🫱🏽‍🫲🏿	medium skin tone, dark skin tone	agreement | dark skin tone | hand | handshake | handshake: medium skin tone, dark skin tone | medium skin tone | meeting | shake
🫱🏾‍🫲🏻	medium-dark skin tone, light skin tone	agreement | hand | handshake | handshake: medium-dark skin tone, light skin tone | light skin tone | medium-dark skin tone | meeting | shake
🫱🏾‍🫲🏼	medium-dark skin tone, medium-light skin tone	agreement | hand | handshake | handshake: medium-dark skin tone, medium-light skin tone | medium-dark skin tone | medium-light skin tone | meeting | shake
🫱🏾‍🫲🏽	medium-dark skin tone, medium skin tone	agreement | hand | handshake | handshake: medium-dark skin tone, medium skin tone | medium skin tone | medium-dark skin tone | meeting | shake
🫱🏾‍🫲🏿	medium-dark skin tone, dark skin tone	agreement | dark skin tone | hand | handshake | handshake: medium-dark skin tone, dark skin tone | medium-dark skin tone | meeting | shake
🫱🏿‍🫲🏻	dark skin tone, light skin tone	agreement | dark skin tone | hand | handshake | handshake: dark skin tone, light skin tone | light skin tone | meeting | shake
🫱🏿‍🫲🏼	dark skin tone, medium-light skin tone	agreement | dark skin tone | hand | handshake | handshake: dark skin tone, medium-light skin tone | medium-light skin tone | meeting | shake
🫱🏿‍🫲🏽	dark skin tone, medium skin tone	agreement | dark skin tone | hand | handshake | handshake: dark skin tone, medium skin tone | medium skin tone | meeting | shake
🫱🏿‍🫲🏾	dark skin tone, medium-dark skin tone	agreement | dark skin tone | hand | handshake | handshake: dark skin tone, medium-dark skin tone | medium-dark skin tone | meeting | shake
🙏	hands	ask | folded hands | hand | high 5 | high five | please | pray | thanks
🙏🏻	hands: light skin tone	ask | folded hands | folded hands: light skin tone | hand | high 5 | high five | light skin tone | please | pray | thanks
🙏🏼	hands: medium-light skin tone	ask | folded hands | folded hands: medium-light skin tone | hand | high 5 | high five | medium-light skin tone | please | pray | thanks
🙏🏽	hands: medium skin tone	ask | folded hands | folded hands: medium skin tone | hand | high 5 | high five | medium skin tone | please | pray | thanks
🙏🏾	hands: medium-dark skin tone	ask | folded hands | folded hands: medium-dark skin tone | hand | high 5 | high five | medium-dark skin tone | please | pray | thanks
🙏🏿	hands: dark skin tone	ask | dark skin tone | folded hands | folded hands: dark skin tone | hand | high 5 | high five | please | pray | thanks
✍️	hand	
✍	hand	hand | write | writing hand
✍🏻	hand: light skin tone	hand | light skin tone | write | writing hand | writing hand: light skin tone
✍🏼	hand: medium-light skin tone	hand | medium-light skin tone | write | writing hand | writing hand: medium-light skin tone
✍🏽	hand: medium skin tone	hand | medium skin tone | write | writing hand | writing hand: medium skin tone
✍🏾	hand: medium-dark skin tone	hand | medium-dark skin tone | write | writing hand | writing hand: medium-dark skin tone
✍🏿	hand: dark skin tone	dark skin tone | hand | write | writing hand | writing hand: dark skin tone
💅	polish	care | cosmetics | manicure | nail | polish
💅🏻	polish: light skin tone	care | cosmetics | light skin tone | manicure | nail | nail polish: light skin tone | polish
💅🏼	polish: medium-light skin tone	care | cosmetics | manicure | medium-light skin tone | nail | nail polish: medium-light skin tone | polish
💅🏽	polish: medium skin tone	care | cosmetics | manicure | medium skin tone | nail | nail polish: medium skin tone | polish
💅🏾	polish: medium-dark skin tone	care | cosmetics | manicure | medium-dark skin tone | nail | nail polish: medium-dark skin tone | polish
💅🏿	polish: dark skin tone	care | cosmetics | dark skin tone | manicure | nail | nail polish: dark skin tone | polish
🤳		camera | phone | selfie
🤳🏻	light skin tone	camera | light skin tone | phone | selfie | selfie: light skin tone
🤳🏼	medium-light skin tone	camera | medium-light skin tone | phone | selfie | selfie: medium-light skin tone
🤳🏽	medium skin tone	camera | medium skin tone | phone | selfie | selfie: medium skin tone
🤳🏾	medium-dark skin tone	camera | medium-dark skin tone | phone | selfie | selfie: medium-dark skin tone
🤳🏿	dark skin tone	camera | dark skin tone | phone | selfie | selfie: dark skin tone
💪	biceps	biceps | comic | flex | flexed biceps | muscle | flexed bicep
💪🏻	biceps: light skin tone	biceps | comic | flex | flexed biceps | flexed biceps: light skin tone | light skin tone | muscle | flexed bicep | flexed bicep: light skin tone
💪🏼	biceps: medium-light skin tone	biceps | comic | flex | flexed biceps | flexed biceps: medium-light skin tone | medium-light skin tone | muscle | flexed bicep | flexed bicep: medium-light skin tone
💪🏽	biceps: medium skin tone	biceps | comic | flex | flexed biceps | flexed biceps: medium skin tone | medium skin tone | muscle | flexed bicep | flexed bicep: medium skin tone
💪🏾	biceps: medium-dark skin tone	biceps | comic | flex | flexed biceps | flexed biceps: medium-dark skin tone | medium-dark skin tone | muscle | flexed bicep | flexed bicep: medium-dark skin tone
💪🏿	biceps: dark skin tone	biceps | comic | dark skin tone | flex | flexed biceps | flexed biceps: dark skin tone | muscle | flexed bicep | flexed bicep: dark skin tone
🦾	arm	accessibility | mechanical arm | prosthetic
🦿	leg	accessibility | mechanical leg | prosthetic
🦵	kick | leg | limb
🦵🏻	light skin tone	kick | leg | leg: light skin tone | light skin tone | limb
🦵🏼	medium-light skin tone	kick | leg | leg: medium-light skin tone | limb | medium-light skin tone
🦵🏽	medium skin tone	kick | leg | leg: medium skin tone | limb | medium skin tone
🦵🏾	medium-dark skin tone	kick | leg | leg: medium-dark skin tone | limb | medium-dark skin tone
🦵🏿	dark skin tone	dark skin tone | kick | leg | leg: dark skin tone | limb
🦶	foot | kick | stomp
🦶🏻	light skin tone	foot | foot: light skin tone | kick | light skin tone | stomp
🦶🏼	medium-light skin tone	foot | foot: medium-light skin tone | kick | medium-light skin tone | stomp
🦶🏽	medium skin tone	foot | foot: medium skin tone | kick | medium skin tone | stomp
🦶🏾	medium-dark skin tone	foot | foot: medium-dark skin tone | kick | medium-dark skin tone | stomp
🦶🏿	dark skin tone	dark skin tone | foot | foot: dark skin tone | kick | stomp
👂	body | ear
👂🏻	light skin tone	body | ear | ear: light skin tone | light skin tone
👂🏼	medium-light skin tone	body | ear | ear: medium-light skin tone | medium-light skin tone
👂🏽	medium skin tone	body | ear | ear: medium skin tone | medium skin tone
👂🏾	medium-dark skin tone	body | ear | ear: medium-dark skin tone | medium-dark skin tone
👂🏿	dark skin tone	body | dark skin tone | ear | ear: dark skin tone
🦻	with hearing aid	accessibility | ear with hearing aid | hard of hearing | hearing impaired
🦻🏻	with hearing aid: light skin tone	accessibility | ear with hearing aid | ear with hearing aid: light skin tone | hard of hearing | light skin tone | hearing impaired
🦻🏼	with hearing aid: medium-light skin tone	accessibility | ear with hearing aid | ear with hearing aid: medium-light skin tone | hard of hearing | medium-light skin tone | hearing impaired
🦻🏽	with hearing aid: medium skin tone	accessibility | ear with hearing aid | ear with hearing aid: medium skin tone | hard of hearing | medium skin tone | hearing impaired
🦻🏾	with hearing aid: medium-dark skin tone	accessibility | ear with hearing aid | ear with hearing aid: medium-dark skin tone | hard of hearing | medium-dark skin tone | hearing impaired
🦻🏿	with hearing aid: dark skin tone	accessibility | dark skin tone | ear with hearing aid | ear with hearing aid: dark skin tone | hard of hearing | hearing impaired
👃	body | nose
👃🏻	light skin tone	body | light skin tone | nose | nose: light skin tone
👃🏼	medium-light skin tone	body | medium-light skin tone | nose | nose: medium-light skin tone
👃🏽	medium skin tone	body | medium skin tone | nose | nose: medium skin tone
👃🏾	medium-dark skin tone	body | medium-dark skin tone | nose | nose: medium-dark skin tone
👃🏿	dark skin tone	body | dark skin tone | nose | nose: dark skin tone
🧠	brain | intelligent
🫀	heart	anatomical | cardiology | heart | organ | pulse | anatomical heart
🫁	breath | exhalation | inhalation | lungs | organ | respiration
🦷	dentist | tooth
🦴	bone | skeleton
👀	eye | eyes | face
👁️	brown eyes
👁	body | eye
👅	body | tongue
👄	lips | mouth
🫦	lip	anxious | biting lip | fear | flirting | nervous | uncomfortable | worried
👶	baby | young
👶🏻	light skin tone	baby | baby: light skin tone | light skin tone | young
👶🏼	medium-light skin tone	baby | baby: medium-light skin tone | medium-light skin tone | young
👶🏽	medium skin tone	baby | baby: medium skin tone | medium skin tone | young
👶🏾	medium-dark skin tone	baby | baby: medium-dark skin tone | medium-dark skin tone | young
👶🏿	dark skin tone	baby | baby: dark skin tone | dark skin tone | young
🧒		child | gender-neutral | unspecified gender | young
🧒🏻	light skin tone	child | child: light skin tone | gender-neutral | light skin tone | unspecified gender | young
🧒🏼	medium-light skin tone	child | child: medium-light skin tone | gender-neutral | medium-light skin tone | unspecified gender | young
🧒🏽	medium skin tone	child | child: medium skin tone | gender-neutral | medium skin tone | unspecified gender | young
🧒🏾	medium-dark skin tone	child | child: medium-dark skin tone | gender-neutral | medium-dark skin tone | unspecified gender | young
🧒🏿	dark skin tone	child | child: dark skin tone | dark skin tone | gender-neutral | unspecified gender | young
👦		boy | young | young person
👦🏻	light skin tone	boy | boy: light skin tone | light skin tone | young | young person
👦🏼	medium-light skin tone	boy | boy: medium-light skin tone | medium-light skin tone | young | young person
👦🏽	medium skin tone	boy | boy: medium skin tone | medium skin tone | young | young person
👦🏾	medium-dark skin tone	boy | boy: medium-dark skin tone | medium-dark skin tone | young | young person
👦🏿	dark skin tone	boy | boy: dark skin tone | dark skin tone | young | young person
👧		girl | Virgo | young | zodiac | young person
👧🏻	light skin ton—e	girl | girl: light skin tone | light skin tone | Virgo | young | zodiac | young person
👧🏼	medium-light skin tone	girl | girl: medium-light skin tone | medium-light skin tone | Virgo | young | zodiac | young person
👧🏽	medium skin tone	girl | girl: medium skin tone | medium skin tone | Virgo | young | zodiac | young person
👧🏾	medium-dark skin tone	girl | girl: medium-dark skin tone | medium-dark skin tone | Virgo | young | zodiac | young person
👧🏿	dark skin tone	dark skin tone | girl | girl: dark skin tone | Virgo | young | zodiac | young person
🧑		adult | gender-neutral | person | unspecified gender
🧑🏻	light skin tone	adult | gender-neutral | light skin tone | person | person: light skin tone | unspecified gender
🧑🏼	medium-light skin tone	adult | gender-neutral | medium-light skin tone | person | person: medium-light skin tone | unspecified gender
🧑🏽	medium skin tone	adult | gender-neutral | medium skin tone | person | person: medium skin tone | unspecified gender
🧑🏾	medium-dark skin tone	adult | gender-neutral | medium-dark skin tone | person | person: medium-dark skin tone | unspecified gender
🧑🏿	dark skin tone	adult | dark skin tone | gender-neutral | person | person: dark skin tone | unspecified gender
👱	blond hair	blond | blond-haired person | hair | person: blond hair
👱🏻	light skin tone, blond hair	blond | blond-haired person | hair | light skin tone | person: blond hair | person: light skin tone, blond hair
👱🏼	medium-light skin tone, blond hair	blond | blond-haired person | hair | medium-light skin tone | person: blond hair | person: medium-light skin tone, blond hair
👱🏽	medium skin tone, blond hair	blond | blond-haired person | hair | medium skin tone | person: blond hair | person: medium skin tone, blond hair
👱🏾	medium-dark skin tone, blond hair	blond | blond-haired person | hair | medium-dark skin tone | person: blond hair | person: medium-dark skin tone, blond hair
👱🏿	dark skin tone, blond hair	blond | blond-haired person | dark skin tone | hair | person: blond hair | person: dark skin tone, blond hair
👨		adult | man
👨🏻	light skin tone	adult | light skin tone | man | man: light skin tone
👨🏼	medium-light skin tone	adult | man | man: medium-light skin tone | medium-light skin tone
👨🏽	medium skin tone	adult | man | man: medium skin tone | medium skin tone
👨🏾	medium-dark skin tone	adult | man | man: medium-dark skin tone | medium-dark skin tone
👨🏿	dark skin tone	adult | dark skin tone | man | man: dark skin tone
🧔	beard	beard | person | person: beard
🧔🏻	light skin tone, beard	beard | light skin tone | person | person: beard | person: light skin tone, beard
🧔🏼	medium-light skin tone, beard	beard | medium-light skin tone | person | person: beard | person: medium-light skin tone, beard
🧔🏽	medium skin tone, beard	beard | medium skin tone | person | person: beard | person: medium skin tone, beard
🧔🏾	medium-dark skin tone, beard	beard | medium-dark skin tone | person | person: beard | person: medium-dark skin tone, beard
🧔🏿	dark skin tone, beard	beard | dark skin tone | person | person: beard | person: dark skin tone, beard
🧔‍♂️	beard	
🧔‍♂	beard	beard | man | man: beard
🧔🏻‍♂️	light skin tone, beard	
🧔🏻‍♂	light skin tone, beard	beard | light skin tone | man | man: beard | man: light skin tone, beard
🧔🏼‍♂️	medium-light skin tone, beard	
🧔🏼‍♂	medium-light skin tone, beard	beard | man | man: beard | man: medium-light skin tone, beard | medium-light skin tone
🧔🏽‍♂️	medium skin tone, beard	
🧔🏽‍♂	medium skin tone, beard	beard | man | man: beard | man: medium skin tone, beard | medium skin tone
🧔🏾‍♂️	medium-dark skin tone, beard	
🧔🏾‍♂	medium-dark skin tone, beard	beard | man | man: beard | man: medium-dark skin tone, beard | medium-dark skin tone
🧔🏿‍♂️	dark skin tone, beard	
🧔🏿‍♂	dark skin tone, beard	beard | dark skin tone | man | man: beard | man: dark skin tone, beard
🧔‍♀️	beard	
🧔‍♀	beard	beard | woman | woman: beard
🧔🏻‍♀️	light skin tone, beard	
🧔🏻‍♀	light skin tone, beard	beard | light skin tone | woman | woman: beard | woman: light skin tone, beard
🧔🏼‍♀️	medium-light skin tone, beard	
🧔🏼‍♀	medium-light skin tone, beard	beard | medium-light skin tone | woman | woman: beard | woman: medium-light skin tone, beard
🧔🏽‍♀️	medium skin tone, beard	
🧔🏽‍♀	medium skin tone, beard	beard | medium skin tone | woman | woman: beard | woman: medium skin tone, beard
🧔🏾‍♀️	medium-dark skin tone, beard	
🧔🏾‍♀	medium-dark skin tone, beard	beard | medium-dark skin tone | woman | woman: beard | woman: medium-dark skin tone, beard
🧔🏿‍♀️	dark skin tone, beard	
🧔🏿‍♀	dark skin tone, beard	beard | dark skin tone | woman | woman: beard | woman: dark skin tone, beard
👨‍🦰	red hair	adult | man | man: red hair | red hair
👨🏻‍🦰	light skin tone, red hair	adult | light skin tone | man | man: light skin tone, red hair | red hair
👨🏼‍🦰	medium-light skin tone, red hair	adult | man | man: medium-light skin tone, red hair | medium-light skin tone | red hair
👨🏽‍🦰	medium skin tone, red hair	adult | man | man: medium skin tone, red hair | medium skin tone | red hair
👨🏾‍🦰	medium-dark skin tone, red hair	adult | man | man: medium-dark skin tone, red hair | medium-dark skin tone | red hair
👨🏿‍🦰	dark skin tone, red hair	adult | dark skin tone | man | man: dark skin tone, red hair | red hair
👨‍🦱	curly hair	adult | curly hair | man | man: curly hair
👨🏻‍🦱	light skin tone, curly hair	adult | curly hair | light skin tone | man | man: light skin tone, curly hair
👨🏼‍🦱	medium-light skin tone, curly hair	adult | curly hair | man | man: medium-light skin tone, curly hair | medium-light skin tone
👨🏽‍🦱	medium skin tone, curly hair	adult | curly hair | man | man: medium skin tone, curly hair | medium skin tone
👨🏾‍🦱	medium-dark skin tone, curly hair	adult | curly hair | man | man: medium-dark skin tone, curly hair | medium-dark skin tone
👨🏿‍🦱	dark skin tone, curly hair	adult | curly hair | dark skin tone | man | man: dark skin tone, curly hair
👨‍🦳	white hair	adult | man | man: white hair | white hair
👨🏻‍🦳	light skin tone, white hair	adult | light skin tone | man | man: light skin tone, white hair | white hair
👨🏼‍🦳	medium-light skin tone, white hair	adult | man | man: medium-light skin tone, white hair | medium-light skin tone | white hair
👨🏽‍🦳	medium skin tone, white hair	adult | man | man: medium skin tone, white hair | medium skin tone | white hair
👨🏾‍🦳	medium-dark skin tone, white hair	adult | man | man: medium-dark skin tone, white hair | medium-dark skin tone | white hair
👨🏿‍🦳	dark skin tone, white hair	adult | dark skin tone | man | man: dark skin tone, white hair | white hair
👨‍🦲	bald	adult | bald | man | man: bald
👨🏻‍🦲	light skin tone, bald	adult | bald | light skin tone | man | man: light skin tone, bald
👨🏼‍🦲	medium-light skin tone, bald	adult | bald | man | man: medium-light skin tone, bald | medium-light skin tone
👨🏽‍🦲	medium skin tone, bald	adult | bald | man | man: medium skin tone, bald | medium skin tone
👨🏾‍🦲	medium-dark skin tone, bald	adult | bald | man | man: medium-dark skin tone, bald | medium-dark skin tone
👨🏿‍🦲	dark skin tone, bald	adult | bald | dark skin tone | man | man: dark skin tone, bald
👩		adult | woman
👩🏻	light skin tone	adult | light skin tone | woman | woman: light skin tone
👩🏼	medium-light skin tone	adult | medium-light skin tone | woman | woman: medium-light skin tone
👩🏽	medium skin tone	adult | medium skin tone | woman | woman: medium skin tone
👩🏾	medium-dark skin tone	adult | medium-dark skin tone | woman | woman: medium-dark skin tone
👩🏿	dark skin tone	adult | dark skin tone | woman | woman: dark skin tone
👩‍🦰	red hair	adult | red hair | woman | woman: red hair
👩🏻‍🦰	light skin tone, red hair	adult | light skin tone | red hair | woman | woman: light skin tone, red hair
👩🏼‍🦰	medium-light skin tone, red hair	adult | medium-light skin tone | red hair | woman | woman: medium-light skin tone, red hair
👩🏽‍🦰	medium skin tone, red hair	adult | medium skin tone | red hair | woman | woman: medium skin tone, red hair
👩🏾‍🦰	medium-dark skin tone, red hair	adult | medium-dark skin tone | red hair | woman | woman: medium-dark skin tone, red hair
👩🏿‍🦰	dark skin tone, red hair	adult | dark skin tone | red hair | woman | woman: dark skin tone, red hair
🧑‍🦰	red hair	adult | gender-neutral | person | person: red hair | red hair | unspecified gender
🧑🏻‍🦰	light skin tone, red hair	adult | gender-neutral | light skin tone | person | person: light skin tone, red hair | red hair | unspecified gender
🧑🏼‍🦰	medium-light skin tone, red hair	adult | gender-neutral | medium-light skin tone | person | person: medium-light skin tone, red hair | red hair | unspecified gender
🧑🏽‍🦰	medium skin tone, red hair	adult | gender-neutral | medium skin tone | person | person: medium skin tone, red hair | red hair | unspecified gender
🧑🏾‍🦰	medium-dark skin tone, red hair	adult | gender-neutral | medium-dark skin tone | person | person: medium-dark skin tone, red hair | red hair | unspecified gender
🧑🏿‍🦰	dark skin tone, red hair	adult | dark skin tone | gender-neutral | person | person: dark skin tone, red hair | red hair | unspecified gender
👩‍🦱	curly hair	adult | curly hair | woman | woman: curly hair
👩🏻‍🦱	light skin tone, curly hair	adult | curly hair | light skin tone | woman | woman: light skin tone, curly hair
👩🏼‍🦱	medium-light skin tone, curly hair	adult | curly hair | medium-light skin tone | woman | woman: medium-light skin tone, curly hair
👩🏽‍🦱	medium skin tone, curly hair	adult | curly hair | medium skin tone | woman | woman: medium skin tone, curly hair
👩🏾‍🦱	medium-dark skin tone, curly hair	adult | curly hair | medium-dark skin tone | woman | woman: medium-dark skin tone, curly hair
👩🏿‍🦱	dark skin tone, curly hair	adult | curly hair | dark skin tone | woman | woman: dark skin tone, curly hair
🧑‍🦱	curly hair	adult | curly hair | gender-neutral | person | person: curly hair | unspecified gender
🧑🏻‍🦱	light skin tone, curly hair	adult | curly hair | gender-neutral | light skin tone | person | person: light skin tone, curly hair | unspecified gender
🧑🏼‍🦱	medium-light skin tone, curly hair	adult | curly hair | gender-neutral | medium-light skin tone | person | person: medium-light skin tone, curly hair | unspecified gender
🧑🏽‍🦱	medium skin tone, curly hair	adult | curly hair | gender-neutral | medium skin tone | person | person: medium skin tone, curly hair | unspecified gender
🧑🏾‍🦱	medium-dark skin tone, curly hair	adult | curly hair | gender-neutral | medium-dark skin tone | person | person: medium-dark skin tone, curly hair | unspecified gender
🧑🏿‍🦱	dark skin tone, curly hair	adult | curly hair | dark skin tone | gender-neutral | person | person: dark skin tone, curly hair | unspecified gender
👩‍🦳	white hair	adult | white hair | woman | woman: white hair
👩🏻‍🦳	light skin tone, white hair	adult | light skin tone | white hair | woman | woman: light skin tone, white hair
👩🏼‍🦳	medium-light skin tone, white hair	adult | medium-light skin tone | white hair | woman | woman: medium-light skin tone, white hair
👩🏽‍🦳	medium skin tone, white hair	adult | medium skin tone | white hair | woman | woman: medium skin tone, white hair
👩🏾‍🦳	medium-dark skin tone, white hair	adult | medium-dark skin tone | white hair | woman | woman: medium-dark skin tone, white hair
👩🏿‍🦳	dark skin tone, white hair	adult | dark skin tone | white hair | woman | woman: dark skin tone, white hair
🧑‍🦳	white hair	adult | gender-neutral | person | person: white hair | unspecified gender | white hair
🧑🏻‍🦳	light skin tone, white hair	adult | gender-neutral | light skin tone | person | person: light skin tone, white hair | unspecified gender | white hair
🧑🏼‍🦳	medium-light skin tone, white hair	adult | gender-neutral | medium-light skin tone | person | person: medium-light skin tone, white hair | unspecified gender | white hair
🧑🏽‍🦳	medium skin tone, white hair	adult | gender-neutral | medium skin tone | person | person: medium skin tone, white hair | unspecified gender | white hair
🧑🏾‍🦳	medium-dark skin tone, white hair	adult | gender-neutral | medium-dark skin tone | person | person: medium-dark skin tone, white hair | unspecified gender | white hair
🧑🏿‍🦳	dark skin tone, white hair	adult | dark skin tone | gender-neutral | person | person: dark skin tone, white hair | unspecified gender | white hair
👩‍🦲	bald	adult | bald | woman | woman: bald
👩🏻‍🦲	light skin tone, bald	adult | bald | light skin tone | woman | woman: light skin tone, bald
👩🏼‍🦲	medium-light skin tone, bald	adult | bald | medium-light skin tone | woman | woman: medium-light skin tone, bald
👩🏽‍🦲	medium skin tone, bald	adult | bald | medium skin tone | woman | woman: medium skin tone, bald
👩🏾‍🦲	medium-dark skin tone, bald	adult | bald | medium-dark skin tone | woman | woman: medium-dark skin tone, bald
👩🏿‍🦲	dark skin tone, bald	adult | bald | dark skin tone | woman | woman: dark skin tone, bald
🧑‍🦲	bald	adult | bald | gender-neutral | person | person: bald | unspecified gender
🧑🏻‍🦲	light skin tone, bald	adult | bald | gender-neutral | light skin tone | person | person: light skin tone, bald | unspecified gender
🧑🏼‍🦲	medium-light skin tone, bald	adult | bald | gender-neutral | medium-light skin tone | person | person: medium-light skin tone, bald | unspecified gender
🧑🏽‍🦲	medium skin tone, bald	adult | bald | gender-neutral | medium skin tone | person | person: medium skin tone, bald | unspecified gender
🧑🏾‍🦲	medium-dark skin tone, bald	adult | bald | gender-neutral | medium-dark skin tone | person | person: medium-dark skin tone, bald | unspecified gender
🧑🏿‍🦲	dark skin tone, bald	adult | bald | dark skin tone | gender-neutral | person | person: dark skin tone, bald | unspecified gender
👱‍♀️	blond hair	
👱‍♀	blond hair	blond-haired woman | blonde | hair | woman | woman: blond hair
👱🏻‍♀️	light skin tone, blond hair	
👱🏻‍♀	light skin tone, blond hair	blond hair | blond-haired woman | blonde | hair | light skin tone | woman | woman: blond hair | woman: light skin tone, blond hair
👱🏼‍♀️	medium-light skin tone, blond hair	
👱🏼‍♀	medium-light skin tone, blond hair	blond hair | blond-haired woman | blonde | hair | medium-light skin tone | woman | woman: blond hair | woman: medium-light skin tone, blond hair
👱🏽‍♀️	medium skin tone, blond hair	
👱🏽‍♀	medium skin tone, blond hair	blond hair | blond-haired woman | blonde | hair | medium skin tone | woman | woman: blond hair | woman: medium skin tone, blond hair
👱🏾‍♀️	medium-dark skin tone, blond hair	
👱🏾‍♀	medium-dark skin tone, blond hair	blond hair | blond-haired woman | blonde | hair | medium-dark skin tone | woman | woman: blond hair | woman: medium-dark skin tone, blond hair
👱🏿‍♀️	dark skin tone, blond hair	
👱🏿‍♀	dark skin tone, blond hair	blond hair | blond-haired woman | blonde | dark skin tone | hair | woman | woman: blond hair | woman: dark skin tone, blond hair
👱‍♂️	blond hair	
👱‍♂	blond hair	blond | blond-haired man | hair | man | man: blond hair
👱🏻‍♂️	light skin tone, blond hair	
👱🏻‍♂	light skin tone, blond hair	blond | blond-haired man | hair | light skin tone | man | man: blond hair | man: light skin tone, blond hair
👱🏼‍♂️	medium-light skin tone, blond hair	
👱🏼‍♂	medium-light skin tone, blond hair	blond | blond-haired man | hair | man | man: blond hair | man: medium-light skin tone, blond hair | medium-light skin tone
👱🏽‍♂️	medium skin tone, blond hair	
👱🏽‍♂	medium skin tone, blond hair	blond | blond-haired man | hair | man | man: blond hair | man: medium skin tone, blond hair | medium skin tone
👱🏾‍♂️	medium-dark skin tone, blond hair	
👱🏾‍♂	medium-dark skin tone, blond hair	blond | blond-haired man | hair | man | man: blond hair | man: medium-dark skin tone, blond hair | medium-dark skin tone
👱🏿‍♂️	dark skin tone, blond hair	
👱🏿‍♂	dark skin tone, blond hair	blond | blond-haired man | dark skin tone | hair | man | man: blond hair | man: dark skin tone, blond hair
🧓	person	adult | gender-neutral | old | older person | unspecified gender
🧓🏻	person: light skin tone	adult | gender-neutral | light skin tone | old | older person | older person: light skin tone | unspecified gender
🧓🏼	person: medium-light skin tone	adult | gender-neutral | medium-light skin tone | old | older person | older person: medium-light skin tone | unspecified gender
🧓🏽	person: medium skin tone	adult | gender-neutral | medium skin tone | old | older person | older person: medium skin tone | unspecified gender
🧓🏾	person: medium-dark skin tone	adult | gender-neutral | medium-dark skin tone | old | older person | older person: medium-dark skin tone | unspecified gender
🧓🏿	person: dark skin tone	adult | dark skin tone | gender-neutral | old | older person | older person: dark skin tone | unspecified gender
👴	man	adult | man | old
👴🏻	man: light skin tone	adult | light skin tone | man | old | old man: light skin tone
👴🏼	man: medium-light skin tone	adult | man | medium-light skin tone | old | old man: medium-light skin tone
👴🏽	man: medium skin tone	adult | man | medium skin tone | old | old man: medium skin tone
👴🏾	man: medium-dark skin tone	adult | man | medium-dark skin tone | old | old man: medium-dark skin tone
👴🏿	man: dark skin tone	adult | dark skin tone | man | old | old man: dark skin tone
👵	woman	adult | old | woman
👵🏻	woman: light skin tone	adult | light skin tone | old | old woman: light skin tone | woman
👵🏼	woman: medium-light skin tone	adult | medium-light skin tone | old | old woman: medium-light skin tone | woman
👵🏽	woman: medium skin tone	adult | medium skin tone | old | old woman: medium skin tone | woman
👵🏾	woman: medium-dark skin tone	adult | medium-dark skin tone | old | old woman: medium-dark skin tone | woman
👵🏿	woman: dark skin tone	adult | dark skin tone | old | old woman: dark skin tone | woman
🙍	frowning	frown | gesture | person frowning
🙍🏻	frowning: light skin tone	frown | gesture | light skin tone | person frowning | person frowning: light skin tone
🙍🏼	frowning: medium-light skin tone	frown | gesture | medium-light skin tone | person frowning | person frowning: medium-light skin tone
🙍🏽	frowning: medium skin tone	frown | gesture | medium skin tone | person frowning | person frowning: medium skin tone
🙍🏾	frowning: medium-dark skin tone	frown | gesture | medium-dark skin tone | person frowning | person frowning: medium-dark skin tone
🙍🏿	frowning: dark skin tone	dark skin tone | frown | gesture | person frowning | person frowning: dark skin tone
🙍‍♂️	frowning	
🙍‍♂	frowning	frowning | gesture | man
🙍🏻‍♂️	frowning: light skin tone	
🙍🏻‍♂	frowning: light skin tone	frowning | gesture | light skin tone | man | man frowning: light skin tone
🙍🏼‍♂️	frowning: medium-light skin tone	
🙍🏼‍♂	frowning: medium-light skin tone	frowning | gesture | man | man frowning: medium-light skin tone | medium-light skin tone
🙍🏽‍♂️	frowning: medium skin tone	
🙍🏽‍♂	frowning: medium skin tone	frowning | gesture | man | man frowning: medium skin tone | medium skin tone
🙍🏾‍♂️	frowning: medium-dark skin tone	
🙍🏾‍♂	frowning: medium-dark skin tone	frowning | gesture | man | man frowning: medium-dark skin tone | medium-dark skin tone
🙍🏿‍♂️	frowning: dark skin tone	
🙍🏿‍♂	frowning: dark skin tone	dark skin tone | frowning | gesture | man | man frowning: dark skin tone
🙍‍♀️	frowning	
🙍‍♀	frowning	frowning | gesture | woman
🙍🏻‍♀️	frowning: light skin tone	
🙍🏻‍♀	frowning: light skin tone	frowning | gesture | light skin tone | woman | woman frowning: light skin tone
🙍🏼‍♀️	frowning: medium-light skin tone	
🙍🏼‍♀	frowning: medium-light skin tone	frowning | gesture | medium-light skin tone | woman | woman frowning: medium-light skin tone
🙍🏽‍♀️	frowning: medium skin tone	
🙍🏽‍♀	frowning: medium skin tone	frowning | gesture | medium skin tone | woman | woman frowning: medium skin tone
🙍🏾‍♀️	frowning: medium-dark skin tone	
🙍🏾‍♀	frowning: medium-dark skin tone	frowning | gesture | medium-dark skin tone | woman | woman frowning: medium-dark skin tone
🙍🏿‍♀️	frowning: dark skin tone	
🙍🏿‍♀	frowning: dark skin tone	dark skin tone | frowning | gesture | woman | woman frowning: dark skin tone
🙎	pouting	gesture | person pouting | pouting | facial expression
🙎🏻	pouting: light skin tone	gesture | light skin tone | person pouting | person pouting: light skin tone | pouting | facial expression
🙎🏼	pouting: medium-light skin tone	gesture | medium-light skin tone | person pouting | person pouting: medium-light skin tone | pouting | facial expression
🙎🏽	pouting: medium skin tone	gesture | medium skin tone | person pouting | person pouting: medium skin tone | pouting | facial expression
🙎🏾	pouting: medium-dark skin tone	gesture | medium-dark skin tone | person pouting | person pouting: medium-dark skin tone | pouting | facial expression
🙎🏿	pouting: dark skin tone	dark skin tone | gesture | person pouting | person pouting: dark skin tone | pouting | facial expression
🙎‍♂️	pouting	
🙎‍♂	pouting	gesture | man | pouting
🙎🏻‍♂️	pouting: light skin tone	
🙎🏻‍♂	pouting: light skin tone	gesture | light skin tone | man | man pouting: light skin tone | pouting
🙎🏼‍♂️	pouting: medium-light skin tone	
🙎🏼‍♂	pouting: medium-light skin tone	gesture | man | man pouting: medium-light skin tone | medium-light skin tone | pouting
🙎🏽‍♂️	pouting: medium skin tone	
🙎🏽‍♂	pouting: medium skin tone	gesture | man | man pouting: medium skin tone | medium skin tone | pouting
🙎🏾‍♂️	pouting: medium-dark skin tone	
🙎🏾‍♂	pouting: medium-dark skin tone	gesture | man | man pouting: medium-dark skin tone | medium-dark skin tone | pouting
🙎🏿‍♂️	pouting: dark skin tone	
🙎🏿‍♂	pouting: dark skin tone	dark skin tone | gesture | man | man pouting: dark skin tone | pouting
🙎‍♀️	pouting	
🙎‍♀	pouting	gesture | pouting | woman
🙎🏻‍♀️	pouting: light skin tone	
🙎🏻‍♀	pouting: light skin tone	gesture | light skin tone | pouting | woman | woman pouting: light skin tone
🙎🏼‍♀️	pouting: medium-light skin tone	
🙎🏼‍♀	pouting: medium-light skin tone	gesture | medium-light skin tone | pouting | woman | woman pouting: medium-light skin tone
🙎🏽‍♀️	pouting: medium skin tone	
🙎🏽‍♀	pouting: medium skin tone	gesture | medium skin tone | pouting | woman | woman pouting: medium skin tone
🙎🏾‍♀️	pouting: medium-dark skin tone	
🙎🏾‍♀	pouting: medium-dark skin tone	gesture | medium-dark skin tone | pouting | woman | woman pouting: medium-dark skin tone
🙎🏿‍♀️	pouting: dark skin tone	
🙎🏿‍♀	pouting: dark skin tone	dark skin tone | gesture | pouting | woman | woman pouting: dark skin tone
🙅	gesturing NO	forbidden | gesture | hand | person gesturing NO | prohibited
🙅🏻	gesturing NO: light skin tone	forbidden | gesture | hand | light skin tone | person gesturing NO | person gesturing NO: light skin tone | prohibited
🙅🏼	gesturing NO: medium-light skin tone	forbidden | gesture | hand | medium-light skin tone | person gesturing NO | person gesturing NO: medium-light skin tone | prohibited
🙅🏽	gesturing NO: medium skin tone	forbidden | gesture | hand | medium skin tone | person gesturing NO | person gesturing NO: medium skin tone | prohibited
🙅🏾	gesturing NO: medium-dark skin tone	forbidden | gesture | hand | medium-dark skin tone | person gesturing NO | person gesturing NO: medium-dark skin tone | prohibited
🙅🏿	gesturing NO: dark skin tone	dark skin tone | forbidden | gesture | hand | person gesturing NO | person gesturing NO: dark skin tone | prohibited
🙅‍♂️	gesturing NO	
🙅‍♂	gesturing NO	forbidden | gesture | hand | man | man gesturing NO | prohibited
🙅🏻‍♂️	gesturing NO: light skin tone	
🙅🏻‍♂	gesturing NO: light skin tone	forbidden | gesture | hand | light skin tone | man | man gesturing NO | man gesturing NO: light skin tone | prohibited
🙅🏼‍♂️	gesturing NO: medium-light skin tone	
🙅🏼‍♂	gesturing NO: medium-light skin tone	forbidden | gesture | hand | man | man gesturing NO | man gesturing NO: medium-light skin tone | medium-light skin tone | prohibited
🙅🏽‍♂️	gesturing NO: medium skin tone	
🙅🏽‍♂	gesturing NO: medium skin tone	forbidden | gesture | hand | man | man gesturing NO | man gesturing NO: medium skin tone | medium skin tone | prohibited
🙅🏾‍♂️	gesturing NO: medium-dark skin tone	
🙅🏾‍♂	gesturing NO: medium-dark skin tone	forbidden | gesture | hand | man | man gesturing NO | man gesturing NO: medium-dark skin tone | medium-dark skin tone | prohibited
🙅🏿‍♂️	gesturing NO: dark skin tone	
🙅🏿‍♂	gesturing NO: dark skin tone	dark skin tone | forbidden | gesture | hand | man | man gesturing NO | man gesturing NO: dark skin tone | prohibited
🙅‍♀️	gesturing NO	
🙅‍♀	gesturing NO	forbidden | gesture | hand | prohibited | woman | woman gesturing NO
🙅🏻‍♀️	gesturing NO: light skin tone	
🙅🏻‍♀	gesturing NO: light skin tone	forbidden | gesture | hand | light skin tone | prohibited | woman | woman gesturing NO | woman gesturing NO: light skin tone
🙅🏼‍♀️	gesturing NO: medium-light skin tone	
🙅🏼‍♀	gesturing NO: medium-light skin tone	forbidden | gesture | hand | medium-light skin tone | prohibited | woman | woman gesturing NO | woman gesturing NO: medium-light skin tone
🙅🏽‍♀️	gesturing NO: medium skin tone	
🙅🏽‍♀	gesturing NO: medium skin tone	forbidden | gesture | hand | medium skin tone | prohibited | woman | woman gesturing NO | woman gesturing NO: medium skin tone
🙅🏾‍♀️	gesturing NO: medium-dark skin tone	
🙅🏾‍♀	gesturing NO: medium-dark skin tone	forbidden | gesture | hand | medium-dark skin tone | prohibited | woman | woman gesturing NO | woman gesturing NO: medium-dark skin tone
🙅🏿‍♀️	gesturing NO: dark skin tone	
🙅🏿‍♀	gesturing NO: dark skin tone	dark skin tone | forbidden | gesture | hand | prohibited | woman | woman gesturing NO | woman gesturing NO: dark skin tone
🙆	gesturing OK	gesture | hand | OK | person gesturing OK
🙆🏻	gesturing OK: light skin tone	gesture | hand | light skin tone | OK | person gesturing OK | person gesturing OK: light skin tone
🙆🏼	gesturing OK: medium-light skin tone	gesture | hand | medium-light skin tone | OK | person gesturing OK | person gesturing OK: medium-light skin tone
🙆🏽	gesturing OK: medium skin tone	gesture | hand | medium skin tone | OK | person gesturing OK | person gesturing OK: medium skin tone
🙆🏾	gesturing OK: medium-dark skin tone	gesture | hand | medium-dark skin tone | OK | person gesturing OK | person gesturing OK: medium-dark skin tone
🙆🏿	gesturing OK: dark skin tone	dark skin tone | gesture | hand | OK | person gesturing OK | person gesturing OK: dark skin tone
🙆‍♂️	gesturing OK	
🙆‍♂	gesturing OK	gesture | hand | man | man gesturing OK | OK
🙆🏻‍♂️	gesturing OK: light skin tone	
🙆🏻‍♂	gesturing OK: light skin tone	gesture | hand | light skin tone | man | man gesturing OK | man gesturing OK: light skin tone | OK
🙆🏼‍♂️	gesturing OK: medium-light skin tone	
🙆🏼‍♂	gesturing OK: medium-light skin tone	gesture | hand | man | man gesturing OK | man gesturing OK: medium-light skin tone | medium-light skin tone | OK
🙆🏽‍♂️	gesturing OK: medium skin tone	
🙆🏽‍♂	gesturing OK: medium skin tone	gesture | hand | man | man gesturing OK | man gesturing OK: medium skin tone | medium skin tone | OK
🙆🏾‍♂️	gesturing OK: medium-dark skin tone	
🙆🏾‍♂	gesturing OK: medium-dark skin tone	gesture | hand | man | man gesturing OK | man gesturing OK: medium-dark skin tone | medium-dark skin tone | OK
🙆🏿‍♂️	gesturing OK: dark skin tone	
🙆🏿‍♂	gesturing OK: dark skin tone	dark skin tone | gesture | hand | man | man gesturing OK | man gesturing OK: dark skin tone | OK
🙆‍♀️	gesturing OK	
🙆‍♀	gesturing OK	gesture | hand | OK | woman | woman gesturing OK
🙆🏻‍♀️	gesturing OK: light skin tone	
🙆🏻‍♀	gesturing OK: light skin tone	gesture | hand | light skin tone | OK | woman | woman gesturing OK | woman gesturing OK: light skin tone
🙆🏼‍♀️	gesturing OK: medium-light skin tone	
🙆🏼‍♀	gesturing OK: medium-light skin tone	gesture | hand | medium-light skin tone | OK | woman | woman gesturing OK | woman gesturing OK: medium-light skin tone
🙆🏽‍♀️	gesturing OK: medium skin tone	
🙆🏽‍♀	gesturing OK: medium skin tone	gesture | hand | medium skin tone | OK | woman | woman gesturing OK | woman gesturing OK: medium skin tone
🙆🏾‍♀️	gesturing OK: medium-dark skin tone	
🙆🏾‍♀	gesturing OK: medium-dark skin tone	gesture | hand | medium-dark skin tone | OK | woman | woman gesturing OK | woman gesturing OK: medium-dark skin tone
🙆🏿‍♀️	gesturing OK: dark skin tone	
🙆🏿‍♀	gesturing OK: dark skin tone	dark skin tone | gesture | hand | OK | woman | woman gesturing OK | woman gesturing OK: dark skin tone
💁	tipping hand	hand | help | information | person tipping hand | sassy | tipping
💁🏻	tipping hand: light skin tone	hand | help | information | light skin tone | person tipping hand | person tipping hand: light skin tone | sassy | tipping
💁🏼	tipping hand: medium-light skin tone	hand | help | information | medium-light skin tone | person tipping hand | person tipping hand: medium-light skin tone | sassy | tipping
💁🏽	tipping hand: medium skin tone	hand | help | information | medium skin tone | person tipping hand | person tipping hand: medium skin tone | sassy | tipping
💁🏾	tipping hand: medium-dark skin tone	hand | help | information | medium-dark skin tone | person tipping hand | person tipping hand: medium-dark skin tone | sassy | tipping
💁🏿	tipping hand: dark skin tone	dark skin tone | hand | help | information | person tipping hand | person tipping hand: dark skin tone | sassy | tipping
💁‍♂️	tipping hand	
💁‍♂	tipping hand	man | man tipping hand | sassy | tipping hand
💁🏻‍♂️	tipping hand: light skin tone	
💁🏻‍♂	tipping hand: light skin tone	light skin tone | man | man tipping hand | man tipping hand: light skin tone | sassy | tipping hand
💁🏼‍♂️	tipping hand: medium-light skin tone	
💁🏼‍♂	tipping hand: medium-light skin tone	man | man tipping hand | man tipping hand: medium-light skin tone | medium-light skin tone | sassy | tipping hand
💁🏽‍♂️	tipping hand: medium skin tone	
💁🏽‍♂	tipping hand: medium skin tone	man | man tipping hand | man tipping hand: medium skin tone | medium skin tone | sassy | tipping hand
💁🏾‍♂️	tipping hand: medium-dark skin tone	
💁🏾‍♂	tipping hand: medium-dark skin tone	man | man tipping hand | man tipping hand: medium-dark skin tone | medium-dark skin tone | sassy | tipping hand
💁🏿‍♂️	tipping hand:— dark skin tone	
💁🏿‍♂	tipping hand: dark skin tone	dark skin tone | man | man tipping hand | man tipping hand: dark skin tone | sassy | tipping hand
💁‍♀️	tipping hand	
💁‍♀	tipping hand	sassy | tipping hand | woman | woman tipping hand
💁🏻‍♀️	tipping hand: light skin tone	
💁🏻‍♀	tipping hand: light skin tone	light skin tone | sassy | tipping hand | woman | woman tipping hand | woman tipping hand: light skin tone
💁🏼‍♀️	tipping hand: medium-light skin tone	
💁🏼‍♀	tipping hand: medium-light skin tone	medium-light skin tone | sassy | tipping hand | woman | woman tipping hand | woman tipping hand: medium-light skin tone
💁🏽‍♀️	tipping hand: medium skin tone	
💁🏽‍♀	tipping hand: medium skin tone	medium skin tone | sassy | tipping hand | woman | woman tipping hand | woman tipping hand: medium skin tone
💁🏾‍♀️	tipping hand: medium-dark skin tone	
💁🏾‍♀	tipping hand: medium-dark skin tone	medium-dark skin tone | sassy | tipping hand | woman | woman tipping hand | woman tipping hand: medium-dark skin tone
💁🏿‍♀️	tipping hand: dark skin tone	
💁🏿‍♀	tipping hand: dark skin tone	dark skin tone | sassy | tipping hand | woman | woman tipping hand | woman tipping hand: dark skin tone
🙋	raising hand	gesture | hand | happy | person raising hand | raised
🙋🏻	raising hand: light skin tone	gesture | hand | happy | light skin tone | person raising hand | person raising hand: light skin tone | raised
🙋🏼	raising hand: medium-light skin tone	gesture | hand | happy | medium-light skin tone | person raising hand | person raising hand: medium-light skin tone | raised
🙋🏽	raising hand: medium skin tone	gesture | hand | happy | medium skin tone | person raising hand | person raising hand: medium skin tone | raised
🙋🏾	raising hand: medium-dark skin tone	gesture | hand | happy | medium-dark skin tone | person raising hand | person raising hand: medium-dark skin tone | raised
🙋🏿	raising hand: dark skin tone	dark skin tone | gesture | hand | happy | person raising hand | person raising hand: dark skin tone | raised
🙋‍♂️	raising hand	
🙋‍♂	raising hand	gesture | man | man raising hand | raising hand
🙋🏻‍♂️	raising hand: light skin tone	
🙋🏻‍♂	raising hand: light skin tone	gesture | light skin tone | man | man raising hand | man raising hand: light skin tone | raising hand
🙋🏼‍♂️	raising hand: medium-light skin tone	
🙋🏼‍♂	raising hand: medium-light skin tone	gesture | man | man raising hand | man raising hand: medium-light skin tone | medium-light skin tone | raising hand
🙋🏽‍♂️	raising hand: medium skin tone	
🙋🏽‍♂	raising hand: medium skin tone	gesture | man | man raising hand | man raising hand: medium skin tone | medium skin tone | raising hand
🙋🏾‍♂️	raising hand: medium-dark skin tone	
🙋🏾‍♂	raising hand: medium-dark skin tone	gesture | man | man raising hand | man raising hand: medium-dark skin tone | medium-dark skin tone | raising hand
🙋🏿‍♂️	raising hand: dark skin tone	
🙋🏿‍♂	raising hand: dark skin tone	dark skin tone | gesture | man | man raising hand | man raising hand: dark skin tone | raising hand
🙋‍♀️	raising hand	
🙋‍♀	raising hand	gesture | raising hand | woman | woman raising hand
🙋🏻‍♀️	raising hand: light skin tone	
🙋🏻‍♀	raising hand: light skin tone	gesture | light skin tone | raising hand | woman | woman raising hand | woman raising hand: light skin tone
🙋🏼‍♀️	raising hand: medium-light skin tone	
🙋🏼‍♀	raising hand: medium-light skin tone	gesture | medium-light skin tone | raising hand | woman | woman raising hand | woman raising hand: medium-light skin tone
🙋🏽‍♀️	raising hand: medium skin tone	
🙋🏽‍♀	raising hand: medium skin tone	gesture | medium skin tone | raising hand | woman | woman raising hand | woman raising hand: medium skin tone
🙋🏾‍♀️	raising hand: medium-dark skin tone	
🙋🏾‍♀	raising hand: medium-dark skin tone	gesture | medium-dark skin tone | raising hand | woman | woman raising hand | woman raising hand: medium-dark skin tone
🙋🏿‍♀️	raising hand: dark skin tone	
🙋🏿‍♀	raising hand: dark skin tone	dark skin tone | gesture | raising hand | woman | woman raising hand | woman raising hand: dark skin tone
🧏	person	accessibility | deaf | deaf person | ear | hear | hard of hearing | hearing impaired
🧏🏻	person: light skin tone	accessibility | deaf | deaf person | deaf person: light skin tone | ear | hear | light skin tone | hard of hearing | hearing impaired
🧏🏼	person: medium-light skin tone	accessibility | deaf | deaf person | deaf person: medium-light skin tone | ear | hear | medium-light skin tone | hard of hearing | hearing impaired
🧏🏽	person: medium skin tone	accessibility | deaf | deaf person | deaf person: medium skin tone | ear | hear | medium skin tone | hard of hearing | hearing impaired
🧏🏾	person: medium-dark skin tone	accessibility | deaf | deaf person | deaf person: medium-dark skin tone | ear | hear | medium-dark skin tone | hard of hearing | hearing impaired
🧏🏿	person: dark skin tone	accessibility | dark skin tone | deaf | deaf person | deaf person: dark skin tone | ear | hear | hard of hearing | hearing impaired
🧏‍♂️	man	
🧏‍♂	man	deaf | man
🧏🏻‍♂️	man: light skin tone	
🧏🏻‍♂	man: light skin tone	deaf | deaf man: light skin tone | light skin tone | man
🧏🏼‍♂️	man: medium-light skin tone	
🧏🏼‍♂	man: medium-light skin tone	deaf | deaf man: medium-light skin tone | man | medium-light skin tone
🧏🏽‍♂️	man: medium skin tone	
🧏🏽‍♂	man: medium skin tone	deaf | deaf man: medium skin tone | man | medium skin tone
🧏🏾‍♂️	man: medium-dark skin tone	
🧏🏾‍♂	man: medium-dark skin tone	deaf | deaf man: medium-dark skin tone | man | medium-dark skin tone
🧏🏿‍♂️	man: dark skin tone	
🧏🏿‍♂	man: dark skin tone	dark skin tone | deaf | deaf man: dark skin tone | man
🧏‍♀️	woman	
🧏‍♀	woman	deaf | woman
🧏🏻‍♀️	woman: light skin tone	
🧏🏻‍♀	woman: light skin tone	deaf | deaf woman: light skin tone | light skin tone | woman
🧏🏼‍♀️	woman: medium-light skin tone	
🧏🏼‍♀	woman: medium-light skin tone	deaf | deaf woman: medium-light skin tone | medium-light skin tone | woman
🧏🏽‍♀️	woman: medium skin tone	
🧏🏽‍♀	woman: medium skin tone	deaf | deaf woman: medium skin tone | medium skin tone | woman
🧏🏾‍♀️	woman: medium-dark skin tone	
🧏🏾‍♀	woman: medium-dark skin tone	deaf | deaf woman: medium-dark skin tone | medium-dark skin tone | woman
🧏🏿‍♀️	woman: dark skin tone	
🧏🏿‍♀	woman: dark skin tone	dark skin tone | deaf | deaf woman: dark skin tone | woman
🙇	bowing	apology | bow | gesture | person bowing | sorry
🙇🏻	bowing: light skin tone	apology | bow | gesture | light skin tone | person bowing | person bowing: light skin tone | sorry
🙇🏼	bowing: medium-light skin tone	apology | bow | gesture | medium-light skin tone | person bowing | person bowing: medium-light skin tone | sorry
🙇🏽	bowing: medium skin tone	apology | bow | gesture | medium skin tone | person bowing | person bowing: medium skin tone | sorry
🙇🏾	bowing: medium-dark skin tone	apology | bow | gesture | medium-dark skin tone | person bowing | person bowing: medium-dark skin tone | sorry
🙇🏿	bowing: dark skin tone	apology | bow | dark skin tone | gesture | person bowing | person bowing: dark skin tone | sorry
🙇‍♂️	bowing	
🙇‍♂	bowing	apology | bowing | favor | gesture | man | sorry | favour
🙇🏻‍♂️	bowing: light skin tone	
🙇🏻‍♂	bowing: light skin tone	apology | bowing | favor | gesture | light skin tone | man | man bowing: light skin tone | sorry | favour
🙇🏼‍♂️	bowing: medium-light skin tone	
🙇🏼‍♂	bowing: medium-light skin tone	apology | bowing | favor | gesture | man | man bowing: medium-light skin tone | medium-light skin tone | sorry | favour
🙇🏽‍♂️	bowing: medium skin tone	
🙇🏽‍♂	bowing: medium skin tone	apology | bowing | favor | gesture | man | man bowing: medium skin tone | medium skin tone | sorry | favour
🙇🏾‍♂️	bowing: medium-dark skin tone	
🙇🏾‍♂	bowing: medium-dark skin tone	apology | bowing | favor | gesture | man | man bowing: medium-dark skin tone | medium-dark skin tone | sorry | favour
🙇🏿‍♂️	bowing: dark skin tone	
🙇🏿‍♂	bowing: dark skin tone	apology | bowing | dark skin tone | favor | gesture | man | man bowing: dark skin tone | sorry | favour
🙇‍♀️	bowing	
🙇‍♀	bowing	apology | bowing | favor | gesture | sorry | woman | favour
🙇🏻‍♀️	bowing: light skin tone	
🙇🏻‍♀	bowing: light skin tone	apology | bowing | favor | gesture | light skin tone | sorry | woman | woman bowing: light skin tone | favour
🙇🏼‍♀️	bowing: medium-light skin tone	
🙇🏼‍♀	bowing: medium-light skin tone	apology | bowing | favor | gesture | medium-light skin tone | sorry | woman | woman bowing: medium-light skin tone | favour
🙇🏽‍♀️	bowing: medium skin tone	
🙇🏽‍♀	bowing: medium skin tone	apology | bowing | favor | gesture | medium skin tone | sorry | woman | woman bowing: medium skin tone | favour
🙇🏾‍♀️	bowing: medium-dark skin tone	
🙇🏾‍♀	bowing: medium-dark skin tone	apology | bowing | favor | gesture | medium-dark skin tone | sorry | woman | woman bowing: medium-dark skin tone | favour
🙇🏿‍♀️	bowing: dark skin tone	
🙇🏿‍♀	bowing: dark skin tone	apology | bowing | dark skin tone | favor | gesture | sorry | woman | woman bowing: dark skin tone | favour
🤦	facepalming	disbelief | exasperation | face | palm | person facepalming
🤦🏻	facepalming: light skin tone	disbelief | exasperation | face | light skin tone | palm | person facepalming | person facepalming: light skin tone
🤦🏼	facepalming: medium-light skin tone	disbelief | exasperation | face | medium-light skin tone | palm | person facepalming | person facepalming: medium-light skin tone
🤦🏽	facepalming: medium skin tone	disbelief | exasperation | face | medium skin tone | palm | person facepalming | person facepalming: medium skin tone
🤦🏾	facepalming: medium-dark skin tone	disbelief | exasperation | face | medium-dark skin tone | palm | person facepalming | person facepalming: medium-dark skin tone
🤦🏿	facepalming: dark skin tone	dark skin tone | disbelief | exasperation | face | palm | person facepalming | person facepalming: dark skin tone
🤦‍♂️	facepalming	
🤦‍♂	facepalming	disbelief | exasperation | facepalm | man | man facepalming
🤦🏻‍♂️	facepalming: light skin tone	
🤦🏻‍♂	facepalming: light skin tone	disbelief | exasperation | facepalm | light skin tone | man | man facepalming | man facepalming: light skin tone
🤦🏼‍♂️	facepalming: medium-light skin tone	
🤦🏼‍♂	facepalming: medium-light skin tone	disbelief | exasperation | facepalm | man | man facepalming | man facepalming: medium-light skin tone | medium-light skin tone
🤦🏽‍♂️	facepalming: medium skin tone	
🤦🏽‍♂	facepalming: medium skin tone	disbelief | exasperation | facepalm | man | man facepalming | man facepalming: medium skin tone | medium skin tone
🤦🏾‍♂️	facepalming: medium-dark skin tone	
🤦🏾‍♂	facepalming: medium-dark skin tone	disbelief | exasperation | facepalm | man | man facepalming | man facepalming: medium-dark skin tone | medium-dark skin tone
🤦🏿‍♂️	facepalming: dark skin tone	
🤦🏿‍♂	facepalming: dark skin tone	dark skin tone | disbelief | exasperation | facepalm | man | man facepalming | man facepalming: dark skin tone
🤦‍♀️	facepalming	
🤦‍♀	facepalming	disbelief | exasperation | facepalm | woman | woman facepalming
🤦🏻‍♀️	facepalming: light skin tone	
🤦🏻‍♀	facepalming: light skin tone	disbelief | exasperation | facepalm | light skin tone | woman | woman facepalming | woman facepalming: light skin tone
🤦🏼‍♀️	facepalming: medium-light skin tone	
🤦🏼‍♀	facepalming: medium-light skin tone	disbelief | exasperation | facepalm | medium-light skin tone | woman | woman facepalming | woman facepalming: medium-light skin tone
🤦🏽‍♀️	facepalming: medium skin tone	
🤦🏽‍♀	facepalming: medium skin tone	disbelief | exasperation | facepalm | medium skin tone | woman | woman facepalming | woman facepalming: medium skin tone
🤦🏾‍♀️	facepalming: medium-dark skin tone	
🤦🏾‍♀	facepalming: medium-dark skin tone	disbelief | exasperation | facepalm | medium-dark skin tone | woman | woman facepalming | woman facepalming: medium-dark skin tone
🤦🏿‍♀️	facepalming: dark skin tone	
🤦🏿‍♀	facepalming: dark skin tone	dark skin tone | disbelief | exasperation | facepalm | woman | woman facepalming | woman facepalming: dark skin tone
🤷	shrugging	doubt | ignorance | indifference | person shrugging | shrug
🤷🏻	shrugging: light skin tone	doubt | ignorance | indifference | light skin tone | person shrugging | person shrugging: light skin tone | shrug
🤷🏼	shrugging: medium-light skin tone	doubt | ignorance | indifference | medium-light skin tone | person shrugging | person shrugging: medium-light skin tone | shrug
🤷🏽	shrugging: medium skin tone	doubt | ignorance | indifference | medium skin tone | person shrugging | person shrugging: medium skin tone | shrug
🤷🏾	shrugging: medium-dark skin tone	doubt | ignorance | indifference | medium-dark skin tone | person shrugging | person shrugging: medium-dark skin tone | shrug
🤷🏿	shrugging: dark skin tone	dark skin tone | doubt | ignorance | indifference | person shrugging | person shrugging: dark skin tone | shrug
🤷‍♂️	shrugging	
🤷‍♂	shrugging	doubt | ignorance | indifference | man | man shrugging | shrug
🤷🏻‍♂️	shrugging: light skin tone	
🤷🏻‍♂	shrugging: light skin tone	doubt | ignorance | indifference | light skin tone | man | man shrugging | man shrugging: light skin tone | shrug
🤷🏼‍♂️	shrugging: medium-light skin tone	
🤷🏼‍♂	shrugging: medium-light skin tone	doubt | ignorance | indifference | man | man shrugging | man shrugging: medium-light skin tone | medium-light skin tone | shrug
🤷🏽‍♂️	shrugging: medium skin tone	
🤷🏽‍♂	shrugging: medium skin tone	doubt | ignorance | indifference | man | man shrugging | man shrugging: medium skin tone | medium skin tone | shrug
🤷🏾‍♂️	shrugging: medium-dark skin tone	
🤷🏾‍♂	shrugging: medium-dark skin tone	doubt | ignorance | indifference | man | man shrugging | man shrugging: medium-dark skin tone | medium-dark skin tone | shrug
🤷🏿‍♂️	shrugging: dark skin tone	
🤷🏿‍♂	shrugging: dark skin tone	dark skin tone | doubt | ignorance | indifference | man | man shrugging | man shrugging: dark skin tone | shrug
🤷‍♀️	shrugging	
🤷‍♀	shrugging	doubt | ignorance | indifference | shrug | woman | woman shrugging
🤷🏻‍♀️	shrugging: light skin tone	
🤷🏻‍♀	shrugging: light skin tone	doubt | ignorance | indifference | light skin tone | shrug | woman | woman shrugging | woman shrugging: light skin tone
🤷🏼‍♀️	shrugging: medium-light skin tone	
🤷🏼‍♀	shrugging: medium-light skin tone	doubt | ignorance | indifference | medium-light skin tone | shrug | woman | woman shrugging | woman shrugging: medium-light skin tone
🤷🏽‍♀️	shrugging: medium skin tone	
🤷🏽‍♀	shrugging: medium skin tone	doubt | ignorance | indifference | medium skin tone | shrug | woman | woman shrugging | woman shrugging: medium skin tone
🤷🏾‍♀️	shrugging: medium-dark skin tone	
🤷🏾‍♀	shrugging: medium-dark skin tone	doubt | ignorance | indifference | medium-dark skin tone | shrug | woman | woman shrugging | woman shrugging: medium-dark skin tone
🤷🏿‍♀️	shrugging: dark skin tone	
🤷🏿‍♀	shrugging: dark skin tone	dark skin tone | doubt | ignorance | indifference | shrug | woman | woman shrugging | woman shrugging: dark skin tone
🧑‍⚕️	worker	
🧑‍⚕	worker	doctor | health worker | healthcare | nurse | therapist | health care
🧑🏻‍⚕️	worker: light skin tone	
🧑🏻‍⚕	worker: light skin tone	doctor | health worker | health worker: light skin tone | healthcare | light skin tone | nurse | therapist | health care
🧑🏼‍⚕️	worker: medium-light skin tone	
🧑🏼‍⚕	worker: medium-light skin tone	doctor | health worker | health worker: medium-light skin tone | healthcare | medium-light skin tone | nurse | therapist | health care
🧑🏽‍⚕️	worker: medium skin tone	
🧑🏽‍⚕	worker: medium skin tone	doctor | health worker | health worker: medium skin tone | healthcare | medium skin tone | nurse | therapist | health care
🧑🏾‍⚕️	worker: medium-dark skin tone	
🧑🏾‍⚕	worker: medium-dark skin tone	doctor | health worker | health worker: medium-dark skin tone | healthcare | medium-dark skin tone | nurse | therapist | health care
🧑🏿‍⚕️	worker: dark skin tone	
🧑🏿‍⚕	worker: dark skin tone	dark skin tone | doctor | health worker | health worker: dark skin tone | healthcare | nurse | therapist | health care
👨‍⚕️	health worker	
👨‍⚕	health worker	doctor | healthcare | man | man health worker | nurse | therapist | health care
👨🏻‍⚕️	health worker: light skin tone	
👨🏻‍⚕	health worker: light skin tone	doctor | healthcare | light skin tone | man | man health worker | man health worker: light skin tone | nurse | therapist | health care
👨🏼‍⚕️	health worker: medium-light skin tone	
👨🏼‍⚕	health worker: medium-light skin tone	doctor | healthcare | man | man health worker | man health worker: medium-light skin tone | medium-light skin tone | nurse | therapist | health care
👨🏽‍⚕️	health worker: medium skin tone	
👨🏽‍⚕	health worker: medium skin tone	doctor | healthcare | man | man health worker | man health worker: medium skin tone | medium skin tone | nurse | therapist | health care
👨🏾‍⚕️	health worker: medium-dark skin tone	
👨🏾‍⚕	health worker: medium-dark skin tone	doctor | healthcare | man | man health worker | man health worker: medium-dark skin tone | medium-dark skin tone | nurse | therapist | health care
👨🏿‍⚕️	health worker: dark skin tone	
👨🏿‍⚕	health worker: dark skin tone	dark skin tone | doctor | healthcare | man | man health worker | man health worker: dark skin tone | nurse | therapist | health care
👩‍⚕️	health worker	
👩‍⚕	health worker	doctor | healthcare | nurse | therapist | woman | woman health worker | health care
👩🏻‍⚕️	health worker: light skin tone	
👩🏻‍⚕	health worker: light skin tone	doctor | healthcare | light skin tone | nurse | therapist | woman | woman health worker | woman health worker: light skin tone | health care
👩🏼‍⚕️	health worker: medium-light skin tone	
👩🏼‍⚕	health worker: medium-light skin tone	doctor | healthcare | medium-light skin tone | nurse | therapist | woman | woman health worker | woman health worker: medium-light skin tone | health care
👩🏽‍⚕️	health worker: medium skin tone	
👩🏽‍⚕	health worker: medium skin tone	doctor | healthcare | medium skin tone | nurse | therapist | woman | woman health worker | woman health worker: medium skin tone | health care
👩🏾‍⚕️	health worker: medium-dark skin tone	
👩🏾‍⚕	health worker: medium-dark skin tone	doctor | healthcare | medium-dark skin tone | nurse | therapist | woman | woman health worker | woman health worker: medium-dark skin tone | health care
👩🏿‍⚕️	health worker: dark skin tone	
👩🏿‍⚕	health worker: dark skin tone	dark skin tone | doctor | healthcare | nurse | therapist | woman | woman health worker | woman health worker: dark skin tone | health care
🧑‍🎓		graduate | student
🧑🏻‍🎓	light skin tone	graduate | light skin tone | student | student: light skin tone
🧑🏼‍🎓	medium-light skin tone	graduate | medium-light skin tone | student | student: medium-light skin tone
🧑🏽‍🎓	medium skin tone	graduate | medium skin tone | student | student: medium skin tone
🧑🏾‍🎓	medium-dark skin tone	graduate | medium-dark skin tone | student | student: medium-dark skin tone
🧑🏿‍🎓	dark skin tone	dark skin tone | graduate | student | student: dark skin tone
👨‍🎓	student	graduate | man | student
👨🏻‍🎓	student: light skin tone	graduate | light skin tone | man | man student: light skin tone | student
👨🏼‍🎓	student: medium-light skin tone	graduate | man | man student: medium-light skin tone | medium-light skin tone | student
👨🏽‍🎓	student: medium skin tone	graduate | man | man student: medium skin tone | medium skin tone | student
👨🏾‍🎓	student: medium-dark skin tone	graduate | man | man student: medium-dark skin tone | medium-dark skin tone | student
👨🏿‍🎓	student: dark skin tone	dark skin tone | graduate | man | man student: dark skin tone | student
👩‍🎓	student	graduate | student | woman
👩🏻‍🎓	student: light skin tone	graduate | light skin tone | student | woman | woman student: light skin tone
👩🏼‍🎓	student: medium-light skin tone	graduate | medium-light skin tone | student | woman | woman student: medium-light skin tone
👩🏽‍🎓	student: medium skin tone	graduate | medium skin tone | student | woman | woman student: medium skin tone
👩🏾‍🎓	student: medium-dark skin tone	graduate | medium-dark skin tone | student | woman | woman student: medium-dark skin tone
👩🏿‍🎓	student: dark skin tone	dark skin tone | graduate | student | woman | woman student: dark skin tone
🧑‍🏫		instructor | lecturer | professor | teacher
🧑🏻‍🏫	light skin tone	instructor | lecturer | light skin tone | professor | teacher | teacher: light skin tone
🧑🏼‍🏫	medium-light skin tone	instructor | lecturer | medium-light skin tone | professor | teacher | teacher: medium-light skin tone
🧑🏽‍🏫	medium skin tone	instructor | lecturer | medium skin tone | professor | teacher | teacher: medium skin tone
🧑🏾‍🏫	medium-dark skin tone	instructor | lecturer | medium-dark skin tone | professor | teacher | teacher: medium-dark skin tone
🧑🏿‍🏫	dark skin tone	dark skin tone | instructor | lecturer | professor | teacher | teacher: dark skin tone
👨‍🏫	teacher	instructor | lecturer | man | professor | teacher
👨🏻‍🏫	teacher: light skin tone	instructor | lecturer | light skin tone | man | man teacher: light skin tone | professor | teacher
👨🏼‍🏫	teacher: medium-light skin tone	instructor | lecturer | man | man teacher: medium-light skin tone | medium-light skin tone | professor | teacher
👨🏽‍🏫	teacher: medium skin tone	instructor | lecturer | man | man teacher: medium skin tone | medium skin tone | professor | teacher
👨🏾‍🏫	teacher: medium-dark skin tone	instructor | lecturer | man | man teacher: medium-dark skin tone | medium-dark skin tone | professor | teacher
👨🏿‍🏫	teacher: dark skin tone	dark skin tone | instructor | lecturer | man | man teacher: dark skin tone | professor | teacher
👩‍🏫	teacher	instructor | lecturer | professor | teacher | woman
👩🏻‍🏫	teacher: light skin tone	instructor | lecturer | light skin tone | professor | teacher | woman | woman teacher: light skin tone
👩🏼‍🏫	teacher: medium-light skin tone	instructor | lecturer | medium-light skin tone | professor | teacher | woman | woman teacher: medium-light skin tone
👩🏽‍🏫	teacher: medium skin tone	instructor | lecturer | medium skin tone | professor | teacher | woman | woman teacher: medium skin tone
👩🏾‍🏫	teacher: medium-dark skin tone	instructor | lecturer | medium-dark skin tone | professor | teacher | woman | woman teacher: medium-dark skin tone
👩🏿‍🏫	teacher: dark skin tone	dark skin tone | instructor | lecturer | professor | teacher | woman | woman teacher: dark skin tone
🧑‍⚖	judge | justice | law | scales
🧑🏻‍⚖️	light skin t—one	
🧑🏻‍⚖	light skin tone	judge | judge: light skin tone | justice | law | light skin tone | scales
🧑🏼‍⚖️	medium-light skin tone	
🧑🏼‍⚖	medium-light skin tone	judge | judge: medium-light skin tone | justice | law | medium-light skin tone | scales
🧑🏽‍⚖️	medium skin tone	
🧑🏽‍⚖	medium skin tone	judge | judge: medium skin tone | justice | law | medium skin tone | scales
🧑🏾‍⚖️	medium-dark skin tone	
🧑🏾‍⚖	medium-dark skin tone	judge | judge: medium-dark skin tone | justice | law | medium-dark skin tone | scales
🧑🏿‍⚖️	dark skin tone	
🧑🏿‍⚖	dark skin tone	dark skin tone | judge | judge: dark skin tone | justice | law | scales
👨‍⚖️	judge	
👨‍⚖	judge	judge | justice | law | man | scales
👨🏻‍⚖️	judge: light skin tone	
👨🏻‍⚖	judge: light skin tone	judge | justice | law | light skin tone | man | man judge: light skin tone | scales
👨🏼‍⚖️	judge: medium-light skin tone	
👨🏼‍⚖	judge: medium-light skin tone	judge | justice | law | man | man judge: medium-light skin tone | medium-light skin tone | scales
👨🏽‍⚖️	judge: medium skin tone	
👨🏽‍⚖	judge: medium skin tone	judge | justice | law | man | man judge: medium skin tone | medium skin tone | scales
👨🏾‍⚖️	judge: medium-dark skin tone	
👨🏾‍⚖	judge: medium-dark skin tone	judge | justice | law | man | man judge: medium-dark skin tone | medium-dark skin tone | scales
👨🏿‍⚖️	judge: dark skin tone	
👨🏿‍⚖	judge: dark skin tone	dark skin tone | judge | justice | law | man | man judge: dark skin tone | scales
👩‍⚖️	judge	
👩‍⚖	judge	judge | justice | law | scales | woman
👩🏻‍⚖️	judge: light skin tone	
👩🏻‍⚖	judge: light skin tone	judge | justice | law | light skin tone | scales | woman | woman judge: light skin tone
👩🏼‍⚖️	judge: medium-light skin tone	
👩🏼‍⚖	judge: medium-light skin tone	judge | justice | law | medium-light skin tone | scales | woman | woman judge: medium-light skin tone
👩🏽‍⚖️	judge: medium skin tone	
👩🏽‍⚖	judge: medium skin tone	judge | justice | law | medium skin tone | scales | woman | woman judge: medium skin tone
👩🏾‍⚖️	judge: medium-dark skin tone	
👩🏾‍⚖	judge: medium-dark skin tone	judge | justice | law | medium-dark skin tone | scales | woman | woman judge: medium-dark skin tone
👩🏿‍⚖️	judge: dark skin tone	
👩🏿‍⚖	judge: dark skin tone	dark skin tone | judge | justice | law | scales | woman | woman judge: dark skin tone
🧑‍🌾	farmer | gardener | rancher
🧑🏻‍🌾	light skin tone	farmer | farmer: light skin tone | gardener | light skin tone | rancher
🧑🏼‍🌾	medium-light skin tone	farmer | farmer: medium-light skin tone | gardener | medium-light skin tone | rancher
🧑🏽‍🌾	medium skin tone	farmer | farmer: medium skin tone | gardener | medium skin tone | rancher
🧑🏾‍🌾	medium-dark skin tone	farmer | farmer: medium-dark skin tone | gardener | medium-dark skin tone | rancher
🧑🏿‍🌾	dark skin tone	dark skin tone | farmer | farmer: dark skin tone | gardener | rancher
👨‍🌾	farmer	farmer | gardener | man | rancher
👨🏻‍🌾	farmer: light skin tone	farmer | gardener | light skin tone | man | man farmer: light skin tone | rancher
👨🏼‍🌾	farmer: medium-light skin tone	farmer | gardener | man | man farmer: medium-light skin tone | medium-light skin tone | rancher
👨🏽‍🌾	farmer: medium skin tone	farmer | gardener | man | man farmer: medium skin tone | medium skin tone | rancher
👨🏾‍🌾	farmer: medium-dark skin tone	farmer | gardener | man | man farmer: medium-dark skin tone | medium-dark skin tone | rancher
👨🏿‍🌾	farmer: dark skin tone	dark skin tone | farmer | gardener | man | man farmer: dark skin tone | rancher
👩‍🌾	farmer	farmer | gardener | rancher | woman
👩🏻‍🌾	farmer: light skin tone	farmer | gardener | light skin tone | rancher | woman | woman farmer: light skin tone
👩🏼‍🌾	farmer: medium-light skin tone	farmer | gardener | medium-light skin tone | rancher | woman | woman farmer: medium-light skin tone
👩🏽‍🌾	farmer: medium skin tone	farmer | gardener | medium skin tone | rancher | woman | woman farmer: medium skin tone
👩🏾‍🌾	farmer: medium-dark skin tone	farmer | gardener | medium-dark skin tone | rancher | woman | woman farmer: medium-dark skin tone
👩🏿‍🌾	farmer: dark skin tone	dark skin tone | farmer | gardener | rancher | woman | woman farmer: dark skin tone
🧑‍🍳	chef | cook
🧑🏻‍🍳	light skin tone	chef | cook | cook: light skin tone | light skin tone
🧑🏼‍🍳	medium-light skin tone	chef | cook | cook: medium-light skin tone | medium-light skin tone
🧑🏽‍🍳	medium skin tone	chef | cook | cook: medium skin tone | medium skin tone
🧑🏾‍🍳	medium-dark skin tone	chef | cook | cook: medium-dark skin tone | medium-dark skin tone
🧑🏿‍🍳	dark skin tone	chef | cook | cook: dark skin tone | dark skin tone
👨‍🍳	cook	chef | cook | man
👨🏻‍🍳	cook: light skin tone	chef | cook | light skin tone | man | man cook: light skin tone
👨🏼‍🍳	cook: medium-light skin tone	chef | cook | man | man cook: medium-light skin tone | medium-light skin tone
👨🏽‍🍳	cook: medium skin tone	chef | cook | man | man cook: medium skin tone | medium skin tone
👨🏾‍🍳	cook: medium-dark skin tone	chef | cook | man | man cook: medium-dark skin tone | medium-dark skin tone
👨🏿‍🍳	cook: dark skin tone	chef | cook | dark skin tone | man | man cook: dark skin tone
👩‍🍳	cook	chef | cook | woman
👩🏻‍🍳	cook: light skin tone	chef | cook | light skin tone | woman | woman cook: light skin tone
👩🏼‍🍳	cook: medium-light skin tone	chef | cook | medium-light skin tone | woman | woman cook: medium-light skin tone
👩🏽‍🍳	cook: medium skin tone	chef | cook | medium skin tone | woman | woman cook: medium skin tone
👩🏾‍🍳	cook: medium-dark skin tone	chef | cook | medium-dark skin tone | woman | woman cook: medium-dark skin tone
👩🏿‍🍳	cook: dark skin tone	chef | cook | dark skin tone | woman | woman cook: dark skin tone
🧑‍🔧	electrician | mechanic | plumber | tradesperson | tradie
🧑🏻‍🔧	light skin tone	electrician | light skin tone | mechanic | mechanic: light skin tone | plumber | tradesperson | tradie
🧑🏼‍🔧	medium-light skin tone	electrician | mechanic | mechanic: medium-light skin tone | medium-light skin tone | plumber | tradesperson | tradie
🧑🏽‍🔧	medium skin tone	electrician | mechanic | mechanic: medium skin tone | medium skin tone | plumber | tradesperson | tradie
🧑🏾‍🔧	medium-dark skin tone	electrician | mechanic | mechanic: medium-dark skin tone | medium-dark skin tone | plumber | tradesperson | tradie
🧑🏿‍🔧	dark skin tone	dark skin tone | electrician | mechanic | mechanic: dark skin tone | plumber | tradesperson | tradie
👨‍🔧	mechanic	electrician | man | mechanic | plumber | tradesperson
👨🏻‍🔧	mechanic: light skin tone	electrician | light skin tone | man | man mechanic: light skin tone | mechanic | plumber | tradesperson
👨🏼‍🔧	mechanic: medium-light skin tone	electrician | man | man mechanic: medium-light skin tone | mechanic | medium-light skin tone | plumber | tradesperson
👨🏽‍🔧	mechanic: medium skin tone	electrician | man | man mechanic: medium skin tone | mechanic | medium skin tone | plumber | tradesperson
👨🏾‍🔧	mechanic: medium-dark skin tone	electrician | man | man mechanic: medium-dark skin tone | mechanic | medium-dark skin tone | plumber | tradesperson
👨🏿‍🔧	mechanic: dark skin tone	dark skin tone | electrician | man | man mechanic: dark skin tone | mechanic | plumber | tradesperson
👩‍🔧	mechanic	electrician | mechanic | plumber | tradesperson | woman
👩🏻‍🔧	mechanic: light skin tone	electrician | light skin tone | mechanic | plumber | tradesperson | woman | woman mechanic: light skin tone
👩🏼‍🔧	mechanic: medium-light skin tone	electrician | mechanic | medium-light skin tone | plumber | tradesperson | woman | woman mechanic: medium-light skin tone
👩🏽‍🔧	mechanic: medium skin tone	electrician | mechanic | medium skin tone | plumber | tradesperson | woman | woman mechanic: medium skin tone
👩🏾‍🔧	mechanic: medium-dark skin tone	electrician | mechanic | medium-dark skin tone | plumber | tradesperson | woman | woman mechanic: medium-dark skin tone
👩🏿‍🔧	mechanic: dark skin tone	dark skin tone | electrician | mechanic | plumber | tradesperson | woman | woman mechanic: dark skin tone
🧑‍🏭	worker	assembly | factory | industrial | worker
🧑🏻‍🏭	worker: light skin tone	assembly | factory | factory worker: light skin tone | industrial | light skin tone | worker
🧑🏼‍🏭	worker: medium-light skin tone	assembly | factory | factory worker: medium-light skin tone | industrial | medium-light skin tone | worker
🧑🏽‍🏭	worker: medium skin tone	assembly | factory | factory worker: medium skin tone | industrial | medium skin tone | worker
🧑🏾‍🏭	worker: medium-dark skin tone	assembly | factory | factory worker: medium-dark skin tone | industrial | medium-dark skin tone | worker
🧑🏿‍🏭	worker: dark skin tone	assembly | dark skin tone | factory | factory worker: dark skin tone | industrial | worker
👨‍🏭	factory worker	assembly | factory | industrial | man | worker
👨🏻‍🏭	factory worker: light skin tone	assembly | factory | industrial | light skin tone | man | man factory worker: light skin tone | worker
👨🏼‍🏭	factory worker: medium-light skin tone	assembly | factory | industrial | man | man factory worker: medium-light skin tone | medium-light skin tone | worker
👨🏽‍🏭	factory worker: medium skin tone	assembly | factory | industrial | man | man factory worker: medium skin tone | medium skin tone | worker
👨🏾‍🏭	factory worker: medium-dark skin tone	assembly | factory | industrial | man | man factory worker: medium-dark skin tone | medium-dark skin tone | worker
👨🏿‍🏭	factory worker: dark skin tone	assembly | dark skin tone | factory | industrial | man | man factory worker: dark skin tone | worker
👩‍🏭	factory worker	assembly | factory | industrial | woman | worker
👩🏻‍🏭	factory worker: light skin tone	assembly | factory | industrial | light skin tone | woman | woman factory worker: light skin tone | worker
👩🏼‍🏭	factory worker: medium-light skin tone	assembly | factory | industrial | medium-light skin tone | woman | woman factory worker: medium-light skin tone | worker
👩🏽‍🏭	factory worker: medium skin tone	assembly | factory | industrial | medium skin tone | woman | woman factory worker: medium skin tone | worker
👩🏾‍🏭	factory worker: medium-dark skin tone	assembly | factory | industrial | medium-dark skin tone | woman | woman factory worker: medium-dark skin tone | worker
👩🏿‍🏭	factory worker: dark skin tone	assembly | dark skin tone | factory | industrial | woman | woman factory worker: dark skin tone | worker
🧑‍💼	worker	architect | business | manager | office worker | white-collar
🧑🏻‍💼	worker: light skin tone	architect | business | light skin tone | manager | office worker | office worker: light skin tone | white-collar
🧑🏼‍💼	worker: medium-light skin tone	architect | business | manager | medium-light skin tone | office worker | office worker: medium-light skin tone | white-collar
🧑🏽‍💼	worker: medium skin tone	architect | business | manager | medium skin tone | office worker | office worker: medium skin tone | white-collar
🧑🏾‍💼	worker: medium-dark skin tone	architect | business | manager | medium-dark skin tone | office worker | office worker: medium-dark skin tone | white-collar
🧑🏿‍💼	worker: dark skin tone	architect | business | dark skin tone | manager | office worker | office worker: dark skin tone | white-collar
👨‍💼	office worker	architect | business | man | man office worker | manager | white-collar | business man | office worker | white collar
👨🏻‍💼	office worker: light skin tone	architect | business | light skin tone | man | man office worker | man office worker: light skin tone | manager | white-collar | business man | office worker | white collar
👨🏼‍💼	office worker: medium-light skin tone	architect | business | man | man office worker | man office worker: medium-light skin tone | manager | medium-light skin tone | white-collar | business man | office worker | white collar
👨🏽‍💼	office worker: medium skin tone	architect | business | man | man office worker | man office worker: medium skin tone | manager | medium skin tone | white-collar | business man | office worker | white collar
👨🏾‍💼	office worker: medium-dark skin tone	architect | business | man | man office worker | man office worker: medium-dark skin tone | manager | medium-dark skin tone | white-collar | business man | office worker | white collar
👨🏿‍💼	office worker: dark skin tone	architect | business | dark skin tone | man | man office worker | man office worker: dark skin tone | manager | white-collar | business man | office worker | white collar
👩‍💼	office worker	architect | business | manager | white-collar | woman | woman office worker | business woman | office worker | white collar
👩🏻‍💼	office worker: light skin tone	architect | business | light skin tone | manager | white-collar | woman | woman office worker | woman office worker: light skin tone | business woman | office worker | white collar
👩🏼‍💼	office worker: medium-light skin tone	architect | business | manager | medium-light skin tone | white-collar | woman | woman office worker | woman office worker: medium-light skin tone | business woman | office worker | white collar
👩🏽‍💼	office worker: medium skin tone	architect | business | manager | medium skin tone | white-collar | woman | woman office worker | woman office worker: medium skin tone | business woman | office worker | white collar
👩🏾‍💼	office worker: medium-dark skin tone	architect | business | manager | medium-dark skin tone | white-collar | woman | woman office worker | woman office worker: medium-dark skin tone | business woman | office worker | white collar
👩🏿‍💼	office worker: dark skin tone	architect | business | dark skin tone | manager | white-collar | woman | woman office worker | woman office worker: dark skin tone | business woman | office worker | white collar
🧑‍🔬	biologist | chemist | engineer | physicist | scientist
🧑🏻‍🔬	light skin tone	biologist | chemist | engineer | light skin tone | physicist | scientist | scientist: light skin tone
🧑🏼‍🔬	medium-light skin tone	biologist | chemist | engineer | medium-light skin tone | physicist | scientist | scientist: medium-light skin tone
🧑🏽‍🔬	medium skin tone	biologist | chemist | engineer | medium skin tone | physicist | scientist | scientist: medium skin tone
🧑🏾‍🔬	medium-dark skin tone	biologist | chemist | engineer | medium-dark skin tone | physicist | scientist | scientist: medium-dark skin tone
🧑🏿‍🔬	dark skin tone	biologist | chemist | dark skin tone | engineer | physicist | scientist | scientist: dark skin tone
👨‍🔬	scientist	biologist | chemist | engineer | man | physicist | scientist
👨🏻‍🔬	scientist: light skin tone	biologist | chemist | engineer | light skin tone | man | man scientist: light skin tone | physicist | scientist
👨🏼‍🔬	scientist: medium-light skin tone	biologist | chemist | engineer | man | man scientist: medium-light skin tone | medium-light skin tone | physicist | scientist
👨🏽‍🔬	scientist: medium skin tone	biologist | chemist | engineer | man | man scientist: medium skin tone | medium skin tone | physicist | scientist
👨🏾‍🔬	scientist: medium-dark skin tone	biologist | chemist | engineer | man | man scientist: medium-dark skin tone | medium-dark skin tone | physicist | scientist
👨🏿‍🔬	scientist: dark skin tone	biologist | chemist | dark skin tone | engineer | man | man scientist: dark skin tone | physicist | scientist
👩‍🔬	scientist	biologist | chemist | engineer | physicist | scientist | woman
👩🏻‍🔬	scientist: light skin tone	biologist | chemist | engineer | light skin tone | physicist | scientist | woman | woman scientist: light skin tone
👩🏼‍🔬	scientist: medium-light skin tone	biologist | chemist | engineer | medium-light skin tone | physicist | scientist | woman | woman scientist: medium-light skin tone
👩🏽‍🔬	scientist: medium skin tone	biologist | chemist | engineer | medium skin tone | physicist | scientist | woman | woman scientist: medium skin tone
👩🏾‍🔬	scientist: medium-dark skin tone	biologist | chemist | engineer | medium-dark skin tone | physicist | scientist | woman | woman scientist: medium-dark skin tone
👩🏿‍🔬	scientist: dark skin tone	biologist | chemist | dark skin tone | engineer | physicist | scientist | woman | woman scientist: dark skin tone
🧑‍💻	coder | developer | inventor | software | technologist
🧑🏻‍💻	light skin tone	coder | developer | inventor | light skin tone | software | technologist | technologist: light skin tone
🧑🏼‍💻	medium-light skin tone	coder | developer | inventor | medium-light skin tone | software | technologist | technologist: medium-light skin tone
🧑🏽‍💻	medium skin tone	coder | developer | inventor | medium skin tone | software | technologist | technologist: medium skin tone
🧑🏾‍💻	medium-dark skin tone	coder | developer | inventor | medium-dark skin tone | software | technologist | technologist: medium-dark skin tone
🧑🏿‍💻	dark skin tone	coder | dark skin tone | developer | inventor | software | technologist | technologist: dark skin tone
👨‍💻	technologist	coder | developer | inventor | man | software | technologist
👨🏻‍💻	technologist: light skin tone	coder | developer | inventor | light skin tone | man | man technologist: light skin tone | software | technologist
👨🏼‍💻	technologist: medium-light skin tone	coder | developer | inventor | man | man technologist: medium-light skin tone | medium-light skin tone | software | technologist
👨🏽‍💻	technologist: medium skin tone	coder | developer | inventor | man | man technologist: medium skin tone | medium skin tone | software | technologist
👨🏾‍💻	technologist: medium-dark skin tone	coder | developer | inventor | man | man technologist: medium-dark skin tone | medium-dark skin tone | software | technologist
👨🏿‍💻	technologist: dark skin tone	coder | dark skin tone | developer | inventor | man | man technologist: dark skin tone | software | technologist
👩‍💻	technologist	coder | developer | inventor | software | technologist | woman
👩🏻‍💻	technologist: light skin tone	coder | developer | inventor | light skin tone | software | technologist | woman | woman technologist: light skin tone
👩🏼‍💻	technologist: medium-light skin tone	coder | developer | inventor | medium-light skin tone | software | technologist | woman | woman technologist: medium-light skin tone
👩🏽‍💻	technologist: medium skin tone	coder | developer | inventor | medium skin tone | software | technologist | woman | woman technologist: medium skin tone
👩🏾‍💻	technologist: medium-dark skin tone	coder | developer | inventor | medium-dark skin tone | software | technologist | woman | woman technologist: medium-dark skin tone
👩🏿‍💻	technologist: dark skin tone	coder | dark skin tone | developer | inventor | software | technologist | woman | woman technologist: dark skin tone
🧑‍🎤	actor | entertainer | rock | singer | star
🧑🏻‍🎤	light skin tone	actor | entertainer | light skin tone | rock | singer | singer: light skin tone | star
🧑🏼‍🎤	medium-light skin tone	actor | entertainer | medium-light skin tone | rock | singer | singer: medium-light skin tone | star
🧑🏽‍🎤	medium skin tone	actor | entertainer | medium skin tone | rock | singer | singer: medium skin tone | star
🧑🏾‍🎤	medium-dark skin tone	actor | entertainer | medium-dark skin tone | rock | singer | singer: medium-dark skin tone | star
🧑🏿‍🎤	dark skin tone	actor | dark skin tone | entertainer | rock | singer | singer: dark skin tone | star
👨‍🎤	singer	actor | entertainer | man | rock | singer | star
👨🏻‍🎤	singer: light skin tone	actor | entertainer | light skin tone | man | man singer: light skin tone | rock | singer | star
👨🏼‍🎤	singer: medium-light skin tone	actor | entertainer | man | man singer: medium-light skin tone | medium-light skin tone | rock | singer | star
👨🏽‍🎤	singer: medium skin tone	actor | entertainer | man | man singer: medium skin tone | medium skin tone | rock | singer | star
👨🏾‍🎤	singer: medium-dark skin tone	actor | entertainer | man | man singer: medium-dark skin tone | medium-dark skin tone | rock | singer | star
👨🏿‍🎤	singer: dark skin tone	actor | dark skin tone | entertainer | man | man singer: dark skin tone | rock | singer | star
👩‍🎤	singer	actor | entertainer | rock | singer | star | woman
👩🏻‍🎤	singer: light skin tone	actor | entertainer | light skin tone | rock | singer | star | woman | woman singer: light skin tone
👩🏼‍🎤	singer: medium-light skin tone	actor | entertainer | medium-light skin tone | rock | singer | star | woman | woman singer: medium-light skin tone
👩🏽‍🎤	singer: medium skin tone	actor | entertainer | medium skin tone | rock | singer | star | woman | woman singer: medium skin tone
👩🏾‍🎤	singer: medium-dark skin tone	actor | entertainer | medium-dark skin tone | rock | singer | star | woman | woman singer: medium-dark skin tone
👩🏿‍🎤	singer: dark skin tone	actor | dark skin tone | entertainer | rock | singer | star | woman | woman singer: dark skin tone
🧑‍🎨	artist | palette
🧑🏻‍🎨	light skin tone	artist | artist: light skin tone | light skin tone | palette
🧑🏼‍🎨	medium-light skin tone	artist | artist: medium-light skin tone | medium-light skin tone | palette
🧑🏽‍🎨	medium skin tone	artist | artist: medium skin tone | medium skin tone | palette
🧑🏾‍🎨	medium-dark skin tone	artist | artist: medium-dark skin tone | medium-dark skin tone | palette
🧑🏿‍🎨	dark skin tone	artist | artist: dark skin tone | dark skin tone | palette
👨‍🎨	artist	artist | man | palette | painter
👨🏻‍🎨	artist: light skin tone	artist | light skin tone | man | man artist: light skin tone | palette | painter
👨🏼‍🎨	artist: medium-light skin tone	artist | man | man artist: medium-light skin tone | medium-light skin tone | palette | painter
👨🏽‍🎨	artist: medium skin tone	artist | man | man artist: medium skin tone | medium skin tone | palette | painter
👨🏾‍🎨	artist: medium-dark skin tone	artist | man | man artist: medium-dark skin tone | medium-dark skin tone | palette | painter
👨🏿‍🎨	artist: dark skin tone	artist | dark skin tone | man | man artist: dark skin tone | palette | painter
👩‍🎨	artist	artist | palette | woman | painter
👩🏻‍🎨	artist: light skin tone	artist | light skin tone | palette | woman | woman artist: light skin tone | painter
👩🏼‍🎨	artist: medium-light skin tone	artist | medium-light skin tone | palette | woman | woman artist: medium-light skin tone | painter
👩🏽‍🎨	artist: medium skin tone	artist | medium skin tone | palette | woman | woman artist: medium skin tone | painter
👩🏾‍🎨	artist: medium-dark skin tone	artist | medium-dark skin tone | palette | woman | woman artist: medium-dark skin tone | painter
👩🏿‍🎨	artist: dark skin tone	artist | dark skin tone | palette | woman | woman artist: dark skin tone | painter	
🧑‍✈	pilot | plane
🧑🏻‍✈️	light skin tone	
🧑🏻‍✈	light skin tone	light skin tone | pilot | pilot: light skin tone | plane
🧑🏼‍✈️	medium-light skin tone	
🧑🏼‍✈	medium-light skin tone	medium-light skin tone | pilot | pilot: medium-light skin tone | plane
🧑🏽‍✈️	medium skin tone	
🧑🏽‍✈	medium skin tone	medium skin tone | pilot | pilot: medium skin tone | plane
🧑🏾‍✈️	medium-dark skin tone	
🧑🏾‍✈	medium-dark skin tone	medium-dark skin tone | pilot | pilot: medium-dark skin tone | plane
🧑🏿‍✈️	dark skin tone	
🧑🏿‍✈	dark skin tone	dark skin tone | pilot | pilot: dark skin tone | plane
👨‍✈️	pilot	
👨‍✈	pilot	man | pilot | plane
👨🏻‍✈️	pilot: light skin tone	
👨🏻‍✈	pilot: light skin tone	light skin tone | man | man pilot: light skin tone | pilot | plane
👨🏼‍✈️	pilot: medium-light skin tone	
👨🏼‍✈	pilot: medium-light skin tone	man | man pilot: medium-light skin tone | medium-light skin tone | pilot | plane
👨🏽‍✈️	pilot: medium skin tone	
👨🏽‍✈	pilot: medium skin tone	man | man pilot: medium skin tone | medium skin tone | pilot | plane
👨🏾‍✈️	pilot: medium-dark skin tone	
👨🏾‍✈	pilot: medium-dark skin tone	man | man pilot: medium-dark skin tone | medium-dark skin tone | pilot | plane
👨🏿‍✈️	pilot: dark skin tone	
👨🏿‍✈	pilot: dark skin tone	dark skin tone | man | man pilot: dark skin tone | pilot | plane
👩‍✈️	pilot	
👩‍✈	pilot	pilot | plane | woman
👩🏻‍✈️	pilot: light skin tone	
👩🏻‍✈	pilot: light skin tone	light skin tone | pilot | plane | woman | woman pilot: light skin tone
👩🏼‍✈️	pilot: medium-light skin tone	
👩🏼‍✈	pilot: medium-light skin tone	medium-light skin tone | pilot | plane | woman | woman pilot: medium-light skin tone
👩🏽‍✈️	pilot: medium skin tone	
👩🏽‍✈	pilot: medium skin tone	medium skin tone | pilot | plane | woman | woman pilot: medium skin tone
👩🏾‍✈️	pilot: medium-dark skin tone	
👩🏾‍✈	pilot: medium-dark skin tone	medium-dark skin tone | pilot | plane | woman | woman pilot: medium-dark skin tone
👩🏿‍✈️	pilot: dark skin tone	
👩🏿‍✈	pilot: dark skin tone	dark skin tone | pilot | plane | woman | woman pilot: dark skin tone
🧑‍🚀	astronaut | rocket
🧑🏻‍🚀	light skin tone	astronaut | astronaut: light skin tone | light skin tone | rocket
🧑🏼‍🚀	medium-light skin tone	astronaut | astronaut: medium-light skin tone | medium-light skin tone | rocket
🧑🏽‍🚀	medium skin tone	astronaut | astronaut: medium skin tone | medium skin tone | rocket
🧑🏾‍🚀	medium-dark skin tone	astronaut | astronaut: medium-dark skin tone | medium-dark skin tone | rocket
🧑🏿‍🚀	dark skin tone	astronaut | astronaut: dark skin tone | dark skin tone | rocket
👨‍🚀	astronaut	astronaut | man | rocket
👨🏻‍🚀	astronaut: light skin tone	astronaut | light skin tone | man | man astronaut: light skin tone | rocket
👨🏼‍🚀	astronaut: medium-light skin tone	astronaut | man | man astronaut: medium-light skin tone | medium-light skin tone | rocket
👨🏽‍🚀	astronaut: medium skin tone	astronaut | man | man astronaut: medium skin tone | medium skin tone | rocket
👨🏾‍🚀	astronaut: medium-dark skin tone	astronaut | man | man astronaut: medium-dark skin tone | medium-dark skin tone | rocket
👨🏿‍🚀	astronaut: dark skin tone	astronaut | dark skin tone | man | man astronaut: dark skin tone | rocket
👩‍🚀	astronaut	astronaut | rocket | woman
👩🏻‍🚀	astronaut: light skin tone	astronaut | light skin tone | rocket | woman | woman astronaut: light skin tone
👩🏼‍🚀	astronaut: medium-light skin tone	astronaut | medium-light skin tone | rocket | woman | woman astronaut: medium-light skin tone
👩🏽‍🚀	astronaut: medium skin tone	astronaut | medium skin tone | rocket | woman | woman astronaut: medium skin tone
👩🏾‍🚀	astronaut: medium-dark skin tone	astronaut | medium-dark skin tone | rocket | woman | woman astronaut: medium-dark skin tone
👩🏿‍🚀	astronaut: dark skin tone	astronaut | dark skin tone | rocket | woman | woman astronaut: dark skin tone
🧑‍🚒	fire | firefighter | firetruck | fire engine | fire truck | engine | truck
🧑🏻‍🚒	light skin tone	fire | firefighter | firefighter: light skin tone | firetruck | light skin tone | fire engine | fire truck | engine | truck
🧑🏼‍🚒	medium-light skin tone	fire | firefighter | firefighter: medium-light skin tone | firetruck | medium-light skin tone | fire engine | fire truck | engine | truck
🧑🏽‍🚒	medium skin tone	fire | firefighter | firefighter: medium skin tone | firetruck | medium skin tone | fire engine | fire truck | engine | truck
🧑🏾‍🚒	medium-dark skin tone	fire | firefighter | firefighter: medium-dark skin tone | firetruck | medium-dark skin tone | fire engine | fire truck | engine | truck
🧑🏿‍🚒	dark skin tone	dark skin tone | fire | firefighter | firefighter: dark skin tone | firetruck | fire engine | fire truck | engine | truck
👨‍🚒	firefighter	firefighter | firetruck | man | fire | fire truck | fireman
👨🏻‍🚒	firefighter: light skin tone	firefighter | firetruck | light skin tone | man | man firefighter: light skin tone | fire | fire truck | fireman
👨🏼‍🚒	firefighter: medium-light skin tone	firefighter | firetruck | man | man firefighter: medium-light skin tone | medium-light skin tone | fire | fire truck | fireman
👨🏽‍🚒	firefighter: medium skin tone	firefighter | firetruck | man | man firefighter: medium skin tone | medium skin tone | fire | fire truck | fireman
👨🏾‍🚒	firefighter: medium-dark skin tone	firefighter | firetruck | man | man firefighter: medium-dark skin tone | medium-dark skin tone | fire | fire truck | fireman
👨🏿‍🚒	firefighter: dark skin tone	dark skin tone | firefighter | firetruck | man | man firefighter: dark skin tone | fire | fire truck | fireman
👩‍🚒	firefighter	firefighter | firetruck | woman | fire | fire truck | engine | firewoman | truck
👩🏻‍🚒	firefighter: light skin tone	firefighter | firetruck | light skin tone | woman | woman firefighter: light skin tone | fire | fire truck | engine | firewoman | truck
👩🏼‍🚒	firefighter: medium-light skin tone	firefighter | firetruck | medium-light skin tone | woman | woman firefighter: medium-light skin tone | fire | fire truck | engine | firewoman | truck
👩🏽‍🚒	firefighter: medium skin tone	firefighter | firetruck | medium skin tone | woman | woman firefighter: medium skin tone | fire | fire truck | engine | firewoman | truck
👩🏾‍🚒	firefighter: medium-dark skin tone	firefighter | firetruck | medium-dark skin tone | woman | woman firefighter: medium-dark skin tone | fire | fire truck | engine | firewoman | truck
👩🏿‍🚒	firefighter: dark skin tone	dark skin tone | firefighter | firetruck | woman | woman firefighter: dark skin tone | fire | fire truck | engine | firewoman | truck
👮	officer	cop | officer | police
👮🏻	officer: light skin tone	cop | light skin tone | officer | police | police officer: light skin tone
👮🏼	officer: medium-light skin tone	cop | medium-light skin tone | officer | police | police officer: medium-light skin tone
👮🏽	officer: medium skin tone	cop | medium skin tone | officer | police | police officer: medium skin tone
👮🏾	officer: medium-dark skin tone	cop | medium-dark skin tone | officer | police | police officer: medium-dark skin tone
👮🏿	officer: dark skin tone	cop | dark skin tone | officer | police | police officer: dark skin tone
👮‍♂️	police officer	
👮‍♂	police officer	cop | man | officer | police
👮🏻‍♂️	police officer: light skin tone	
👮🏻‍♂	police officer: light skin tone	cop | light skin tone | man | man police officer: light skin tone | officer | police
👮🏼‍♂️	police officer: medium-light skin tone	
👮🏼‍♂	police officer: medium-light skin tone	cop | man | man police officer: medium-light skin tone | medium-light skin tone | officer | police
👮🏽‍♂️	police officer: medium skin tone	
👮🏽‍♂	police officer: medium skin tone	cop | man | man police officer: medium skin tone | medium skin tone | officer | police
👮🏾‍♂️	police officer: medium-dark skin tone	
👮🏾‍♂	police officer: medium-dark skin tone	cop | man | man police officer: medium-dark skin tone | medium-dark skin tone | officer | police
👮🏿‍♂️	police officer: dark skin tone	
👮🏿‍♂	police officer: dark skin tone	cop | dark skin tone | man | man police officer: dark skin tone | officer | police
👮‍♀️	police officer	
👮‍♀	police officer	cop | officer | police | woman
👮🏻‍♀️	police officer: light skin tone	
👮🏻‍♀	police officer: light skin tone	cop | light skin tone | officer | police | woman | woman police officer: light skin tone
👮🏼‍♀️	police officer: medium-light skin tone	
👮🏼‍♀	police officer: medium-light skin tone	cop | medium-light skin tone | officer | police | woman | woman police officer: medium-light skin tone
👮🏽‍♀️	police officer: medium skin tone	
👮🏽‍♀	police officer: medium skin tone	cop | medium skin tone | officer | police | woman | woman police officer: medium skin tone
👮🏾‍♀️	police officer: medium-dark skin tone	
👮🏾‍♀	police officer: medium-dark skin tone	cop | medium-dark skin tone | officer | police | woman | woman police officer: medium-dark skin tone
👮🏿‍♀️	police officer: dark skin tone	
👮🏿‍♀	police officer: dark skin tone	cop | dark skin tone | officer | police | woman | woman police officer: dark skin tone
🕵	detective | sleuth | spy | investigator | private eye
🕵🏻	light skin tone	detective | detective: light skin tone | light skin tone | sleuth | spy | investigator | private eye
🕵🏼	medium-light skin tone	detective | detective: medium-light skin tone | medium-light skin tone | sleuth | spy | investigator | private eye
🕵🏽	medium skin tone	detective | detective: medium skin tone | medium skin tone | sleuth | spy | investigator | private eye
🕵🏾	medium-dark skin tone	detective | detective: medium-dark skin tone | medium-dark skin tone | sleuth | spy | investigator | private eye
🕵🏿	dark skin tone	dark skin tone | detective | detective: dark skin tone | sleuth | spy | investigator | private eye
🕵️‍♂️	detective	
🕵️‍♂	detective	
🕵‍♂	detective	detective | man | sleuth | spy | investigator
🕵🏻‍♂️	detective: light skin tone	
🕵🏻‍♂	detective: light skin tone	detective | light skin tone | man | man detective: light skin tone | sleuth | spy | investigator
🕵🏼‍♂️	detective: medium-light skin tone	
🕵🏼‍♂	detective: medium-light skin tone	detective | man | man detective: medium-light skin tone | medium-light skin tone | sleuth | spy | investigator
🕵🏽‍♂️	detective: medium skin tone	
🕵🏽‍♂	detective: medium skin tone	detective | man | man detective: medium skin tone | medium skin tone | sleuth | spy | investigator
🕵🏾‍♂️	detective: medium-dark skin tone	
🕵🏾‍♂	detective: medium-dark skin tone	detective | man | man detective: medium-dark skin tone | medium-dark skin tone | sleuth | spy | investigator
🕵🏿‍♂️	detective: dark skin tone	
🕵🏿‍♂	detective: dark skin tone	dark skin tone | detective | man | man detective: dark skin tone | sleuth | spy | investigator
🕵‍♀	detective	detective | sleuth | spy | woman | investigator
🕵🏻‍♀️	detective: light skin tone	
🕵🏻‍♀	detective: light skin tone	detective | light skin tone | sleuth | spy | woman | woman detective: light skin tone | investigator
🕵🏼‍♀️	detective: medium-light skin tone	
🕵🏼‍♀	detective: medium-light skin tone	detective | medium-light skin tone | sleuth | spy | woman | woman detective: medium-light skin tone | investigator
🕵🏽‍♀️	detective: medium skin tone	
🕵🏽‍♀	detective: medium skin tone	detective | medium skin tone | sleuth | spy | woman | woman detective: medium skin tone | investigator
🕵🏾‍♀️	detective: medium-dark skin tone	
🕵🏾‍♀	detective: medium-dark skin tone	detective | medium-dark skin tone | sleuth | spy | woman | woman detective: medium-dark skin tone | investigator
🕵🏿‍♀️	detective: dark skin tone	
🕵🏿‍♀	detective: dark skin tone	dark skin tone | detective | sleuth | spy | woman | woman detective: dark skin tone | investigator
💂	guard
💂🏻	light skin tone	guard | guard: light skin tone | light skin tone
💂🏼	medium-light skin tone	guard | guard: medium-light skin tone | medium-light skin tone
💂🏽	medium skin tone	guard | guard: medium skin tone | medium skin tone
💂🏾	medium-dark skin tone	guard | guard: medium-dark skin tone | medium-dark skin tone
💂🏿	dark skin tone	dark skin tone | guard | guard: dark skin tone
💂‍♂	guard	guard | man
💂🏻‍♂️	guard: light skin tone	
💂🏻‍♂	guard: light skin tone	guard | light skin tone | man | man guard: light skin tone
💂🏼‍♂️	guard: medium-light skin tone	
💂🏼‍♂	guard: medium-light skin tone	guard | man | man guard: medium-light skin tone | medium-light skin tone
💂🏽‍♂️	guard: medium skin tone	
💂🏽‍♂	guard: medium skin tone	guard | man | man guard: medium skin tone | medium skin tone
💂🏾‍♂️	guard: medium-dark skin tone	
💂🏾‍♂	guard: medium-dark skin tone	guard | man | man guard: medium-dark skin tone | medium-dark skin tone
💂🏿‍♂️	guard: dark skin tone	
💂🏿‍♂	guard: dark skin tone	dark skin tone | guard | man | man guard: dark skin tone
💂‍♀️	guard	
💂‍♀	guard	guard | woman
💂🏻‍♀️	guard: light skin tone	
💂🏻‍♀	guard: light skin tone	guard | light skin tone | woman | woman guard: light skin tone
💂🏼‍♀️	guard: medium-light skin tone	
💂🏼‍♀	guard: medium-light skin tone	guard | medium-light skin tone | woman | woman guard: medium-light skin tone
💂🏽‍♀️	guard: medium skin tone	
💂🏽‍♀	guard: medium skin tone	guard | medium skin tone | woman | woman guard: medium skin tone
💂🏾‍♀️	guard: medium-dark skin tone	
💂🏾‍♀	guard: medium-dark skin tone	guard | medium-dark skin tone | woman | woman guard: medium-dark skin tone
💂🏿‍♀️	guard: dark skin tone	
💂🏿‍♀	guard: dark skin tone	dark skin tone | guard | woman | woman guard: dark skin tone
🥷	fighter | hidden | ninja | stealth
🥷🏻	light skin tone	fighter | hidden | light skin tone | ninja | ninja: light skin tone | stealth
🥷🏼	medium-light skin tone	fighter | hidden | medium-light skin tone | ninja | ninja: medium-light skin tone | stealth
🥷🏽	medium skin tone	fighter | hidden | medium skin tone | ninja | ninja: medium skin tone | stealth
🥷🏾	medium-dark skin tone	fighter | hidden | medium-dark skin tone | ninja | ninja: medium-dark skin tone | stealth
🥷🏿	dark skin tone	dark skin tone | fighter | hidden | ninja | ninja: dark skin tone | stealth
👷	worker	construction | hat | worker
👷🏻	worker: light skin tone	construction | construction worker: light skin tone | hat | light skin tone | worker
👷🏼	worker: medium-light skin tone	construction | construction worker: medium-light skin tone | hat | medium-light skin tone | worker
👷🏽	worker: medium skin tone	construction | construction worker: medium skin tone | hat | medium skin tone | worker
👷🏾	worker: medium-dark skin tone	construction | construction worker: medium-dark skin tone | hat | medium-dark skin tone | worker
👷🏿	worker: dark skin tone	construction | construction worker: dark skin tone | dark skin tone | hat | worker
👷‍♂️	construction worker	
👷‍♂	construction worker	construction | man | worker
👷🏻‍♂️	construction worker: light skin tone	
👷🏻‍♂	construction worker: light skin tone	construction | light skin tone | man | man construction worker: light skin tone | worker
👷🏼‍♂️	construction worker: medium-light skin tone	
👷🏼‍♂	construction worker: medium-light skin tone	construction | man | man construction worker: medium-light skin tone | medium-light skin tone | worker
👷🏽‍♂️	construction worker: medium skin tone	
👷🏽‍♂	construction worker: medium skin tone	construction | man | man construction worker: medium skin tone | medium skin tone | worker
👷🏾‍♂️	construction worker: medium-dark skin tone	
👷🏾‍♂	construction worker: medium-dark skin tone	construction | man | man construction worker: medium-dark skin tone | medium-dark skin tone | worker
👷🏿‍♂️	construction worker: dark skin tone	
👷🏿‍♂	construction worker: dark skin tone	construction | dark skin tone | man | man construction worker: dark skin tone | worker
👷‍♀️	construction worker	
👷‍♀	construction worker	construction | woman | worker
👷🏻‍♀️	construction worker: light skin tone	
👷🏻‍♀	construction worker: light skin tone	construction | light skin tone | woman | woman construction worker: light skin tone | worker
👷🏼‍♀️	construction worker: medium-light skin tone	
👷🏼‍♀	construction worker: medium-light skin tone	construction | medium-light skin tone | woman | woman construction worker: medium-light skin tone | worker
👷🏽‍♀️	construction worker: medium skin tone	
👷🏽‍♀	construction worker: medium skin tone	construction | medium skin tone | woman | woman construction worker: medium skin tone | worker
👷🏾‍♀️	construction worker: medium-dark skin tone	
👷🏾‍♀	construction worker: medium-dark skin tone	construction | medium-dark skin tone | woman | woman construction worker: medium-dark skin tone | worker
👷🏿‍♀️	construction worker: dark skin tone	
👷🏿‍♀	construction worker: dark skin tone	construction | dark skin tone | woman | woman construction worker: dark skin tone | worker
🫅	with crown	monarch | noble | person with crown | regal | royalty | king | queen
🫅🏻	with crown: light skin tone	light skin tone | monarch | noble | person with crown | person with crown: light skin tone | regal | royalty | king | queen
🫅🏼	with crown: medium-light skin tone	medium-light skin tone | monarch | noble | person with crown | person with crown: medium-light skin tone | regal | royalty | king | queen
🫅🏽	with crown: medium skin tone	medium skin tone | monarch | noble | person with crown | person with crown: medium skin tone | regal | royalty | king | queen
🫅🏾	with crown: medium-dark skin tone	medium-dark skin tone | monarch | noble | person with crown | person with crown: medium-dark skin tone | regal | royalty | king | queen
🫅🏿	with crown: dark skin tone	dark skin tone | monarch | noble | person with crown | person with crown: dark skin tone | regal | royalty | king | queen
🤴	prince | fairy tale | fantasy
🤴🏻	light skin tone	light skin tone | prince | prince: light skin tone | fairy tale | fantasy
🤴🏼	medium-light skin tone	medium-light skin tone | prince | prince: medium-light skin tone | fairy tale | fantasy
🤴🏽	medium skin tone	medium skin tone | prince | prince: medium skin tone | fairy tale | fantasy
🤴🏾	medium-dark skin tone	medium-dark skin tone | prince | prince: medium-dark skin tone | fairy tale | fantasy
🤴🏿	dark skin tone	dark skin tone | prince | prince: dark skin tone | fairy tale | fantasy
👸	fairy tale | fantasy | princess
👸🏻	light skin tone	fairy tale | fantasy | light skin tone | princess | princess: light skin tone
👸🏼	medium-light skin tone	fairy tale | fantasy | medium-light skin tone | princess | princess: medium-light skin tone
👸🏽	medium skin tone	fairy tale | fantasy | medium skin tone | princess | princess: medium skin tone
👸🏾	medium-dark skin tone	fairy tale | fantasy | medium-dark skin tone | princess | princess: medium-dark skin tone
👸🏿	dark skin tone	dark skin tone | fairy tale | fantasy | princess | princess: dark skin tone
👳	wearing turban	person wearing turban | turban
👳🏻	wearing turban: light skin tone	light skin tone | person wearing turban | person wearing turban: light skin tone | turban
👳🏼	wearing turban: medium-light skin tone	medium-light skin tone | person wearing turban | person wearing turban: medium-light skin tone | turban
👳🏽	wearing turban: medium skin tone	medium skin tone | person wearing turban | person wearing turban: medium skin tone | turban
👳🏾	wearing turban: medium-dark skin tone	medium-dark skin tone | person wearing turban | person wearing turban: medium-dark skin tone | turban
👳🏿	wearing turban: dark skin tone	dark skin tone | person wearing turban | person wearing turban: dark skin tone | turban
👳‍♂️	wearing turban	
👳‍♂	wearing turban	man | man wearing turban | turban
👳🏻‍♂️	wearing turban: light skin tone	
👳🏻‍♂	wearing turban: light skin tone	light skin tone | man | man wearing turban | man wearing turban: light skin tone | turban
👳🏼‍♂️	wearing turban: medium-light skin tone	
👳🏼‍♂	wearing turban: medium-light skin tone	man | man wearing turban | man wearing turban: medium-light skin tone | medium-light skin tone | turban
👳🏽‍♂️	wearing turban: medium skin tone	
👳🏽‍♂	wearing turban: medium skin tone	man | man wearing turban | man wearing turban: medium skin tone | medium skin tone | turban
👳🏾‍♂️	wearing turban: medium-dark skin tone	
👳🏾‍♂	wearing turban: medium-dark skin tone	man | man wearing turban | man wearing turban: medium-dark skin tone | medium-dark skin tone | turban
👳🏿‍♂️	wearing turban: dark skin tone	
👳🏿‍♂	wearing turban: dark skin tone	dark skin tone | man | man wearing turban | man wearing turban: dark skin tone | turban
👳‍♀️	wearing turban	
👳‍♀	wearing turban	turban | woman | woman wearing turban
👳🏻‍♀️	wearing turban: light skin tone	
👳🏻‍♀	wearing turban: light skin tone	light skin tone | turban | woman | woman wearing turban | woman wearing turban: light skin tone
👳🏼‍♀️	wearing turban: medium-light skin tone	
👳🏼‍♀	wearing turban: medium-light skin tone	medium-light skin tone | turban | woman | woman wearing turban | woman wearing turban: medium-light skin tone
👳🏽‍♀️	wearing turban: medium skin tone	
👳🏽‍♀	wearing turban: medium skin tone	medium skin tone | turban | woman | woman wearing turban | woman wearing turban: medium skin tone
👳🏾‍♀️	wearing turban: medium-dark skin tone	
👳🏾‍♀	wearing turban: medium-dark skin tone	medium-dark skin tone | turban | woman | woman wearing turban | woman wearing turban: medium-dark skin tone
👳🏿‍♀️	wearing turban: dark skin tone	
👳🏿‍♀	wearing turban: dark skin tone	dark skin tone | turban | woman | woman wearing turban | woman wearing turban: dark skin tone
👲	with skullcap	cap | gua pi mao | hat | person | person with skullcap | skullcap
👲🏻	with skullcap: light skin tone	cap | gua pi mao | hat | light skin tone | person | person with skullcap | person with skullcap: light skin tone | skullcap
👲🏼	with skullcap: medium-light skin tone	cap | gua pi mao | hat | medium-light skin tone | person | person with skullcap | person with skullcap: medium-light skin tone | skullcap
👲🏽	with skullcap: medium skin tone	cap | gua pi mao | hat | medium skin tone | person | person with skullcap | person with skullcap: medium skin tone | skullcap
👲🏾	with skullcap: medium-dark skin tone	cap | gua pi mao | hat | medium-dark skin tone | person | person with skullcap | person with skullcap: medium-dark skin tone | skullcap
👲🏿	with skullcap: dark skin tone	cap | dark skin tone | gua pi mao | hat | person | person with skullcap | person with skullcap: dark skin tone | skullcap
🧕	with headscarf	headscarf | hijab | mantilla | tichel | woman with headscarf
🧕🏻	with headscarf: light skin tone	headscarf | hijab | light skin tone | mantilla | tichel | woman with headscarf | woman with headscarf: light skin tone
🧕🏼	with headscarf: medium-light skin tone	headscarf | hijab | mantilla | medium-light skin tone | tichel | woman with headscarf | woman with headscarf: medium-light skin tone
🧕🏽	with headscarf: medium skin tone	headscarf | hijab | mantilla | medium skin tone | tichel | woman with headscarf | woman with headscarf: medium skin tone
🧕🏾	with headscarf: medium-dark skin tone	headscarf | hijab | mantilla | medium-dark skin tone | tichel | woman with headscarf | woman with headscarf: medium-dark skin tone
🧕🏿	with headscarf: dark skin tone	dark skin tone | headscarf | hijab | mantilla | tichel | woman with headscarf | woman with headscarf: dark skin tone
🤵	in tuxedo	groom | person | person in tuxedo | tuxedo | person in tux
🤵🏻	in tuxedo: light skin tone	groom | light skin tone | person | person in tuxedo | person in tuxedo: light skin tone | tuxedo | person in tux
🤵🏼	in tuxedo: medium-light skin tone	groom | medium-light skin tone | person | person in tuxedo | person in tuxedo: medium-light skin tone | tuxedo | person in tux
🤵🏽	in tuxedo: medium skin tone	groom | medium skin tone | person | person in tuxedo | person in tuxedo: medium skin tone | tuxedo | person in tux
🤵🏾	in tuxedo: medium-dark skin tone	groom | medium-dark skin tone | person | person in tuxedo | person in tuxedo: medium-dark skin tone | tuxedo | person in tux
🤵🏿	in tuxedo: dark skin tone	dark skin tone | groom | person | person in tuxedo | person in tuxedo: dark skin tone | tuxedo | person in tux
🤵‍♂️	in tuxedo	
🤵‍♂	in tuxedo	man | man in tuxedo | tuxedo | man in tux | tux
🤵🏻‍♂️	in tuxedo: light skin tone	
🤵🏻‍♂	in tuxedo: light skin tone	light skin tone | man | man in tuxedo | man in tuxedo: light skin tone | tuxedo | man in tux | tux
🤵🏼‍♂️	in tuxedo: medium-light skin tone	
🤵🏼‍♂	in tuxedo: medium-light skin tone	man | man in tuxedo | man in tuxedo: medium-light skin tone | medium-light skin tone | tuxedo | man in tux | tux
🤵🏽‍♂️	in tuxedo: medium skin tone	
🤵🏽‍♂	in tuxedo: medium skin tone	man | man in tuxedo | man in tuxedo: medium skin tone | medium skin tone | tuxedo | man in tux | tux
🤵🏾‍♂️	in tuxedo: medium-dark skin tone	
🤵🏾‍♂	in tuxedo: medium-dark skin tone	man | man in tuxedo | man in tuxedo: medium-dark skin tone | medium-dark skin tone | tuxedo | man in tux | tux
🤵🏿‍♂️	in tuxedo: dark skin tone	
🤵🏿‍♂	in tuxedo: dark skin tone	dark skin tone | man | man in tuxedo | man in tuxedo: dark skin tone | tuxedo | man in tux | tux
🤵‍♀️	in tuxedo	
🤵‍♀	in tuxedo	tuxedo | woman | woman in tuxedo | woman in tux
🤵🏻‍♀️	in tuxedo: light skin tone	
🤵🏻‍♀	in tuxedo: light skin tone	light skin tone | tuxedo | woman | woman in tuxedo | woman in tuxedo: light skin tone | woman in tux
🤵🏼‍♀️	in tuxedo: medium-light skin tone	
🤵🏼‍♀	in tuxedo: medium-light skin tone	medium-light skin tone | tuxedo | woman | woman in tuxedo | woman in tuxedo: medium-light skin tone | woman in tux
🤵🏽‍♀️	in tuxedo: medium skin tone	
🤵🏽‍♀	in tuxedo: medium skin tone	medium skin tone | tuxedo | woman | woman in tuxedo | woman in tuxedo: medium skin tone | woman in tux
🤵🏾‍♀️	in tuxedo: medium-dark skin tone	
🤵🏾‍♀	in tuxedo: medium-dark skin tone	medium-dark skin tone | tuxedo | woman | woman in tuxedo | woman in tuxedo: medium-dark skin tone | woman in tux
🤵🏿‍♀️	in tuxedo: dark skin tone	
🤵🏿‍♀	in tuxedo: dark skin tone	dark skin tone | tuxedo | woman | woman in tuxedo | woman in tuxedo: dark skin tone | woman in tux
👰	with veil	bride | person | person with veil | veil | wedding
👰🏻	with veil: light skin tone	bride | light skin tone | person | person with veil | person with veil: light skin tone | veil | wedding
👰🏼	with veil: medium-light skin tone	bride | medium-light skin tone | person | person with veil | person with veil: medium-light skin tone | veil | wedding
👰🏽	with veil: medium skin tone	bride | medium skin tone | person | person with veil | person with veil: medium skin tone | veil | wedding
👰🏾	with veil: medium-dark skin tone	bride | medium-dark skin tone | person | person with veil | person with veil: medium-dark skin tone | veil | wedding
👰🏿	with veil: dark skin tone	bride | dark skin tone | person | person with veil | person with veil: dark skin tone | veil | wedding
👰‍♂️	with veil	
👰‍♂	with veil	man | man with veil | veil
👰🏻‍♂️	with veil: light skin tone	
👰🏻‍♂	with veil: light skin tone	light skin tone | man | man with veil | man with veil: light skin tone | veil
👰🏼‍♂️	with veil: medium-light skin tone	
👰🏼‍♂	with veil: medium-light skin tone	man | man with veil | man with veil: medium-light skin tone | medium-light skin tone | veil
👰🏽‍♂️	with veil: medium skin tone	
👰🏽‍♂	with veil: medium skin tone	man | man with veil | man with veil: medium skin tone | medium skin tone | veil
👰🏾‍♂️	with veil: medium-dark skin tone	
👰🏾‍♂	with veil: medium-dark skin tone	man | man with veil | man with veil: medium-dark skin tone | medium-dark skin tone | veil
👰🏿‍♂️	with veil: dark skin tone	
👰🏿‍♂	with veil: dark skin tone	dark skin tone | man | man with veil | man with veil: dark skin tone | veil
👰‍♀️	with veil	
👰‍♀	with veil	veil | woman | woman with veil | bride
👰🏻‍♀️	with veil: light skin tone	
👰🏻‍♀	with veil: light skin tone	light skin tone | veil | woman | woman with veil | woman with veil: light skin tone | bride
👰🏼‍♀️	with veil: medium-light skin tone	
👰🏼‍♀	with veil: medium-light skin tone	medium-light skin tone | veil | woman | woman with veil | woman with veil: medium-light skin tone | bride
👰🏽‍♀️	with veil: medium skin tone	
👰🏽‍♀	with veil: medium skin tone	medium skin tone | veil | woman | woman with veil | woman with veil: medium skin tone | bride
👰🏾‍♀️	with veil: medium-dark skin tone	
👰🏾‍♀	with veil: medium-dark skin tone	medium-dark skin tone | veil | woman | woman with veil | woman with veil: medium-dark skin tone | bride
👰🏿‍♀️	with veil: dark skin tone	
👰🏿‍♀	with veil: dark skin tone	dark skin tone | veil | woman | woman with veil | woman with veil: dark skin tone | bride
🤰	woman	pregnant | woman
🤰🏻	woman: light skin tone	light skin tone | pregnant | pregnant woman: light skin tone | woman
🤰🏼	woman: medium-light skin tone	medium-light skin tone | pregnant | pregnant woman: medium-light skin tone | woman
🤰🏽	woman: medium skin tone	medium skin tone | pregnant | pregnant woman: medium skin tone | woman
🤰🏾	woman: medium-dark skin tone	medium-dark skin tone | pregnant | pregnant woman: medium-dark skin tone | woman
🤰🏿	woman: dark skin tone	dark skin tone | pregnant | pregnant woman: dark skin tone | woman
🫃	man	belly | bloated | full | pregnant | pregnant man
🫃🏻	man: light skin tone	belly | bloated | full | light skin tone | pregnant | pregnant man | pregnant man: light skin tone
🫃🏼	man: medium-light skin tone	belly | bloated | full | medium-light skin tone | pregnant | pregnant man | pregnant man: medium-light skin tone
🫃🏽	man: medium skin tone	belly | bloated | full | medium skin tone | pregnant | pregnant man | pregnant man: medium skin tone
🫃🏾	man: medium-dark skin tone	belly | bloated | full | medium-dark skin tone | pregnant | pregnant man | pregnant man: medium-dark skin tone
🫃🏿	man: dark skin tone	belly | bloated | dark skin tone | full | pregnant | pregnant man | pregnant man: dark skin tone
🫄	person	belly | bloated | full | pregnant | pregnant person
🫄🏻	person: light skin tone	belly | bloated | full | light skin tone | pregnant | pregnant person | pregnant person: light skin tone
🫄🏼	person: medium-light skin tone	belly | bloated | full | medium-light skin tone | pregnant | pregnant person | pregnant person: medium-light skin tone
🫄🏽	person: medium skin tone	belly | bloated | full | medium skin tone | pregnant | pregnant person | pregnant person: medium skin tone
🫄🏾	person: medium-dark skin tone	belly | bloated | full | medium-dark skin tone | pregnant | pregnant person | pregnant person: medium-dark skin tone
🫄🏿	person: dark skin tone	belly | bloated | dark skin tone | full | pregnant | pregnant person | pregnant person: dark skin tone
🤱	baby | breast | breast-feeding | nursing
🤱🏻	light skin tone	baby | breast | breast-feeding | breast-feeding: light skin tone | light skin tone | nursing
🤱🏼	medium-light skin tone	baby | breast | breast-feeding | breast-feeding: medium-light skin tone | medium-light skin tone | nursing
🤱🏽	medium skin tone	baby | breast | breast-feeding | breast-feeding: medium skin tone | medium skin tone | nursing
🤱🏾	medium-dark skin tone	baby | breast | breast-feeding | breast-feeding: medium-dark skin tone | medium-dark skin tone | nursing
🤱🏿	dark skin tone	baby | breast | breast-feeding | breast-feeding: dark skin tone | dark skin tone | nursing
👩‍🍼	feeding baby	baby | feeding | nursing | woman
👩🏻‍🍼	feeding baby: light skin tone	baby | feeding | light skin tone | nursing | woman | woman feeding baby: light skin tone
👩🏼‍🍼	feeding baby: medium-light skin tone	baby | feeding | medium-light skin tone | nursing | woman | woman feeding baby: medium-light skin tone
👩🏽‍🍼	feeding baby: medium skin tone	baby | feeding | medium skin tone | nursing | woman | woman feeding baby: medium skin tone
👩🏾‍🍼	feeding baby: medium-dark skin tone	baby | feeding | medium-dark skin tone | nursing | woman | woman feeding baby: medium-dark skin tone
👩🏿‍🍼	feeding baby: dark skin tone	baby | dark skin tone | feeding | nursing | woman | woman feeding baby: dark skin tone
👨‍🍼	feeding baby	baby | feeding | man | nursing
👨🏻‍🍼	feeding baby: light skin tone	baby | feeding | light skin tone | man | man feeding baby: light skin tone | nursing
👨🏼‍🍼	feeding baby: medium-light skin tone	baby | feeding | man | man feeding baby: medium-light skin tone | medium-light skin tone | nursing
👨🏽‍🍼	feeding baby: medium skin tone	baby | feeding | man | man feeding baby: medium skin tone | medium skin tone | nursing
👨🏾‍🍼	feeding baby: medium-dark skin tone	baby | feeding | man | man feeding baby: medium-dark skin tone | medium-dark skin tone | nursing
👨🏿‍🍼	feeding baby: dark skin tone	baby | dark skin tone | feeding | man | man feeding baby: dark skin tone | nursing
🧑‍🍼	feeding baby	baby | feeding | nursing | person
🧑🏻‍🍼	feeding baby: light skin tone	baby | feeding | light skin tone | nursing | person | person feeding baby: light skin tone
🧑🏼‍🍼	feeding baby: medium-light skin tone	baby | feeding | medium-light skin tone | nursing | person | person feeding baby: medium-light skin tone
🧑🏽‍🍼	feeding baby: medium skin tone	baby | feeding | medium skin tone | nursing | person | person feeding baby: medium skin tone
🧑🏾‍🍼	feeding baby: medium-dark skin tone	baby | feeding | medium-dark skin tone | nursing | person | person feeding baby: medium-dark skin tone
🧑🏿‍🍼	feeding baby: dark skin tone	baby | dark skin tone | feeding | nursing | person | person feeding baby: dark skin tone
👼	angel	angel | baby | face | fairy tale | fantasy
👼🏻	angel: light skin tone	angel | baby | baby angel: light skin tone | face | fairy tale | fantasy | light skin tone
👼🏼	angel: medium-light skin tone	angel | baby | baby angel: medium-light skin tone | face | fairy tale | fantasy | medium-light skin tone
👼🏽	angel: medium skin tone	angel | baby | baby angel: medium skin tone | face | fairy tale | fantasy | medium skin tone
👼🏾	angel: medium-dark skin tone	angel | baby | baby angel: medium-dark skin tone | face | fairy tale | fantasy | medium-dark skin tone
👼🏿	angel: dark skin tone	angel | baby | baby angel: dark skin tone | dark skin tone | face | fairy tale | fantasy
🎅	Claus	celebration | Christmas | claus | father | santa | Father Christmas | Santa | Santa Claus | Claus | Father
🎅🏻	Claus: light skin tone	celebration | Christmas | claus | father | light skin tone | santa | Santa Claus: light skin tone | Father Christmas | Santa | Santa Claus | Santa: light skin tone | Claus | Father
🎅🏼	Claus: medium-light skin tone	celebration | Christmas | claus | father | medium-light skin tone | santa | Santa Claus: medium-light skin tone | Father Christmas | Santa | Santa Claus | Santa: medium-light skin tone | Claus | Father
🎅🏽	Claus: medium skin tone	celebration | Christmas | claus | father | medium skin tone | santa | Santa Claus: medium skin tone | Father Christmas | Santa | Santa Claus | Santa: medium skin tone | Claus | Father
🎅🏾	Claus: medium-dark skin tone	celebration | Christmas | claus | father | medium-dark skin tone | santa | Santa Claus: medium-dark skin tone | Father Christmas | Santa | Santa Claus | Santa: medium-dark skin tone | Claus | Father
🎅🏿	Claus: dark skin tone	celebration | Christmas | claus | dark skin tone | father | santa | Santa Claus: dark skin tone | Father Christmas | Santa | Santa Claus | Santa: dark skin tone | Claus | Father
🤶	Claus	celebration | Christmas | claus | mother | Mrs. | Mrs Claus | Mrs Santa Claus | Mrs. Claus | Claus | Mother | Mrs
🤶🏻	Claus: light skin tone	celebration | Christmas | claus | light skin tone | mother | Mrs. | Mrs. Claus: light skin tone | Mrs Claus | Mrs Santa Claus | Mrs. Claus | Claus | Mother | Mrs | Mrs Claus: light skin tone
🤶🏼	Claus: medium-light skin tone	celebration | Christmas | claus | medium-light skin tone | mother | Mrs. | Mrs. Claus: medium-light skin tone | Mrs Claus | Mrs Santa Claus | Mrs. Claus | Claus | Mother | Mrs | Mrs Claus: medium-light skin tone
🤶🏽	Claus: medium skin tone	celebration | Christmas | claus | medium skin tone | mother | Mrs. | Mrs. Claus: medium skin tone | Mrs Claus | Mrs Santa Claus | Mrs. Claus | Claus | Mother | Mrs | Mrs Claus: medium skin tone
🤶🏾	Claus: medium-dark skin tone	celebration | Christmas | claus | medium-dark skin tone | mother | Mrs. | Mrs. Claus: medium-dark skin tone | Mrs Claus | Mrs Santa Claus | Mrs. Claus | Claus | Mother | Mrs | Mrs Claus: medium-dark skin tone
🤶🏿	Claus: dark skin tone	celebration | Christmas | claus | dark skin tone | mother | Mrs. | Mrs. Claus: dark skin tone | Mrs Claus | Mrs Santa Claus | Mrs. Claus | Claus | Mother | Mrs | Mrs Claus: dark skin tone
🧑‍🎄	claus	christmas | claus | mx claus | Christmas | Claus | Mx. Claus
🧑🏻‍🎄	claus: light skin tone	christmas | claus | light skin tone | mx claus | mx claus: light skin tone | Christmas | Claus | Mx. Claus | Mx. Claus: light skin tone
🧑🏼‍🎄	claus: medium-light skin tone	christmas | claus | medium-light skin tone | mx claus | mx claus: medium-light skin tone | Christmas | Claus | Mx. Claus | Mx. Claus: medium-light skin tone
🧑🏽‍🎄	claus: medium skin tone	christmas | claus | medium skin tone | mx claus | mx claus: medium skin tone | Christmas | Claus | Mx. Claus | Mx. Claus: medium skin tone
🧑🏾‍🎄	claus: medium-dark skin tone	christmas | claus | medium-dark skin tone | mx claus | mx claus: medium-dark skin tone | Christmas | Claus | Mx. Claus | Mx. Claus: medium-dark skin tone
🧑🏿‍🎄	claus: dark skin tone	christmas | claus | dark skin tone | mx claus | mx claus: dark skin tone | Christmas | Claus | Mx. Claus | Mx. Claus: dark skin tone
🦸	good | hero | heroine | superhero | superpower
🦸🏻	light skin tone	good | hero | heroine | light skin tone | superhero | superhero: light skin tone | superpower
🦸🏼	medium-light skin tone	good | hero | heroine | medium-light skin tone | superhero | superhero: medium-light skin tone | superpower
🦸🏽	medium skin tone	good | hero | heroine | medium skin tone | superhero | superhero: medium skin tone | superpower
🦸🏾	medium-dark skin tone	good | hero | heroine | medium-dark skin tone | superhero | superhero: medium-dark skin tone | superpower
🦸🏿	dark skin tone	dark skin tone | good | hero | heroine | superhero | superhero: dark skin tone | superpower
🦸‍♂️	superhero	
🦸‍♂	superhero	good | hero | man | man superhero | superpower
🦸🏻‍♂️	superhero: light skin tone	
🦸🏻‍♂	superhero: light skin tone	good | hero | light skin tone | man | man superhero | man superhero: light skin tone | superpower
🦸🏼‍♂️	superhero: medium-light skin tone	
🦸🏼‍♂	superhero: medium-light skin tone	good | hero | man | man superhero | man superhero: medium-light skin tone | medium-light skin tone | superpower
🦸🏽‍♂️	superhero: medium skin tone	
🦸🏽‍♂	superhero: medium skin tone	good | hero | man | man superhero | man superhero: medium skin tone | medium skin tone | superpower
🦸🏾‍♂️	superhero: medium-dark skin tone	
🦸🏾‍♂	superhero: medium-dark skin tone	good | hero | man | man superhero | man superhero: medium-dark skin tone | medium-dark skin tone | superpower
🦸🏿‍♂️	superhero: dark skin tone	
🦸🏿‍♂	superhero: dark skin tone	dark skin tone | good | hero | man | man superhero | man superhero: dark skin tone | superpower
🦸‍♀	superhero	good | hero | heroine | superpower | woman | woman superhero
🦸🏻‍♀️	superhero: light skin tone	
🦸🏻‍♀	superhero: light skin tone	good | hero | heroine | light skin tone | superpower | woman | woman superhero | woman superhero: light skin tone
🦸🏼‍♀️	superhero: medium-light skin tone	
🦸🏼‍♀	superhero: medium-light skin tone	good | hero | heroine | medium-light skin tone | superpower | woman | woman superhero | woman superhero: medium-light skin tone
🦸🏽‍♀️	superhero: medium skin tone	
🦸🏽‍♀	superhero: medium skin tone	good | hero | heroine | medium skin tone | superpower | woman | woman superhero | woman superhero: medium skin tone
🦸🏾‍♀️	superhero: medium-dark skin tone	
🦸🏾‍♀	superhero: medium-dark skin tone	good | hero | heroine | medium-dark skin tone | superpower | woman | woman superhero | woman superhero: medium-dark skin tone
🦸🏿‍♀️	superhero: dark skin tone	
🦸🏿‍♀	superhero: dark skin tone	dark skin tone | good | hero | heroine | superpower | woman | woman superhero | woman superhero: dark skin tone
🦹	criminal | evil | superpower | supervillain | villain
🦹🏻	light skin tone	criminal | evil | light skin tone | superpower | supervillain | supervillain: light skin tone | villain
🦹🏼	medium-light skin tone	criminal | evil | medium-light skin tone | superpower | supervillain | supervillain: medium-light skin tone | villain
🦹🏽	medium skin tone	criminal | evil | medium skin tone | superpower | supervillain | supervillain: medium skin tone | villain
🦹🏾	medium-dark skin tone	criminal | evil | medium-dark skin tone | superpower | supervillain | supervillain: medium-dark skin tone | villain
🦹🏿	dark skin tone	criminal | dark skin tone | evil | superpower | supervillain | supervillain: dark skin tone | villain
🦹‍♂️	supervillain	
🦹‍♂	supervillain	criminal | evil | man | man supervillain | superpower | villain
🦹🏻‍♂️	supervillain: light skin tone	
🦹🏻‍♂	supervillain: light skin tone	criminal | evil | light skin tone | man | man supervillain | man supervillain: light skin tone | superpower | villain
🦹🏼‍♂️	supervillain: medium-light skin tone	
🦹🏼‍♂	supervillain: medium-light skin tone	criminal | evil | man | man supervillain | man supervillain: medium-light skin tone | medium-light skin tone | superpower | villain
🦹🏽‍♂️	supervillain: medium skin tone	
🦹🏽‍♂	supervillain: medium skin tone	criminal | evil | man | man supervillain | man supervillain: medium skin tone | medium skin tone | superpower | villain
🦹🏾‍♂️	supervillain: medium-dark skin tone	
🦹🏾‍♂	supervillain: medium-dark skin tone	criminal | evil | man | man supervillain | man supervillain: medium-dark skin tone | medium-dark skin tone | superpower | villain
🦹🏿‍♂️	supervillain: dark skin tone	
🦹🏿‍♂	supervillain: dark skin tone	criminal | dark skin tone | evil | man | man supervillain | man supervillain: dark skin tone | superpower | villain
🦹‍♀️	supervillain	
🦹‍♀	supervillain	criminal | evil | superpower | villain | woman | woman supervillain
🦹🏻‍♀️	supervillain: light skin tone	
🦹🏻‍♀	supervillain: light skin tone	criminal | evil | light skin tone | superpower | villain | woman | woman supervillain | woman supervillain: light skin tone
🦹🏼‍♀️	supervillain: medium-light skin tone	
🦹🏼‍♀	supervillain: medium-light skin tone	criminal | evil | medium-light skin tone | superpower | villain | woman | woman supervillain | woman supervillain: medium-light skin tone
🦹🏽‍♀️	supervillain: medium skin tone	
🦹🏽‍♀	supervillain: medium skin tone	criminal | evil | medium skin tone | superpower | villain | woman | woman supervillain | woman supervillain: medium skin tone
🦹🏾‍♀️	supervillain: medium-dark skin tone	
🦹🏾‍♀	supervillain: medium-dark skin tone	criminal | evil | medium-dark skin tone | superpower | villain | woman | woman supervillain | woman supervillain: medium-dark skin tone
🦹🏿‍♀️	supervillain: dark skin tone	
🦹🏿‍♀	supervillain: dark skin tone	criminal | dark skin tone | evil | superpower | villain | woman | woman supervillain | woman supervillain: dark skin tone
🧙	mage | sorcerer | sorceress | witch | wizard
🧙🏻	light skin tone	light skin tone | mage | mage: light skin tone | sorcerer | sorceress | witch | wizard
🧙🏼	medium-light skin tone	mage | mage: medium-light skin tone | medium-light skin tone | sorcerer | sorceress | witch | wizard
🧙🏽	medium skin tone	mage | mage: medium skin tone | medium skin tone | sorcerer | sorceress | witch | wizard
🧙🏾	medium-dark skin tone	mage | mage: medium-dark skin tone | medium-dark skin tone | sorcerer | sorceress | witch | wizard
🧙🏿	dark skin tone	dark skin tone | mage | mage: dark skin tone | sorcerer | sorceress | witch | wizard
🧙‍♂️	mage	
🧙‍♂	mage	man mage | sorcerer | wizard
🧙🏻‍♂️	mage: light skin tone	
🧙🏻‍♂	mage: light skin tone	light skin tone | man mage | man mage: light skin tone | sorcerer | wizard
🧙🏼‍♂️	mage: medium-light skin tone	
🧙🏼‍♂	mage: medium-light skin tone	man mage | man mage: medium-light skin tone | medium-light skin tone | sorcerer | wizard
🧙🏽‍♂️	mage: medium skin tone	
🧙🏽‍♂	mage: medium skin tone	man mage | man mage: medium skin tone | medium skin tone | sorcerer | wizard
🧙🏾‍♂️	mage: medium-dark skin tone	
🧙🏾‍♂	mage: medium-dark skin tone	man mage | man mage: medium-dark skin tone | medium-dark skin tone | sorcerer | wizard
🧙🏿‍♂️	mage: dark skin tone	
🧙🏿‍♂	mage: dark skin tone	dark skin tone | man mage | man mage: dark skin tone | sorcerer | wizard	
🧙‍♀	mage	sorceress | witch | woman mage
🧙🏻‍♀️	mage: light skin tone	
🧙🏻‍♀	mage: light skin tone	light skin tone | sorceress | witch | woman mage | woman mage: light skin tone
🧙🏼‍♀️	mage: medium-light skin tone	
🧙🏼‍♀	mage: medium-light skin tone	medium-light skin tone | sorceress | witch | woman mage | woman mage: medium-light skin tone
🧙🏽‍♀️	mage: medium skin tone	
🧙🏽‍♀	mage: medium skin tone	medium skin tone | sorceress | witch | woman mage | woman mage: medium skin tone
🧙🏾‍♀️	mage: medium-dark skin tone	
🧙🏾‍♀	mage: medium-dark skin tone	medium-dark skin tone | sorceress | witch | woman mage | woman mage: medium-dark skin tone
🧙🏿‍♀️	mage: dark skin tone	
🧙🏿‍♀	mage: dark skin tone	dark skin tone | sorceress | witch | woman mage | woman mage: dark skin tone
🧚	fairy | Oberon | Puck | Titania
🧚🏻	light skin tone	fairy | fairy: light skin tone | light skin tone | Oberon | Puck | Titania
🧚🏼	medium-light skin tone	fairy | fairy: medium-light skin tone | medium-light skin tone | Oberon | Puck | Titania
🧚🏽	medium skin tone	fairy | fairy: medium skin tone | medium skin tone | Oberon | Puck | Titania
🧚🏾	medium-dark skin tone	fairy | fairy: medium-dark skin tone | medium-dark skin tone | Oberon | Puck | Titania
🧚🏿	dark skin tone	dark skin tone | fairy | fairy: dark skin tone | Oberon | Puck | Titania
🧚‍♂️	fairy	
🧚‍♂	fairy	man fairy | Oberon | Puck
🧚🏻‍♂️	fairy: light skin tone	
🧚🏻‍♂	fairy: light skin tone	light skin tone | man fairy | man fairy: light skin tone | Oberon | Puck
🧚🏼‍♂️	fairy: medium-light skin tone	
🧚🏼‍♂	fairy: medium-light skin tone	man fairy | man fairy: medium-light skin tone | medium-light skin tone | Oberon | Puck
🧚🏽‍♂️	fairy: medium skin tone	
🧚🏽‍♂	fairy: medium skin tone	man fairy | man fairy: medium skin tone | medium skin tone | Oberon | Puck
🧚🏾‍♂️	fairy: medium-dark skin tone	
🧚🏾‍♂	fairy: medium-dark skin tone	man fairy | man fairy: medium-dark skin tone | medium-dark skin tone | Oberon | Puck
🧚🏿‍♂️	fairy: dark skin tone	
🧚🏿‍♂	fairy: dark skin tone	dark skin tone | man fairy | man fairy: dark skin tone | Oberon | Puck
🧚‍♀	fairy	Titania | woman fairy
🧚🏻‍♀️	fairy: light skin tone	
🧚🏻‍♀	fairy: light skin tone	light skin tone | Titania | woman fairy | woman fairy: light skin tone
🧚🏼‍♀️	fairy: medium-light skin tone	
🧚🏼‍♀	fairy: medium-light skin tone	medium-light skin tone | Titania | woman fairy | woman fairy: medium-light skin tone
🧚🏽‍♀️	fairy: medium skin tone	
🧚🏽‍♀	fairy: medium skin tone	medium skin tone | Titania | woman fairy | woman fairy: medium skin tone
🧚🏾‍♀️	fairy: medium-dark skin tone	
🧚🏾‍♀	fairy: medium-dark skin tone	medium-dark skin tone | Titania | woman fairy | woman fairy: medium-dark skin tone
🧚🏿‍♀️	fairy: dark skin tone	
🧚🏿‍♀	fairy: dark skin tone	dark skin tone | Titania | woman fairy | woman fairy: dark skin tone
🧛	Dracula | undead | vampire
🧛🏻	light skin tone	Dracula | light skin tone | undead | vampire | vampire: light skin tone
🧛🏼	medium-light skin tone	Dracula | medium-light skin tone | undead | vampire | vampire: medium-light skin tone
🧛🏽	medium skin tone	Dracula | medium skin tone | undead | vampire | vampire: medium skin tone
🧛🏾	medium-dark skin tone	Dracula | medium-dark skin tone | undead | vampire | vampire: medium-dark skin tone
🧛🏿	dark skin tone	dark skin tone | Dracula | undead | vampire | vampire: dark skin tone
🧛‍♂️	vampire	
🧛‍♂	vampire	Dracula | man vampire | undead
🧛🏻‍♂️	vampire: light skin tone	
🧛🏻‍♂	vampire: light skin tone	Dracula | light skin tone | man vampire | man vampire: light skin tone | undead
🧛🏼‍♂️	vampire: medium-light skin tone	
🧛🏼‍♂	vampire: medium-light skin tone	Dracula | man vampire | man vampire: medium-light skin tone | medium-light skin tone | undead
🧛🏽‍♂️	vampire: medium skin tone	
🧛🏽‍♂	vampire: medium skin tone	Dracula | man vampire | man vampire: medium skin tone | medium skin tone | undead
🧛🏾‍♂️	vampire: medium-dark skin tone	
🧛🏾‍♂	vampire: medium-dark skin tone	Dracula | man vampire | man vampire: medium-dark skin tone | medium-dark skin tone | undead
🧛🏿‍♂️	vampire: dark skin tone	
🧛🏿‍♂	vampire: dark skin tone	dark skin tone | Dracula | man vampire | man vampire: dark skin tone | undead
🧛‍♀	vampire	undead | woman vampire
🧛🏻‍♀️	vampire: light skin tone	
🧛🏻‍♀	vampire: light skin tone	light skin tone | undead | woman vampire | woman vampire: light skin tone
🧛🏼‍♀️	vampire: medium-light skin tone	
🧛🏼‍♀	vampire: medium-light skin tone	medium-light skin tone | undead | woman vampire | woman vampire: medium-light skin tone
🧛🏽‍♀️	vampire: medium skin tone	
🧛🏽‍♀	vampire: medium skin tone	medium skin tone | undead | woman vampire | woman vampire: medium skin tone
🧛🏾‍♀️	vampire: medium-dark skin tone	
🧛🏾‍♀	vampire: medium-dark skin tone	medium-dark skin tone | undead | woman vampire | woman vampire: medium-dark skin tone
🧛🏿‍♀️	vampire: dark skin tone	
🧛🏿‍♀	vampire: dark skin tone	dark skin tone | undead | woman vampire | woman vampire: dark skin tone
🧜	mermaid | merman | merperson | merwoman
🧜🏻	light skin tone	light skin tone | mermaid | merman | merperson | merperson: light skin tone | merwoman
🧜🏼	medium-light skin tone	medium-light skin tone | mermaid | merman | merperson | merperson: medium-light skin tone | merwoman
🧜🏽	medium skin tone	medium skin tone | mermaid | merman | merperson | merperson: medium skin tone | merwoman
🧜🏾	medium-dark skin tone	medium-dark skin tone | mermaid | merman | merperson | merperson: medium-dark skin tone | merwoman
🧜🏿	dark skin tone	dark skin tone | mermaid | merman | merperson | merperson: dark skin tone | merwoman
🧜‍♂	merman | Triton
🧜🏻‍♂️	light skin tone	
🧜🏻‍♂	light skin tone	light skin tone | merman | merman: light skin tone | Triton
🧜🏼‍♂️	medium-light skin tone	
🧜🏼‍♂	medium-light skin tone	medium-light skin tone | merman | merman: medium-light skin tone | Triton
🧜🏽‍♂️	medium skin tone	
🧜🏽‍♂	medium skin tone	medium skin tone | merman | merman: medium skin tone | Triton
🧜🏾‍♂️	medium-dark skin tone	
🧜🏾‍♂	medium-dark skin tone	medium-dark skin tone | merman | merman: medium-dark skin tone | Triton
🧜🏿‍♂️	dark skin tone	
🧜🏿‍♂	dark skin tone	dark skin tone | merman | merman: dark skin tone | Triton
🧜‍♀	mermaid | merwoman
🧜🏻‍♀️	light skin tone	
🧜🏻‍♀	light skin tone	light skin tone | mermaid | mermaid: light skin tone | merwoman
🧜🏼‍♀️	medium-light skin tone	
🧜🏼‍♀	medium-light skin tone	medium-light skin tone | mermaid | mermaid: medium-light skin tone | merwoman
🧜🏽‍♀️	medium skin tone	
🧜🏽‍♀	medium skin tone	medium skin tone | mermaid | mermaid: medium skin tone | merwoman
🧜🏾‍♀️	medium-dark skin tone	
🧜🏾‍♀	medium-dark skin tone	medium-dark skin tone | mermaid | mermaid: medium-dark skin tone | merwoman
🧜🏿‍♀️	dark skin tone	
🧜🏿‍♀	dark skin tone	dark skin tone | mermaid | mermaid: dark skin tone | merwoman
🧝	elf | magical
🧝🏻	light skin tone	elf | elf: light skin tone | light skin tone | magical
🧝🏼	medium-light skin tone	elf | elf: medium-light skin tone | magical | medium-light skin tone
🧝🏽	medium skin tone	elf | elf: medium skin tone | magical | medium skin tone
🧝🏾	medium-dark skin tone	elf | elf: medium-dark skin tone | magical | medium-dark skin tone
🧝🏿	dark skin tone	dark skin tone | elf | elf: dark skin tone | magical
🧝‍♂️	elf	
🧝‍♂	elf	magical | man elf
🧝🏻‍♂️	elf: light skin tone	
🧝🏻‍♂	elf: light skin tone	light skin tone | magical | man elf | man elf: light skin tone
🧝🏼‍♂️	elf: medium-light skin tone	
🧝🏼‍♂	elf: medium-light skin tone	magical | man elf | man elf: medium-light skin tone | medium-light skin tone
🧝🏽‍♂️	elf: medium skin tone	
🧝🏽‍♂	elf: medium skin tone	magical | man elf | man elf: medium skin tone | medium skin tone
🧝🏾‍♂️	elf: medium-dark skin tone	
🧝🏾‍♂	elf: medium-dark skin tone	magical | man elf | man elf: medium-dark skin tone | medium-dark skin tone
🧝🏿‍♂️	elf: dark s—kin tone	
🧝🏿‍♂	elf: dark skin tone	dark skin tone | magical | man elf | man elf: dark skin tone
🧝‍♀	elf	magical | woman elf
🧝🏻‍♀️	elf: light skin tone	
🧝🏻‍♀	elf: light skin tone	light skin tone | magical | woman elf | woman elf: light skin tone
🧝🏼‍♀️	elf: medium-light skin tone	
🧝🏼‍♀	elf: medium-light skin tone	magical | medium-light skin tone | woman elf | woman elf: medium-light skin tone
🧝🏽‍♀️	elf: medium skin tone	
🧝🏽‍♀	elf: medium skin tone	magical | medium skin tone | woman elf | woman elf: medium skin tone
🧝🏾‍♀️	elf: medium-dark skin tone	
🧝🏾‍♀	elf: medium-dark skin tone	magical | medium-dark skin tone | woman elf | woman elf: medium-dark skin tone
🧝🏿‍♀️	elf: dark skin tone	
🧝🏿‍♀	elf: dark skin tone	dark skin tone | magical | woman elf | woman elf: dark skin tone
🧞	djinn | genie
🧞‍♂️	genie	
🧞‍♂	genie	djinn | man genie
🧞‍♀️	genie	
🧞‍♀	genie	djinn | woman genie
🧟	undead | walking dead | zombie
🧟‍♂️	zombie	
🧟‍♂	zombie	man zombie | undead | walking dead
🧟‍♀️	zombie	
🧟‍♀	zombie	undead | walking dead | woman zombie
🧌	fairy tale | fantasy | monster | troll
💆	getting massage	face | massage | person getting massage | salon
💆🏻	getting massage: light skin tone	face | light skin tone | massage | person getting massage | person getting massage: light skin tone | salon
💆🏼	getting massage: medium-light skin tone	face | massage | medium-light skin tone | person getting massage | person getting massage: medium-light skin tone | salon
💆🏽	getting massage: medium skin tone	face | massage | medium skin tone | person getting massage | person getting massage: medium skin tone | salon
💆🏾	getting massage: medium-dark skin tone	face | massage | medium-dark skin tone | person getting massage | person getting massage: medium-dark skin tone | salon
💆🏿	getting massage: dark skin tone	dark skin tone | face | massage | person getting massage | person getting massage: dark skin tone | salon
💆‍♂️	getting massage	
💆‍♂	getting massage	face | man | man getting massage | massage
💆🏻‍♂️	getting massage: light skin tone	
💆🏻‍♂	getting massage: light skin tone	face | light skin tone | man | man getting massage | man getting massage: light skin tone | massage
💆🏼‍♂️	getting massage: medium-light skin tone	
💆🏼‍♂	getting massage: medium-light skin tone	face | man | man getting massage | man getting massage: medium-light skin tone | massage | medium-light skin tone
💆🏽‍♂️	getting massage: medium skin tone	
💆🏽‍♂	getting massage: medium skin tone	face | man | man getting massage | man getting massage: medium skin tone | massage | medium skin tone
💆🏾‍♂️	getting massage: medium-dark skin tone	
💆🏾‍♂	getting massage: medium-dark skin tone	face | man | man getting massage | man getting massage: medium-dark skin tone | massage | medium-dark skin tone
💆🏿‍♂️	getting massage: dark skin tone	
💆🏿‍♂	getting massage: dark skin tone	dark skin tone | face | man | man getting massage | man getting massage: dark skin tone | massage
💆‍♀️	getting massage	
💆‍♀	getting massage	face | massage | woman | woman getting massage
💆🏻‍♀️	getting massage: light skin tone	
💆🏻‍♀	getting massage: light skin tone	face | light skin tone | massage | woman | woman getting massage | woman getting massage: light skin tone
💆🏼‍♀️	getting massage: medium-light skin tone	
💆🏼‍♀	getting massage: medium-light skin tone	face | massage | medium-light skin tone | woman | woman getting massage | woman getting massage: medium-light skin tone
💆🏽‍♀️	getting massage: medium skin tone	
💆🏽‍♀	getting massage: medium skin tone	face | massage | medium skin tone | woman | woman getting massage | woman getting massage: medium skin tone
💆🏾‍♀️	getting massage: medium-dark skin tone	
💆🏾‍♀	getting massage: medium-dark skin tone	face | massage | medium-dark skin tone | woman | woman getting massage | woman getting massage: medium-dark skin tone
💆🏿‍♀️	getting massage: dark skin tone	
💆🏿‍♀	getting massage: dark skin tone	dark skin tone | face | massage | woman | woman getting massage | woman getting massage: dark skin tone
💇	getting haircut	barber | beauty | haircut | parlor | person getting haircut | parlour | salon
💇🏻	getting haircut: light skin tone	barber | beauty | haircut | light skin tone | parlor | person getting haircut | person getting haircut: light skin tone | parlour | salon
💇🏼	getting haircut: medium-light skin tone	barber | beauty | haircut | medium-light skin tone | parlor | person getting haircut | person getting haircut: medium-light skin tone | parlour | salon
💇🏽	getting haircut: medium skin tone	barber | beauty | haircut | medium skin tone | parlor | person getting haircut | person getting haircut: medium skin tone | parlour | salon
💇🏾	getting haircut: medium-dark skin tone	barber | beauty | haircut | medium-dark skin tone | parlor | person getting haircut | person getting haircut: medium-dark skin tone | parlour | salon
💇🏿	getting haircut: dark skin tone	barber | beauty | dark skin tone | haircut | parlor | person getting haircut | person getting haircut: dark skin tone | parlour | salon
💇‍♂️	getting haircut	
💇‍♂	getting haircut	haircut | man | man getting haircut | hairdresser
💇🏻‍♂️	getting haircut: light skin tone	
💇🏻‍♂	getting haircut: light skin tone	haircut | light skin tone | man | man getting haircut | man getting haircut: light skin tone | hairdresser
💇🏼‍♂️	getting haircut: medium-light skin tone	
💇🏼‍♂	getting haircut: medium-light skin tone	haircut | man | man getting haircut | man getting haircut: medium-light skin tone | medium-light skin tone | hairdresser
💇🏽‍♂️	getting haircut: medium skin tone	
💇🏽‍♂	getting haircut: medium skin tone	haircut | man | man getting haircut | man getting haircut: medium skin tone | medium skin tone | hairdresser
💇🏾‍♂️	getting haircut: medium-dark skin tone	
💇🏾‍♂	getting haircut: medium-dark skin tone	haircut | man | man getting haircut | man getting haircut: medium-dark skin tone | medium-dark skin tone | hairdresser
💇🏿‍♂️	getting haircut: dark skin tone	
💇🏿‍♂	getting haircut: dark skin tone	dark skin tone | haircut | man | man getting haircut | man getting haircut: dark skin tone | hairdresser
💇‍♀️	getting haircut	
💇‍♀	getting haircut	haircut | woman | woman getting haircut | hairdresser
💇🏻‍♀️	getting haircut: light skin tone	
💇🏻‍♀	getting haircut: light skin tone	haircut | light skin tone | woman | woman getting haircut | woman getting haircut: light skin tone | hairdresser
💇🏼‍♀️	getting haircut: medium-light skin tone	
💇🏼‍♀	getting haircut: medium-light skin tone	haircut | medium-light skin tone | woman | woman getting haircut | woman getting haircut: medium-light skin tone | hairdresser
💇🏽‍♀️	getting haircut: medium skin tone	
💇🏽‍♀	getting haircut: medium skin tone	haircut | medium skin tone | woman | woman getting haircut | woman getting haircut: medium skin tone | hairdresser
💇🏾‍♀️	getting haircut: medium-dark skin tone	
💇🏾‍♀	getting haircut: medium-dark skin tone	haircut | medium-dark skin tone | woman | woman getting haircut | woman getting haircut: medium-dark skin tone | hairdresser
💇🏿‍♀️	getting haircut: dark skin tone	
💇🏿‍♀	getting haircut: dark skin tone	dark skin tone | haircut | woman | woman getting haircut | woman getting haircut: dark skin tone | hairdresser
🚶	walking	hike | person walking | walk | walking
🚶🏻	walking: light skin tone	hike | light skin tone | person walking | person walking: light skin tone | walk | walking
🚶🏼	walking: medium-light skin tone	hike | medium-light skin tone | person walking | person walking: medium-light skin tone | walk | walking
🚶🏽	walking: medium skin tone	hike | medium skin tone | person walking | person walking: medium skin tone | walk | walking
🚶🏾	walking: medium-dark skin tone	hike | medium-dark skin tone | person walking | person walking: medium-dark skin tone | walk | walking
🚶🏿	walking: dark skin tone	dark skin tone | hike | person walking | person walking: dark skin tone | walk | walking
🚶‍♂️	walking	
🚶‍♂	walking	hike | man | man walking | walk
🚶🏻‍♂️	walking: light skin tone	
🚶🏻‍♂	walking: light skin tone	hike | light skin tone | man | man walking | man walking: light skin tone | walk
🚶🏼‍♂️	walking: medium-light skin tone	
🚶🏼‍♂	walking: medium-light skin tone	hike | man | man walking | man walking: medium-light skin tone | medium-light skin tone | walk
🚶🏽‍♂️	walking: medium skin tone	
🚶🏽‍♂	walking: medium skin tone	hike | man | man walking | man walking: medium skin tone | medium skin tone | walk
🚶🏾‍♂️	walking: medium-dark skin tone	
🚶🏾‍♂	walking: medium-dark skin tone	hike | man | man walking | man walking: medium-dark skin tone | medium-dark skin tone | walk
🚶🏿‍♂️	walking: dark skin tone	
🚶🏿‍♂	walking: dark skin tone	dark skin tone | hike | man | man walking | man walking: dark skin tone | walk
🚶‍♀️	walking	
🚶‍♀	walking	hike | walk | woman | woman walking
🚶🏻‍♀️	walking: light skin tone	
🚶🏻‍♀	walking: light skin tone	hike | light skin tone | walk | woman | woman walking | woman walking: light skin tone
🚶🏼‍♀️	walking: medium-light skin tone	
🚶🏼‍♀	walking: medium-light skin tone	hike | medium-light skin tone | walk | woman | woman walking | woman walking: medium-light skin tone
🚶🏽‍♀️	walking: medium skin tone	
🚶🏽‍♀	walking: medium skin tone	hike | medium skin tone | walk | woman | woman walking | woman walking: medium skin tone
🚶🏾‍♀️	walking: medium-dark skin tone	
🚶🏾‍♀	walking: medium-dark skin tone	hike | medium-dark skin tone | walk | woman | woman walking | woman walking: medium-dark skin tone
🚶🏿‍♀️	walking: dark skin tone	
🚶🏿‍♀	walking: dark skin tone	dark skin tone | hike | walk | woman | woman walking | woman walking: dark skin tone
🚶‍➡️	walking facing right	
🚶‍➡	walking facing right	hike | person walking | person walking facing right | walk | walking
🚶🏻‍➡️	walking facing right: light skin tone	
🚶🏻‍➡	walking facing right: light skin tone	hike | person walking | person walking facing right | walk | walking
🚶🏼‍➡️	walking facing right: medium-light skin tone	
🚶🏼‍➡	walking facing right: medium-light skin tone	hike | person walking | person walking facing right | walk | walking
🚶🏽‍➡️	walking facing right: medium skin tone	
🚶🏽‍➡	walking facing right: medium skin tone	hike | person walking | person walking facing right | walk | walking
🚶🏾‍➡️	walking facing right: medium-dark skin tone	
🚶🏾‍➡	walking facing right: medium-dark skin tone	hike | person walking | person walking facing right | walk | walking
🚶🏿‍➡️	walking facing right: dark skin tone	
🚶🏿‍➡	walking facing right: dark skin tone	hike | person walking | person walking facing right | walk | walking
🚶‍♀️‍➡️	walking facing right	
🚶‍♀‍➡	walking facing right	hike | walk | woman | woman walking | woman walking facing right
🚶🏻‍♀️‍➡️	walking facing right: light skin tone	
🚶🏻‍♀‍➡	walking facing right: light skin tone	hike | walk | woman | woman walking | woman walking facing right
🚶🏼‍♀️‍➡️	walking facing right: medium-light skin tone	
🚶🏼‍♀‍➡	walking facing right: medium-light skin tone	hike | walk | woman | woman walking | woman walking facing right
🚶🏽‍♀️‍➡️	walking facing right: medium skin tone	
🚶🏽‍♀‍➡	walking facing right: medium skin tone	hike | walk | woman | woman walking | woman walking facing right
🚶🏾‍♀️‍➡️	walking facing right: medium-dark skin tone	
🚶🏾‍♀‍➡	walking facing right: medium-dark skin tone	hike | walk | woman | woman walking | woman walking facing right
🚶🏿‍♀️‍➡️	walking facing right: dark skin tone	
🚶🏿‍♀‍➡	walking facing right: dark skin tone	hike | walk | woman | woman walking | woman walking facing right
🚶‍♂️‍➡️	walking facing right	
🚶‍♂‍➡	walking facing right	hike | man | man walking | man walking facing right | walk
🚶🏻‍♂️‍➡️	walking facing right: light skin tone	
🚶🏻‍♂‍➡	walking facing right: light skin tone	hike | man | man walking | man walking facing right | walk
🚶🏼‍♂️‍➡️	walking facing right: medium-light skin tone	
🚶🏼‍♂‍➡	walking facing right: medium-light skin tone	hike | man | man walking | man walking facing right | walk
🚶🏽‍♂️‍➡️	walking facing right: medium skin tone	
🚶🏽‍♂‍➡	walking facing right: medium skin tone	hike | man | man walking | man walking facing right | walk
🚶🏾‍♂️‍➡️	walking facing right: medium-dark skin tone	
🚶🏾‍♂‍➡	walking facing right: medium-dark skin tone	hike | man | man walking | man walking facing right | walk
🚶🏿‍♂️‍➡️	walking facing right: dark skin tone	
🚶🏿‍♂‍➡	walking facing right: dark skin tone	hike | man | man walking | man walking facing right | walk
🧍	standing	person standing | stand | standing
🧍🏻	standing: light skin tone	light skin tone | person standing | person standing: light skin tone | stand | standing
🧍🏼	standing: medium-light skin tone	medium-light skin tone | person standing | person standing: medium-light skin tone | stand | standing
🧍🏽	standing: medium skin tone	medium skin tone | person standing | person standing: medium skin tone | stand | standing
🧍🏾	standing: medium-dark skin tone	medium-dark skin tone | person standing | person standing: medium-dark skin tone | stand | standing
🧍🏿	standing: dark skin tone	dark skin tone | person standing | person standing: dark skin tone | stand | standing
🧍‍♂️	standing	—
🧍‍♂	standing	man | standing
🧍🏻‍♂️	standing: light skin tone	
🧍🏻‍♂	standing: light skin tone	light skin tone | man | man standing: light skin tone | standing
🧍🏼‍♂️	standing: medium-light skin tone	
🧍🏼‍♂	standing: medium-light skin tone	man | man standing: medium-light skin tone | medium-light skin tone | standing
🧍🏽‍♂️	standing: medium skin tone	
🧍🏽‍♂	standing: medium skin tone	man | man standing: medium skin tone | medium skin tone | standing
🧍🏾‍♂️	standing: medium-dark skin tone	
🧍🏾‍♂	standing: medium-dark skin tone	man | man standing: medium-dark skin tone | medium-dark skin tone | standing
🧍🏿‍♂️	standing: dark skin tone	
🧍🏿‍♂	standing: dark skin tone	dark skin tone | man | man standing: dark skin tone | standing
🧍‍♀️	standing	
🧍‍♀	standing	standing | woman
🧍🏻‍♀️	standing: light skin tone	
🧍🏻‍♀	standing: light skin tone	light skin tone | standing | woman | woman standing: light skin tone
🧍🏼‍♀️	standing: medium-light skin tone	
🧍🏼‍♀	standing: medium-light skin tone	medium-light skin tone | standing | woman | woman standing: medium-light skin tone
🧍🏽‍♀️	standing: medium skin tone	
🧍🏽‍♀	standing: medium skin tone	medium skin tone | standing | woman | woman standing: medium skin tone
🧍🏾‍♀️	standing: medium-dark skin tone	
🧍🏾‍♀	standing: medium-dark skin tone	medium-dark skin tone | standing | woman | woman standing: medium-dark skin tone
🧍🏿‍♀️	standing: dark skin tone	
🧍🏿‍♀	standing: dark skin tone	dark skin tone | standing | woman | woman standing: dark skin tone
🧎	kneeling	kneel | kneeling | person kneeling
🧎🏻	kneeling: light skin tone	kneel | kneeling | light skin tone | person kneeling | person kneeling: light skin tone
🧎🏼	kneeling: medium-light skin tone	kneel | kneeling | medium-light skin tone | person kneeling | person kneeling: medium-light skin tone
🧎🏽	kneeling: medium skin tone	kneel | kneeling | medium skin tone | person kneeling | person kneeling: medium skin tone
🧎🏾	kneeling: medium-dark skin tone	kneel | kneeling | medium-dark skin tone | person kneeling | person kneeling: medium-dark skin tone
🧎🏿	kneeling: dark skin tone	dark skin tone | kneel | kneeling | person kneeling | person kneeling: dark skin tone
🧎‍♂️	kneeling	
🧎‍♂	kneeling	kneeling | man
🧎🏻‍♂️	kneeling: light skin tone	
🧎🏻‍♂	kneeling: light skin tone	kneeling | light skin tone | man | man kneeling: light skin tone
🧎🏼‍♂️	kneeling: medium-light skin tone	
🧎🏼‍♂	kneeling: medium-light skin tone	kneeling | man | man kneeling: medium-light skin tone | medium-light skin tone
🧎🏽‍♂️	kneeling: medium skin tone	
🧎🏽‍♂	kneeling: medium skin tone	kneeling | man | man kneeling: medium skin tone | medium skin tone
🧎🏾‍♂️	kneeling: medium-dark skin tone	
🧎🏾‍♂	kneeling: medium-dark skin tone	kneeling | man | man kneeling: medium-dark skin tone | medium-dark skin tone
🧎🏿‍♂️	kneeling: dark skin tone	
🧎🏿‍♂	kneeling: dark skin tone	dark skin tone | kneeling | man | man kneeling: dark skin tone
🧎‍♀️	kneeling	
🧎‍♀	kneeling	kneeling | woman
🧎🏻‍♀️	kneeling: light skin tone	
🧎🏻‍♀	kneeling: light skin tone	kneeling | light skin tone | woman | woman kneeling: light skin tone
🧎🏼‍♀️	kneeling: medium-light skin tone	
🧎🏼‍♀	kneeling: medium-light skin tone	kneeling | medium-light skin tone | woman | woman kneeling: medium-light skin tone
🧎🏽‍♀️	kneeling: medium skin tone	
🧎🏽‍♀	kneeling: medium skin tone	kneeling | medium skin tone | woman | woman kneeling: medium skin tone
🧎🏾‍♀️	kneeling: medium-dark skin tone	
🧎🏾‍♀	kneeling: medium-dark skin tone	kneeling | medium-dark skin tone | woman | woman kneeling: medium-dark skin tone
🧎🏿‍♀️	kneeling: dark skin tone	
🧎🏿‍♀	kneeling: dark skin tone	dark skin tone | kneeling | woman | woman kneeling: dark skin tone
🧎‍➡️	kneeling facing right	
🧎‍➡	kneeling facing right	kneel | kneeling | person kneeling | person kneeling facing right
🧎🏻‍➡️	kneeling facing right: light skin tone	
🧎🏻‍➡	kneeling facing right: light skin tone	kneel | kneeling | person kneeling | person kneeling facing right
🧎🏼‍➡️	kneeling facing right: medium-light skin tone	
🧎🏼‍➡	kneeling facing right: medium-light skin tone	kneel | kneeling | person kneeling | person kneeling facing right
🧎🏽‍➡️	kneeling facing right: medium skin tone	
🧎🏽‍➡	kneeling facing right: medium skin tone	kneel | kneeling | person kneeling | person kneeling facing right
🧎🏾‍➡️	kneeling facing right: medium-dark skin tone	
🧎🏾‍➡	kneeling facing right: medium-dark skin tone	kneel | kneeling | person kneeling | person kneeling facing right
🧎🏿‍➡️	kneeling facing right: dark skin tone	
🧎🏿‍➡	kneeling facing right: dark skin tone	kneel | kneeling | person kneeling | person kneeling facing right
🧎‍♀️‍➡️	kneeling facing right	
🧎‍♀‍➡	kneeling facing right	kneeling | woman | woman kneeling facing right
🧎🏻‍♀️‍➡️	kneeling facing right: light skin tone	
🧎🏻‍♀‍➡	kneeling facing right: light skin tone	kneeling | woman | woman kneeling facing right
🧎🏼‍♀️‍➡️	kneeling facing right: medium-light skin tone	
🧎🏼‍♀‍➡	kneeling facing right: medium-light skin tone	kneeling | woman | woman kneeling facing right
🧎🏽‍♀️‍➡️	kneeling facing right: medium skin tone	
🧎🏽‍♀‍➡	kneeling facing right: medium skin tone	kneeling | woman | woman kneeling facing right
🧎🏾‍♀️‍➡️	kneeling facing right: medium-dark skin tone	
🧎🏾‍♀‍➡	kneeling facing right: medium-dark skin tone	kneeling | woman | woman kneeling facing right
🧎🏿‍♀️‍➡️	kneeling facing right: dark skin tone	
🧎🏿‍♀‍➡	kneeling facing right: dark skin tone	kneeling | woman | woman kneeling facing right
🧎‍♂️‍➡️	kneeling facing right	
🧎‍♂‍➡	kneeling facing right	kneeling | man | man kneeling facing right
🧎🏻‍♂️‍➡️	kneeling facing right: light skin tone	
🧎🏻‍♂‍➡	kneeling facing right: light skin tone	kneeling | man | man kneeling facing right
🧎🏼‍♂️‍➡️	kneeling facing right: medium-light skin tone	
🧎🏼‍♂‍➡	kneeling facing right: medium-light skin tone	kneeling | man | man kneeling facing right
🧎🏽‍♂️‍➡️	kneeling facing right: medium skin tone	
🧎🏽‍♂‍➡	kneeling facing right: medium skin tone	kneeling | man | man kneeling facing right
🧎🏾‍♂️‍➡️	kneeling facing right: medium-dark skin tone	
🧎🏾‍♂‍➡	kneeling facing right: medium-dark skin tone	kneeling | man | man kneeling facing right
🧎🏿‍♂️‍➡️	kneeling facing right: dark skin tone	
🧎🏿‍♂‍➡	kneeling facing right: dark skin tone	kneeling | man | man kneeling facing right
🧑‍🦯	with white cane	accessibility | blind | person with white cane | person with guide cane | person with long mobility cane
🧑🏻‍🦯	with white cane: light skin tone	accessibility | blind | light skin tone | person with white cane | person with white cane: light skin tone | person with guide cane | person with guide cane: light skin tone | person with long mobility cane | person with long mobility cane: light skin tone
🧑🏼‍🦯	with white cane: medium-light skin tone	accessibility | blind | medium-light skin tone | person with white cane | person with white cane: medium-light skin tone | person with guide cane | person with guide cane: medium-light skin tone | person with long mobility cane | person with long mobility cane: medium-light skin tone
🧑🏽‍🦯	with white cane: medium skin tone	accessibility | blind | medium skin tone | person with white cane | person with white cane: medium skin tone | person with guide cane | person with guide cane: medium skin tone | person with long mobility cane | person with long mobility cane: medium skin tone
🧑🏾‍🦯	with white cane: medium-dark skin tone	accessibility | blind | medium-dark skin tone | person with white cane | person with white cane: medium-dark skin tone | person with guide cane | person with guide cane: medium-dark skin tone | person with long mobility cane | person with long mobility cane: medium-dark skin tone
🧑🏿‍🦯	with white cane: dark skin tone	accessibility | blind | dark skin tone | person with white cane | person with white cane: dark skin tone | person with guide cane | person with guide cane: dark skin tone | person with long mobility cane | person with long mobility cane: dark skin tone
🧑‍🦯‍➡️	with white cane facing right	
🧑‍🦯‍➡	with white cane facing right	accessibility | blind | person with white cane | person with white cane facing right | person with guide cane | person with guide cane facing right | person with long mobility cane | person with long mobility cane facing right
🧑🏻‍🦯‍➡️	with white cane facing right: light skin tone	
🧑🏻‍🦯‍➡	with white cane facing right: light skin tone	accessibility | blind | person with white cane | person with white cane facing right | person with guide cane | person with guide cane facing right | person with long mobility cane | person with long mobility cane facing right
🧑🏼‍🦯‍➡️	with white cane facing right: medium-light skin tone	
🧑🏼‍🦯‍➡	with white cane facing right: medium-light skin tone	accessibility | blind | person with white cane | person with white cane facing right | person with guide cane | person with guide cane facing right | person with long mobility cane | person with long mobility cane facing right
🧑🏽‍🦯‍➡️	with white cane facing right: medium skin tone	
🧑🏽‍🦯‍➡	with white cane facing right: medium skin tone	accessibility | blind | person with white cane | person with white cane facing right | person with guide cane | person with guide cane facing right | person with long mobility cane | person with long mobility cane facing right
🧑🏾‍🦯‍➡️	with white cane facing right: medium-dark skin tone	
🧑🏾‍🦯‍➡	with white cane facing right: medium-dark skin tone	accessibility | blind | person with white cane | person with white cane facing right | person with guide cane | person with guide cane facing right | person with long mobility cane | person with long mobility cane facing right
🧑🏿‍🦯‍➡️	with white cane facing right: dark skin tone	
🧑🏿‍🦯‍➡	with white cane facing right: dark skin tone	accessibility | blind | person with white cane | person with white cane facing right | person with guide cane | person with guide cane facing right | person with long mobility cane | person with long mobility cane facing right
👨‍🦯	with white cane	accessibility | blind | man | man with white cane | man with guide cane
👨🏻‍🦯	with white cane: light skin tone	accessibility | blind | light skin tone | man | man with white cane | man with white cane: light skin tone | man with guide cane | man with guide cane: light skin tone
👨🏼‍🦯	with white cane: medium-light skin tone	accessibility | blind | man | man with white cane | man with white cane: medium-light skin tone | medium-light skin tone | man with guide cane | man with guide cane: medium-light skin tone
👨🏽‍🦯	with white cane: medium skin tone	accessibility | blind | man | man with white cane | man with white cane: medium skin tone | medium skin tone | man with guide cane | man with guide cane: medium skin tone
👨🏾‍🦯	with white cane: medium-dark skin tone	accessibility | blind | man | man with white cane | man with white cane: medium-dark skin tone | medium-dark skin tone | man with guide cane | man with guide cane: medium-dark skin tone
👨🏿‍🦯	with white cane: dark skin tone	accessibility | blind | dark skin tone | man | man with white cane | man with white cane: dark skin tone | man with guide cane | man with guide cane: dark skin tone
👨‍🦯‍➡️	with white cane facing right	
👨‍🦯‍➡	with white cane facing right	accessibility | blind | man | man with white cane | man with white cane facing right | man with guide cane | man with guide cane facing right
👨🏻‍🦯‍➡️	with white cane facing right: light skin tone	
👨🏻‍🦯‍➡	with white cane facing right: light skin tone	accessibility | blind | man | man with white cane | man with white cane facing right | man with guide cane | man with guide cane facing right
👨🏼‍🦯‍➡️	with white cane facing right: medium-light skin tone	
👨🏼‍🦯‍➡	with white cane facing right: medium-light skin tone	accessibility | blind | man | man with white cane | man with white cane facing right | man with guide cane | man with guide cane facing right
👨🏽‍🦯‍➡️	with white cane facing right: medium skin tone	
👨🏽‍🦯‍➡	with white cane facing right: medium skin tone	accessibility | blind | man | man with white cane | man with white cane facing right | man with guide cane | man with guide cane facing right
👨🏾‍🦯‍➡️	with white cane facing right: medium-dark skin tone	
👨🏾‍🦯‍➡	with white cane facing right: medium-dark skin tone	accessibility | blind | man | man with white cane | man with white cane facing right | man with guide cane | man with guide cane facing right
👨🏿‍🦯‍➡️	with white cane facing right: dark skin tone	
👨🏿‍🦯‍➡	with white cane facing right: dark skin tone	accessibility | blind | man | man with white cane | man with white cane facing right | man with guide cane | man with guide cane facing right
👩‍🦯	with white cane	accessibility | blind | woman | woman with white cane | woman with guide cane
👩🏻‍🦯	with white cane: light skin tone	accessibility | blind | light skin tone | woman | woman with white cane | woman with white cane: light skin tone | woman with guide cane | woman with guide cane: light skin tone
👩🏼‍🦯	with white cane: medium-light skin tone	accessibility | blind | medium-light skin tone | woman | woman with white cane | woman with white cane: medium-light skin tone | woman with guide cane | woman with guide cane: medium-light skin tone
👩🏽‍🦯	with white cane: medium skin tone	accessibility | blind | medium skin tone | woman | woman with white cane | woman with white cane: medium skin tone | woman with guide cane | woman with guide cane: medium skin tone
👩🏾‍🦯	with white cane: medium-dark skin tone	accessibility | blind | medium-dark skin tone | woman | woman with white cane | woman with white cane: medium-dark skin tone | woman with guide cane | woman with guide cane: medium-dark skin tone
👩🏿‍🦯	with white cane: dark skin tone	accessibility | blind | dark skin tone | woman | woman with white cane | woman with white cane: dark skin tone | woman with guide cane | woman with guide cane: dark skin tone
👩‍🦯‍➡️	with white cane facing right	
👩‍🦯‍➡	with white cane facing right	accessibility | blind | woman | woman with white cane | woman with white cane facing right | woman with guide cane | woman with guide cane facing right
👩🏻‍🦯‍➡️	with white cane facing right: light skin tone	
👩🏻‍🦯‍➡	with white cane facing right: light skin tone	accessibility | blind | woman | woman with white cane | woman with white cane facing right | woman with guide cane | woman with guide cane facing right
👩🏼‍🦯‍➡️	with white cane facing right: medium-light skin tone	
👩🏼‍🦯‍➡	with white cane facing right: medium-light skin tone	accessibility | blind | woman | woman with white cane | woman with white cane facing right | woman with guide cane | woman with guide cane facing right
👩🏽‍🦯‍➡️	with white cane facing right: medium skin tone	
👩🏽‍🦯‍➡	with white cane facing right: medium skin tone	accessibility | blind | woman | woman with white cane | woman with white cane facing right | woman with guide cane | woman with guide cane facing right
👩🏾‍🦯‍➡️	with white cane facing right: medium-dark skin tone	
👩🏾‍🦯‍➡	with white cane facing right: medium-dark skin tone	accessibility | blind | woman | woman with white cane | woman with white cane facing right | woman with guide cane | woman with guide cane facing right
👩🏿‍🦯‍➡️	with white cane facing right: dark skin tone	
👩🏿‍🦯‍➡	with white cane facing right: dark skin tone	accessibility | blind | woman | woman with white cane | woman with white cane facing right | woman with guide cane | woman with guide cane facing right
🧑‍🦼	in motorized wheelchair	accessibility | person in motorized wheelchair | wheelchair | person in powered wheelchair | electric wheelchair | person in motorised wheelchair
🧑🏻‍🦼	in motorized wheelchair: light skin tone	accessibility | light skin tone | person in motorized wheelchair | person in motorized wheelchair: light skin tone | wheelchair | person in powered wheelchair | person in powered wheelchair: light skin tone | electric wheelchair | person in motorised wheelchair | person in motorised wheelchair: light skin tone
🧑🏼‍🦼	in motorized wheelchair: medium-light skin tone	accessibility | medium-light skin tone | person in motorized wheelchair | person in motorized wheelchair: medium-light skin tone | wheelchair | person in powered wheelchair | person in powered wheelchair: medium-light skin tone | electric wheelchair | person in motorised wheelchair | person in motorised wheelchair: medium-light skin tone
🧑🏽‍🦼	in motorized wheelchair: medium skin tone	accessibility | medium skin tone | person in motorized wheelchair | person in motorized wheelchair: medium skin tone | wheelchair | person in powered wheelchair | person in powered wheelchair: medium skin tone | electric wheelchair | person in motorised wheelchair | person in motorised wheelchair: medium skin tone
🧑🏾‍🦼	in motorized wheelchair: medium-dark skin tone	accessibility | medium-dark skin tone | person in motorized wheelchair | person in motorized wheelchair: medium-dark skin tone | wheelchair | person in powered wheelchair | person in powered wheelchair: medium-dark skin tone | electric wheelchair | person in motorised wheelchair | person in motorised wheelchair: medium-dark skin tone
🧑🏿‍🦼	in motorized wheelchair: dark skin tone	accessibility | dark skin tone | person in motorized wheelchair | person in motorized wheelchair: dark skin tone | wheelchair | person in powered wheelchair | person in powered wheelchair: dark skin tone | electric wheelchair | person in motorised wheelchair | person in motorised wheelchair: dark skin tone
🧑‍🦼‍➡️	in motorized wheelchair facing right	
🧑‍🦼‍➡	in motorized wheelchair facing right	accessibility | person in motorized wheelchair | person in motorized wheelchair facing right | wheelchair | person in powered wheelchair | person in powered wheelchair facing right | electric wheelchair | person in motorised wheelchair | person in motorised wheelchair facing right
🧑🏻‍🦼‍➡️	in motorized wheelchair facing right: light skin tone	
🧑🏻‍🦼‍➡	in motorized wheelchair facing right: light skin tone	accessibility | person in motorized wheelchair | person in motorized wheelchair facing right | wheelchair | person in powered wheelchair | person in powered wheelchair facing right | electric wheelchair | person in motorised wheelchair | person in motorised wheelchair facing right
🧑🏼‍🦼‍➡️	in motorized wheelchair facing right: medium-light skin tone	
🧑🏼‍🦼‍➡	in motorized wheelchair facing right: medium-light skin tone	accessibility | person in motorized wheelchair | person in motorized wheelchair facing right | wheelchair | person in powered wheelchair | person in powered wheelchair facing right | electric wheelchair | person in motorised wheelchair | person in motorised wheelchair facing right
🧑🏽‍🦼‍➡️	in motorized wheelchair facing right: medium skin tone	
🧑🏽‍🦼‍➡	in motorized wheelchair facing right: medium skin tone	accessibility | person in motorized wheelchair | person in motorized wheelchair facing right | wheelchair | person in powered wheelchair | person in powered wheelchair facing right | electric wheelchair | person in motorised wheelchair | person in motorised wheelchair facing right
🧑🏾‍🦼‍➡️	in motorized wheelchair facing right: medium-dark skin tone	
🧑🏾‍🦼‍➡	in motorized wheelchair facing right: medium-dark skin tone	accessibility | person in motorized wheelchair | person in motorized wheelchair facing right | wheelchair | person in powered wheelchair | person in powered wheelchair facing right | electric wheelchair | person in motorised wheelchair | person in motorised wheelchair facing right
🧑🏿‍🦼‍➡️	in motorized wheelchair facing right: dark skin tone	
🧑🏿‍🦼‍➡	in motorized wheelchair facing right: dark skin tone	accessibility | person in motorized wheelchair | person in motorized wheelchair facing right | wheelchair | person in powered wheelchair | person in powered wheelchair facing right | electric wheelchair | person in motorised wheelchair | person in motorised wheelchair facing right
👨‍🦼	in motorized wheelchair	accessibility | man | man in motorized wheelchair | wheelchair | man in powered wheelchair | electric wheelchair | man in motorised wheelchair
👨🏻‍🦼	in motorized wheelchair: light skin tone	accessibility | light skin tone | man | man in motorized wheelchair | man in motorized wheelchair: light skin tone | wheelchair | man in powered wheelchair | man in powered wheelchair: light skin tone | electric wheelchair | man in motorised wheelchair | man in motorised wheelchair: light skin tone
👨🏼‍🦼	in motorized wheelchair: medium-light skin tone	accessibility | man | man in motorized wheelchair | man in motorized wheelchair: medium-light skin tone | medium-light skin tone | wheelchair | man in powered wheelchair | man in powered wheelchair: medium-light skin tone | electric wheelchair | man in motorised wheelchair | man in motorised wheelchair: medium-light skin tone
👨🏽‍🦼	in motorized wheelchair: medium skin tone	accessibility | man | man in motorized wheelchair | man in motorized wheelchair: medium skin tone | medium skin tone | wheelchair | man in powered wheelchair | man in powered wheelchair: medium skin tone | electric wheelchair | man in motorised wheelchair | man in motorised wheelchair: medium skin tone
👨🏾‍🦼	in motorized wheelchair: medium-dark skin tone	accessibility | man | man in motorized wheelchair | man in motorized wheelchair: medium-dark skin tone | medium-dark skin tone | wheelchair | man in powered wheelchair | man in powered wheelchair: medium-dark skin tone | electric wheelchair | man in motorised wheelchair | man in motorised wheelchair: medium-dark skin tone
👨🏿‍🦼	in motorized wheelchair: dark skin tone	accessibility | dark skin tone | man | man in motorized wheelchair | man in motorized wheelchair: dark skin tone | wheelchair | man in powered wheelchair | man in powered wheelchair: dark skin tone | electric wheelchair | man in motorised wheelchair | man in motorised wheelchair: dark skin tone
👨‍🦼‍➡️	in motorized wheelchair facing right	
👨‍🦼‍➡	in motorized wheelchair facing right	accessibility | man | man in motorized wheelchair | man in motorized wheelchair facing right | wheelchair | man in powered wheelchair | man in powered wheelchair facing right | electric wheelchair | man in motorised wheelchair | man in motorised wheelchair facing right
👨🏻‍🦼‍➡️	in motorized wheelchair facing right: light skin tone	
👨🏻‍🦼‍➡	in motorized wheelchair facing right: light skin tone	accessibility | man | man in motorized wheelchair | man in motorized wheelchair facing right | wheelchair | man in powered wheelchair | man in powered wheelchair facing right | electric wheelchair | man in motorised wheelchair | man in motorised wheelchair facing right
👨🏼‍🦼‍➡️	in motorized wheelchair facing right: medium-light skin tone	
👨🏼‍🦼‍➡	in motorized wheelchair facing right: medium-light skin tone	accessibility | man | man in motorized wheelchair | man in motorized wheelchair facing right | wheelchair | man in powered wheelchair | man in powered wheelchair facing right | electric wheelchair | man in motorised wheelchair | man in motorised wheelchair facing right
👨🏽‍🦼‍➡️	in motorized wheelchair facing right: medium skin tone	
👨🏽‍🦼‍➡	in motorized wheelchair facing right: medium skin tone	accessibility | man | man in motorized wheelchair | man in motorized wheelchair facing right | wheelchair | man in powered wheelchair | man in powered wheelchair facing right | electric wheelchair | man in motorised wheelchair | man in motorised wheelchair facing right
👨🏾‍🦼‍➡️	in motorized wheelchair facing right: medium-dark skin tone	
👨🏾‍🦼‍➡	in motorized wheelchair facing right: medium-dark skin tone	accessibility | man | man in motorized wheelchair | man in motorized wheelchair facing right | wheelchair | man in powered wheelchair | man in powered wheelchair facing right | electric wheelchair | man in motorised wheelchair | man in motorised wheelchair facing right
👨🏿‍🦼‍➡️	in motorized wheelchair facing right: dark skin tone	
👨🏿‍🦼‍➡	in motorized wheelchair facing right: dark skin tone	accessibility | man | man in motorized wheelchair | man in motorized wheelchair facing right | wheelchair | man in powered wheelchair | man in powered wheelchair facing right | electric wheelchair | man in motorised wheelchair | man in motorised wheelchair facing right
👩‍🦼	in motorized wheelchair	accessibility | wheelchair | woman | woman in motorized wheelchair | woman in powered wheelchair | electric wheelchair | woman in motorised wheelchair
👩🏻‍🦼	in motorized wheelchair: light skin tone	accessibility | light skin tone | wheelchair | woman | woman in motorized wheelchair | woman in motorized wheelchair: light skin tone | woman in powered wheelchair | woman in powered wheelchair: light skin tone | electric wheelchair | woman in motorised wheelchair | woman in motorised wheelchair: light skin tone
👩🏼‍🦼	in motorized wheelchair: medium-light skin tone	accessibility | medium-light skin tone | wheelchair | woman | woman in motorized wheelchair | woman in motorized wheelchair: medium-light skin tone | woman in powered wheelchair | woman in powered wheelchair: medium-light skin tone | electric wheelchair | woman in motorised wheelchair | woman in motorised wheelchair: medium-light skin tone
👩🏽‍🦼	in motorized wheelchair: medium skin tone	accessibility | medium skin tone | wheelchair | woman | woman in motorized wheelchair | woman in motorized wheelchair: medium skin tone | woman in powered wheelchair | woman in powered wheelchair: medium skin tone | electric wheelchair | woman in motorised wheelchair | woman in motorised wheelchair: medium skin tone
👩🏾‍🦼	in motorized wheelchair: medium-dark skin tone	accessibility | medium-dark skin tone | wheelchair | woman | woman in motorized wheelchair | woman in motorized wheelchair: medium-dark skin tone | woman in powered wheelchair | woman in powered wheelchair: medium-dark skin tone | electric wheelchair | woman in motorised wheelchair | woman in motorised wheelchair: medium-dark skin tone
👩🏿‍🦼	in motorized wheelchair: dark skin tone	accessibility | dark skin tone | wheelchair | woman | woman in motorized wheelchair | woman in motorized wheelchair: dark skin tone | woman in powered wheelchair | woman in powered wheelchair: dark skin tone | electric wheelchair | woman in motorised wheelchair | woman in motorised wheelchair: dark skin tone
👩‍🦼‍➡️	in motorized wheelchair facing right	
👩‍🦼‍➡	in motorized wheelchair facing right	accessibility | wheelchair | woman | woman in motorized wheelchair | woman in motorized wheelchair facing right | woman in powered wheelchair | woman in powered wheelchair facing right | electric wheelchair | woman in motorised wheelchair | woman in motorised wheelchair facing right
👩🏻‍🦼‍➡️	in motorized wheelchair facing right: light skin tone	
👩🏻‍🦼‍➡	in motorized wheelchair facing right: light skin tone	accessibility | wheelchair | woman | woman in motorized wheelchair | woman in motorized wheelchair facing right | woman in powered wheelchair | woman in powered wheelchair facing right | electric wheelchair | woman in motorised wheelchair | woman in motorised wheelchair facing right
👩🏼‍🦼‍➡️	in motorized wheelchair facing right: medium-light skin tone	
👩🏼‍🦼‍➡	in motorized wheelchair facing right: medium-light skin tone	accessibility | wheelchair | woman | woman in motorized wheelchair | woman in motorized wheelchair facing right | woman in powered wheelchair | woman in powered wheelchair facing right | electric wheelchair | woman in motorised wheelchair | woman in motorised wheelchair facing right
👩🏽‍🦼‍➡️	in motorized wheelchair facing right: medium skin tone	
👩🏽‍🦼‍➡	in motorized wheelchair facing right: medium skin tone	accessibility | wheelchair | woman | woman in motorized wheelchair | woman in motorized wheelchair facing right | woman in powered wheelchair | woman in powered wheelchair facing right | electric wheelchair | woman in motorised wheelchair | woman in motorised wheelchair facing right
👩🏾‍🦼‍➡️	in motorized wheelchair facing right: medium-dark skin tone	
👩🏾‍🦼‍➡	in motorized wheelchair facing right: medium-dark skin tone	accessibility | wheelchair | woman | woman in motorized wheelchair | woman in motorized wheelchair facing right | woman in powered wheelchair | woman in powered wheelchair facing right | electric wheelchair | woman in motorised wheelchair | woman in motorised wheelchair facing right
👩🏿‍🦼‍➡️	in motorized wheelchair facing right: dark skin tone	
👩🏿‍🦼‍➡	in motorized wheelchair facing right: dark skin tone	accessibility | wheelchair | woman | woman in motorized wheelchair | woman in motorized wheelchair facing right | woman in powered wheelchair | woman in powered wheelchair facing right | electric wheelchair | woman in motorised wheelchair | woman in motorised wheelchair facing right
🧑‍🦽	in manual wheelchair	accessibility | person in manual wheelchair | wheelchair
🧑🏻‍🦽	in manual wheelchair: light skin tone	accessibility | light skin tone | person in manual wheelchair | person in manual wheelchair: light skin tone | wheelchair
🧑🏼‍🦽	in manual wheelchair: medium-light skin tone	accessibility | medium-light skin tone | person in manual wheelchair | person in manual wheelchair: medium-light skin tone | wheelchair
🧑🏽‍🦽	in manual wheelchair: medium skin tone	accessibility | medium skin tone | person in manual wheelchair | person in manual wheelchair: medium skin tone | wheelchair
🧑🏾‍🦽	in manual wheelchair: medium-dark skin tone	accessibility | medium-dark skin tone | person in manual wheelchair | person in manual wheelchair: medium-dark skin tone | wheelchair
🧑🏿‍🦽	in manual wheelchair: dark skin tone	accessibility | dark skin tone | person in manual wheelchair | person in manual wheelchair: dark skin tone | wheelchair
🧑‍🦽‍➡️	in manual wheelchair facing right	
🧑‍🦽‍➡	in manual wheelchair facing right	accessibility | person in manual wheelchair | person in manual wheelchair facing right | wheelchair
🧑🏻‍🦽‍➡️	in manual wheelchair facing right: light skin tone	
🧑🏻‍🦽‍➡	in manual wheelchair facing right: light skin tone	accessibility | person in manual wheelchair | person in manual wheelchair facing right | wheelchair
🧑🏼‍🦽‍➡️	in manual wheelchair facing right: medium-light skin tone	
🧑🏼‍🦽‍➡	in manual wheelchair facing right: medium-light skin tone	accessibility | person in manual wheelchair | person in manual wheelchair facing right | wheelchair
🧑🏽‍🦽‍➡️	in manual wheelchair facing right: medium skin tone	
🧑🏽‍🦽‍➡	in manual wheelchair facing right: medium skin tone	accessibility | person in manual wheelchair | person in manual wheelchair facing right | wheelchair
🧑🏾‍🦽‍➡️	in manual wheelchair facing right: medium-dark skin tone	
🧑🏾‍🦽‍➡	in manual wheelchair facing right: medium-dark skin tone	accessibility | person in manual wheelchair | person in manual wheelchair facing right | wheelchair
🧑🏿‍🦽‍➡️	in manual wheelchair facing right: dark skin tone	
🧑🏿‍🦽‍➡	in manual wheelchair facing right: dark skin tone	accessibility | person in manual wheelchair | person in manual wheelchair facing right | wheelchair
👨‍🦽	in manual wheelchair	accessibility | man | man in manual wheelchair | wheelchair
👨🏻‍🦽	in manual wheelchair: light skin tone	accessibility | light skin tone | man | man in manual wheelchair | man in manual wheelchair: light skin tone | wheelchair
👨🏼‍🦽	in manual wheelchair: medium-light skin tone	accessibility | man | man in manual wheelchair | man in manual wheelchair: medium-light skin tone | medium-light skin tone | wheelchair
👨🏽‍🦽	in manual wheelchair: medium skin tone	accessibility | man | man in manual wheelchair | man in manual wheelchair: medium skin tone | medium skin tone | wheelchair
👨🏾‍🦽	in manual wheelchair: medium-dark skin tone	accessibility | man | man in manual wheelchair | man in manual wheelchair: medium-dark skin tone | medium-dark skin tone | wheelchair
👨🏿‍🦽	in manual wheelchair: dark skin tone	accessibility | dark skin tone | man | man in manual wheelchair | man in manual wheelchair: dark skin tone | wheelchair
👨‍🦽‍➡️	in manual wheelchair facing right	
👨‍🦽‍➡	in manual wheelchair facing right	accessibility | man | man in manual wheelchair | man in manual wheelchair facing right | wheelchair
👨🏻‍🦽‍➡️	in manual wheelchair facing right: light skin tone	
👨🏻‍🦽‍➡	in manual wheelchair facing right: light skin tone	accessibility | man | man in manual wheelchair | man in manual wheelchair facing right | wheelchair
👨🏼‍🦽‍➡️	in manual wheelchair facing right: medium-light skin tone	
👨🏼‍🦽‍➡	in manual wheelchair facing right: medium-light skin tone	accessibility | man | man in manual wheelchair | man in manual wheelchair facing right | wheelchair
👨🏽‍🦽‍➡️	in manual wheelchair facing right: medium skin tone	
👨🏽‍🦽‍➡	in manual wheelchair facing right: medium skin tone	accessibility | man | man in manual wheelchair | man in manual wheelchair facing right | wheelchair
👨🏾‍🦽‍➡️	in manual wheelchair facing right: medium-dark skin tone	
👨🏾‍🦽‍➡	in manual wheelchair facing right: medium-dark skin tone	accessibility | man | man in manual wheelchair | man in manual wheelchair facing right | wheelchair
👨🏿‍🦽‍➡️	in manual wheelchair facing right: dark skin tone	
👨🏿‍🦽‍➡	in manual wheelchair facing right: dark skin tone	accessibility | man | man in manual wheelchair | man in manual wheelchair facing right | wheelchair
👩‍🦽	in manual wheelchair	accessibility | wheelchair | woman | woman in manual wheelchair
👩🏻‍🦽	in manual wheelchair: light skin tone	accessibility | light skin tone | wheelchair | woman | woman in manual wheelchair | woman in manual wheelchair: light skin tone
👩🏼‍🦽	in manual wheelchair: medium-light skin tone	accessibility | medium-light skin tone | wheelchair | woman | woman in manual wheelchair | woman in manual wheelchair: medium-light skin tone
👩🏽‍🦽	in manual wheelchair: medium skin tone	accessibility | medium skin tone | wheelchair | woman | woman in manual wheelchair | woman in manual wheelchair: medium skin tone
👩🏾‍🦽	in manual wheelchair: medium-dark skin tone	accessibility | medium-dark skin tone | wheelchair | woman | woman in manual wheelchair | woman in manual wheelchair: medium-dark skin tone
👩🏿‍🦽	in manual wheelchair: dark skin tone	accessibility | dark skin tone | wheelchair | woman | woman in manual wheelchair | woman in manual wheelchair: dark skin tone
👩‍🦽‍➡️	in manual wheelchair facing right	
👩‍🦽‍➡	in manual wheelchair facing right	accessibility | wheelchair | woman | woman in manual wheelchair | woman in manual wheelchair facing right
👩🏻‍🦽‍➡️	in manual wheelchair facing right: light skin tone	
👩🏻‍🦽‍➡	in manual wheelc—hair facing right: light skin tone	accessibility | wheelchair | woman | woman in manual wheelchair | woman in manual wheelchair facing right
👩🏼‍🦽‍➡️	in manual wheelchair facing right: medium-light skin tone	
👩🏼‍🦽‍➡	in manual wheelchair facing right: medium-light skin tone	accessibility | wheelchair | woman | woman in manual wheelchair | woman in manual wheelchair facing right
👩🏽‍🦽‍➡️	in manual wheelchair facing right: medium skin tone	
👩🏽‍🦽‍➡	in manual wheelchair facing right: medium skin tone	accessibility | wheelchair | woman | woman in manual wheelchair | woman in manual wheelchair facing right
👩🏾‍🦽‍➡️	in manual wheelchair facing right: medium-dark skin tone	
👩🏾‍🦽‍➡	in manual wheelchair facing right: medium-dark skin tone	accessibility | wheelchair | woman | woman in manual wheelchair | woman in manual wheelchair facing right
👩🏿‍🦽‍➡️	in manual wheelchair facing right: dark skin tone	
👩🏿‍🦽‍➡	in manual wheelchair facing right: dark skin tone	accessibility | wheelchair | woman | woman in manual wheelchair | woman in manual wheelchair facing right
🏃	running	marathon | person running | running
🏃🏻	running: light skin tone	light skin tone | marathon | person running | person running: light skin tone | running
🏃🏼	running: medium-light skin tone	marathon | medium-light skin tone | person running | person running: medium-light skin tone | running
🏃🏽	running: medium skin tone	marathon | medium skin tone | person running | person running: medium skin tone | running
🏃🏾	running: medium-dark skin tone	marathon | medium-dark skin tone | person running | person running: medium-dark skin tone | running
🏃🏿	running: dark skin tone	dark skin tone | marathon | person running | person running: dark skin tone | running
🏃‍♂️	running	
🏃‍♂	running	man | marathon | racing | running
🏃🏻‍♂️	running: light skin tone	
🏃🏻‍♂	running: light skin tone	light skin tone | man | man running: light skin tone | marathon | racing | running
🏃🏼‍♂️	running: medium-light skin tone	
🏃🏼‍♂	running: medium-light skin tone	man | man running: medium-light skin tone | marathon | medium-light skin tone | racing | running
🏃🏽‍♂️	running: medium skin tone	
🏃🏽‍♂	running: medium skin tone	man | man running: medium skin tone | marathon | medium skin tone | racing | running
🏃🏾‍♂️	running: medium-dark skin tone	
🏃🏾‍♂	running: medium-dark skin tone	man | man running: medium-dark skin tone | marathon | medium-dark skin tone | racing | running
🏃🏿‍♂️	running: dark skin tone	
🏃🏿‍♂	running: dark skin tone	dark skin tone | man | man running: dark skin tone | marathon | racing | running
🏃‍♀️	running	
🏃‍♀	running	marathon | racing | running | woman
🏃🏻‍♀️	running: light skin tone	
🏃🏻‍♀	running: light skin tone	light skin tone | marathon | racing | running | woman | woman running: light skin tone
🏃🏼‍♀️	running: medium-light skin tone	
🏃🏼‍♀	running: medium-light skin tone	marathon | medium-light skin tone | racing | running | woman | woman running: medium-light skin tone
🏃🏽‍♀️	running: medium skin tone	
🏃🏽‍♀	running: medium skin tone	marathon | medium skin tone | racing | running | woman | woman running: medium skin tone
🏃🏾‍♀️	running: medium-dark skin tone	
🏃🏾‍♀	running: medium-dark skin tone	marathon | medium-dark skin tone | racing | running | woman | woman running: medium-dark skin tone
🏃🏿‍♀️	running: dark skin tone	
🏃🏿‍♀	running: dark skin tone	dark skin tone | marathon | racing | running | woman | woman running: dark skin tone
🏃‍➡️	running facing right	
🏃‍➡	running facing right	marathon | person running | person running facing right | running
🏃🏻‍➡️	running facing right: light skin tone	
🏃🏻‍➡	running facing right: light skin tone	marathon | person running | person running facing right | running
🏃🏼‍➡️	running facing right: medium-light skin tone	
🏃🏼‍➡	running facing right: medium-light skin tone	marathon | person running | person running facing right | running
🏃🏽‍➡️	running facing right: medium skin tone	
🏃🏽‍➡	running facing right: medium skin tone	marathon | person running | person running facing right | running
🏃🏾‍➡️	running facing right: medium-dark skin tone	
🏃🏾‍➡	running facing right: medium-dark skin tone	marathon | person running | person running facing right | running
🏃🏿‍➡️	running facing right: dark skin tone	
🏃🏿‍➡	running facing right: dark skin tone	marathon | person running | person running facing right | running
🏃‍♀️‍➡️	running facing right	
🏃‍♀‍➡	running facing right	marathon | racing | running | woman | woman running facing right
🏃🏻‍♀️‍➡️	running facing right: light skin tone	
🏃🏻‍♀‍➡	running facing right: light skin tone	marathon | racing | running | woman | woman running facing right
🏃🏼‍♀️‍➡️	running facing right: medium-light skin tone	
🏃🏼‍♀‍➡	running facing right: medium-light skin tone	marathon | racing | running | woman | woman running facing right
🏃🏽‍♀️‍➡️	running facing right: medium skin tone	
🏃🏽‍♀‍➡	running facing right: medium skin tone	marathon | racing | running | woman | woman running facing right
🏃🏾‍♀️‍➡️	running facing right: medium-dark skin tone	
🏃🏾‍♀‍➡	running facing right: medium-dark skin tone	marathon | racing | running | woman | woman running facing right
🏃🏿‍♀️‍➡️	running facing right: dark skin tone	
🏃🏿‍♀‍➡	running facing right: dark skin tone	marathon | racing | running | woman | woman running facing right
🏃‍♂️‍➡️	running facing right	
🏃‍♂‍➡	running facing right	man | man running facing right | marathon | racing | running
🏃🏻‍♂️‍➡️	running facing right: light skin tone	
🏃🏻‍♂‍➡	running facing right: light skin tone	man | man running facing right | marathon | racing | running
🏃🏼‍♂️‍➡️	running facing right: medium-light skin tone	
🏃🏼‍♂‍➡	running facing right: medium-light skin tone	man | man running facing right | marathon | racing | running
🏃🏽‍♂️‍➡️	running facing right: medium skin tone	
🏃🏽‍♂‍➡	running facing right: medium skin tone	man | man running facing right | marathon | racing | running
🏃🏾‍♂️‍➡️	running facing right: medium-dark skin tone	
🏃🏾‍♂‍➡	running facing right: medium-dark skin tone	man | man running facing right | marathon | racing | running
🏃🏿‍♂️‍➡️	running facing right: dark skin tone	
🏃🏿‍♂‍➡	running facing right: dark skin tone	man | man running facing right | marathon | racing | running
💃	dancing	dance | dancing | woman
💃🏻	dancing: light skin tone	dance | dancing | light skin tone | woman | woman dancing: light skin tone
💃🏼	dancing: medium-light skin tone	dance | dancing | medium-light skin tone | woman | woman dancing: medium-light skin tone
💃🏽	dancing: medium skin tone	dance | dancing | medium skin tone | woman | woman dancing: medium skin tone
💃🏾	dancing: medium-dark skin tone	dance | dancing | medium-dark skin tone | woman | woman dancing: medium-dark skin tone
💃🏿	dancing: dark skin tone	dance | dancing | dark skin tone | woman | woman dancing: dark skin tone
🕺	dancing	dance | dancing | man
🕺🏻	dancing: light skin tone	dance | dancing | light skin tone | man | man dancing: light skin tone
🕺🏼	dancing: medium-light skin tone	dance | dancing | man | man dancing: medium-light skin tone | medium-light skin tone
🕺🏽	dancing: medium skin tone	dance | dancing | man | man dancing: medium skin tone | medium skin tone
🕺🏾	dancing: medium-dark skin tone	dance | dancing | man | man dancing: medium-dark skin tone | medium-dark skin tone
🕺🏿	dancing: dark skin tone	dance | dancing | dark skin tone | man | man dancing: dark skin tone
🕴️	in suit levitating	
🕴	in suit levitating	business | person | person in suit levitating | suit
🕴🏻	in suit levitating: light skin tone	business | light skin tone | person | person in suit levitating | person in suit levitating: light skin tone | suit
🕴🏼	in suit levitating: medium-light skin tone	business | medium-light skin tone | person | person in suit levitating | person in suit levitating: medium-light skin tone | suit
🕴🏽	in suit levitating: medium skin tone	business | medium skin tone | person | person in suit levitating | person in suit levitating: medium skin tone | suit
🕴🏾	in suit levitating: medium-dark skin tone	business | medium-dark skin tone | person | person in suit levitating | person in suit levitating: medium-dark skin tone | suit
🕴🏿	in suit levitating: dark skin tone	business | dark skin tone | person | person in suit levitating | person in suit levitating: dark skin tone | suit
👯	with bunny ears	bunny ear | dancer | partying | people with bunny ears
👯‍♂️	with bunny ears	
👯‍♂	with bunny ears	bunny ear | dancer | men | men with bunny ears | partying
👯‍♀️	with bunny ears	
👯‍♀	with bunny ears	bunny ear | dancer | partying | women | women with bunny ears
🧖	in steamy room	person in steamy room | sauna | steam room
🧖🏻	in steamy room: light skin tone	light skin tone | person in steamy room | person in steamy room: light skin tone | sauna | steam room
🧖🏼	in steamy room: medium-light skin tone	medium-light skin tone | person in steamy room | person in steamy room: medium-light skin tone | sauna | steam room
🧖🏽	in steamy room: medium skin tone	medium skin tone | person in steamy room | person in steamy room: medium skin tone | sauna | steam room
🧖🏾	in steamy room: medium-dark skin tone	medium-dark skin tone | person in steamy room | person in steamy room: medium-dark skin tone | sauna | steam room
🧖🏿	in steamy room: dark skin tone	dark skin tone | person in steamy room | person in steamy room: dark skin tone | sauna | steam room
🧖‍♂️	in steamy room	
🧖‍♂	in steamy room	man in steamy room | sauna | steam room | man in steam room
🧖🏻‍♂️	in steamy room: light skin tone	
🧖🏻‍♂	in steamy room: light skin tone	light skin tone | man in steamy room | man in steamy room: light skin tone | sauna | steam room | man in steam room | man in steam room: light skin tone
🧖🏼‍♂️	in steamy room: medium-light skin tone	
🧖🏼‍♂	in steamy room: medium-light skin tone	man in steamy room | man in steamy room: medium-light skin tone | medium-light skin tone | sauna | steam room | man in steam room | man in steam room: medium-light skin tone
🧖🏽‍♂️	in steamy room: medium skin tone	
🧖🏽‍♂	in steamy room: medium skin tone	man in steamy room | man in steamy room: medium skin tone | medium skin tone | sauna | steam room | man in steam room | man in steam room: medium skin tone
🧖🏾‍♂️	in steamy room: medium-dark skin tone	
🧖🏾‍♂	in steamy room: medium-dark skin tone	man in steamy room | man in steamy room: medium-dark skin tone | medium-dark skin tone | sauna | steam room | man in steam room | man in steam room: medium-dark skin tone
🧖🏿‍♂️	in steamy room: dark skin tone	
🧖🏿‍♂	in steamy room: dark skin tone	dark skin tone | man in steamy room | man in steamy room: dark skin tone | sauna | steam room | man in steam room | man in steam room: dark skin tone
🧖‍♀️	in steamy room	
🧖‍♀	in steamy room	sauna | steam room | woman in steamy room | woman in steam room
🧖🏻‍♀️	in steamy room: light skin tone	
🧖🏻‍♀	in steamy room: light skin tone	light skin tone | sauna | steam room | woman in steamy room | woman in steamy room: light skin tone | woman in steam room | woman in steam room: light skin tone
🧖🏼‍♀️	in steamy room: medium-light skin tone	
🧖🏼‍♀	in steamy room: medium-light skin tone	medium-light skin tone | sauna | steam room | woman in steamy room | woman in steamy room: medium-light skin tone | woman in steam room | woman in steam room: medium-light skin tone
🧖🏽‍♀️	in steamy room: medium skin tone	
🧖🏽‍♀	in steamy room: medium skin tone	medium skin tone | sauna | steam room | woman in steamy room | woman in steamy room: medium skin tone | woman in steam room | woman in steam room: medium skin tone
🧖🏾‍♀️	in steamy room: medium-dark skin tone	
🧖🏾‍♀	in steamy room: medium-dark skin tone	medium-dark skin tone | sauna | steam room | woman in steamy room | woman in steamy room: medium-dark skin tone | woman in steam room | woman in steam room: medium-dark skin tone
🧖🏿‍♀️	in steamy room: dark skin tone	
🧖🏿‍♀	in steamy room: dark skin tone	dark skin tone | sauna | steam room | woman in steamy room | woman in steamy room: dark skin tone | woman in steam room | woman in steam room: dark skin tone
🧗	climbing	climber | person climbing
🧗🏻	climbing: light skin tone	climber | light skin tone | person climbing | person climbing: light skin tone
🧗🏼	climbing: medium-light skin tone	climber | medium-light skin tone | person climbing | person climbing: medium-light skin tone
🧗🏽	climbing: medium skin tone	climber | medium skin tone | person climbing | person climbing: medium skin tone
🧗🏾	climbing: medium-dark skin tone	climber | medium-dark skin tone | person climbing | person climbing: medium-dark skin tone
🧗🏿	climbing: dark skin tone	climber | dark skin tone | person climbing | person climbing: dark skin tone
🧗‍♂️	climbing	
🧗‍♂	climbing	climber | man climbing
🧗🏻‍♂️	climbing: light skin tone	
🧗🏻‍♂	climbing: light skin tone	climber | light skin tone | man climbing | man climbing: light skin tone
🧗🏼‍♂️	climbing: medium-light skin tone	
🧗🏼‍♂	climbing: medium-light skin tone	climber | man climbing | man climbing: medium-light skin tone | medium-light skin tone
🧗🏽‍♂️	climbing: medium skin tone	
🧗🏽‍♂	climbing: medium skin tone	climber | man climbing | man climbing: medium skin tone | medium skin tone
🧗🏾‍♂️	climbing: medium-dark skin tone	
🧗🏾‍♂	climbing: medium-dark skin tone	climber | man climbing | man climbing: medium-dark skin tone | medium-dark skin tone
🧗🏿‍♂️	climbing: dark skin tone	
🧗🏿‍♂	climbing: dark skin tone	climber | dark skin tone | man climbing | man climbing: dark skin tone
🧗‍♀️	climbing	
🧗‍♀	climbing	climber | woman climbing
🧗🏻‍♀️	climbing: light skin tone	
🧗🏻‍♀	climbing: light skin tone	climber | light skin tone | woman climbing | woman climbing: light skin tone
🧗🏼‍♀️	climbing: medium-light skin tone	
🧗🏼‍♀	climbing: medium-light skin tone	climber | medium-light skin tone | woman climbing | woman climbing: medium-light skin tone
🧗🏽‍♀️	climbing: medium skin tone	
🧗🏽‍♀	climbing: medium skin tone	climber | medium skin tone | woman climbing | woman climbing: medium skin tone
🧗🏾‍♀️	climbing: medium-dark skin tone	
🧗🏾‍♀	climbing: medium-dark skin tone	climber | medium-dark skin tone | woman climbing | woman climbing: medium-dark skin tone
🧗🏿‍♀️	climbing: dark skin tone	
🧗🏿‍♀	climbing: dark skin tone	climber | dark skin tone | woman climbing | woman climbing: dark skin tone
🤺	fencing	fencer | fencing | person fencing | sword
🏇	racing	horse | jockey | racehorse | racing
🏇🏻	racing: light skin tone	horse | horse racing: light skin tone | jockey | light skin tone | racehorse | racing
🏇🏼	racing: medium-light skin tone	horse | horse racing: medium-light skin tone | jockey | medium-light skin tone | racehorse | racing
🏇🏽	racing: medium skin tone	horse | horse racing: medium skin tone | jockey | medium skin tone | racehorse | racing
🏇🏾	racing: medium-dark skin tone	horse | horse racing: medium-dark skin tone | jockey | medium-dark skin tone | racehorse | racing
🏇🏿	racing: dark skin tone	dark skin tone | horse | horse racing: dark skin tone | jockey | racehorse | racing
⛷	ski | skier | snow
🏂	ki | snow | snowboard | snowboarder
🏂🏻	light skin tone	light skin tone | ski | snow | snowboard | snowboarder | snowboarder: light skin tone
🏂🏼	medium-light skin tone	medium-light skin tone | ski | snow | snowboard | snowboarder | snowboarder: medium-light skin tone
🏂🏽	medium skin tone	medium skin tone | ski | snow | snowboard | snowboarder | snowboarder: medium skin tone
🏂🏾	medium-dark skin tone	medium-dark skin tone | ski | snow | snowboard | snowboarder | snowboarder: medium-dark skin tone
🏂🏿	dark skin tone	dark skin tone | ski | snow | snowboard | snowboarder | snowboarder: dark skin tone
🏌️	golfing	
🏌	golfing	ball | golf | person golfing | golfer
🏌🏻	golfing: light skin tone	ball | golf | light skin tone | person golfing | person golfing: light skin tone | golfer
🏌🏼	golfing: medium-light skin tone	ball | golf | medium-light skin tone | person golfing | person golfing: medium-light skin tone | golfer
🏌🏽	golfing: medium skin tone	ball | golf | medium skin tone | person golfing | person golfing: medium skin tone | golfer
🏌🏾	golfing: medium-dark skin tone	ball | golf | medium-dark skin tone | person golfing | person golfing: medium-dark skin tone | golfer
🏌🏿	golfing: dark skin tone	ball | dark skin tone | golf | person golfing | person golfing: dark skin tone | golfer
🏌️‍♂️	golfing	
🏌️‍♂	golfing	
🏌‍♂	golfing	golf | man | man golfing | golfer
🏌🏻‍♂️	golfing: light skin tone	
🏌🏻‍♂	golfing: light skin tone	golf | light skin tone | man | man golfing | man golfing: light skin tone | golfer
🏌🏼‍♂️	golfing: medium-light skin tone	
🏌🏼‍♂	golfing: medium-light skin tone	golf | man | man golfing | man golfing: medium-light skin tone | medium-light skin tone | golfer
🏌🏽‍♂️	golfing: medium skin tone	
🏌🏽‍♂	golfing: medium skin tone	golf | man | man golfing | man golfing: medium skin tone | medium skin tone | golfer
🏌🏾‍♂️	golfing: medium-dark skin tone	
🏌🏾‍♂	golfing: medium-dark skin tone	golf | man | man golfing | man golfing: medium-dark skin tone | medium-dark skin tone | golfer
🏌🏿‍♂️	golfing: dark skin tone	
🏌🏿‍♂	golfing: dark skin tone	dark skin tone | golf | man | man golfing | man golfing: dark skin tone | golfer
🏌️‍♀️	golfing	
🏌️‍♀	golfing	
🏌‍♀	golfing	golf | woman | woman golfing | golfer
🏌🏻‍♀️	golfing: light skin tone	
🏌🏻‍♀	golfing: light skin tone	golf | light skin tone | woman | woman golfing | woman golfing: light skin tone | golfer
🏌🏼‍♀️	golfing: medium-light skin tone	
🏌🏼‍♀	golfing: medium-light skin tone	golf | medium-light skin tone | woman | woman golfing | woman golfing: medium-light skin tone | golfer
🏌🏽‍♀️	golfing: medium skin tone	
🏌🏽‍♀	golfing: medium skin tone	golf | medium skin tone | woman | woman golfing | woman golfing: medium skin tone | golfer
🏌🏾‍♀️	golfing: medium-dark skin tone	
🏌🏾‍♀	golfing: medium-dark skin tone	golf | medium-dark skin tone | woman | woman golfing | woman golfing: medium-dark skin tone | golfer
🏌🏿‍♀️	golfing: dark skin tone	
🏌🏿‍♀	golfing: dark skin tone	dark skin tone | golf | woman | woman golfing | woman golfing: dark skin tone | golfer
🏄	surfing	person surfing | surfing | surfer
🏄🏻	surfing: light skin tone	light skin tone | person surfing | person surfing: light skin tone | surfing | surfer
🏄🏼	surfing: medium-light skin tone	medium-light skin tone | person surfing | person surfing: medium-light skin tone | surfing | surfer
🏄🏽	surfing: medium skin tone	medium skin tone | person surfing | person surfing: medium skin tone | surfing | surfer
🏄🏾	surfing: medium-dark skin tone	medium-dark skin tone | person surfing | person surfing: medium-dark skin tone | surfing | surfer
🏄🏿	surfing: dark skin tone	dark skin tone | person surfing | person surfing: dark skin tone | surfing | surfer
🏄‍♂️	surfing	
🏄‍♂	surfing	man | surfing | surfer
🏄🏻‍♂️	surfing: light skin tone	
🏄🏻‍♂	surfing: light skin tone	light skin tone | man | man surfing: light skin tone | surfing | surfer
🏄🏼‍♂️	surfing: medium-light skin tone	
🏄🏼‍♂	surfing: medium-light skin tone	man | man surfing: medium-light skin tone | medium-light skin tone | surfing | surfer
🏄🏽‍♂️	surfing: medium skin tone	
🏄🏽‍♂	surfing: medium skin tone	man | man surfing: medium skin tone | medium skin tone | surfing | surfer
🏄🏾‍♂️	surfing: medium-dark skin tone	
🏄🏾‍♂	surfing: medium-dark skin tone	man | man surfing: medium-dark skin tone | medium-dark skin tone | surfing | surfer
🏄🏿‍♂️	surfing: dark skin tone	
🏄🏿‍♂	surfing: dark skin tone	dark skin tone | man | man surfing: dark skin tone | surfing | surfer
🏄‍♀️	surfing	
🏄‍♀	surfing	surfing— | woman | surfer
🏄🏻‍♀️	surfing: light skin tone	
🏄🏻‍♀	surfing: light skin tone	light skin tone | surfing | woman | woman surfing: light skin tone | surfer
🏄🏼‍♀️	surfing: medium-light skin tone	
🏄🏼‍♀	surfing: medium-light skin tone	medium-light skin tone | surfing | woman | woman surfing: medium-light skin tone | surfer
🏄🏽‍♀️	surfing: medium skin tone	
🏄🏽‍♀	surfing: medium skin tone	medium skin tone | surfing | woman | woman surfing: medium skin tone | surfer
🏄🏾‍♀️	surfing: medium-dark skin tone	
🏄🏾‍♀	surfing: medium-dark skin tone	medium-dark skin tone | surfing | woman | woman surfing: medium-dark skin tone | surfer
🏄🏿‍♀️	surfing: dark skin tone	
🏄🏿‍♀	surfing: dark skin tone	dark skin tone | surfing | woman | woman surfing: dark skin tone | surfer
🚣	rowing boat	boat | person rowing boat | rowboat | person
🚣🏻	rowing boat: light skin tone	boat | light skin tone | person rowing boat | person rowing boat: light skin tone | rowboat | person
🚣🏼	rowing boat: medium-light skin tone	boat | medium-light skin tone | person rowing boat | person rowing boat: medium-light skin tone | rowboat | person
🚣🏽	rowing boat: medium skin tone	boat | medium skin tone | person rowing boat | person rowing boat: medium skin tone | rowboat | person
🚣🏾	rowing boat: medium-dark skin tone	boat | medium-dark skin tone | person rowing boat | person rowing boat: medium-dark skin tone | rowboat | person
🚣🏿	rowing boat: dark skin tone	boat | dark skin tone | person rowing boat | person rowing boat: dark skin tone | rowboat | person
🚣‍♂️	rowing boat	
🚣‍♂	rowing boat	boat | man | man rowing boat | rowboat
🚣🏻‍♂️	rowing boat: light skin tone	
🚣🏻‍♂	rowing boat: light skin tone	boat | light skin tone | man | man rowing boat | man rowing boat: light skin tone | rowboat
🚣🏼‍♂️	rowing boat: medium-light skin tone	
🚣🏼‍♂	rowing boat: medium-light skin tone	boat | man | man rowing boat | man rowing boat: medium-light skin tone | medium-light skin tone | rowboat
🚣🏽‍♂️	rowing boat: medium skin tone	
🚣🏽‍♂	rowing boat: medium skin tone	boat | man | man rowing boat | man rowing boat: medium skin tone | medium skin tone | rowboat
🚣🏾‍♂️	rowing boat: medium-dark skin tone	
🚣🏾‍♂	rowing boat: medium-dark skin tone	boat | man | man rowing boat | man rowing boat: medium-dark skin tone | medium-dark skin tone | rowboat
🚣🏿‍♂️	rowing boat: dark skin tone	
🚣🏿‍♂	rowing boat: dark skin tone	boat | dark skin tone | man | man rowing boat | man rowing boat: dark skin tone | rowboat
🚣‍♀️	rowing boat	
🚣‍♀	rowing boat	boat | rowboat | woman | woman rowing boat
🚣🏻‍♀️	rowing boat: light skin tone	
🚣🏻‍♀	rowing boat: light skin tone	boat | light skin tone | rowboat | woman | woman rowing boat | woman rowing boat: light skin tone
🚣🏼‍♀️	rowing boat: medium-light skin tone	
🚣🏼‍♀	rowing boat: medium-light skin tone	boat | medium-light skin tone | rowboat | woman | woman rowing boat | woman rowing boat: medium-light skin tone
🚣🏽‍♀️	rowing boat: medium skin tone	
🚣🏽‍♀	rowing boat: medium skin tone	boat | medium skin tone | rowboat | woman | woman rowing boat | woman rowing boat: medium skin tone
🚣🏾‍♀️	rowing boat: medium-dark skin tone	
🚣🏾‍♀	rowing boat: medium-dark skin tone	boat | medium-dark skin tone | rowboat | woman | woman rowing boat | woman rowing boat: medium-dark skin tone
🚣🏿‍♀️	rowing boat: dark skin tone	
🚣🏿‍♀	rowing boat: dark skin tone	boat | dark skin tone | rowboat | woman | woman rowing boat | woman rowing boat: dark skin tone
🏊	swimming	person swimming | swim | swimmer
🏊🏻	swimming: light skin tone	light skin tone | person swimming | person swimming: light skin tone | swim | swimmer
🏊🏼	swimming: medium-light skin tone	medium-light skin tone | person swimming | person swimming: medium-light skin tone | swim | swimmer
🏊🏽	swimming: medium skin tone	medium skin tone | person swimming | person swimming: medium skin tone | swim | swimmer
🏊🏾	swimming: medium-dark skin tone	medium-dark skin tone | person swimming | person swimming: medium-dark skin tone | swim | swimmer
🏊🏿	swimming: dark skin tone	dark skin tone | person swimming | person swimming: dark skin tone | swim | swimmer
🏊‍♂️	swimming	
🏊‍♂	swimming	man | man swimming | swim | swimmer
🏊🏻‍♂️	swimming: light skin tone	
🏊🏻‍♂	swimming: light skin tone	light skin tone | man | man swimming | man swimming: light skin tone | swim | swimmer
🏊🏼‍♂️	swimming: medium-light skin tone	
🏊🏼‍♂	swimming: medium-light skin tone	man | man swimming | man swimming: medium-light skin tone | medium-light skin tone | swim | swimmer
🏊🏽‍♂️	swimming: medium skin tone	
🏊🏽‍♂	swimming: medium skin tone	man | man swimming | man swimming: medium skin tone | medium skin tone | swim | swimmer
🏊🏾‍♂️	swimming: medium-dark skin tone	
🏊🏾‍♂	swimming: medium-dark skin tone	man | man swimming | man swimming: medium-dark skin tone | medium-dark skin tone | swim | swimmer
🏊🏿‍♂️	swimming: dark skin tone	
🏊🏿‍♂	swimming: dark skin tone	dark skin tone | man | man swimming | man swimming: dark skin tone | swim | swimmer
🏊‍♀️	swimming	
🏊‍♀	swimming	swim | woman | woman swimming | swimmer
🏊🏻‍♀️	swimming: light skin tone	
🏊🏻‍♀	swimming: light skin tone	light skin tone | swim | woman | woman swimming | woman swimming: light skin tone | swimmer
🏊🏼‍♀️	swimming: medium-light skin tone	
🏊🏼‍♀	swimming: medium-light skin tone	medium-light skin tone | swim | woman | woman swimming | woman swimming: medium-light skin tone | swimmer
🏊🏽‍♀️	swimming: medium skin tone	
🏊🏽‍♀	swimming: medium skin tone	medium skin tone | swim | woman | woman swimming | woman swimming: medium skin tone | swimmer
🏊🏾‍♀️	swimming: medium-dark skin tone	
🏊🏾‍♀	swimming: medium-dark skin tone	medium-dark skin tone | swim | woman | woman swimming | woman swimming: medium-dark skin tone | swimmer
🏊🏿‍♀️	swimming: dark skin tone	
🏊🏿‍♀	swimming: dark skin tone	dark skin tone | swim | woman | woman swimming | woman swimming: dark skin tone | swimmer
⛹️	bouncing ball	
⛹	bouncing ball	ball | person bouncing ball
⛹🏻	bouncing ball: light skin tone	ball | light skin tone | person bouncing ball | person bouncing ball: light skin tone
⛹🏼	bouncing ball: medium-light skin tone	ball | medium-light skin tone | person bouncing ball | person bouncing ball: medium-light skin tone
⛹🏽	bouncing ball: medium skin tone	ball | medium skin tone | person bouncing ball | person bouncing ball: medium skin tone
⛹🏾	bouncing ball: medium-dark skin tone	ball | medium-dark skin tone | person bouncing ball | person bouncing ball: medium-dark skin tone
⛹🏿	bouncing ball: dark skin tone	ball | dark skin tone | person bouncing ball | person bouncing ball: dark skin tone
⛹️‍♂️	bouncing ball	
⛹️‍♂	bouncing ball	
⛹‍♂	bouncing ball	ball | man | man bouncing ball
⛹🏻‍♂️	bouncing ball: light skin tone	
⛹🏻‍♂	bouncing ball: light skin tone	ball | light skin tone | man | man bouncing ball | man bouncing ball: light skin tone
⛹🏼‍♂️	bouncing ball: medium-light skin tone	
⛹🏼‍♂	bouncing ball: medium-light skin tone	ball | man | man bouncing ball | man bouncing ball: medium-light skin tone | medium-light skin tone
⛹🏽‍♂️	bouncing ball: medium skin tone	
⛹🏽‍♂	bouncing ball: medium skin tone	ball | man | man bouncing ball | man bouncing ball: medium skin tone | medium skin tone
⛹🏾‍♂️	bouncing ball: medium-dark skin tone	
⛹🏾‍♂	bouncing ball: medium-dark skin tone	ball | man | man bouncing ball | man bouncing ball: medium-dark skin tone | medium-dark skin tone
⛹🏿‍♂️	bouncing ball: dark skin tone	
⛹🏿‍♂	bouncing ball: dark skin tone	ball | dark skin tone | man | man bouncing ball | man bouncing ball: dark skin tone
⛹️‍♀️	bouncing ball	
⛹️‍♀	bouncing ball	
⛹‍♀	bouncing ball	ball | woman | woman bouncing ball
⛹🏻‍♀️	bouncing ball: light skin tone	
⛹🏻‍♀	bouncing ball: light skin tone	ball | light skin tone | woman | woman bouncing ball | woman bouncing ball: light skin tone
⛹🏼‍♀️	bouncing ball: medium-light skin tone	
⛹🏼‍♀	bouncing ball: medium-light skin tone	ball | medium-light skin tone | woman | woman bouncing ball | woman bouncing ball: medium-light skin tone
⛹🏽‍♀️	bouncing ball: medium skin tone	
⛹🏽‍♀	bouncing ball: medium skin tone	ball | medium skin tone | woman | woman bouncing ball | woman bouncing ball: medium skin tone
⛹🏾‍♀️	bouncing ball: medium-dark skin tone	
⛹🏾‍♀	bouncing ball: medium-dark skin tone	ball | medium-dark skin tone | woman | woman bouncing ball | woman bouncing ball: medium-dark skin tone
⛹🏿‍♀️	bouncing ball: dark skin tone	
⛹🏿‍♀	bouncing ball: dark skin tone	ball | dark skin tone | woman | woman bouncing ball | woman bouncing ball: dark skin tone
🏋️	lifting weights	
🏋	lifting weights	lifter | person lifting weights | weight | weightlifter
🏋🏻	lifting weights: light skin tone	lifter | light skin tone | person lifting weights | person lifting weights: light skin tone | weight | weightlifter
🏋🏼	lifting weights: medium-light skin tone	lifter | medium-light skin tone | person lifting weights | person lifting weights: medium-light skin tone | weight | weightlifter
🏋🏽	lifting weights: medium skin tone	lifter | medium skin tone | person lifting weights | person lifting weights: medium skin tone | weight | weightlifter
🏋🏾	lifting weights: medium-dark skin tone	lifter | medium-dark skin tone | person lifting weights | person lifting weights: medium-dark skin tone | weight | weightlifter
🏋🏿	lifting weights: dark skin tone	dark skin tone | lifter | person lifting weights | person lifting weights: dark skin tone | weight | weightlifter
🏋️‍♂️	lifting weights	
🏋️‍♂	lifting weights	
🏋‍♂	lifting weights	man | man lifting weights | weight lifter
🏋🏻‍♂️	lifting weights: light skin tone	
🏋🏻‍♂	lifting weights: light skin tone	light skin tone | man | man lifting weights | man lifting weights: light skin tone | weight lifter
🏋🏼‍♂️	lifting weights: medium-light skin tone	
🏋🏼‍♂	lifting weights: medium-light skin tone	man | man lifting weights | man lifting weights: medium-light skin tone | medium-light skin tone | weight lifter
🏋🏽‍♂️	lifting weights: medium skin tone	
🏋🏽‍♂	lifting weights: medium skin tone	man | man lifting weights | man lifting weights: medium skin tone | medium skin tone | weight lifter
🏋🏾‍♂️	lifting weights: medium-dark skin tone	
🏋🏾‍♂	lifting weights: medium-dark skin tone	man | man lifting weights | man lifting weights: medium-dark skin tone | medium-dark skin tone | weight lifter
🏋🏿‍♂️	lifting weights: dark skin tone	
🏋🏿‍♂	lifting weights: dark skin tone	dark skin tone | man | man lifting weights | man lifting weights: dark skin tone | weight lifter
🏋️‍♀️	lifting weights	
🏋️‍♀	lifting weights	
🏋‍♀	lifting weights	weight lifter | woman | woman lifting weights
🏋🏻‍♀️	lifting weights: light skin tone	
🏋🏻‍♀	lifting weights: light skin tone	light skin tone | weight lifter | woman | woman lifting weights | woman lifting weights: light skin tone
🏋🏼‍♀️	lifting weights: medium-light skin tone	
🏋🏼‍♀	lifting weights: medium-light skin tone	medium-light skin tone | weight lifter | woman | woman lifting weights | woman lifting weights: medium-light skin tone
🏋🏽‍♀️	lifting weights: medium skin tone	
🏋🏽‍♀	lifting weights: medium skin tone	medium skin tone | weight lifter | woman | woman lifting weights | woman lifting weights: medium skin tone
🏋🏾‍♀️	lifting weights: medium-dark skin tone	
🏋🏾‍♀	lifting weights: medium-dark skin tone	medium-dark skin tone | weight lifter | woman | woman lifting weights | woman lifting weights: medium-dark skin tone
🏋🏿‍♀️	lifting weights: dark skin tone	
🏋🏿‍♀	lifting weights: dark skin tone	dark skin tone | weight lifter | woman | woman lifting weights | woman lifting weights: dark skin tone
🚴	biking	bicycle | biking | cyclist | person biking | person riding a bike
🚴🏻	biking: light skin tone	bicycle | biking | cyclist | light skin tone | person biking | person biking: light skin tone | person riding a bike | person riding a bike: light skin tone
🚴🏼	biking: medium-light skin tone	bicycle | biking | cyclist | medium-light skin tone | person biking | person biking: medium-light skin tone | person riding a bike | person riding a bike: medium-light skin tone
🚴🏽	biking: medium skin tone	bicycle | biking | cyclist | medium skin tone | person biking | person biking: medium skin tone | person riding a bike | person riding a bike: medium skin tone
🚴🏾	biking: medium-dark skin tone	bicycle | biking | cyclist | medium-dark skin tone | person biking | person biking: medium-dark skin tone | person riding a bike | person riding a bike: medium-dark skin tone
🚴🏿	biking: dark skin tone	bicycle | biking | cyclist | dark skin tone | person biking | person biking: dark skin tone | person riding a bike | person riding a bike: dark skin tone
🚴‍♂️	biking	
🚴‍♂	biking	bicycle | biking | cyclist | man | cycling | man riding a bike
🚴🏻‍♂️	biking: light skin tone	
🚴🏻‍♂	biking: light skin tone	bicycle | biking | cyclist | light skin tone | man | man biking: light skin tone | cycling | man riding a bike | man riding a bike: light skin tone
🚴🏼‍♂️	biking: medium-light skin tone	
🚴🏼‍♂	biking: medium-light skin tone	bicycle | biking | cyclist | man | man biking: medium-light skin tone | medium-light skin tone | cycling | man riding a bike | man riding a bike: medium-light skin tone
🚴🏽‍♂️	biking: medium skin tone	
🚴🏽‍♂	biking: medium skin tone	bicycle | biking | cyclist | man | man biking: medium skin tone | medium skin tone | cycling | man riding a bike | man riding a bike: medium skin tone
🚴🏾‍♂️	biking: medium-dark skin tone	
🚴🏾‍♂	biking: medium-dark skin tone	bicycle | biking | cyclist | man | man biking: medium-dark skin tone | medium-dark skin tone | cycling | man riding a bike | man riding a bike: medium-dark skin tone
🚴🏿‍♂️	biking: dark skin tone	
🚴🏿‍♂	biking: dark skin tone	bicycle | biking | cyclist | dark skin tone | man | man biking: dark skin tone | cycling | man riding a bike | man riding a bike: dark skin tone
🚴‍♀️	biking	
🚴‍♀	biking	bicycle | biking | cyclist | woman | cycling | woman riding a bike
🚴🏻‍♀️	biking: light skin tone	
🚴🏻‍♀	biking: light skin tone	bicycle | biking | cyclist | light skin tone | woman | woman biking: light skin tone | cycling | woman riding a bike | woman riding a bike: light skin tone
🚴🏼‍♀️	biking: medium-light skin tone	
🚴🏼‍♀	biking: medium-light skin tone	bicycle | biking | cyclist | medium-light skin tone | woman | woman biking: medium-light skin tone | cycling | woman riding a bike | woman riding a bike: medium-light skin tone
🚴🏽‍♀️	biking: medium skin tone	
🚴🏽‍♀	biking: medium skin tone	bicycle | biking | cyclist | medium skin tone | woman | woman biking: medium skin tone | cycling | woman riding a bike | woman riding a bike: medium skin tone
🚴🏾‍♀️	biking: medium-dark skin tone	
🚴🏾‍♀	biking: medium-dark skin tone	bicycle | biking | cyclist | medium-dark skin tone | woman | woman biking: medium-dark skin tone | cycling | woman riding a bike | woman riding a bike: medium-dark skin tone
🚴🏿‍♀️	biking: dark skin tone	
🚴🏿‍♀	biking: dark skin tone	bicycle | biking | cyclist | dark skin tone | woman | woman biking: dark skin tone | cycling | woman riding a bike | woman riding a bike: dark skin tone
🚵	mountain biking	bicycle | bicyclist | bike | cyclist | mountain | person mountain biking
🚵🏻	mountain biking: light skin tone	bicycle | bicyclist | bike | cyclist | light skin tone | mountain | person mountain biking | person mountain biking: light skin tone
🚵🏼	mountain biking: medium-light skin tone	bicycle | bicyclist | bike | cyclist | medium-light skin tone | mountain | person mountain biking | person mountain biking: medium-light skin tone
🚵🏽	mountain biking: medium skin tone	bicycle | bicyclist | bike | cyclist | medium skin tone | mountain | person mountain biking | person mountain biking: medium skin tone
🚵🏾	mountain biking: medium-dark skin tone	bicycle | bicyclist | bike | cyclist | medium-dark skin tone | mountain | person mountain biking | person mountain biking: medium-dark skin tone
🚵🏿	mountain biking: dark skin tone	bicycle | bicyclist | bike | cyclist | dark skin tone | mountain | person mountain biking | person mountain biking: dark skin tone
🚵‍♂️	mountain biking	
🚵‍♂	mountain biking	bicycle | bike | cyclist | man | man mountain biking | mountain
🚵🏻‍♂️	mountain biking: light skin tone	
🚵🏻‍♂	mountain biking: light skin tone	bicycle | bike | cyclist | light skin tone | man | man mountain biking | man mountain biking: light skin tone | mountain
🚵🏼‍♂️	mountain bikin—g: medium-light skin tone	
🚵🏼‍♂	mountain biking: medium-light skin tone	bicycle | bike | cyclist | man | man mountain biking | man mountain biking: medium-light skin tone | medium-light skin tone | mountain
🚵🏽‍♂️	mountain biking: medium skin tone	
🚵🏽‍♂	mountain biking: medium skin tone	bicycle | bike | cyclist | man | man mountain biking | man mountain biking: medium skin tone | medium skin tone | mountain
🚵🏾‍♂️	mountain biking: medium-dark skin tone	
🚵🏾‍♂	mountain biking: medium-dark skin tone	bicycle | bike | cyclist | man | man mountain biking | man mountain biking: medium-dark skin tone | medium-dark skin tone | mountain
🚵🏿‍♂️	mountain biking: dark skin tone	
🚵🏿‍♂	mountain biking: dark skin tone	bicycle | bike | cyclist | dark skin tone | man | man mountain biking | man mountain biking: dark skin tone | mountain
🚵‍♀️	mountain biking	
🚵‍♀	mountain biking	bicycle | bike | biking | cyclist | mountain | woman
🚵🏻‍♀️	mountain biking: light skin tone	
🚵🏻‍♀	mountain biking: light skin tone	bicycle | bike | biking | cyclist | light skin tone | mountain | woman | woman mountain biking: light skin tone
🚵🏼‍♀️	mountain biking: medium-light skin tone	
🚵🏼‍♀	mountain biking: medium-light skin tone	bicycle | bike | biking | cyclist | medium-light skin tone | mountain | woman | woman mountain biking: medium-light skin tone
🚵🏽‍♀️	mountain biking: medium skin tone	
🚵🏽‍♀	mountain biking: medium skin tone	bicycle | bike | biking | cyclist | medium skin tone | mountain | woman | woman mountain biking: medium skin tone
🚵🏾‍♀️	mountain biking: medium-dark skin tone	
🚵🏾‍♀	mountain biking: medium-dark skin tone	bicycle | bike | biking | cyclist | medium-dark skin tone | mountain | woman | woman mountain biking: medium-dark skin tone
🚵🏿‍♀️	mountain biking: dark skin tone	
🚵🏿‍♀	mountain biking: dark skin tone	bicycle | bike | biking | cyclist | dark skin tone | mountain | woman | woman mountain biking: dark skin tone
🤸	cartwheeling	cartwheel | gymnastics | person cartwheeling
🤸🏻	cartwheeling: light skin tone	cartwheel | gymnastics | light skin tone | person cartwheeling | person cartwheeling: light skin tone
🤸🏼	cartwheeling: medium-light skin tone	cartwheel | gymnastics | medium-light skin tone | person cartwheeling | person cartwheeling: medium-light skin tone
🤸🏽	cartwheeling: medium skin tone	cartwheel | gymnastics | medium skin tone | person cartwheeling | person cartwheeling: medium skin tone
🤸🏾	cartwheeling: medium-dark skin tone	cartwheel | gymnastics | medium-dark skin tone | person cartwheeling | person cartwheeling: medium-dark skin tone
🤸🏿	cartwheeling: dark skin tone	cartwheel | dark skin tone | gymnastics | person cartwheeling | person cartwheeling: dark skin tone
🤸‍♂️	cartwheeling	
🤸‍♂	cartwheeling	cartwheel | gymnastics | man | man cartwheeling
🤸🏻‍♂️	cartwheeling: light skin tone	
🤸🏻‍♂	cartwheeling: light skin tone	cartwheel | gymnastics | light skin tone | man | man cartwheeling | man cartwheeling: light skin tone
🤸🏼‍♂️	cartwheeling: medium-light skin tone	
🤸🏼‍♂	cartwheeling: medium-light skin tone	cartwheel | gymnastics | man | man cartwheeling | man cartwheeling: medium-light skin tone | medium-light skin tone
🤸🏽‍♂️	cartwheeling: medium skin tone	
🤸🏽‍♂	cartwheeling: medium skin tone	cartwheel | gymnastics | man | man cartwheeling | man cartwheeling: medium skin tone | medium skin tone
🤸🏾‍♂️	cartwheeling: medium-dark skin tone	
🤸🏾‍♂	cartwheeling: medium-dark skin tone	cartwheel | gymnastics | man | man cartwheeling | man cartwheeling: medium-dark skin tone | medium-dark skin tone
🤸🏿‍♂️	cartwheeling: dark skin tone	
🤸🏿‍♂	cartwheeling: dark skin tone	cartwheel | dark skin tone | gymnastics | man | man cartwheeling | man cartwheeling: dark skin tone
🤸‍♀️	cartwheeling	
🤸‍♀	cartwheeling	cartwheel | gymnastics | woman | woman cartwheeling
🤸🏻‍♀️	cartwheeling: light skin tone	
🤸🏻‍♀	cartwheeling: light skin tone	cartwheel | gymnastics | light skin tone | woman | woman cartwheeling | woman cartwheeling: light skin tone
🤸🏼‍♀️	cartwheeling: medium-light skin tone	
🤸🏼‍♀	cartwheeling: medium-light skin tone	cartwheel | gymnastics | medium-light skin tone | woman | woman cartwheeling | woman cartwheeling: medium-light skin tone
🤸🏽‍♀️	cartwheeling: medium skin tone	
🤸🏽‍♀	cartwheeling: medium skin tone	cartwheel | gymnastics | medium skin tone | woman | woman cartwheeling | woman cartwheeling: medium skin tone
🤸🏾‍♀️	cartwheeling: medium-dark skin tone	
🤸🏾‍♀	cartwheeling: medium-dark skin tone	cartwheel | gymnastics | medium-dark skin tone | woman | woman cartwheeling | woman cartwheeling: medium-dark skin tone
🤸🏿‍♀️	cartwheeling: dark skin tone	
🤸🏿‍♀	cartwheeling: dark skin tone	cartwheel | dark skin tone | gymnastics | woman | woman cartwheeling | woman cartwheeling: dark skin tone
🤼	wrestling	people wrestling | wrestle | wrestler
🤼‍♂️	wrestling	
🤼‍♂	wrestling	men | men wrestling | wrestle
🤼‍♀️	wrestling	
🤼‍♀	wrestling	women | women wrestling | wrestle
🤽	playing water polo	person playing water polo | polo | water
🤽🏻	playing water polo: light skin tone	light skin tone | person playing water polo | person playing water polo: light skin tone | polo | water
🤽🏼	playing water polo: medium-light skin tone	medium-light skin tone | person playing water polo | person playing water polo: medium-light skin tone | polo | water
🤽🏽	playing water polo: medium skin tone	medium skin tone | person playing water polo | person playing water polo: medium skin tone | polo | water
🤽🏾	playing water polo: medium-dark skin tone	medium-dark skin tone | person playing water polo | person playing water polo: medium-dark skin tone | polo | water
🤽🏿	playing water polo: dark skin tone	dark skin tone | person playing water polo | person playing water polo: dark skin tone | polo | water
🤽‍♂️	playing water polo	
🤽‍♂	playing water polo	man | man playing water polo | water polo
🤽🏻‍♂️	playing water polo: light skin tone	
🤽🏻‍♂	playing water polo: light skin tone	light skin tone | man | man playing water polo | man playing water polo: light skin tone | water polo
🤽🏼‍♂️	playing water polo: medium-light skin tone	
🤽🏼‍♂	playing water polo: medium-light skin tone	man | man playing water polo | man playing water polo: medium-light skin tone | medium-light skin tone | water polo
🤽🏽‍♂️	playing water polo: medium skin tone	
🤽🏽‍♂	playing water polo: medium skin tone	man | man playing water polo | man playing water polo: medium skin tone | medium skin tone | water polo
🤽🏾‍♂️	playing water polo: medium-dark skin tone	
🤽🏾‍♂	playing water polo: medium-dark skin tone	man | man playing water polo | man playing water polo: medium-dark skin tone | medium-dark skin tone | water polo
🤽🏿‍♂️	playing water polo: dark skin tone	
🤽🏿‍♂	playing water polo: dark skin tone	dark skin tone | man | man playing water polo | man playing water polo: dark skin tone | water polo
🤽‍♀️	playing water polo	
🤽‍♀	playing water polo	water polo | woman | woman playing water polo
🤽🏻‍♀️	playing water polo: light skin tone	
🤽🏻‍♀	playing water polo: light skin tone	light skin tone | water polo | woman | woman playing water polo | woman playing water polo: light skin tone
🤽🏼‍♀️	playing water polo: medium-light skin tone	
🤽🏼‍♀	playing water polo: medium-light skin tone	medium-light skin tone | water polo | woman | woman playing water polo | woman playing water polo: medium-light skin tone
🤽🏽‍♀️	playing water polo: medium skin tone	
🤽🏽‍♀	playing water polo: medium skin tone	medium skin tone | water polo | woman | woman playing water polo | woman playing water polo: medium skin tone
🤽🏾‍♀️	playing water polo: medium-dark skin tone	
🤽🏾‍♀	playing water polo: medium-dark skin tone	medium-dark skin tone | water polo | woman | woman playing water polo | woman playing water polo: medium-dark skin tone
🤽🏿‍♀️	playing water polo: dark skin tone	
🤽🏿‍♀	playing water polo: dark skin tone	dark skin tone | water polo | woman | woman playing water polo | woman playing water polo: dark skin tone
🤾	playing handball	ball | handball | person playing handball
🤾🏻	playing handball: light skin tone	ball | handball | light skin tone | person playing handball | person playing handball: light skin tone
🤾🏼	playing handball: medium-light skin tone	ball | handball | medium-light skin tone | person playing handball | person playing handball: medium-light skin tone
🤾🏽	playing handball: medium skin tone	ball | handball | medium skin tone | person playing handball | person playing handball: medium skin tone
🤾🏾	playing handball: medium-dark skin tone	ball | handball | medium-dark skin tone | person playing handball | person playing handball: medium-dark skin tone
🤾🏿	playing handball: dark skin tone	ball | dark skin tone | handball | person playing handball | person playing handball: dark skin tone
🤾‍♂️	playing handball	
🤾‍♂	playing handball	handball | man | man playing handball
🤾🏻‍♂️	playing handball: light skin tone	
🤾🏻‍♂	playing handball: light skin tone	handball | light skin tone | man | man playing handball | man playing handball: light skin tone
🤾🏼‍♂️	playing handball: medium-light skin tone	
🤾🏼‍♂	playing handball: medium-light skin tone	handball | man | man playing handball | man playing handball: medium-light skin tone | medium-light skin tone
🤾🏽‍♂️	playing handball: medium skin tone	
🤾🏽‍♂	playing handball: medium skin tone	handball | man | man playing handball | man playing handball: medium skin tone | medium skin tone
🤾🏾‍♂️	playing handball: medium-dark skin tone	
🤾🏾‍♂	playing handball: medium-dark skin tone	handball | man | man playing handball | man playing handball: medium-dark skin tone | medium-dark skin tone
🤾🏿‍♂️	playing handball: dark skin tone	
🤾🏿‍♂	playing handball: dark skin tone	dark skin tone | handball | man | man playing handball | man playing handball: dark skin tone
🤾‍♀️	playing handball	
🤾‍♀	playing handball	handball | woman | woman playing handball
🤾🏻‍♀️	playing handball: light skin tone	
🤾🏻‍♀	playing handball: light skin tone	handball | light skin tone | woman | woman playing handball | woman playing handball: light skin tone
🤾🏼‍♀️	playing handball: medium-light skin tone	
🤾🏼‍♀	playing handball: medium-light skin tone	handball | medium-light skin tone | woman | woman playing handball | woman playing handball: medium-light skin tone
🤾🏽‍♀️	playing handball: medium skin tone	
🤾🏽‍♀	playing handball: medium skin tone	handball | medium skin tone | woman | woman playing handball | woman playing handball: medium skin tone
🤾🏾‍♀️	playing handball: medium-dark skin tone	
🤾🏾‍♀	playing handball: medium-dark skin tone	handball | medium-dark skin tone | woman | woman playing handball | woman playing handball: medium-dark skin tone
🤾🏿‍♀️	playing handball: dark skin tone	
🤾🏿‍♀	playing handball: dark skin tone	dark skin tone | handball | woman | woman playing handball | woman playing handball: dark skin tone
🤹	juggling	balance | juggle | multitask | person juggling | skill | multi-task
🤹🏻	juggling: light skin tone	balance | juggle | light skin tone | multitask | person juggling | person juggling: light skin tone | skill | multi-task
🤹🏼	juggling: medium-light skin tone	balance | juggle | medium-light skin tone | multitask | person juggling | person juggling: medium-light skin tone | skill | multi-task
🤹🏽	juggling: medium skin tone	balance | juggle | medium skin tone | multitask | person juggling | person juggling: medium skin tone | skill | multi-task
🤹🏾	juggling: medium-dark skin tone	balance | juggle | medium-dark skin tone | multitask | person juggling | person juggling: medium-dark skin tone | skill | multi-task
🤹🏿	juggling: dark skin tone	balance | dark skin tone | juggle | multitask | person juggling | person juggling: dark skin tone | skill | multi-task
🤹‍♂️	juggling	
🤹‍♂	juggling	juggling | man | multitask | multi-task
🤹🏻‍♂️	juggling: light skin tone	
🤹🏻‍♂	juggling: light skin tone	juggling | light skin tone | man | man juggling: light skin tone | multitask | multi-task
🤹🏼‍♂️	juggling: medium-light skin tone	
🤹🏼‍♂	juggling: medium-light skin tone	juggling | man | man juggling: medium-light skin tone | medium-light skin tone | multitask | multi-task
🤹🏽‍♂️	juggling: medium skin tone	
🤹🏽‍♂	juggling: medium skin tone	juggling | man | man juggling: medium skin tone | medium skin tone | multitask | multi-task
🤹🏾‍♂️	juggling: medium-dark skin tone	
🤹🏾‍♂	juggling: medium-dark skin tone	juggling | man | man juggling: medium-dark skin tone | medium-dark skin tone | multitask | multi-task
🤹🏿‍♂️	juggling: dark skin tone	
🤹🏿‍♂	juggling: dark skin tone	dark skin tone | juggling | man | man juggling: dark skin tone | multitask | multi-task
🤹‍♀️	juggling	
🤹‍♀	juggling	juggling | multitask | woman | multi-task
🤹🏻‍♀️	juggling: light skin tone	
🤹🏻‍♀	juggling: light skin tone	juggling | light skin tone | multitask | woman | woman juggling: light skin tone | multi-task
🤹🏼‍♀️	juggling: medium-light skin tone	
🤹🏼‍♀	juggling: medium-light skin tone	juggling | medium-light skin tone | multitask | woman | woman juggling: medium-light skin tone | multi-task
🤹🏽‍♀️	juggling: medium skin tone	
🤹🏽‍♀	juggling: medium skin tone	juggling | medium skin tone | multitask | woman | woman juggling: medium skin tone | multi-task
🤹🏾‍♀️	juggling: medium-dark skin tone	
🤹🏾‍♀	juggling: medium-dark skin tone	juggling | medium-dark skin tone | multitask | woman | woman juggling: medium-dark skin tone | multi-task
🤹🏿‍♀️	juggling: dark skin tone	
🤹🏿‍♀	juggling: dark skin tone	dark skin tone | juggling | multitask | woman | woman juggling: dark skin tone | multi-task
🧘	meditation | person in lotus position | yoga
🧘🏻	 light skin tone	light skin tone | meditation | person in lotus position | person in lotus position: light skin tone | yoga
🧘🏼	 medium-light skin tone	meditation | medium-light skin tone | person in lotus position | person in lotus position: medium-light skin tone | yoga
🧘🏽	 medium skin tone	meditation | medium skin tone | person in lotus position | person in lotus position: medium skin tone | yoga
🧘🏾	 medium-dark skin tone	meditation | medium-dark skin tone | person in lotus position | person in lotus position: medium-dark skin tone | yoga
🧘🏿	 dark skin tone	dark skin tone | meditation | person in lotus position | person in lotus position: dark skin tone | yoga
🧘‍♂	in lotus position	man in lotus position | meditation | yoga
🧘🏻‍♂️	 light skin tone	
🧘🏻‍♂	 light skin tone	light skin tone | man in lotus position | man in lotus position: light skin tone | meditation | yoga
🧘🏼‍♂️	 medium-light skin tone	
🧘🏼‍♂	 medium-light skin tone	man in lotus position | man in lotus position: medium-light skin tone | meditation | medium-light skin tone | yoga
🧘🏽‍♂️	 medium skin tone	
🧘🏽‍♂	 medium skin tone	man in lotus position | man in lotus position: medium skin tone | meditation | medium skin tone | yoga
🧘🏾‍♂️	 medium-dark skin tone	
🧘🏾‍♂	 medium-dark skin tone	man in lotus position | man in lotus position: medium-dark skin tone | meditation | medium-dark skin tone | yoga
🧘🏿‍♂️	 dark skin tone	
🧘🏿‍♂	 dark skin tone	dark skin tone | man in lotus position | man in lotus position: dark skin tone | meditation | yoga
🧘‍♀️	in lotus position	
🧘‍♀	in lotus position	meditation | woman in lotus position | yoga
🧘🏻‍♀️	 light skin tone	
🧘🏻‍♀	 light skin tone	light skin tone | meditation | woman in lotus position | woman in lotus position: light skin tone | yoga
🧘🏼‍♀️	 medium-light skin tone	
🧘🏼‍♀	 medium-light skin tone	meditation | medium-light skin tone | woman in lotus position | woman in lotus position: medium-light skin tone | yoga
🧘🏽‍♀️	 medium skin tone	
🧘🏽‍♀	 medium skin tone	meditation | medium skin tone | woman in lotus position | woman in lotus position: medium skin tone | yoga
🧘🏾‍♀️	 medium-dark skin tone	
🧘🏾‍♀	 medium-dark skin tone	meditation | medium-dark skin tone | woman in lotus position | woman in lotus position: medium-dark skin tone | yoga
🧘🏿‍♀️	 dark skin tone	
🧘🏿‍♀	 dark skin tone	dark skin tone | meditation | woman in lotus position | woman in lotus position: dark skin tone | yoga
🛀	taking bath	bath | bathtub | person taking bath | tub
🛀🏻	taking bath: light skin tone	bath | bathtub | light skin tone | person taking bath | person taking bath: light skin tone | tub
🛀🏼	taking bath: medium-light skin tone	bath | bathtub | medium-light skin tone | person taking bath | person taking bath: medium-light skin tone | tub
🛀🏽	taking bath: medium skin tone	bath | bathtub | medium skin tone | person taking bath | person taking bath: medium skin tone | tub
🛀🏾	taking bath: medium-dark skin tone	bath | bathtub | medium-dark skin tone | person taking bath | person taking bath: medium-dark skin tone | tub
🛀🏿	taking bath: dark skin tone	bath | bathtub | dark skin tone | person taking bath | person taking bath: dark skin tone | tub
🛌	in bed	good night | hotel | person in bed | sleep | sleeping
🛌🏻	in bed: light skin tone	good night | hotel | light skin tone | person in bed | person in bed: light skin tone | sleep | sleeping
🛌🏼	in bed: medium-light skin tone	good night | hotel | medium-light skin tone | person in bed | person in bed: medium-light skin tone | sleep | sleeping
🛌🏽	in bed: medium skin tone	good night | hotel | medium skin tone | person in bed | person in bed: medium skin tone | sleep | sleeping
🛌🏾	in bed: medium-dark skin tone	good night | hotel | medium-dark skin tone | person in bed | person in bed: medium-dark skin tone | sleep | sleeping
🛌🏿	in bed: dark skin tone	dark skin tone | good night | hotel | person in bed | person in bed: dark skin tone | sleep | sleeping
🧑‍🤝‍🧑	couple | hand | hold | holding hands | people holding hands | person
🧑🏻‍🤝‍🧑🏻	light skin tone	couple | hand | hold | holding hands | light skin tone | people holding hands | people holding hands: light skin tone | person
🧑🏻‍🤝‍🧑🏼	light skin tone, medium-light skin tone	couple | hand | hold | holding hands | light skin tone | medium-light skin tone | people holding hands | people holding hands: light skin tone, medium-light skin tone | person
🧑🏻‍🤝‍🧑🏽	light skin tone, medium skin tone	couple | hand | hold | holding hands | light skin tone | medium skin tone | people holding hands | people holding hands: light skin tone, medium skin tone | person
🧑🏻‍🤝‍🧑🏾	light skin tone, medium-dark skin tone	couple | hand | hold | holding hands | light skin tone | medium-dark skin tone | people holding hands | people holding hands: light skin tone, medium-dark skin tone | person
🧑🏻‍🤝‍🧑🏿	light skin tone, dark skin tone	couple | dark skin tone | hand | hold | holding hands | light skin tone | people holding hands | people holding hands: light skin tone, dark skin tone | person
🧑🏼‍🤝‍🧑🏻	medium-light skin tone, light skin tone	couple | hand | hold | holding hands | light skin tone | medium-light skin tone | people holding hands | people holding hands: medium-light skin tone, light skin tone | person
🧑🏼‍🤝‍🧑🏼	medium-light skin tone	couple | hand | hold | holding hands | medium-light skin tone | people holding hands | people holding hands: medium-light skin tone | person
🧑🏼‍🤝‍🧑🏽	medium-light skin tone, medium skin tone	couple | hand | hold | holding hands | medium skin tone | medium-light skin tone | people holding hands | people holding hands: medium-light skin tone, medium skin tone | person
🧑🏼‍🤝‍🧑🏾	medium-light skin tone, medium-dark skin tone	couple | hand | hold | holding hands | medium-dark skin tone | medium-light skin tone | people holding hands | people holding hands: medium-light skin tone, medium-dark skin tone | person
🧑🏼‍🤝‍🧑🏿	medium-light skin tone, dark skin tone	couple | dark skin tone | hand | hold | holding hands | medium-light skin tone | people holding hands | people holding hands: medium-light skin tone, dark skin tone | person
🧑🏽‍🤝‍🧑🏻	medium skin tone, light skin tone	couple | hand | hold | holding hands | light skin tone | medium skin tone | people holding hands | people holding hands: medium skin tone, light skin tone | person
🧑🏽‍🤝‍🧑🏼	medium skin tone, medium-light skin tone	couple | hand | hold | holding hands | medium skin tone | medium-light skin tone | people holding hands | people holding hands: medium skin tone, medium-light skin tone | person
🧑🏽‍🤝‍🧑🏽	medium skin tone	couple | hand | hold | holding hands | medium skin tone | people holding hands | people holding hands: medium skin tone | person
🧑🏽‍🤝‍🧑🏾	medium skin tone, medium-dark skin tone	couple | hand | hold | holding hands | medium skin tone | medium-dark skin tone | people holding hands | people holding hands: medium skin tone, medium-dark skin tone | person
🧑🏽‍🤝‍🧑🏿	medium skin tone, dark skin tone	couple | dark skin tone | hand | hold | holding hands | medium skin tone | people holding hands | people holding hands: medium skin tone, dark skin tone | person
🧑🏾‍🤝‍🧑🏻	medium-dark skin tone, light skin tone	couple | hand | hold | holding hands | light skin tone | medium-dark skin tone | people holding hands | people holding hands: medium-dark skin tone, light skin tone | person
🧑🏾‍🤝‍🧑🏼	medium-dark skin tone, medium-light skin tone	couple | hand | hold | holding hands | medium-dark skin tone | medium-light skin tone | people holding hands | people holding hands: medium-dark skin tone, medium-light skin tone | person
🧑🏾‍🤝‍🧑🏽	medium-dark skin tone, medium skin tone	couple | hand | hold | holding hands | medium skin tone | medium-dark skin tone | people holding hands | people holding hands: medium-dark skin tone, medium skin tone | person
🧑🏾‍🤝‍🧑🏾	medium-dark skin tone	couple | hand | hold | holding hands | medium-dark skin tone | people holding hands | people holding hands: medium-dark skin tone | person
🧑🏾‍🤝‍🧑🏿	medium-dark skin tone, dark skin tone	couple | dark skin tone | hand | hold | holding hands | medium-dark skin tone | people holding hands | people holding hands: medium-dark skin tone, dark skin tone | person
🧑🏿‍🤝‍🧑🏻	dark skin tone, light skin tone	couple | dark skin tone | hand | hold | holding hands | light skin tone | people holding hands | people holding hands: dark skin tone, light skin tone | person
🧑🏿‍🤝‍🧑🏼	dark skin tone, medium-light skin tone	couple | dark skin tone | hand | hold | holding hands | medium-light skin tone | people holding hands | people holding hands: dark skin tone, medium-light skin tone | person
🧑🏿‍🤝‍🧑🏽	dark skin tone, medium skin tone	couple | dark skin tone | hand | hold | holding hands | medium skin tone | people holding hands | people holding hands: dark skin tone, medium skin tone | person
🧑🏿‍🤝‍🧑🏾	dark skin tone, medium-dark skin tone	couple | dark skin tone | hand | hold | holding hands | medium-dark skin tone | people holding hands | people holding hands: dark skin tone, medium-dark skin tone | person
🧑🏿‍🤝‍🧑🏿	dark skin tone	couple | dark skin tone | hand | hold | holding hands | people holding hands | people holding hands: dark skin tone | person
👭	holding hands	couple | hand | holding hands | women | women holding hands | two women holding hands
👭🏻	light skin tone	couple | hand | holding hands | light skin tone | women | women holding hands | women holding hands: light skin tone | two women holding hands
👩🏻‍🤝‍👩🏼	light skin tone, medium-light skin tone	couple | hand | holding hands | light skin tone | medium-light skin tone | women | women holding hands | women holding hands: light skin tone, medium-light skin tone | two women holding hands
👩🏻‍🤝‍👩🏽	light skin tone, medium skin tone	couple | hand | holding hands | light skin tone | medium skin tone | women | women holding hands | women holding hands: light skin tone, medium skin tone | two women holding hands
👩🏻‍🤝‍👩🏾	light skin tone, medium-dark skin tone	couple | hand | holding hands | light skin tone | medium-dark skin tone | women | women holding hands | women holding hands: light skin tone, medium-dark skin tone | two women holding hands
👩🏻‍🤝‍👩🏿	light skin tone, dark skin tone	couple | dark skin tone | hand | holding hands | light skin tone | women | women holding hands | women holding hands: light skin tone, dark skin tone | two women holding hands
👩🏼‍🤝‍👩🏻	medium-light skin tone, light skin tone	couple | hand | holding hands | light skin tone | medium-light skin tone | women | women holding hands | women holding hands: medium-light skin tone, light skin tone | two women holding hands
👭🏼	medium-light skin tone	couple | hand | holding hands | medium-light skin tone | women | women holding hands | women holding hands: medium-light skin tone | two women holding hands
👩🏼‍🤝‍👩🏽	medium-light skin tone, medium skin tone	couple | hand | holding hands | medium skin tone | medium-light skin tone | women | women holding hands | women holding hands: medium-light skin tone, medium skin tone | two women holding hands
👩🏼‍🤝‍👩🏾	medium-light skin tone, medium-dark skin tone	couple | hand | holding hands | medium-dark skin tone | medium-light skin tone | women | women holding hands | women holding hands: medium-light skin tone, medium-dark skin tone | two women holding hands
👩🏼‍🤝‍👩🏿	medium-light skin tone, dark skin tone	couple | dark skin tone | hand | holding hands | medium-light skin tone | women | women holding hands | women holding hands: medium-light skin tone, dark skin tone | two women holding hands
👩🏽‍🤝‍👩🏻	medium skin tone, light skin tone	couple | hand | holding hands | light skin tone | medium skin tone | women | women holding hands | women holding hands: medium skin tone, light skin tone | two women holding hands
👩🏽‍🤝‍👩🏼	medium skin tone, medium-light skin tone	couple | hand | holding hands | medium skin tone | medium-light skin tone | women | women holding hands | women holding hands: medium skin tone, medium-light skin tone | two women holding hands
👭🏽	medium skin tone	couple | hand | holding hands | medium skin tone | women | women holding hands | women holding hands: medium skin tone | two women holding hands
👩🏽‍🤝‍👩🏾	medium skin tone, medium-dark skin tone	couple | hand | holding hands | medium skin tone | medium-dark skin tone | women | women holding hands | women holding hands: medium skin tone, medium-dark skin tone | two women holding hands
👩🏽‍🤝‍👩🏿	medium skin tone, dark skin tone	couple | dark skin tone | hand | holding hands | medium skin tone | women | women holding hands | women holding hands: medium skin tone, dark skin tone | two women holding hands
👩🏾‍🤝‍👩🏻	medium-dark skin tone, light skin tone	couple | hand | holding hands | light skin tone | medium-dark skin tone | women | women holding hands | women holding hands: medium-dark skin tone, light skin tone | two women holding hands
👩🏾‍🤝‍👩🏼	medium-dark skin tone, medium-light skin tone	couple | hand | holding hands | medium-dark skin tone | medium-light skin tone | women | women holding hands | women holding hands: medium-dark skin tone, medium-light skin tone | two women holding hands
👩🏾‍🤝‍👩🏽	medium-dark skin tone, medium skin tone	couple | hand | holding hands | medium skin tone | medium-dark skin tone | women | women holding hands | women holding hands: medium-dark skin tone, medium skin tone | two women holding hands
👭🏾	medium-dark skin tone	couple | hand | holding hands | medium-dark skin tone | women | women holding hands | women holding hands: medium-dark skin tone | two women holding hands
👩🏾‍🤝‍👩🏿	medium-dark skin tone, dark skin tone	couple | dark skin tone | hand | holding hands | medium-dark skin tone | women | women holding hands | women holding hands: medium-dark skin tone, dark skin tone | two women holding hands
👩🏿‍🤝‍👩🏻	dark skin tone, light skin tone	couple | dark skin tone | hand | holding hands | light skin tone | women | women holding hands | women holding hands: dark skin tone, light skin tone | two women holding hands
👩🏿‍🤝‍👩🏼	dark skin tone, medium-light skin tone	couple | dark skin tone | hand | holding hands | medium-light skin tone | women | women holding hands | women holding hands: dark skin tone, medium-light skin tone | two women holding hands
👩🏿‍🤝‍👩🏽	dark skin tone, medium skin tone	couple | dark skin tone | hand | holding hands | medium skin tone | women | women holding hands | women holding hands: dark skin tone, medium skin tone | two women holding hands
👩🏿‍🤝‍👩🏾	dark skin tone, medium-dark skin tone	couple | dark skin tone | hand | holding hands | medium-dark skin tone | women | women holding hands | women holding hands: dark skin tone, medium-dark skin tone | two women holding hands
👭🏿	dark skin tone	couple | dark skin tone | hand | holding hands | women | women holding hands | women holding hands: dark skin tone | two women holding hands
👫	couple | hand | hold | holding hands | man | woman | woman and man holding hands | man and woman holding hands
👫🏻	light skin tone	couple | hand | hold | holding hands | light skin tone | man | woman | woman and man holding hands | woman and man holding hands: light skin tone | man and woman holding hands
👩🏻‍🤝‍👨🏼	light skin tone, medium-light skin tone	couple | hand | hold | holding hands | light skin tone | man | medium-light skin tone | woman | woman and man holding hands | woman and man holding hands: light skin tone, medium-light skin tone | man and woman holding hands
👩🏻‍🤝‍👨🏽	light skin tone, medium skin tone	couple | hand | hold | holding hands | light skin tone | man | medium skin tone | woman | woman and man holding hands | woman and man holding hands: light skin tone, medium skin tone | man and woman holding hands
👩🏻‍🤝‍👨🏾	light skin tone, medium-dark skin tone	couple | hand | hold | holding hands | light skin tone | man | medium-dark skin tone | woman | woman and man holding hands | woman and man holding hands: light skin tone, medium-dark skin tone | man and woman holding hands
👩🏻‍🤝‍👨🏿	light skin tone, dark skin tone	couple | dark skin tone | hand | hold | holding hands | light skin tone | man | woman | woman and man holding hands | woman and man holding hands: light skin tone, dark skin tone | man and woman holding hands
👩🏼‍🤝‍👨🏻	medium-light skin tone, light skin tone	couple | hand | hold | holding hands | light skin tone | man | medium-light skin tone | woman | woman and man holding hands | woman and man holding hands: medium-light skin tone, light skin tone | man and woman holding hands
👫🏼	medium-light skin tone	couple | hand | hold | holding hands | man | medium-light skin tone | woman | woman and man holding hands | woman and man holding hands: medium-light skin tone | man and woman holding hands
👩🏼‍🤝‍👨🏽	medium-light skin tone, medium skin tone	couple | hand | hold | holding hands | man | medium skin tone | medium-light skin tone | woman | woman and man holding hands | woman and man holding hands: medium-light skin tone, medium skin tone | man and woman holding hands
👩🏼‍🤝‍👨🏾	medium-light skin tone, medium-dark skin tone	couple | hand | hold | holding hands | man | medium-dark skin tone | medium-light skin tone | woman | woman and man holding hands | woman and man holding hands: medium-light skin tone, medium-dark skin tone | man and woman holding hands
👩🏼‍🤝‍👨🏿	medium-light skin tone, dark skin tone	couple | dark skin tone | hand | hold | holding hands | man | medium-light skin tone | woman | woman and man holding hands | woman and man holding hands: medium-light skin tone, dark skin tone | man and woman holding hands
👩🏽‍🤝‍👨🏻	medium skin tone, light skin tone	couple | hand | hold | holding hands | light skin tone | man | medium skin tone | woman | woman and man holding hands | woman and man holding hands: medium skin tone, light skin tone | man and woman holding hands
👩🏽‍🤝‍👨🏼	medium skin tone, medium-light skin tone	couple | hand | hold | holding hands | man | medium skin tone | medium-light skin tone | woman | woman and man holding hands | woman and man holding hands: medium skin tone, medium-light skin tone | man and woman holding hands
👫🏽	medium skin tone	couple | hand | hold | holding hands | man | medium skin tone | woman | woman and man holding hands | woman and man holding hands: medium skin tone | man and woman holding hands
👩🏽‍🤝‍👨🏾	medium skin tone, medium-dark skin tone	couple | hand | hold | holding hands | man | medium skin tone | medium-dark skin tone | woman | woman and man holding hands | woman and man holding hands: medium skin tone, medium-dark skin tone | man and woman holding hands
👩🏽‍🤝‍👨🏿	medium skin tone, dark skin tone	couple | dark skin tone | hand | hold | holding hands | man | medium skin tone | woman | woman and man holding hands | woman and man holding hands: medium skin tone, dark skin tone | man and woman holding hands
👩🏾‍🤝‍👨🏻	medium-dark skin tone, light skin tone	couple | hand | hold | holding hands | light skin tone | man | medium-dark skin tone | woman | woman and man holding hands | woman and man holding hands: medium-dark skin tone, light skin tone | man and woman holding hands
👩🏾‍🤝‍👨🏼	medium-dark skin tone, medium-light skin tone	couple | hand | hold | holding hands | man | medium-dark skin tone | medium-light skin tone | woman | woman and man holding hands | woman and man holding hands: medium-dark skin tone, medium-light skin tone | man and woman holding hands
👩🏾‍🤝‍👨🏽	medium-dark skin tone, medium skin tone	couple | hand | hold | holding hands | man | medium skin tone | medium-dark skin tone | woman | woman and man holding hands | woman and man holding hands: medium-dark skin tone, medium skin tone | man and woman holding hands
👫🏾	medium-dark skin tone	couple | hand | hold | holding hands | man | medium-dark skin tone | woman | woman and man holding hands | woman and man holding hands: medium-dark skin tone | man and woman holding hands
👩🏾‍🤝‍👨🏿	medium-dark skin tone, dark skin tone	couple | dark skin tone | hand | hold | holding hands | man | medium-dark skin tone | woman | woman and man holding hands | woman and man holding hands: medium-dark skin tone, dark skin tone | man and woman holding hands
👩🏿‍🤝‍👨🏻	dark skin tone, light skin tone	couple | dark skin tone | hand | hold | holding hands | light skin tone | man | woman | woman and man holding hands | woman and man holding hands: dark skin tone, light skin tone | man and woman holding hands
👩🏿‍🤝‍👨🏼	dark skin tone, medium-light skin tone	couple | dark skin tone | hand | hold | holding hands | man | medium-light skin tone | woman | woman and man holding hands | woman and man holding hands: dark skin tone, medium-light skin tone | man and woman holding hands
👩🏿‍🤝‍👨🏽	dark skin tone, medium skin tone	couple | dark skin tone | hand | hold | holding hands | man | medium skin tone | woman | woman and man holding hands | woman and man holding hands: dark skin tone, medium skin tone | man and woman holding hands
👩🏿‍🤝‍👨🏾	dark skin tone, medium-dark skin tone	couple | dark skin tone | hand | hold | holding hands | man | medium-dark skin tone | woman | woman and man holding hands | woman and man holding hands: dark skin tone, medium-dark skin tone | man and woman holding hands
👫🏿	dark skin tone	couple | dark skin tone | hand | hold | holding hands | man | woman | woman and man holding hands | woman and man holding hands: dark skin tone | man and woman holding hands
👬	couple | Gemini | holding hands | man | men | men holding hands | twins | zodiac
👬🏻	light skin tone	couple | Gemini | holding hands | light skin tone | man | men | men holding hands | men holding hands: light skin tone | twins | zodiac
👨🏻‍🤝‍👨🏼	light skin tone, medium-light skin tone	couple | Gemini | holding hands | light skin tone | man | medium-light skin tone | men | men holding hands | men holding hands: light skin tone, medium-light skin tone | twins | zodiac
👨🏻‍🤝‍👨🏽	light skin tone, medium skin tone	couple | Gemini | holding hands | light skin tone | man | medium skin tone | men | men holding hands | men holding hands: light skin tone, medium skin tone | twins | zodiac
👨🏻‍🤝‍👨🏾	light skin tone, medium-dark skin tone	couple | Gemini | holding hands | light skin tone | man | medium-dark skin tone | men | men holding hands | men holding hands: light skin tone, medium-dark skin tone | twins | zodiac
👨🏻‍🤝‍👨🏿	light skin tone, dark skin tone	couple | dark skin tone | Gemini | holding hands | light skin tone | man | men | men holding hands | men holding hands: light skin tone, dark skin tone | twins | zodiac
👨🏼‍🤝‍👨🏻	medium-light skin tone, light skin tone	couple | Gemini | holding hands | light skin tone | man | medium-light skin tone | men | men holding hands | men holding hands: medium-light skin tone, light skin tone | twins | zodiac
👬🏼	medium-light skin tone	couple | Gemini | holding hands | man | medium-light skin tone | men | men holding hands | men holding hands: medium-light skin tone | twins | zodiac
👨🏼‍🤝‍👨🏽	medium-light skin tone, medium skin tone	couple | Gemini | holding hands | man | medium skin tone | medium-light skin tone | men | men holding hands | men holding hands: medium-light skin tone, medium skin tone | twins | zodiac
👨🏼‍🤝‍👨🏾	medium-light skin tone, medium-dark skin tone	couple | Gemini | holding hands | man | medium-dark skin tone | medium-light skin tone | men | men holding hands | men holding hands: medium-light skin tone, medium-dark skin tone | twins | zodiac
👨🏼‍🤝‍👨🏿	medium-light skin tone, dark skin tone	couple | dark skin tone | Gemini | holding hands | man | medium-light skin tone | men | men holding hands | men holding hands: medium-light skin tone, dark skin tone | twins | zodiac
👨🏽‍🤝‍👨🏻	medium skin tone, light skin tone	couple | Gemini | holding hands | light skin tone | man | medium skin tone | men | men holding hands | men holding hands: medium skin tone, light skin tone | twins | zodiac
👨🏽‍🤝‍👨🏼	medium skin tone, medium-light skin tone	couple | Gemini | holding hands | man | medium skin tone | medium-light skin tone | men | men holding hands | men holding hands: medium skin tone, medium-light skin tone | twins | zodiac
👬🏽	medium skin tone	couple | Gemini | holding hands | man | medium skin tone | men | men holding hands | men holding hands: medium skin tone | twins | zodiac
👨🏽‍🤝‍👨🏾	medium skin tone, medium-dark skin tone	couple | Gemini | holding hands | man | medium skin tone | medium-dark skin tone | men | men holding hands | men holding hands: medium skin tone, medium-dark skin tone | twins | zodiac
👨🏽‍🤝‍👨🏿	medium skin tone, dark skin tone	couple | dark skin tone | Gemini | holding hands | man | medium skin tone | men | men holding hands | men holding hands: medium skin tone, dark skin tone | twins | zodiac
👨🏾‍🤝‍👨🏻	medium-dark skin tone, light skin tone	couple | Gemini | holding hands | light skin tone | man | medium-dark skin tone | men | men holding hands | men holding hands: medium-dark skin tone, light skin tone | twins | zodiac
👨🏾‍🤝‍👨🏼	medium-dark skin tone, medium-light skin tone	couple | Gemini | holding hands | man | medium-dark skin tone | medium-light skin tone | men | men holding hands | men holding hands: medium-dark skin tone, medium-light skin tone | twins | zodiac
👨🏾‍🤝‍👨🏽	medium-dark skin tone, medium skin tone	couple | Gemini | holding hands | man | medium skin tone | medium-dark skin tone | men | men holding hands | men holding hands: medium-dark skin tone, medium skin tone | twins | zodiac
👬🏾	medium-dark skin tone	couple | Gemini | holding hands | man | medium-dark skin tone | men | men holding hands | men holding hands: medium-dark skin tone | twins | zodiac
👨🏾‍🤝‍👨🏿	medium-dark skin tone, dark skin tone	couple | dark skin tone | Gemini | holding hands | man | medium-dark skin tone | men | men holding hands | men holding hands: medium-dark skin tone, dark skin tone | twins | zodiac
👨🏿‍🤝‍👨🏻	dark skin tone, light skin tone	couple | dark skin tone | Gemini | holding hands | light skin tone | man | men | men holding hands | men holding hands: dark skin tone, light skin tone | twins | zodiac
👨🏿‍🤝‍👨🏼	dark skin tone, medium-light skin tone	couple | dark skin tone | Gemini | holding hands | man | medium-light skin tone | men | men holding hands | men holding hands: dark skin tone, medium-light skin tone | twins | zodiac
👨🏿‍🤝‍👨🏽	dark skin tone, medium skin tone	couple | dark skin tone | Gemini | holding hands | man | medium skin tone | men | men holding hands | men holding hands: dark skin tone, medium skin tone | twins | zodiac
👨🏿‍🤝‍👨🏾	dark skin tone, medium-dark skin tone	couple | dark skin tone | Gemini | holding hands | man | medium-dark skin tone | men | men holding hands | men holding hands: dark skin tone, medium-dark skin tone | twins | zodiac
👬🏿	dark skin tone	couple | dark skin tone | Gemini | holding hands | man | men | men holding hands | men holding hands: dark skin tone | twins | zodiac
💏	couple | kiss
💏🏻	light skin tone	couple | kiss | kiss: light skin tone | light skin tone
💏🏼	medium-light skin tone	couple | kiss | kiss: medium-light skin tone | medium-light skin tone
💏🏽	medium skin tone	couple | kiss | kiss: medium skin tone | medium skin tone
💏🏾	medium-dark skin tone	couple | kiss | kiss: medium-dark skin tone | medium-dark skin tone
💏🏿	dark skin tone	couple | dark skin tone | kiss | kiss: dark skin tone
🧑🏻‍❤️‍💋‍🧑🏼	person, person, light skin tone, medium-light skin tone	
🧑🏻‍❤‍💋‍🧑🏼	person, person, light skin tone, medium-light skin tone	couple | kiss | kiss: person, person, light skin tone, medium-light skin tone | light skin tone | medium-light skin tone | person
🧑🏻‍❤️‍💋‍🧑🏽	person, person, light skin tone, medium skin tone	
🧑🏻‍❤‍💋‍🧑🏽	person, person, light skin tone, medium skin tone	couple | kiss | kiss: person, person, light skin tone, medium skin tone | light skin tone | medium skin tone | person
🧑🏻‍❤️‍💋‍🧑🏾	person, person, light skin tone, medium-dark skin tone	
🧑🏻‍❤‍💋‍🧑🏾	person, person, light skin tone, medium-dark skin tone	couple | kiss | kiss: person, person, light skin tone, medium-dark skin tone | light skin tone | medium-dark skin tone | person
🧑🏻‍❤️‍💋‍🧑🏿	person, person, light skin tone, dark skin tone	
🧑🏻‍❤‍💋‍🧑🏿	person, perso—n, light skin tone, dark skin tone	couple | dark skin tone | kiss | kiss: person, person, light skin tone, dark skin tone | light skin tone | person
🧑🏼‍❤️‍💋‍🧑🏻	person, person, medium-light skin tone, light skin tone	
🧑🏼‍❤‍💋‍🧑🏻	person, person, medium-light skin tone, light skin tone	couple | kiss | kiss: person, person, medium-light skin tone, light skin tone | light skin tone | medium-light skin tone | person
🧑🏼‍❤️‍💋‍🧑🏽	person, person, medium-light skin tone, medium skin tone	
🧑🏼‍❤‍💋‍🧑🏽	person, person, medium-light skin tone, medium skin tone	couple | kiss | kiss: person, person, medium-light skin tone, medium skin tone | medium skin tone | medium-light skin tone | person
🧑🏼‍❤️‍💋‍🧑🏾	person, person, medium-light skin tone, medium-dark skin tone	
🧑🏼‍❤‍💋‍🧑🏾	person, person, medium-light skin tone, medium-dark skin tone	couple | kiss | kiss: person, person, medium-light skin tone, medium-dark skin tone | medium-dark skin tone | medium-light skin tone | person
🧑🏼‍❤️‍💋‍🧑🏿	person, person, medium-light skin tone, dark skin tone	
🧑🏼‍❤‍💋‍🧑🏿	person, person, medium-light skin tone, dark skin tone	couple | dark skin tone | kiss | kiss: person, person, medium-light skin tone, dark skin tone | medium-light skin tone | person
🧑🏽‍❤️‍💋‍🧑🏻	person, person, medium skin tone, light skin tone	
🧑🏽‍❤‍💋‍🧑🏻	person, person, medium skin tone, light skin tone	couple | kiss | kiss: person, person, medium skin tone, light skin tone | light skin tone | medium skin tone | person
🧑🏽‍❤️‍💋‍🧑🏼	person, person, medium skin tone, medium-light skin tone	
🧑🏽‍❤‍💋‍🧑🏼	person, person, medium skin tone, medium-light skin tone	couple | kiss | kiss: person, person, medium skin tone, medium-light skin tone | medium skin tone | medium-light skin tone | person
🧑🏽‍❤️‍💋‍🧑🏾	person, person, medium skin tone, medium-dark skin tone	
🧑🏽‍❤‍💋‍🧑🏾	person, person, medium skin tone, medium-dark skin tone	couple | kiss | kiss: person, person, medium skin tone, medium-dark skin tone | medium skin tone | medium-dark skin tone | person
🧑🏽‍❤️‍💋‍🧑🏿	person, person, medium skin tone, dark skin tone	
🧑🏽‍❤‍💋‍🧑🏿	person, person, medium skin tone, dark skin tone	couple | dark skin tone | kiss | kiss: person, person, medium skin tone, dark skin tone | medium skin tone | person
🧑🏾‍❤️‍💋‍🧑🏻	person, person, medium-dark skin tone, light skin tone	
🧑🏾‍❤‍💋‍🧑🏻	person, person, medium-dark skin tone, light skin tone	couple | kiss | kiss: person, person, medium-dark skin tone, light skin tone | light skin tone | medium-dark skin tone | person
🧑🏾‍❤️‍💋‍🧑🏼	person, person, medium-dark skin tone, medium-light skin tone	
🧑🏾‍❤‍💋‍🧑🏼	person, person, medium-dark skin tone, medium-light skin tone	couple | kiss | kiss: person, person, medium-dark skin tone, medium-light skin tone | medium-dark skin tone | medium-light skin tone | person
🧑🏾‍❤️‍💋‍🧑🏽	person, person, medium-dark skin tone, medium skin tone	
🧑🏾‍❤‍💋‍🧑🏽	person, person, medium-dark skin tone, medium skin tone	couple | kiss | kiss: person, person, medium-dark skin tone, medium skin tone | medium skin tone | medium-dark skin tone | person
🧑🏾‍❤️‍💋‍🧑🏿	person, person, medium-dark skin tone, dark skin tone	
🧑🏾‍❤‍💋‍🧑🏿	person, person, medium-dark skin tone, dark skin tone	couple | dark skin tone | kiss | kiss: person, person, medium-dark skin tone, dark skin tone | medium-dark skin tone | person
🧑🏿‍❤️‍💋‍🧑🏻	person, person, dark skin tone, light skin tone	
🧑🏿‍❤‍💋‍🧑🏻	person, person, dark skin tone, light skin tone	couple | dark skin tone | kiss | kiss: person, person, dark skin tone, light skin tone | light skin tone | person
🧑🏿‍❤️‍💋‍🧑🏼	person, person, dark skin tone, medium-light skin tone	
🧑🏿‍❤‍💋‍🧑🏼	person, person, dark skin tone, medium-light skin tone	couple | dark skin tone | kiss | kiss: person, person, dark skin tone, medium-light skin tone | medium-light skin tone | person
🧑🏿‍❤️‍💋‍🧑🏽	person, person, dark skin tone, medium skin tone	
🧑🏿‍❤‍💋‍🧑🏽	person, person, dark skin tone, medium skin tone	couple | dark skin tone | kiss | kiss: person, person, dark skin tone, medium skin tone | medium skin tone | person
🧑🏿‍❤️‍💋‍🧑🏾	person, person, dark skin tone, medium-dark skin tone	
🧑🏿‍❤‍💋‍🧑🏾	person, person, dark skin tone, medium-dark skin tone	couple | dark skin tone | kiss | kiss: person, person, dark skin tone, medium-dark skin tone | medium-dark skin tone | person
👩‍❤️‍💋‍👨	woman, man	
👩‍❤‍💋‍👨	woman, man	couple | kiss | kiss: woman, man | man | woman
👩🏻‍❤️‍💋‍👨🏻	woman, man, light skin tone	
👩🏻‍❤‍💋‍👨🏻	woman, man, light skin tone	couple | kiss | kiss: woman, man, light skin tone | light skin tone | man | woman
👩🏻‍❤️‍💋‍👨🏼	woman, man, light skin tone, medium-light skin tone	
👩🏻‍❤‍💋‍👨🏼	woman, man, light skin tone, medium-light skin tone	couple | kiss | kiss: woman, man, light skin tone, medium-light skin tone | light skin tone | man | medium-light skin tone | woman
👩🏻‍❤️‍💋‍👨🏽	woman, man, light skin tone, medium skin tone	
👩🏻‍❤‍💋‍👨🏽	woman, man, light skin tone, medium skin tone	couple | kiss | kiss: woman, man, light skin tone, medium skin tone | light skin tone | man | medium skin tone | woman
👩🏻‍❤️‍💋‍👨🏾	woman, man, light skin tone, medium-dark skin tone	
👩🏻‍❤‍💋‍👨🏾	woman, man, light skin tone, medium-dark skin tone	couple | kiss | kiss: woman, man, light skin tone, medium-dark skin tone | light skin tone | man | medium-dark skin tone | woman
👩🏻‍❤️‍💋‍👨🏿	woman, man, light skin tone, dark skin tone	
👩🏻‍❤‍💋‍👨🏿	woman, man, light skin tone, dark skin tone	couple | dark skin tone | kiss | kiss: woman, man, light skin tone, dark skin tone | light skin tone | man | woman
👩🏼‍❤️‍💋‍👨🏻	woman, man, medium-light skin tone, light skin tone	
👩🏼‍❤‍💋‍👨🏻	woman, man, medium-light skin tone, light skin tone	couple | kiss | kiss: woman, man, medium-light skin tone, light skin tone | light skin tone | man | medium-light skin tone | woman
👩🏼‍❤️‍💋‍👨🏼	woman, man, medium-light skin tone	
👩🏼‍❤‍💋‍👨🏼	woman, man, medium-light skin tone	couple | kiss | kiss: woman, man, medium-light skin tone | man | medium-light skin tone | woman
👩🏼‍❤️‍💋‍👨🏽	woman, man, medium-light skin tone, medium skin tone	
👩🏼‍❤‍💋‍👨🏽	woman, man, medium-light skin tone, medium skin tone	couple | kiss | kiss: woman, man, medium-light skin tone, medium skin tone | man | medium skin tone | medium-light skin tone | woman
👩🏼‍❤️‍💋‍👨🏾	woman, man, medium-light skin tone, medium-dark skin tone	
👩🏼‍❤‍💋‍👨🏾	woman, man, medium-light skin tone, medium-dark skin tone	couple | kiss | kiss: woman, man, medium-light skin tone, medium-dark skin tone | man | medium-dark skin tone | medium-light skin tone | woman
👩🏼‍❤️‍💋‍👨🏿	woman, man, medium-light skin tone, dark skin tone	
👩🏼‍❤‍💋‍👨🏿	woman, man, medium-light skin tone, dark skin tone	couple | dark skin tone | kiss | kiss: woman, man, medium-light skin tone, dark skin tone | man | medium-light skin tone | woman
👩🏽‍❤️‍💋‍👨🏻	woman, man, medium skin tone, light skin tone	
👩🏽‍❤‍💋‍👨🏻	woman, man, medium skin tone, light skin tone	couple | kiss | kiss: woman, man, medium skin tone, light skin tone | light skin tone | man | medium skin tone | woman
👩🏽‍❤️‍💋‍👨🏼	woman, man, medium skin tone, medium-light skin tone	
👩🏽‍❤‍💋‍👨🏼	woman, man, medium skin tone, medium-light skin tone	couple | kiss | kiss: woman, man, medium skin tone, medium-light skin tone | man | medium skin tone | medium-light skin tone | woman
👩🏽‍❤️‍💋‍👨🏽	woman, man, medium skin tone	
👩🏽‍❤‍💋‍👨🏽	woman, man, medium skin tone	couple | kiss | kiss: woman, man, medium skin tone | man | medium skin tone | woman
👩🏽‍❤️‍💋‍👨🏾	woman, man, medium skin tone, medium-dark skin tone	
👩🏽‍❤‍💋‍👨🏾	woman, man, medium skin tone, medium-dark skin tone	couple | kiss | kiss: woman, man, medium skin tone, medium-dark skin tone | man | medium skin tone | medium-dark skin tone | woman
👩🏽‍❤️‍💋‍👨🏿	woman, man, medium skin tone, dark skin tone	
👩🏽‍❤‍💋‍👨🏿	woman, man, medium skin tone, dark skin tone	couple | dark skin tone | kiss | kiss: woman, man, medium skin tone, dark skin tone | man | medium skin tone | woman
👩🏾‍❤️‍💋‍👨🏻	woman, man, medium-dark skin tone, light skin tone	
👩🏾‍❤‍💋‍👨🏻	woman, man, medium-dark skin tone, light skin tone	couple | kiss | kiss: woman, man, medium-dark skin tone, light skin tone | light skin tone | man | medium-dark skin tone | woman
👩🏾‍❤️‍💋‍👨🏼	woman, man, medium-dark skin tone, medium-light skin tone	
👩🏾‍❤‍💋‍👨🏼	woman, man, medium-dark skin tone, medium-light skin tone	couple | kiss | kiss: woman, man, medium-dark skin tone, medium-light skin tone | man | medium-dark skin tone | medium-light skin tone | woman
👩🏾‍❤️‍💋‍👨🏽	woman, man, medium-dark skin tone, medium skin tone	
👩🏾‍❤‍💋‍👨🏽	woman, man, medium-dark skin tone, medium skin tone	couple | kiss | kiss: woman, man, medium-dark skin tone, medium skin tone | man | medium skin tone | medium-dark skin tone | woman
👩🏾‍❤️‍💋‍👨🏾	woman, man, medium-dark skin tone	
👩🏾‍❤‍💋‍👨🏾	woman, man, medium-dark skin tone	couple | kiss | kiss: woman, man, medium-dark skin tone | man | medium-dark skin tone | woman
👩🏾‍❤️‍💋‍👨🏿	woman, man, medium-dark skin tone, dark skin tone	
👩🏾‍❤‍💋‍👨🏿	woman, man, medium-dark skin tone, dark skin tone	couple | dark skin tone | kiss | kiss: woman, man, medium-dark skin tone, dark skin tone | man | medium-dark skin tone | woman
👩🏿‍❤️‍💋‍👨🏻	woman, man, dark skin tone, light skin tone	
👩🏿‍❤‍💋‍👨🏻	woman, man, dark skin tone, light skin tone	couple | dark skin tone | kiss | kiss: woman, man, dark skin tone, light skin tone | light skin tone | man | woman
👩🏿‍❤️‍💋‍👨🏼	woman, man, dark skin tone, medium-light skin tone	
👩🏿‍❤‍💋‍👨🏼	woman, man, dark skin tone, medium-light skin tone	couple | dark skin tone | kiss | kiss: woman, man, dark skin tone, medium-light skin tone | man | medium-light skin tone | woman
👩🏿‍❤️‍💋‍👨🏽	woman, man, dark skin tone, medium skin tone	
👩🏿‍❤‍💋‍👨🏽	woman, man, dark skin tone, medium skin tone	couple | dark skin tone | kiss | kiss: woman, man, dark skin tone, medium skin tone | man | medium skin tone | woman
👩🏿‍❤️‍💋‍👨🏾	woman, man, dark skin tone, medium-dark skin tone	
👩🏿‍❤‍💋‍👨🏾	woman, man, dark skin tone, medium-dark skin tone	couple | dark skin tone | kiss | kiss: woman, man, dark skin tone, medium-dark skin tone | man | medium-dark skin tone | woman
👩🏿‍❤️‍💋‍👨🏿	woman, man, dark skin tone	
👩🏿‍❤‍💋‍👨🏿	woman, man, dark skin tone	couple | dark skin tone | kiss | kiss: woman, man, dark skin tone | man | woman
👨‍❤️‍💋‍👨	man, man	
👨‍❤‍💋‍👨	man, man	couple | kiss | kiss: man, man | man
👨🏻‍❤️‍💋‍👨🏻	man, man, light skin tone	
👨🏻‍❤‍💋‍👨🏻	man, man, light skin tone	couple | kiss | kiss: man, man, light skin tone | light skin tone | man
👨🏻‍❤️‍💋‍👨🏼	man, man, light skin tone, medium-light skin tone	
👨🏻‍❤‍💋‍👨🏼	man, man, light skin tone, medium-light skin tone	couple | kiss | kiss: man, man, light skin tone, medium-light skin tone | light skin tone | man | medium-light skin tone
👨🏻‍❤️‍💋‍👨🏽	man, man, light skin tone, medium skin tone	
👨🏻‍❤‍💋‍👨🏽	man, man, light skin tone, medium skin tone	couple | kiss | kiss: man, man, light skin tone, medium skin tone | light skin tone | man | medium skin tone
👨🏻‍❤️‍💋‍👨🏾	man, man, light skin tone, medium-dark skin tone	
👨🏻‍❤‍💋‍👨🏾	man, man, light skin tone, medium-dark skin tone	couple | kiss | kiss: man, man, light skin tone, medium-dark skin tone | light skin tone | man | medium-dark skin tone
👨🏻‍❤️‍💋‍👨🏿	man, man, light skin tone, dark skin tone	
👨🏻‍❤‍💋‍👨🏿	man, man, light skin tone, dark skin tone	couple | dark skin tone | kiss | kiss: man, man, light skin tone, dark skin tone | light skin tone | man
👨🏼‍❤️‍💋‍👨🏻	man, man, medium-light skin tone, light skin tone	
👨🏼‍❤‍💋‍👨🏻	man, man, medium-light skin tone, light skin tone	couple | kiss | kiss: man, man, medium-light skin tone, light skin tone | light skin tone | man | medium-light skin tone
👨🏼‍❤️‍💋‍👨🏼	man, man, medium-light skin tone	
👨🏼‍❤‍💋‍👨🏼	man, man, medium-light skin tone	couple | kiss | kiss: man, man, medium-light skin tone | man | medium-light skin tone
👨🏼‍❤️‍💋‍👨🏽	man, man, medium-light skin tone, medium skin tone	
👨🏼‍❤‍💋‍👨🏽	man, man, medium-light skin tone, medium skin tone	couple | kiss | kiss: man, man, medium-light skin tone, medium skin tone | man | medium skin tone | medium-light skin tone
👨🏼‍❤️‍💋‍👨🏾	man, man, medium-light skin tone, medium-dark skin tone	
👨🏼‍❤‍💋‍👨🏾	man, man, medium-light skin tone, medium-dark skin tone	couple | kiss | kiss: man, man, medium-light skin tone, medium-dark skin tone | man | medium-dark skin tone | medium-light skin tone
👨🏼‍❤️‍💋‍👨🏿	man, man, medium-light skin tone, dark skin tone	
👨🏼‍❤‍💋‍👨🏿	man, man, medium-light skin tone, dark skin tone	couple | dark skin tone | kiss | kiss: man, man, medium-light skin tone, dark skin tone | man | medium-light skin tone
👨🏽‍❤️‍💋‍👨🏻	man, man, medium skin tone, light skin tone	
👨🏽‍❤‍💋‍👨🏻	man, man, medium skin tone, light skin tone	couple | kiss | kiss: man, man, medium skin tone, light skin tone | light skin tone | man | medium skin tone
👨🏽‍❤️‍💋‍👨🏼	man, man, medium skin tone, medium-light skin tone	
👨🏽‍❤‍💋‍👨🏼	man, man, medium skin tone, medium-light skin tone	couple | kiss | kiss: man, man, medium skin tone, medium-light skin tone | man | medium skin tone | medium-light skin tone
👨🏽‍❤️‍💋‍👨🏽	man, man, medium skin tone	
👨🏽‍❤‍💋‍👨🏽	man, man, medium skin tone	couple | kiss | kiss: man, man, medium skin tone | man | medium skin tone
👨🏽‍❤️‍💋‍👨🏾	man, man, medium skin tone, medium-dark skin tone	
👨🏽‍❤‍💋‍👨🏾	man, man, medium skin tone, medium-dark skin tone	couple | kiss | kiss: man, man, medium skin tone, medium-dark skin tone | man | medium skin tone | medium-dark skin tone
👨🏽‍❤️‍💋‍👨🏿	man, man, medium skin tone, dark skin tone	
👨🏽‍❤‍💋‍👨🏿	man, man, medium skin tone, dark skin tone	couple | dark skin tone | kiss | kiss: man, man, medium skin tone, dark skin tone | man | medium skin tone
👨🏾‍❤️‍💋‍👨🏻	man, man, medium-dark skin tone, light skin tone	
👨🏾‍❤‍💋‍👨🏻	man, man, medium-dark skin tone, light skin tone	couple | kiss | kiss: man, man, medium-dark skin tone, light skin tone | light skin tone | man | medium-dark skin tone
👨🏾‍❤️‍💋‍👨🏼	man, man, medium-dark skin tone, medium-light skin tone	
👨🏾‍❤‍💋‍👨🏼	man, man, medium-dark skin tone, medium-light skin tone	couple | kiss | kiss: man, man, medium-dark skin tone, medium-light skin tone | man | medium-dark skin tone | medium-light skin tone
👨🏾‍❤️‍💋‍👨🏽	man, man, medium-dark skin tone, medium skin tone	
👨🏾‍❤‍💋‍👨🏽	man, man, medium-dark skin tone, medium skin tone	couple | kiss | kiss: man, man, medium-dark skin tone, medium skin tone | man | medium skin tone | medium-dark skin tone
👨🏾‍❤️‍💋‍👨🏾	man, man, medium-dark skin tone	
👨🏾‍❤‍💋‍👨🏾	man, man, medium-dark skin tone	couple | kiss | kiss: man, man, medium-dark skin tone | man | medium-dark skin tone
👨🏾‍❤️‍💋‍👨🏿	man, man, medium-dark skin tone, dark skin tone	
👨🏾‍❤‍💋‍👨🏿	man, man, medium-dark skin tone, dark skin tone	couple | dark skin tone | kiss | kiss: man, man, medium-dark skin tone, dark skin tone | man | medium-dark skin tone
👨🏿‍❤️‍💋‍👨🏻	man, man, dark skin tone, light skin tone	
👨🏿‍❤‍💋‍👨🏻	man, man, dark skin tone, light skin tone	couple | dark skin tone | kiss | kiss: man, man, dark skin tone, light skin tone | light skin tone | man
👨🏿‍❤️‍💋‍👨🏼	man, man, dark skin tone, medium-light skin tone	
👨🏿‍❤‍💋‍👨🏼	man, man, dark skin tone, medium-light skin tone	couple | dark skin tone | kiss | kiss: man, man, dark skin tone, medium-light skin tone | man | medium-light skin tone
👨🏿‍❤️‍💋‍👨🏽	man, man, dark skin tone, medium skin tone	
👨🏿‍❤‍💋‍👨🏽	man, man, dark skin tone, medium skin tone	couple | dark skin tone | kiss | kiss: man, man, dark skin tone, medium skin tone | man | medium skin tone
👨🏿‍❤️‍💋‍👨🏾	man, man, dark skin tone, medium-dark skin tone	
👨🏿‍❤‍💋‍👨🏾	man, man, dark skin tone, medium-dark skin tone	couple | dark skin tone | kiss | kiss: man, man, dark skin tone, medium-dark skin tone | man | medium-dark skin tone
👨🏿‍❤️‍💋‍👨🏿	man, man, dark skin tone	
👨🏿‍❤‍💋‍👨🏿	man, man, dark skin tone	couple | dark skin tone | kiss | kiss: man, man, dark skin tone | man
👩‍❤️‍💋‍👩	woman, woman	
👩‍❤‍💋‍👩	woman, woman	couple | kiss | kiss: woman, woman | woman
👩🏻‍❤️‍💋‍👩🏻	woman, woman, light skin tone	
👩🏻‍❤‍💋‍👩🏻	woman, woman, light skin tone	couple | kiss | kiss: woman, woman, light skin tone | light skin tone | woman
👩🏻‍❤️‍💋‍👩🏼	woman, woman, light skin tone, medium-light skin tone	
👩🏻‍❤‍💋‍👩🏼	woman, woman, light skin tone, medium-light skin tone	couple | kiss | kiss: woman, woman, light skin tone, medium-light skin tone | light skin tone | medium-light skin tone | woman
👩🏻‍❤️‍💋‍👩🏽	woman, woman, light skin tone, medium skin tone	
👩🏻‍❤‍💋‍👩🏽	woman, woman, light skin tone, medium skin tone	couple | kiss | kiss: woman, woman, light skin tone, medium skin tone | light skin tone | medium skin tone | woman
👩🏻‍❤️‍💋‍👩🏾	woman, woman, light skin tone, medium-dark skin tone	
👩🏻‍❤‍💋‍👩🏾	woman, woman, light skin tone, medium-dark skin tone	couple | kiss | kiss: woman, woman, light skin tone, medium-dark skin tone | light skin tone | medium-dark skin tone | woman
👩🏻‍❤️‍💋‍👩🏿	woman, woman, light skin tone, dark skin tone	
👩🏻‍❤‍💋‍👩🏿	woman, woman, light skin tone, dark skin tone	couple | dark skin tone | kiss | kiss: woman, woman, light skin tone, dark skin tone | light skin tone | woman
👩🏼‍❤️‍💋‍👩🏻	woman, woman, medium-light skin tone, light skin tone	
👩🏼‍❤‍💋‍👩🏻	woman, woman, medium-light skin tone, light skin tone	couple | kiss | kiss: woman, woman, medium-light skin tone, light skin tone | light skin tone | medium-light skin tone | woman
👩🏼‍❤️‍💋‍👩🏼	woman, woman, medium-light skin tone	
👩🏼‍❤‍💋‍👩🏼	woman, woman, medium-light skin tone	couple | kiss | kiss: woman, woman, medium-light skin tone | medium-light skin tone | woman
👩🏼‍❤️‍💋‍👩🏽	woman, woman, medium-light skin tone, medium skin tone	
👩🏼‍❤‍💋‍👩🏽	woman, woman, medium-light skin tone, medium skin tone	couple | kiss | kiss: woman, woman, medium-light skin tone, medium skin tone | medium skin tone | medium-light skin tone | woman
👩🏼‍❤️‍💋‍👩🏾	woman, woman, medium-light skin tone, medium-dark skin tone	
👩🏼‍❤‍💋‍👩🏾	woman, woman, medium-light skin tone, medium-dark skin tone	couple | kiss | kiss: woman, woman, medium-light skin tone, medium-dark skin tone | medium-dark skin tone | medium-light skin tone | woman
👩🏼‍❤️‍💋‍👩🏿	woman, woman, medium-light skin tone, dark skin tone	
👩🏼‍❤‍💋‍👩🏿	woman, woman, medium-light skin tone, dark skin tone	couple | dark skin tone | kiss | kiss: woman, woman, medium-light skin tone, dark skin tone | medium-light skin tone | woman
👩🏽‍❤️‍💋‍👩🏻	woman, woman, medium skin tone, light skin tone	
👩🏽‍❤‍💋‍👩🏻	woman, woman, medium skin tone, light skin tone	couple | kiss | kiss: woman, woman, medium skin tone, light skin tone | light skin tone | medium skin tone | woman
👩🏽‍❤️‍💋‍👩🏼	woman, woman, medium skin tone, medium-light skin tone	
👩🏽‍❤‍💋‍👩🏼	woman, woman, medium skin tone, medium-light skin tone	couple | kiss | kiss: woman, woman, medium skin tone, medium-light skin tone | medium skin tone | medium-light skin tone | woman
👩🏽‍❤️‍💋‍👩🏽	woman, woman, medium skin tone	
👩🏽‍❤‍💋‍👩🏽	woman, woman, medium skin tone	couple | kiss | kiss: woman, woman, medium skin tone | medium skin tone | woman
👩🏽‍❤️‍💋‍👩🏾	woman, woman, medium skin tone, medium-dark skin tone	
👩🏽‍❤‍💋‍👩🏾	woman, woman, medium skin tone, medium-dark skin tone	couple | kiss | kiss: woman, woman, medium skin tone, medium-dark skin tone | medium skin tone | medium-dark skin tone | woman
👩🏽‍❤️‍💋‍👩🏿	woman, woman, medium skin tone, dark skin tone	
👩🏽‍❤‍💋‍👩🏿	woman, woman, medium skin tone, dark skin tone	couple | dark skin tone | kiss | kiss: woman, woman, medium skin tone, dark skin tone | medium skin tone | woman
👩🏾‍❤️‍💋‍👩🏻	woman, woman, medium-dark skin tone, light skin tone	
👩🏾‍❤‍💋‍👩🏻	woman, woman, medium-dark skin tone, light skin tone	couple | kiss | kiss: woman, woman, medium-dark skin tone, light skin tone | light skin tone | medium-dark skin tone | woman
👩🏾‍❤️‍💋‍👩🏼	woman, woman, medium-dark skin tone, medium-light skin tone	
👩🏾‍❤‍💋‍👩🏼	woman, woman, medium-dark skin tone, medium-light skin tone	couple | kiss | kiss: woman, woman, medium-dark skin tone, medium-light skin tone | medium-dark skin tone | medium-light skin tone | woman
👩🏾‍❤️‍💋‍👩🏽	woman, woman, medium-dark skin tone, medium skin tone	
👩🏾‍❤‍💋‍👩🏽	woman, woman, medium-dark skin tone, medium skin tone	couple | kiss | kiss: woman, woman, medium-dark skin tone, medium skin tone | medium skin tone | medium-dark skin tone | woman
👩🏾‍❤️‍💋‍👩🏾	woman, woman, medium-dark skin tone	
👩🏾‍❤‍💋‍👩🏾	woman, woman, medium-dark skin tone	couple | kiss | kiss: woman, woman, medium-dark skin tone | medium-dark skin tone | woman
👩🏾‍❤️‍💋‍👩🏿	woman, woman, medium-dark skin tone, dark skin tone	
👩🏾‍❤‍💋‍👩🏿	woman, woman, medium-dark skin tone, dark skin tone	couple | dark skin tone | kiss | kiss: woman, woman, medium-dark skin tone, dark skin tone | medium-dark skin tone | woman
👩🏿‍❤️‍💋‍👩🏻	woman, woman, dark skin tone, light skin tone	
👩🏿‍❤‍💋‍👩🏻	woman, woman, dark skin tone, light skin tone	couple | dark skin tone | kiss | kiss: woman, woman, dark skin tone, light skin tone | light skin tone | woman
👩🏿‍❤️‍💋‍👩🏼	woman, woman, dark skin tone, medium-light skin tone	
👩🏿‍❤‍💋‍👩🏼	woman, woman, dark skin tone, medium-light skin tone	couple | dark skin tone | kiss | kiss: woman, woman, dark skin tone, medium-light skin tone | medium-light skin tone | woman
👩🏿‍❤️‍💋‍👩🏽	woman, woman, dark skin tone, medium skin tone	
👩🏿‍❤‍💋‍👩🏽	woman, woman, dark skin tone, medium skin tone	couple | dark skin tone | kiss | kiss: woman, woman, dark skin tone, medium skin tone | medium skin tone | woman
👩🏿‍❤️‍💋‍👩🏾	woman, woman, dark skin tone, medium-dark skin tone	
👩🏿‍❤‍💋‍👩🏾	woman, woman, dark skin tone, medium-dark skin tone	couple | dark skin tone | kiss | kiss: woman, woman, dark skin tone, medium-dark skin tone | medium-dark skin tone | woman
👩🏿‍❤️‍💋‍👩🏿	woman, woman, dark skin tone	
👩🏿‍❤‍💋‍👩🏿	woman, woman, dark skin tone	couple | dark skin tone | kiss | kiss: woman, woman, dark skin tone | woman
💑	with heart	couple | couple with heart | love
💑🏻	with heart: light skin tone	couple | couple with heart | couple with heart: light skin tone | light skin tone | love
💑🏼	with heart: medium-light skin tone	couple | couple with heart | couple with heart: medium-light skin tone | love | medium-light skin tone
💑🏽	with heart: medium skin tone	couple | couple with heart | couple with heart: medium skin tone | love | medium skin tone
💑🏾	with heart: medium-dark skin tone	couple | couple with heart | couple with heart: medium-dark skin tone | love | medium-dark skin tone
💑🏿	with heart: dark skin tone	couple | couple with heart | couple with heart: dark skin tone | dark skin tone | love
🧑🏻‍❤️‍🧑🏼	with heart: person, person, light skin tone, medium-light skin tone	
🧑🏻‍❤‍🧑🏼	with heart: person, person, light skin tone, medium-light skin tone	couple | couple with heart | couple with heart: person, person, light skin tone, medium-light skin tone | light skin tone | love | medium-light skin tone | person
🧑🏻‍❤️‍🧑🏽	with heart: person, person, light skin tone, medium skin tone	
🧑🏻‍❤‍🧑🏽	with heart: person, person, light skin tone, medium skin tone	couple | couple with heart | couple with heart: person, person, light skin tone, medium skin tone | light skin tone | love | medium skin tone | person
🧑🏻‍❤️‍🧑🏾	with heart: person, person, light skin tone, medium-dark skin tone	
🧑🏻‍❤‍🧑🏾	with heart: person, person, light skin tone, medium-dark skin tone	couple | couple with heart | couple with heart: person, person, light skin tone, medium-dark skin tone | light skin tone | love | medium-dark skin tone | person
🧑🏻‍❤️‍🧑🏿	with heart: person, person, light skin tone, dark skin tone	
🧑🏻‍❤‍🧑🏿	with heart: person, person, light skin tone, dark skin tone	couple | couple with heart | couple with heart: person, person, light skin tone, dark skin tone | dark skin tone | light skin tone | love | person
🧑🏼‍❤️‍🧑🏻	with heart: person, person, medium-light skin tone, light skin tone	
🧑🏼‍❤‍🧑🏻	with heart: person, person, medium-light skin tone, light skin tone	couple | couple with heart | couple with heart: person, person, medium-light skin tone, light skin tone | light skin tone | love | medium-light skin tone | person
🧑🏼‍❤️‍🧑🏽	with heart: person, person, medium-light skin tone, medium skin tone	
🧑🏼‍❤‍🧑🏽	with heart: person, person, medium-light skin tone, medium skin tone	couple | couple with heart | couple with heart: person, person, medium-light skin tone, medium skin tone | love | medium skin tone | medium-light skin tone | person
🧑🏼‍❤️‍🧑🏾	with heart: person, person, medium-light skin tone, medium-dark skin tone	
🧑🏼‍❤‍🧑🏾	with heart: person, person, medium-light skin tone, medium-dark skin tone	couple | couple with heart | couple with heart: person, person, medium-light skin tone, medium-dark skin tone | love | medium-dark skin tone | medium-light skin tone | person
🧑🏼‍❤️‍🧑🏿	with heart: person, person, medium-light skin tone, dark skin tone	
🧑🏼‍❤‍🧑🏿	with heart: person, person, medium-light skin tone, dark skin tone	couple | couple with heart | couple with heart: person, person, medium-light skin tone, dark skin tone | dark skin tone | love | medium-light skin tone | person
🧑🏽‍❤️‍🧑🏻	with heart: person, person, medium skin tone, light skin tone	
🧑🏽‍❤‍🧑🏻	with heart: person, person, medium skin tone, light skin tone	couple | couple with heart | couple with heart: person, person, medium skin tone, light skin tone | light skin tone | love | medium skin tone | person
🧑🏽‍❤️‍🧑🏼	with heart: person, person, medium skin tone, medium-light skin tone	
🧑🏽‍❤‍🧑🏼	with heart: person, person, medium skin tone, medium-light skin tone	couple | couple with heart | couple with heart: person, person, medium skin tone, medium-light skin tone | love | medium skin tone | medium-light skin tone | person
🧑🏽‍❤️‍🧑🏾	with heart: person, person, medium skin tone, medium-dark skin tone	
🧑🏽‍❤‍🧑🏾	with heart: person, person, medium skin tone, medium-dark skin tone	couple | couple with heart | couple with heart: person, person, medium skin tone, medium-dark skin tone | love | medium skin tone | medium-dark skin tone | person
🧑🏽‍❤️‍🧑🏿	with heart: person, person, medium skin tone, dark skin tone	
🧑🏽‍❤‍🧑🏿	with heart: person, person, medium skin tone, dark skin tone	couple | couple with heart | couple with heart: person, person, medium skin tone, dark skin tone | dark skin tone | love | medium skin tone | person
🧑🏾‍❤️‍🧑🏻	with heart: person, person, medium-dark skin tone, light skin tone	
🧑🏾‍❤‍🧑🏻	with heart: person, person, medium-dark skin tone, light skin tone	couple | couple with heart | couple with heart: person, person, medium-dark skin tone, light skin tone | light skin tone | love | medium-dark skin tone | person
🧑🏾‍❤️‍🧑🏼	with heart: person, person, medium-dark skin tone, medium-light skin tone	
🧑🏾‍❤‍🧑🏼	with heart: person, person, medium-dark skin tone, medium-light skin tone	couple | couple with heart | couple with heart: person, person, medium-dark skin tone, medium-light skin tone | love | medium-dark skin tone | medium-light skin tone | person
🧑🏾‍❤️‍🧑🏽	with heart: person, person, medium-dark skin tone, medium skin tone	
🧑🏾‍❤‍🧑🏽	with heart: person, person, medium-dark skin tone, medium skin tone	couple | couple with heart | couple with heart: person, person, medium-dark skin tone, medium skin tone | love | medium skin tone | medium-dark skin tone | person
🧑🏾‍❤️‍🧑🏿	with heart: person, person, medium-dark skin tone, dark skin tone	
🧑🏾‍❤‍🧑🏿	with heart: person, person, medium-dark skin tone, dark skin tone	couple | couple with heart | couple with heart: person, person, medium-dark skin tone, dark skin tone | dark skin tone | love | medium-dark skin tone | person
🧑🏿‍❤️‍🧑🏻	with heart: person, person, dark skin tone, light skin tone	
🧑🏿‍❤‍🧑🏻	with heart: person, person, dark skin tone, light skin tone	couple | couple with heart | couple with heart: person, person, dark skin tone, light skin tone | dark skin tone | light skin tone | love | person
🧑🏿‍❤️‍🧑🏼	with heart: person, person, dark skin tone, medium-light skin tone	
🧑🏿‍❤‍🧑🏼	with heart: person, person, dark skin tone, medium-light skin tone	couple | couple with heart | couple with heart: person, person, dark skin tone, medium-light skin tone | dark skin tone | love | medium-light skin tone | person
🧑🏿‍❤️‍🧑🏽	with heart: person, person, dark skin tone, medium skin tone	
🧑🏿‍❤‍🧑🏽	with heart: person, person, dark skin tone, medium skin tone	couple | couple with heart | couple with heart: person, person, dark skin tone, medium skin tone | dark skin tone | love | medium skin tone | person
🧑🏿‍❤️‍🧑🏾	with heart: person, person, dark skin tone, medium-dark skin tone	
🧑🏿‍❤‍🧑🏾	with heart: person, person, dark skin tone, medium-dark skin tone	couple | couple with heart | couple with heart: person, person, dark skin tone, medium-dark skin tone | dark skin tone | love | medium-dark skin tone | person
👩‍❤️‍👨	with heart: woman, man	
👩‍❤‍👨	with heart: woman, man	couple | couple with heart | couple with heart: woman, man | love | man | woman
👩🏻‍❤️‍👨🏻	with heart: woman, man, light skin tone	
👩🏻‍❤‍👨🏻	with heart: woman, man, light skin tone	couple | couple with heart | couple with heart: woman, man, light skin tone | light skin tone | love | man | woman
👩🏻‍❤️‍👨🏼	with heart: woman, man, light skin tone, medium-light skin tone	
👩🏻‍❤‍👨🏼	with heart: woman, man, light skin tone, medium-light skin tone	couple | couple with heart | couple with heart: woman, man, light skin tone, medium-light skin tone | light skin tone | love | man | medium-light skin tone | woman
👩🏻‍❤️‍👨🏽	with heart: woman, man, light skin tone, medium skin tone	
👩🏻‍❤‍👨🏽	with heart: woman, man, light skin tone, medium skin tone	couple | couple with heart | couple with heart: woman, man, light skin tone, medium skin tone | light skin tone | love | man | medium skin tone | woman
👩🏻‍❤️‍👨🏾	with heart: woman, man, light skin tone, medium-dark skin tone	
👩🏻‍❤‍👨🏾	with heart: woman, man, light skin tone, medium-dark skin tone	couple | couple with heart | couple with heart: woman, man, light skin tone, medium-dark skin tone | light skin tone | love | man | medium-dark skin tone | woman
👩🏻‍❤️‍👨🏿	with heart: woman, man, light skin tone, dark skin tone	
👩🏻‍❤‍👨🏿	with heart: woman, man, light skin tone, dark skin tone	couple | couple with heart | couple with heart: woman, man, light skin tone, dark skin tone | dark skin tone | light skin tone | love | man | woman
👩🏼‍❤️‍👨🏻	with heart: woman, man, medium-light skin tone, light skin tone	
👩🏼‍❤‍👨🏻	with heart: woman, man, medium-light skin tone, light skin tone	couple | couple with heart | couple with heart: woman, man, medium-light skin tone, light skin tone | light skin tone | love | man | medium-light skin tone | woman
👩🏼‍❤️‍👨🏼	with heart: woman, man, medium-light skin tone	
👩🏼‍❤‍👨🏼	with heart: woman, man, medium-light skin tone	couple | couple with heart | couple with heart: woman, man, medium-light skin tone | love | man | medium-light skin tone | woman
👩🏼‍❤️‍👨🏽	with heart: woman, man, medium-light skin tone, medium skin tone	
👩🏼‍❤‍👨🏽	with heart: woman, man, medium-light skin tone, medium skin tone	couple | couple with heart | couple with heart: woman, man, medium-light skin tone, medium skin tone | love | man | medium skin tone | medium-light skin tone | woman
👩🏼‍❤️‍👨🏾	with heart: woman, man, medium-light skin tone, medium-dark skin tone	
👩🏼‍❤‍👨🏾	with heart: woman, man, medium-light skin tone, medium-dark skin tone	couple | couple with heart | couple with heart: woman, man, medium-light skin tone, medium-dark skin tone | love | man | medium-dark skin tone | medium-light skin tone | woman
👩🏼‍❤️‍👨🏿	with heart: woman, man, medium-light skin tone, dark skin tone	
👩🏼‍❤‍👨🏿	with heart: woman, man, medium-light skin tone, dark skin tone	couple | couple with heart | couple with heart: woman, man, medium-light skin tone, dark skin tone | dark skin tone | love | man | medium-light skin tone | woman
👩🏽‍❤️‍👨🏻	with heart: woman, man, medium skin tone, light skin tone	
👩🏽‍❤‍👨🏻	with heart: woman, man, medium skin tone, light skin tone	couple | couple with heart | couple with heart: woman, man, medium skin tone, light skin tone | light skin tone | love | man | medium skin tone | woman
👩🏽‍❤️‍👨🏼	with heart: woman, man, medium skin tone, medium-light skin tone	
👩🏽‍❤‍👨🏼	with heart: woman, man, medium skin tone, medium-light skin tone	couple | couple with heart | couple with heart: woman, man, medium skin tone, medium-light skin tone | love | man | medium skin tone | medium-light skin tone | woman
👩🏽‍❤️‍👨🏽	with heart: woman, man, medium skin tone	
👩🏽‍❤‍👨🏽	with heart: woman, man, medium skin tone	couple | couple with heart | couple with heart: woman, man, medium skin tone | love | man | medium skin tone | woman
👩🏽‍❤️‍👨🏾	with heart: woman, man, medium skin tone, medium-dark skin tone	
👩🏽‍❤‍👨🏾	with heart: woman, man, medium skin tone, medium-dark skin tone	couple | couple with heart | couple with heart: woman, man, medium skin tone, medium-dark skin tone | love | man | medium skin tone | medium-dark skin tone | woman
👩🏽‍❤️‍👨🏿	with heart: woman, man, medium skin tone, dark skin tone	
👩🏽‍❤‍👨🏿	with heart: woman, man, medium skin tone, dark skin tone	couple | couple with heart | couple with heart: woman, man, medium skin tone, dark skin tone | dark skin tone | love | man | medium skin tone | woman
👩🏾‍❤️‍👨🏻	with heart: woman, man, medium-dark skin tone, light skin tone	
👩🏾‍❤‍👨🏻	with heart: woman, man, medium-dark skin tone, light skin tone	couple | couple with heart | couple with heart: woman, man, medium-dark skin tone, light skin tone | light skin tone | love | man | medium-dark skin tone | woman
👩🏾‍❤️‍👨🏼	with heart: woman, man, medium-dark skin tone, medium-light skin tone	
👩🏾‍❤‍👨🏼	with heart: woman, man, medium-dark skin tone, medium-light skin tone	couple | couple with heart | couple with heart: woman, man, medium-dark skin tone, medium-light skin tone | love | man | medium-dark skin tone | medium-light skin tone | woman
👩🏾‍❤️‍👨🏽	with heart: woman, man, medium-dark skin tone, medium skin tone	
👩🏾‍❤‍👨🏽	with heart: woman, man, medium-dark skin tone, medium skin tone	couple | couple with heart | couple with heart: woman, man, medium-dark skin tone, medium skin tone | love | man | medium skin tone | medium-dark skin tone | woman
👩🏾‍❤️‍👨🏾	with heart: woman, man, medium-dark skin tone	
👩🏾‍❤‍👨🏾	with heart: woman, man, medium-dark skin tone	couple | couple with heart | couple with heart: woman, man, medium-dark skin tone | love | man | medium-dark skin tone | woman
👩🏾‍❤️‍👨🏿	with heart: woman, man, medium-dark skin tone, dark skin tone	
👩🏾‍❤‍👨🏿	with heart: woman, man, medium-dark skin tone, dark skin tone	couple | couple with heart | couple with heart: woman, man, medium-dark skin tone, dark skin tone | dark skin tone | love | man | medium-dark skin tone | woman
👩🏿‍❤️‍👨🏻	with heart: woman, man, dark skin tone, light skin tone	
👩🏿‍❤‍👨🏻	with heart: woman, man, dark skin tone, light skin tone	couple | couple with heart | couple with heart: woman, man, dark skin tone, light skin tone | dark skin tone | light skin tone | love | man | woman
👩🏿‍❤️‍👨🏼	with heart: woman, man, dark skin tone, medium-light skin tone	
👩🏿‍❤‍👨🏼	with heart: woman, man, dark skin tone, medium-light skin tone	couple | couple with heart | couple with heart: woman, man, dark skin tone, medium-light skin tone | dark skin tone | love | man | medium-light skin tone | woman
👩🏿‍❤️‍👨🏽	with heart: woman, man, dark skin tone, medium skin tone	
👩🏿‍❤‍👨🏽	with heart: woman, man, dark skin tone, medium skin tone	couple | couple with heart | couple with heart: woman, man, dark skin tone, medium skin tone | dark skin tone | love | man | medium skin tone | woman
👩🏿‍❤️‍👨🏾	with heart: woman, man, dark skin tone, medium-dark skin tone	
👩🏿‍❤‍👨🏾	with heart: woman, man, dark skin tone, medium-dark skin tone	couple | couple with heart | couple with heart: woman, man, dark skin tone, medium-dark skin tone | dark skin tone | love | man | medium-dark skin tone | woman
👩🏿‍❤️‍👨🏿	with heart: woman, man, dark skin tone	
👩🏿‍❤‍👨🏿	with heart: woman, man, dark skin tone	couple | couple with heart | couple with heart: woman, man, dark skin tone | dark skin tone | love | man | woman
👨‍❤️‍👨	with heart: man, man	
👨‍❤‍👨	with heart: man, man	couple | couple with heart | couple with heart: man, man | love | man
👨🏻‍❤️‍👨🏻	with heart: man, man, light skin tone	
👨🏻‍❤‍👨🏻	with heart: man, man, light skin tone	couple | couple with heart | couple with heart: man, man, light skin tone | light skin tone | love | man
👨🏻‍❤️‍👨🏼	with heart: man, man, light skin tone, medium-light skin tone	
👨🏻‍❤‍👨🏼	with heart: man, man, light skin tone, medium-light skin tone	couple | couple with heart | couple with heart: man, man, light skin tone, medium-light skin tone | light skin tone | love | man | medium-light skin tone
👨🏻‍❤️‍👨🏽	with heart: man, man, light skin tone, medium skin tone	
👨🏻‍❤‍👨🏽	with heart: man, man, light skin tone, medium skin tone	couple | couple with heart | couple with heart: man, man, light skin tone, medium skin tone | light skin tone | love | man | medium skin tone
👨🏻‍❤️‍👨🏾	ith heart: man, man, light skin tone, medium-dark skin tone	
👨🏻‍❤‍👨🏾	with heart: man, man, light skin tone, medium-dark skin tone	couple | couple with heart | couple with heart: man, man, light skin tone, medium-dark skin tone | light skin tone | love | man | medium-dark skin tone
👨🏻‍❤️‍👨🏿	with heart: man, man, light skin tone, dark skin tone	
👨🏻‍❤‍👨🏿	with heart: man, man, light skin tone, dark skin tone	couple | couple with heart | couple with heart: man, man, light skin tone, dark skin tone | dark skin tone | light skin tone | love | man
👨🏼‍❤️‍👨🏻	with heart: man, man, medium-light skin tone, light skin tone	
👨🏼‍❤‍👨🏻	with heart: man, man, medium-light skin tone, light skin tone	couple | couple with heart | couple with heart: man, man, medium-light skin tone, light skin tone | light skin tone | love | man | medium-light skin tone
👨🏼‍❤️‍👨🏼	with heart: man, man, medium-light skin tone	
👨🏼‍❤‍👨🏼	with heart: man, man, medium-light skin tone	couple | couple with heart | couple with heart: man, man, medium-light skin tone | love | man | medium-light skin tone
👨🏼‍❤️‍👨🏽	with heart: man, man, medium-light skin tone, medium skin tone	
👨🏼‍❤‍👨🏽	with heart: man, man, medium-light skin tone, medium skin tone	couple | couple with heart | couple with heart: man, man, medium-light skin tone, medium skin tone | love | man | medium skin tone | medium-light skin tone
👨🏼‍❤️‍👨🏾	with heart: man, man, medium-light skin tone, medium-dark skin tone	
👨🏼‍❤‍👨🏾	with heart: man, man, medium-light skin tone, medium-dark skin tone	couple | couple with heart | couple with heart: man, man, medium-light skin tone, medium-dark skin tone | love | man | medium-dark skin tone | medium-light skin tone
👨🏼‍❤️‍👨🏿	with heart: man, man, medium-light skin tone, dark skin tone	
👨🏼‍❤‍👨🏿	with heart: man, man, medium-light skin tone, dark skin tone	couple | couple with heart | couple with heart: man, man, medium-light skin tone, dark skin tone | dark skin tone | love | man | medium-light skin tone
👨🏽‍❤️‍👨🏻	with heart: man, man, medium skin tone, light skin tone	
👨🏽‍❤‍👨🏻	with heart: man, man, medium skin tone, light skin tone	couple | couple with heart | couple with heart: man, man, medium skin tone, light skin tone | light skin tone | love | man | medium skin tone
👨🏽‍❤️‍👨🏼	with heart: man, man, medium skin tone, medium-light skin tone	
👨🏽‍❤‍👨🏼	with heart: man, man, medium skin tone, medium-light skin tone	couple | couple with heart | couple with heart: man, man, medium skin tone, medium-light skin tone | love | man | medium skin tone | medium-light skin tone
👨🏽‍❤️‍👨🏽	with heart: man, man, medium skin tone	
👨🏽‍❤‍👨🏽	with heart: man, man, medium skin tone	couple | couple with heart | couple with heart: man, man, medium skin tone | love | man | medium skin tone
👨🏽‍❤️‍👨🏾	with heart: man, man, medium skin tone, medium-dark skin tone	
👨🏽‍❤‍👨🏾	with heart: man, man, medium skin tone, medium-dark skin tone	couple | couple with heart | couple with heart: man, man, medium skin tone, medium-dark skin tone | love | man | medium skin tone | medium-dark skin tone
👨🏽‍❤️‍👨🏿	with heart: man, man, medium skin tone, dark skin tone	
👨🏽‍❤‍👨🏿	with heart: man, man, medium skin tone, dark skin tone	couple | couple with heart | couple with heart: man, man, medium skin tone, dark skin tone | dark skin tone | love | man | medium skin tone
👨🏾‍❤️‍👨🏻	with heart: man, man, medium-dark skin tone, light skin tone	
👨🏾‍❤‍👨🏻	with heart: man, man, medium-dark skin tone, light skin tone	couple | couple with heart | couple with heart: man, man, medium-dark skin tone, light skin tone | light skin tone | love | man | medium-dark skin tone
👨🏾‍❤️‍👨🏼	with heart: man, man, medium-dark skin tone, medium-light skin tone	
👨🏾‍❤‍👨🏼	with heart: man, man, medium-dark skin tone, medium-light skin tone	couple | couple with heart | couple with heart: man, man, medium-dark skin tone, medium-light skin tone | love | man | medium-dark skin tone | medium-light skin tone
👨🏾‍❤️‍👨🏽	with heart: man, man, medium-dark skin tone, medium skin tone	
👨🏾‍❤‍👨🏽	with heart: man, man, medium-dark skin tone, medium skin tone	couple | couple with heart | couple with heart: man, man, medium-dark skin tone, medium skin tone | love | man | medium skin tone | medium-dark skin tone
👨🏾‍❤️‍👨🏾	with heart: man, man, medium-dark skin tone	
👨🏾‍❤‍👨🏾	with heart: man, man, medium-dark skin tone	couple | couple with heart | couple with heart: man, man, medium-dark skin tone | love | man | medium-dark skin tone
👨🏾‍❤️‍👨🏿	with heart: man, man, medium-dark skin tone, dark skin tone	
👨🏾‍❤‍👨🏿	with heart: man, man, medium-dark skin tone, dark skin tone	couple | couple with heart | couple with heart: man, man, medium-dark skin tone, dark skin tone | dark skin tone | love | man | medium-dark skin tone
👨🏿‍❤️‍👨🏻	with heart: man, man, dark skin tone, light skin tone	
👨🏿‍❤‍👨🏻	with heart: man, man, dark skin tone, light skin tone	couple | couple with heart | couple with heart: man, man, dark skin tone, light skin tone | dark skin tone | light skin tone | love | man
👨🏿‍❤️‍👨🏼	with heart: man, man, dark skin tone, medium-light skin tone	
👨🏿‍❤‍👨🏼	with heart: man, man, dark skin tone, medium-light skin tone	couple | couple with heart | couple with heart: man, man, dark skin tone, medium-light skin tone | dark skin tone | love | man | medium-light skin tone
👨🏿‍❤️‍👨🏽	with heart: man, man, dark skin tone, medium skin tone	
👨🏿‍❤‍👨🏽	with heart: man, man, dark skin tone, medium skin tone	couple | couple with heart | couple with heart: man, man, dark skin tone, medium skin tone | dark skin tone | love | man | medium skin tone
👨🏿‍❤️‍👨🏾	with heart: man, man, dark skin tone, medium-dark skin tone	
👨🏿‍❤‍👨🏾	with heart: man, man, dark skin tone, medium-dark skin tone	couple | couple with heart | couple with heart: man, man, dark skin tone, medium-dark skin tone | dark skin tone | love | man | medium-dark skin tone
👨🏿‍❤️‍👨🏿	with heart: man, man, dark skin tone	
👨🏿‍❤‍👨🏿	with heart: man, man, dark skin tone	couple | couple with heart | couple with heart: man, man, dark skin tone | dark skin tone | love | man
👩‍❤️‍👩	with heart: woman, woman	
👩‍❤‍👩	with heart: woman, woman	couple | couple with heart | couple with heart: woman, woman | love | woman
👩🏻‍❤️‍👩🏻	with heart: woman, woman, light skin tone	
👩🏻‍❤‍👩🏻	with heart: woman, woman, light skin tone	couple | couple with heart | couple with heart: woman, woman, light skin tone | light skin tone | love | woman
👩🏻‍❤️‍👩🏼	with heart: woman, woman, light skin tone, medium-light skin tone	
👩🏻‍❤‍👩🏼	with heart: woman, woman, light skin tone, medium-light skin tone	couple | couple with heart | couple with heart: woman, woman, light skin tone, medium-light skin tone | light skin tone | love | medium-light skin tone | woman
👩🏻‍❤️‍👩🏽	with heart: woman, woman, light skin tone, medium skin tone	
👩🏻‍❤‍👩🏽	with heart: woman, woman, light skin tone, medium skin tone	couple | couple with heart | couple with heart: woman, woman, light skin tone, medium skin tone | light skin tone | love | medium skin tone | woman
👩🏻‍❤️‍👩🏾	with heart: woman, woman, light skin tone, medium-dark skin tone	
👩🏻‍❤‍👩🏾	with heart: woman, woman, light skin tone, medium-dark skin tone	couple | couple with heart | couple with heart: woman, woman, light skin tone, medium-dark skin tone | light skin tone | love | medium-dark skin tone | woman
👩🏻‍❤️‍👩🏿	with heart: woman, woman, light skin tone, dark skin tone	
👩🏻‍❤‍👩🏿	with heart: woman, woman, light skin tone, dark skin tone	couple | couple with heart | couple with heart: woman, woman, light skin tone, dark skin tone | dark skin tone | light skin tone | love | woman
👩🏼‍❤️‍👩🏻	with heart: woman, woman, medium-light skin tone, light skin tone	
👩🏼‍❤‍👩🏻	with heart: woman, woman, medium-light skin tone, light skin tone	couple | couple with heart | couple with heart: woman, woman, medium-light skin tone, light skin tone | light skin tone | love | medium-light skin tone | woman
👩🏼‍❤️‍👩🏼	with heart: woman, woman, medium-light skin tone	
👩🏼‍❤‍👩🏼	with heart: woman, woman, medium-light skin tone	couple | couple with heart | couple with heart: woman, woman, medium-light skin tone | love | medium-light skin tone | woman
👩🏼‍❤️‍👩🏽	with heart: woman, woman, medium-light skin tone, medium skin tone	
👩🏼‍❤‍👩🏽	with heart: woman, woman, medium-light skin tone, medium skin tone	couple | couple with heart | couple with heart: woman, woman, medium-light skin tone, medium skin tone | love | medium skin tone | medium-light skin tone | woman
👩🏼‍❤️‍👩🏾	with heart: woman, woman, medium-light skin tone, medium-dark skin tone	
👩🏼‍❤‍👩🏾	with heart: woman, woman, medium-light skin tone, medium-dark skin tone	couple | couple with heart | couple with heart: woman, woman, medium-light skin tone, medium-dark skin tone | love | medium-dark skin tone | medium-light skin tone | woman
👩🏼‍❤️‍👩🏿	with heart: woman, woman, medium-light skin tone, dark skin tone	
👩🏼‍❤‍👩🏿	with heart: woman, woman, medium-light skin tone, dark skin tone	couple | couple with heart | couple with heart: woman, woman, medium-light skin tone, dark skin tone | dark skin tone | love | medium-light skin tone | woman
👩🏽‍❤️‍👩🏻	with heart: woman, woman, medium skin tone, light skin tone	
👩🏽‍❤‍👩🏻	with heart: woman, woman, medium skin tone, light skin tone	couple | couple with heart | couple with heart: woman, woman, medium skin tone, light skin tone | light skin tone | love | medium skin tone | woman
👩🏽‍❤️‍👩🏼	with heart: woman, woman, medium skin tone, medium-light skin tone	
👩🏽‍❤‍👩🏼	with heart: woman, woman, medium skin tone, medium-light skin tone	couple | couple with heart | couple with heart: woman, woman, medium skin tone, medium-light skin tone | love | medium skin tone | medium-light skin tone | woman
👩🏽‍❤️‍👩🏽	with heart: woman, woman, medium skin tone	
👩🏽‍❤‍👩🏽	with heart: woman, woman, medium skin tone	couple | couple with heart | couple with heart: woman, woman, medium skin tone | love | medium skin tone | woman
👩🏽‍❤️‍👩🏾	with heart: woman, woman, medium skin tone, medium-dark skin tone	
👩🏽‍❤‍👩🏾	with heart: woman, woman, medium skin tone, medium-dark skin tone	couple | couple with heart | couple with heart: woman, woman, medium skin tone, medium-dark skin tone | love | medium skin tone | medium-dark skin tone | woman
👩🏽‍❤️‍👩🏿	with heart: woman, woman, medium skin tone, dark skin tone	
👩🏽‍❤‍👩🏿	with heart: woman, woman, medium skin tone, dark skin tone	couple | couple with heart | couple with heart: woman, woman, medium skin tone, dark skin tone | dark skin tone | love | medium skin tone | woman
👩🏾‍❤️‍👩🏻	with heart: woman, woman, medium-dark skin tone, light skin tone	
👩🏾‍❤‍👩🏻	with heart: woman, woman, medium-dark skin tone, light skin tone	couple | couple with heart | couple with heart: woman, woman, medium-dark skin tone, light skin tone | light skin tone | love | medium-dark skin tone | woman
👩🏾‍❤️‍👩🏼	with heart: woman, woman, medium-dark skin tone, medium-light skin tone	
👩🏾‍❤‍👩🏼	with heart: woman, woman, medium-dark skin tone, medium-light skin tone	couple | couple with heart | couple with heart: woman, woman, medium-dark skin tone, medium-light skin tone | love | medium-dark skin tone | medium-light skin tone | woman
👩🏾‍❤️‍👩🏽	with heart: woman, woman, medium-dark skin tone, medium skin tone	
👩🏾‍❤‍👩🏽	with heart: woman, woman, medium-dark skin tone, medium skin tone	couple | couple with heart | couple with heart: woman, woman, medium-dark skin tone, medium skin tone | love | medium skin tone | medium-dark skin tone | woman
👩🏾‍❤️‍👩🏾	with heart: woman, woman, medium-dark skin tone	
👩🏾‍❤‍👩🏾	with heart: woman, woman, medium-dark skin tone	couple | couple with heart | couple with heart: woman, woman, medium-dark skin tone | love | medium-dark skin tone | woman
👩🏾‍❤️‍👩🏿	with heart: woman, woman, medium-dark skin tone, dark skin tone	
👩🏾‍❤‍👩🏿	with heart: woman, woman, medium-dark skin tone, dark skin tone	couple | couple with heart | couple with heart: woman, woman, medium-dark skin tone, dark skin tone | dark skin tone | love | medium-dark skin tone | woman
👩🏿‍❤️‍👩🏻	with heart: woman, woman, dark skin tone, light skin tone	
👩🏿‍❤‍👩🏻	with heart: woman, woman, dark skin tone, light skin tone	couple | couple with heart | couple with heart: woman, woman, dark skin tone, light skin tone | dark skin tone | light skin tone | love | woman
👩🏿‍❤️‍👩🏼	with heart: woman, woman, dark skin tone, medium-light skin tone	
👩🏿‍❤‍👩🏼	with heart: woman, woman, dark skin tone, medium-light skin tone	couple | couple with heart | couple with heart: woman, woman, dark skin tone, medium-light skin tone | dark skin tone | love | medium-light skin tone | woman
👩🏿‍❤️‍👩🏽	with heart: woman, woman, dark skin tone, medium skin tone	
👩🏿‍❤‍👩🏽	with heart: woman, woman, dark skin tone, medium skin tone	couple | couple with heart | couple with heart: woman, woman, dark skin tone, medium skin tone | dark skin tone | love | medium skin tone | woman
👩🏿‍❤️‍👩🏾	with heart: woman, woman, dark skin tone, medium-dark skin tone	
👩🏿‍❤‍👩🏾	with heart: woman, woman, dark skin tone, medium-dark skin tone	couple | couple with heart | couple with heart: woman, woman, dark skin tone, medium-dark skin tone | dark skin tone | love | medium-dark skin tone | woman
👩🏿‍❤️‍👩🏿	with heart: woman, woman, dark skin tone	
👩🏿‍❤‍👩🏿	with heart: woman, woman, dark skin tone	couple | couple with heart | couple with heart: woman, woman, dark skin tone | dark skin tone | love | woman
👨‍👩‍👦	man, woman, boy	boy | family | family: man, woman, boy | man | woman
👨‍👩‍👧	man, woman, girl	family | family: man, woman, girl | girl | man | woman
👨‍👩‍👧‍👦	man, woman, girl, boy	boy | family | family: man, woman, girl, boy | girl | man | woman
👨‍👩‍👦‍👦	man, woman, boy, boy	boy | family | family: man, woman, boy, boy | man | woman
👨‍👩‍👧‍👧	man, woman, girl, girl	family | family: man, woman, girl, girl | girl | man | woman
👨‍👨‍👦	man, man, boy	boy | family | family: man, man, boy | man
👨‍👨‍👧	man, man, girl	family | family: man, man, girl | girl | man
👨‍👨‍👧‍👦	man, man, girl, boy	boy | family | family: man, man, girl, boy | girl | man
👨‍👨‍👦‍👦	man, man, boy, boy	boy | family | family: man, man, boy, boy | man
👨‍👨‍👧‍👧	man, man, girl, girl	family | family: man, man, girl, girl | girl | man
👩‍👩‍👦	woman, woman, boy	boy | family | family: woman, woman, boy | woman
👩‍👩‍👧	woman, woman, girl	family | family: woman, woman, girl | girl | woman
👩‍👩‍👧‍👦	woman, woman, girl, boy	boy | family | family: woman, woman, girl, boy | girl | woman
👩‍👩‍👦‍👦	woman, woman, boy, boy	boy | family | family: woman, woman, boy, boy | woman
👩‍👩‍👧‍👧	woman, woman, girl, girl	family | family: woman, woman, girl, girl | girl | woman
👨‍👦	man, boy	boy | family | family: man, boy | man
👨‍👦‍👦	man, boy, boy	boy | family | family: man, boy, boy | man
👨‍👧	man, girl	family | family: man, girl | girl | man
👨‍👧‍👦	man, girl, boy	boy | family | family: man, girl, boy | girl | man
👨‍👧‍👧	man, girl, girl	family | family: man, girl, girl | girl | man
👩‍👦	woman, boy	boy | family | family: woman, boy | woman
👩‍👦‍👦	woman, boy, boy	boy | family | family: woman, boy, boy | woman
👩‍👧	woman, girl	family | family: woman, girl | girl | woman
👩‍👧‍👦	woman, girl, boy	boy | family | family: woman, girl, boy | girl | woman
👩‍👧‍👧	woman, girl, girl	family | family: woman, girl, girl | girl | woman
🗣️	head	
🗣	head	face | head | silhouette | speak | speaking
👤	in silhouette	bust | bust in silhouette | silhouette
👥	in silhouette	bust | busts in silhouette | silhouette
🫂	hugging	goodbye | hello | hug | people hugging | thanks
👪	family
🧑‍🧑‍🧒	adult, adult, child	family: adult, adult, child
🧑‍🧑‍🧒‍🧒	adult, adult, child, child	family: adult, adult, child, child
🧑‍🧒	adult, child	family: adult, child
🧑‍🧒‍🧒	adult, child, child	family: adult, child, child
👣	clothing | footprint | footprints | print
🏻	Component	skin-tone	skin tone	light skin tone | skin tone | type 1–2
🏼	Component	skin-tone	skin tone	medium-light skin tone | skin tone | type 3
🏽	Component	skin-tone	skin tone	medium skin tone | skin tone | type 4
🏾	Component	skin-tone	skin tone	medium-dark skin tone | skin tone | type 5
🏿	Component	skin-tone	skin tone	dark skin tone | skin tone | type 6
🦰	Component	hair-style	hair	ginger | red hair | redhead
🦱	Component	hair-style	hair	afro | curly | curly hair | ringlets
🦳	Component	hair-style	hair	gray | hair | old | white | grey
🦲	Component	hair-style		bald | chemotherapy | hairless | no hair | shaven
🐵	face	face | monkey
🐒	monkey
🦍	gorilla
🦧	ape | orangutan
🐶	face	dog | face | pet
🐕	dog | pet
🦮	dog	accessibility | blind | guide | guide dog
🐕‍🦺	dog	accessibility | assistance | dog | service
🐩	dog | poodle
🐺	face | wolf
🦊	face | fox
🦝	curious | raccoon | sly
🐱	face	cat | face | pet
🐈	cat | pet
🐈‍⬛	cat	black | cat | unlucky
🦁	face | Leo | lion | zodiac
🐯	face	face | tiger
🐅	tiger
🐆	leopard
🐴	face	face | horse
🫎	animal | antlers | elk | mammal | moose
🫏	animal | ass | burro | donkey | mammal | mule | stubborn
🐎	equestrian | horse | racehorse | racing
🦄	face | unicorn
🦓	stripe | zebra
🦌	deer | stag
🦬	bison | buffalo | herd | wisent
🐮	face	cow | face
🐂	bull | ox | Taurus | zodiac
🐃	buffalo	buffalo | water
🐄	cow
🐷	face	face | pig
🐖	pig | sow
🐗	boar | pig
🐽	nose	face | nose | pig
🐏	Aries | male | ram | sheep | zodiac
🐑	ewe | female | sheep
🐐	Capricorn | goat | zodiac
🐪	camel | dromedary | hump
🐫	camel	bactrian | camel | hump | two-hump camel | Bactrian
🦙	alpaca | guanaco | llama | vicuña | wool
🦒	giraffe | spots
🐘	elephant
🦣	extinction | large | mammoth | tusk | woolly | extinct
🦏	rhinoceros | rhino
🦛	hippo | hippopotamus
🐭	face	face | mouse | pet
🐁	mouse | pet | rodent
🐀	rat | pet | rodent
🐹	face | hamster | pet
🐰	face	bunny | face | pet | rabbit
🐇	bunny | pet | rabbit	
🐿	chipmunk | squirrel
🦫	beaver | dam
🦔	hedgehog | spiny
🦇	bat | vampire
🐻	bear | face
🐻‍❄️	bear	
🐻‍❄	bear	arctic | bear | polar bear | white
🐨	face | koala | marsupial
🐼	face | panda
🦥	lazy | sloth | slow
🦦	fishing | otter | playful
🦨	skunk | stink
🦘	joey | jump | kangaroo | marsupial
🦡	badger | honey badger | pester
🐾	prints	feet | paw | paw prints | print
🦃	bird | turkey | poultry
🐔	bird | chicken | poultry
🐓	bird | rooster
🐣	chick	baby | bird | chick | hatching
🐤	chick	baby | bird | chick
🐥	baby chick	baby | bird | chick | front-facing baby chick
🐦	bird
🐧	bird | penguin		
🕊	bird | dove | fly | peace
🦅	bird | eagle | bird of prey
🦆	bird | duck
🦢	bird | cygnet | swan | ugly duckling
🦉	bird | owl | wise | bird of prey
🦤	dodo | extinction | large | Mauritius
🪶	bird | feather | flight | light | plumage
🦩	flamboyant | flamingo | tropical
🦚	bird | ostentatious | peacock | peahen | proud
🦜	bird | parrot | pirate | talk
🪽	angelic | aviation | bird | flying | mythology | wing
🐦‍⬛	bird	bird | black | crow | raven | rook
🪿	bird | fowl | goose | honk | silly
🐦‍🔥	fantasy | firebird | phoenix | rebirth | reincarnation
🐸	animal-amphibian		face | frog
🐊	animal-reptile		crocodile
🐢	animal-reptile		terrapin | tortoise | turtle
🦎	animal-reptile		lizard | reptile
🐍	animal-reptile		bearer | Ophiuchus | serpent | snake | zodiac
🐲	animal-reptile	face	dragon | face | fairy tale
🐉	animal-reptile		dragon | fairy tale
🦕	animal-reptile		brachiosaurus | brontosaurus | diplodocus | sauropod
🦖	animal-reptile		T-Rex | Tyrannosaurus Rex
🐳	animal-marine	whale	face | spouting | whale
🐋	animal-marine		whale
🐬	animal-marine		dolphin | flipper | porpoise
🦭	animal-marine		sea lion | seal
🐟	animal-marine		fish | Pisces | zodiac
🐠	animal-marine	fish	fish | tropical | reef fish
🐡	animal-marine		blowfish | fish
🦈	animal-marine		fish | shark
🐙	animal-marine		octopus
🐚	animal-marine	shell	shell | spiral
🪸	animal-marine		coral | ocean | reef
🪼	animal-marine		burn | invertebrate | jelly | jellyfish | marine | ouch | stinger
🐌	animal-bug		snail | mollusc
🦋	animal-bug		butterfly | insect | pretty | moth
🐛	animal-bug		bug | insect | caterpillar | worm
🐜	animal-bug		ant | insect
🐝	animal-bug		bee | honeybee | insect
🪲	animal-bug		beetle | bug | insect
🐞	animal-bug	beetle	beetle | insect | lady beetle | ladybird | ladybug
🦗	animal-bug		cricket | grasshopper
🪳	animal-bug		cockroach | insect | pest | roach
🕷️	animal-bug		
🕷	animal-bug		insect | spider | arachnid
🕸️	animal-bug	web	
🕸	animal-bug	web	spider | web
🦂	animal-bug		Scorpio | scorpion | zodiac
🦟	animal-bug		disease | fever | malaria | mosquito | pest | virus | dengue | insect | mozzie
🪰	animal-bug		disease | fly | maggot | pest | rotting
🪱	animal-bug		annelid | earthworm | parasite | worm
🦠	animal-bug		amoeba | bacteria | microbe | virus
💐	plant-flower		bouquet | flower
🌸	plant-flower	blossom	blossom | cherry | flower
💮	plant-flower	flower	flower | white flower
🪷	plant-flower		Buddhism | flower | Hinduism | lotus | purity
🏵️	plant-flower		
🏵	plant-flower		plant | rosette
🌹	plant-flower		flower | rose
🥀	plant-flower	flower	flower | wilted
🌺	plant-flower		flower | hibiscus
🌻	plant-flower		flower | sun | sunflower
🌼	plant-flower		blossom | flower
🌷	plant-flower		flower | tulip
🪻	plant-flower		bluebonnet | flower | hyacinth | lavender | lupine | snapdragon
🌱	plant-other		seedling | young
🪴	plant-other	plant	boring | grow | house | nurturing | plant | potted plant | useless | pot plant
🌲	plant-other	tree	evergreen tree | tree
🌳	plant-other	tree	deciduous | shedding | tree
🌴	plant-other	tree	palm | tree
🌵	plant-other		cactus | plant
🌾	plant-other	of rice	ear | grain | rice | sheaf of rice | sheaf
🌿	plant-other		herb | leaf
☘️	plant-other		
☘	plant-other		plant | shamrock
🍀	plant-other	leaf clover	4 | clover | four | four-leaf clover | leaf
🍁	plant-other	leaf	falling | leaf | maple
🍂	plant-other	leaf	fallen leaf | falling | leaf
🍃	plant-other	fluttering in wind	blow | flutter | leaf | leaf fluttering in wind | wind
🪹	plant-other	nest	empty nest | nesting
🪺	plant-other	with eggs	nest with eggs | nesting
🍄	plant-other		mushroom | toadstool
🍇	food-fruit		fruit | grape | grapes
🍈	food-fruit		fruit | melon
🍉	food-fruit		fruit | watermelon
🍊	food-fruit		fruit | orange | tangerine | mandarin
🍋	food-fruit		citrus | fruit | lemon
🍋‍🟩	food-fruit		citrus | fruit | lime | tropical
🍌	food-fruit		banana | fruit
🍍	food-fruit		fruit | pineapple
🥭	food-fruit		fruit | mango | tropical
🍎	food-fruit	apple	apple | fruit | red
🍏	food-fruit	apple	apple | fruit | green
🍐	food-fruit		fruit | pear
🍑	food-fruit		fruit | peach
🍒	food-fruit		berries | cherries | cherry | fruit | red
🍓	food-fruit		berry | fruit | strawberry
🫐	food-fruit		berry | bilberry | blue | blueberries | blueberry
🥝	food-fruit	fruit	food | fruit | kiwi | kiwi fruit
🍅	food-fruit		fruit | tomato | vegetable
🫒	food-fruit		food | olive
🥥	food-fruit		coconut | palm | piña colada
🥑	food-vegetable		avocado | food | fruit
🍆	food-vegetable		aubergine | eggplant | vegetable
🥔	food-vegetable		food | potato | vegetable
🥕	food-vegetable		carrot | food | vegetable
🌽	food-vegetable	of corn	corn | ear | ear of corn | maize | maze | corn on the cob | sweetcorn
🌶️	food-vegetable	pepper	
🌶	food-vegetable	pepper	hot | pepper | chilli | hot pepper
🫑	food-vegetable	pepper	bell pepper | capsicum | pepper | vegetable | sweet pepper
🥒	food-vegetable		cucumber | food | pickle | vegetable
🥬	food-vegetable	green	bok choy | cabbage | kale | leafy green | lettuce | pak choi
🥦	food-vegetable		broccoli | wild cabbage
🧄	food-vegetable		flavoring | garlic | flavouring
🧅	food-vegetable		flavoring | onion | flavouring
🥜	food-vegetable		food | nut | peanut | peanuts | vegetable | nuts
🫘	food-vegetable		beans | food | kidney | legume | kidney bean | kidney beans
🌰	food-vegetable		chestnut | plant | nut
🫚	food-vegetable	root	beer | ginger root | root | spice | ginger | root ginger
🫛	food-vegetable	pod	beans | edamame | legume | pea | pod | vegetable
🍄‍🟫	food-vegetable	mushroom	brown mushroom | food | fungus | nature | vegetable
🍞	food-prepared		bread | loaf
🥐	food-prepared		bread | breakfast | croissant | food | french | roll | crescent | French
🥖	food-prepared	bread	baguette | bread | food | french | French stick | French
🫓	food-prepared		arepa | flatbread | lavash | naan | pita
🥨	food-prepared		pretzel | twisted
🥯	food-prepared		bagel | bakery | breakfast | schmear
🥞	food-prepared		breakfast | crêpe | food | hotcake | pancake | pancakes | crepe
🧇	food-prepared		breakfast | indecisive | iron | waffle | unclear | vague | waffle with butter
🧀	food-prepared	wedge	cheese | cheese wedge
🍖	food-prepared	on bone	bone | meat | meat on bone
🍗	food-prepared	leg	bone | chicken | drumstick | leg | poultry
🥩	food-prepared	of meat	chop | cut of meat | lambchop | porkchop | steak | lamb chop | pork chop
🥓	food-prepared		bacon | breakfast | food | meat
🍔	food-prepared		burger | hamburger | beefburger
🍟	food-prepared	fries	french | fries | chips | french fries | French
🍕	food-prepared		cheese | pizza | slice
🌭	food-prepared	dog	frankfurter | hot dog | hotdog | sausage | frank
🥪	food-prepared		bread | sandwich
🌮	food-prepared		mexican | taco | Mexican
🌯	food-prepared		burrito | mexican | wrap | Mexican
🫔	food-prepared		mexican | tamale | wrapped | Mexican
🥙	food-prepared	flatbread	falafel | flatbread | food | gyro | kebab | stuffed | pita roll
🧆	food-prepared		chickpea | falafel | meatball | chick pea
🥚	food-prepared		breakfast | egg | food
🍳	food-prepared		breakfast | cooking | egg | frying | pan
🥘	food-prepared	pan of food	casserole | food | paella | pan | shallow | shallow pan of food
🍲	food-prepared	of food	pot | pot of food | stew
🫕	food-prepared		cheese | chocolate | fondue | melted | pot | Swiss
🥣	food-prepared	with spoon	bowl with spoon | breakfast | cereal | congee
🥗	food-prepared	salad	food | green | salad | garden
🍿	food-prepared		popcorn
🧈	food-prepared		butter | dairy
🧂	food-prepared		condiment | salt | shaker
🥫	food-prepared	food	can | canned food
🍱	food-asian	box	bento | box
🍘	food-asian	cracker	cracker | rice
🍙	food-asian	ball	ball | Japanese | rice
🍚	food-asian	rice	cooked | rice
🍛	food-asian	rice	curry | rice
🍜	food-asian	bowl	bowl | noodle | ramen | steaming
🍝	food-asian		pasta | spaghetti
🍠	food-asian	sweet potato	potato | roasted | sweet
🍢	food-asian		kebab | oden | seafood | skewer | stick
🍣	food-asian		sushi
🍤	food-asian	shrimp	fried | prawn | shrimp | tempura | battered
🍥	food-asian	cake with swirl	cake | fish | fish cake with swirl | pastry | swirl | narutomaki
🥮	food-asian	cake	autumn | festival | moon cake | yuèbǐng
🍡	food-asian		dango | dessert | Japanese | skewer | stick | sweet
🥟	food-asian		dumpling | empanada | gyōza | jiaozi | pierogi | potsticker | pastie | samosa
🥠	food-asian	cookie	fortune cookie | prophecy
🥡	food-asian	box	oyster pail | takeout box | takeaway box | takeaway container | takeout
🦀	food-marine		Cancer | crab | zodiac | crustacean | seafood | shellfish
🦞	food-marine		bisque | claws | lobster | seafood | shellfish
🦐	food-marine		food | shellfish | shrimp | small | prawn | seafood
🦑	food-marine		food | molusc | squid | decapod | seafood
🦪	food-marine		diving | oyster | pearl
🍦	food-sweet	ice cream	cream | dessert | ice | icecream | soft | sweet | ice cream | soft serve | soft-serve ice cream
🍧	food-sweet	ice	dessert | ice | shaved | sweet | granita
🍨	food-sweet	cream	cream | dessert | ice | sweet | ice cream
🍩	food-sweet		breakfast | dessert | donut | doughnut | sweet
🍪	food-sweet		cookie | dessert | sweet | biscuit
🎂	food-sweet	cake	birthday | cake | celebration | dessert | pastry | sweet
🍰	food-sweet		cake | dessert | pastry | shortcake | slice | sweet
🧁	food-sweet		bakery | cupcake | sweet
🥧	food-sweet		filling | pastry | pie
🍫	food-sweet	bar	bar | chocolate | dessert | sweet
🍬	food-sweet		candy | dessert | sweet | sweets
🍭	food-sweet		candy | dessert | lollipop | sweet
🍮	food-sweet		custard | dessert | pudding | sweet | baked custard
🍯	food-sweet	pot	honey | honeypot | pot | sweet
🍼	drink	bottle	baby | bottle | drink | milk
🥛	drink	of milk	drink | glass | glass of milk | milk
☕	drink	beverage	beverage | coffee | drink | hot | steaming | tea
🫖	drink		drink | pot | tea | teapot
🍵	drink	without handle	beverage | cup | drink | tea | teacup | teacup without handle
🍶	drink		bar | beverage | bottle | cup | drink | sake | saké
🍾	drink	with popping cork	bar | bottle | bottle with popping cork | cork | drink | popping | bubbly
🍷	drink	glass	bar | beverage | drink | glass | wine
🍸	drink	glass	bar | cocktail | drink | glass
🍹	drink	drink	bar | drink | tropical
🍺	drink	mug	bar | beer | drink | mug
🍻	drink	beer mugs	bar | beer | clink | clinking beer mugs | drink | mug | cheers
🥂	drink	glasses	celebrate | clink | clinking glasses | drink | glass | cheers
🥃	drink	glass	glass | liquor | shot | tumbler | whisky | whiskey
🫗	drink	liquid	drink | empty | glass | pouring liquid | spill
🥤	drink	with straw	cup with straw | juice | soda
🧋	drink	tea	bubble | milk | pearl | tea | boba
🧃	drink	box	beverage | box | juice | straw | sweet | drink carton | juice box | popper
🧉	drink		drink | mate | maté
🧊	drink		cold | ice | ice cube | iceberg
🥢	dishware		chopsticks | hashi | pair of chopsticks
🍽️	dishware	and knife with plate	
🍽	dishware	and knife with plate	cooking | fork | fork and knife with plate | knife | plate
🍴	dishware	and knife	cooking | cutlery | fork | fork and knife | knife | knife and fork
🥄	dishware		spoon | tableware
🔪	dishware	knife	cooking | hocho | kitchen knife | knife | tool | weapon
🫙	dishware		condiment | container | empty | jar | sauce | store
🏺	dishware		amphora | Aquarius | cooking | drink | jug | zodiac | jar
🌍	place-map	showing Europe-Africa	Africa | earth | Europe | globe | globe showing Europe-Africa | world
🌎	place-map	showing Americas	Americas | earth | globe | globe showing Americas | world
🌏	place-map	showing Asia-Australia	Asia | Australia | earth | globe | globe showing Asia-Australia | world
🌐	place-map	with meridians	earth | globe | globe with meridians | meridians | world
🗺️	place-map	map	
🗺	place-map	map	map | world
🗾	place-map	of Japan	Japan | map | map of Japan
🧭	place-map		compass | magnetic | navigation | orienteering
🏔️	place-geographic	mountain	
🏔	place-geographic	mountain	cold | mountain | snow | snow-capped mountain
⛰️	place-geographic		
⛰	place-geographic		mountain
🌋	place-geographic		eruption | mountain | volcano
🗻	place-geographic	fuji	fuji | mount fuji | mountain | Fuji | Mount Fuji | mount Fuji
🏕️	place-geographic		
🏕	place-geographic		camping
🏖️	place-geographic	with umbrella	
🏖	place-geographic	with umbrella	beach | beach with umbrella | umbrella
🏜️	place-geographic		
🏜	place-geographic		desert
🏝️	place-geographic	island	
🏝	place-geographic	island	desert | island
🏞️	place-geographic	park	
🏞	place-geographic	park	national park | park
🏟️	place-building		
🏟	place-building		stadium | arena
🏛️	place-building	building	
🏛	place-building	building	classical | classical building | column
🏗️	place-building	construction	
🏗	place-building	construction	building construction | construction
🧱	place-building		brick | bricks | clay | mortar | wall
🪨	place-building		boulder | heavy | rock | solid | stone
🪵	place-building		log | lumber | timber | wood
🛖	place-building		house | hut | roundhouse | yurt
🏘️	place-building		
🏘	place-building		houses
🏚️	place-building	house	
🏚	place-building	house	derelict | house
🏠	place-building		home | house
🏡	place-building	with garden	garden | home | house | house with garden
🏢	place-building	building	building | office building
🏣	place-building	post office	Japanese | Japanese post office | post
🏤	place-building	office	European | post | post office
🏥	place-building		doctor | hospital | medicine
🏦	place-building		bank | building
🏨	place-building		building | hotel
🏩	place-building	hotel	hotel | love
🏪	place-building	store	convenience | store | dépanneur
🏫	place-building		building | school
🏬	place-building	store	department | store
🏭	place-building		building | factory
🏯	place-building	castle	castle | Japanese
🏰	place-building		castle | European
💒	place-building		chapel | romance | wedding
🗼	place-building	tower	Tokyo | tower | Tower
🗽	place-building	of Liberty	liberty | statue | Statue of Liberty | Liberty | Statue
⛪	place-religious		Christian | church | cross | religion
🕌	place-religious		islam | mosque | Muslim | religion | Islam
🛕	place-religious	temple	hindu | temple | Hindu
🕍	place-religious		Jew | Jewish | religion | synagogue | temple | shul
⛩️	place-religious	shrine	
⛩	place-religious	shrine	religion | shinto | shrine | Shinto
🕋	place-religious		islam | kaaba | Muslim | religion | Islam | Kaaba
⛲	place-other		fountain
⛺	place-other		camping | tent
🌁	place-other		fog | foggy
🌃	place-other	with stars	night | night with stars | star | starry night
🏙️	place-other		
🏙	place-other		city | cityscape | skyline
🌄	place-other	over mountains	morning | mountain | sun | sunrise | sunrise over mountains
🌅	place-other		morning | sun | sunrise
🌆	place-other	at dusk	city | cityscape at dusk | dusk | evening | landscape | sunset | skyline at dusk
🌇	place-other		dusk | sun | sunset
🌉	place-other	at night	bridge | bridge at night | night
♨️	place-other	springs	
♨	place-other	springs	hot | hotsprings | springs | steaming
🎠	place-other	horse	carousel | horse | merry-go-round
🛝	place-other	slide	amusement park | play | playground slide | theme park
🎡	place-other	wheel	amusement park | ferris | theme park | wheel | Ferris
🎢	place-other	coaster	amusement park | coaster | roller | theme park
💈	place-other	pole	barber | haircut | pole
🎪	place-other	tent	circus | tent | big top
🚂	transport-ground		engine | locomotive | railway | steam | train
🚃	transport-ground	car	car | electric | railway | train | tram | trolleybus | railway carriage | train carriage | trolley bus
🚄	transport-ground	train	high-speed train | railway | shinkansen | speed | train | Shinkansen
🚅	transport-ground	train	bullet | railway | shinkansen | speed | train | Shinkansen
🚆	transport-ground		railway | train
🚇	transport-ground		metro | subway | tube | underground
🚈	transport-ground	rail	light rail | railway
🚉	transport-ground		railway | station | train
🚊	transport-ground		tram | trolleybus | light rail | oncoming | oncoming light rail | car | streetcar | tramcar | trolley | trolley bus
🚝	transport-ground		monorail | vehicle
🚞	transport-ground	railway	car | mountain | railway
🚋	transport-ground	car	car | tram | trolleybus | trolley bus | streetcar | tramcar | trolley
🚌	transport-ground		bus | vehicle
🚍	transport-ground	bus	bus | oncoming
🚎	transport-ground		bus | tram | trolley | trolleybus | streetcar
🚐	transport-ground		bus | minibus
🚑	transport-ground		ambulance | vehicle
🚒	transport-ground	engine	engine | fire | truck
🚓	transport-ground	car	car | patrol | police
🚔	transport-ground	police car	car | oncoming | police
🚕	transport-ground		taxi | vehicle
🚖	transport-ground	taxi	oncoming | taxi
🚗	transport-ground		automobile | car
🚘	transport-ground	automobile	automobile | car | oncoming
🚙	transport-ground	utility vehicle	recreational | sport utility | sport utility vehicle | 4x4 | off-road vehicle | 4WD | four-wheel drive | SUV
🛻	transport-ground	truck	pick-up | pickup | truck | ute
🚚	transport-ground	truck	delivery | truck
🚛	transport-ground	lorry	articulated lorry | lorry | semi | truck | articulated truck
🚜	transport-ground		tractor | vehicle
🏎️	transport-ground	car	
🏎	transport-ground	car	car | racing
🏍️	transport-ground		
🏍	transport-ground		motorcycle | racing
🛵	transport-ground	scooter	motor | scooter
🦽	transport-ground	wheelchair	accessibility | manual wheelchair
🦼	transport-ground	wheelchair	accessibility | motorized wheelchair | powered wheelchair | mobility scooter
🛺	transport-ground	rickshaw	auto rickshaw | tuk tuk | tuk-tuk | tuktuk
🚲	transport-ground		bicycle | bike
🛴	transport-ground	scooter	kick | scooter
🛹	transport-ground		board | skateboard
🛼	transport-ground	skate	roller | skate | rollerskate
🚏	transport-ground	stop	bus | stop | busstop
🛣️	transport-ground		
🛣	transport-ground		highway | motorway | road | freeway
🛤️	transport-ground	track	
🛤	transport-ground	track	railway | railway track | train
🛢️	transport-ground	drum	
🛢	transport-ground	drum	drum | oil
⛽	transport-ground	pump	diesel | fuel | fuelpump | gas | pump | station | petrol pump
🛞	transport-ground		circle | tire | turn | wheel | tyre
🚨	transport-ground	car light	beacon | car | light | police | revolving
🚥	transport-ground	traffic light	horizontal traffic light | light | signal | traffic | horizontal traffic lights | lights
🚦	transport-ground	traffic light	light | signal | traffic | vertical traffic light | lights | vertical traffic lights
🛑	transport-ground	sign	octagonal | sign | stop
🚧	transport-ground		barrier | construction
⚓	transport-water		anchor | ship | tool
🛟	transport-water	buoy	float | life preserver | life saver | rescue | ring buoy | safety | lifebuoy | buoy
⛵	transport-water		boat | resort | sailboat | sea | yacht
🛶	transport-water		boat | canoe
🚤	transport-water		boat | speedboat
🛳️	transport-water	ship	
🛳	transport-water	ship	passenger | ship
⛴️	transport-water		
⛴	transport-water		boat | ferry | passenger
🛥️	transport-water	boat	
🛥	transport-water	boat	boat | motor boat | motorboat
🚢	transport-water		boat | passenger | ship
✈️	transport-air		
✈	transport-air		aeroplane | airplane | flight
🛩️	transport-air	airplane	
🛩	transport-air	airplane	aeroplane | airplane | small airplane | small plane
🛫	transport-air	departure	aeroplane | airplane | check-in | departure | departures | take-off | flight departure | plane departure
🛬	transport-air	arrival	aeroplane | airplane | airplane arrival | arrivals | arriving | landing
🪂	transport-air		hang-glide | parachute | parasail | skydive | parascend
💺	transport-air		chair | seat
🚁	transport-air		helicopter | vehicle
🚟	transport-air	railway	railway | suspension | cable
🚠	transport-air	cableway	cable | gondola | mountain | mountain cableway | cableway
🚡	transport-air	tramway	aerial | cable | car | gondola | tramway
🛰️	transport-air		
🛰	transport-air		satellite | space
🚀	transport-air		rocket | space
🛸	transport-air	saucer	flying saucer | UFO | spaceship
🛎️	hotel	bell	
🛎	hotel	bell	bell | bellhop | hotel | porter
🧳	hotel		luggage | packing | travel
⌛	time	done	hourglass done | sand | timer | hourglass
⏳	time	not done	hourglass | hourglass not done | sand | timer
⌚	time		clock | watch
⏰	time	clock	alarm | clock
⏱️	time		
⏱	time		clock | stopwatch
⏲️	time	clock	
⏲	time	clock	clock | timer
🕰️	time	clock	
🕰	time	clock	clock | mantelpiece clock
🕛	time	o’clock	00 | 12 | 12:00 | clock | o’clock | twelve
🕧	time		12 | 12:30 | clock | thirty | twelve | twelve-thirty | 12.30 | half past twelve
🕐	time	o’clock	00 | 1 | 1:00 | clock | o’clock | one
🕜	time		1 | 1:30 | clock | one | one-thirty | thirty | 1.30 | half past one
🕑	time	o’clock	00 | 2 | 2:00 | clock | o’clock | two
🕝	time		2 | 2:30 | clock | thirty | two | two-thirty | 2.30 | half past two
🕒	time	o’clock	00 | 3 | 3:00 | clock | o’clock | three
🕞	time		3 | 3:30 | clock | thirty | three | three-thirty | 3.30 | half past three
🕓	time	o’clock	00 | 4 | 4:00 | clock | four | o’clock
🕟	time		4 | 4:30 | clock | four | four-thirty | thirty | 4.30 | half past four
🕔	time	o’clock	00 | 5 | 5:00 | clock | five | o’clock
🕠	time		5 | 5:30 | clock | five | five-thirty | thirty | 5.30 | half past five
🕕	time	o’clock	00 | 6 | 6:00 | clock | o’clock | six
🕡	time		6 | 6:30 | clock | six | six-thirty | thirty | 6.30 | half past six
🕖	time	o’clock	00 | 7 | 7:00 | clock | o’clock | seven
🕢	time		7 | 7:30 | clock | seven | seven-thirty | thirty | 7.30 | half past seven
🕗	time	o’clock	00 | 8 | 8:00 | clock | eight | o’clock
🕣	time		8 | 8:30 | clock | eight | eight-thirty | thirty | 8.30 | half past eight
🕘	time	o’clock	00 | 9 | 9:00 | clock | nine | o’clock
🕤	time		9 | 9:30 | clock | nine | nine-thirty | thirty | 9.30 | half past nine
🕙	time	o’clock	00 | 10 | 10:00 | clock | o’clock | ten
🕥	time		10 | 10:30 | clock | ten | ten-thirty | thirty | 10.30 | half past ten
🕚	time	o’clock	00 | 11 | 11:00 | clock | eleven | o’clock
🕦	time		11 | 11:30 | clock | eleven | eleven-thirty | thirty | 11.30 | half past eleven
🌑	sky & weather	moon	dark | moon | new moon
🌒	sky & weather	crescent moon	crescent | moon | waxing
🌓	sky & weather	quarter moon	first quarter moon | moon | quarter
🌔	sky & weather	gibbous moon	gibbous | moon | waxing
🌕	sky & weather	moon	full | moon
🌖	sky & weather	gibbous moon	gibbous | moon | waning
🌗	sky & weather	quarter moon	last quarter moon | moon | quarter
🌘	sky & weather	crescent moon	crescent | moon | waning
🌙	sky & weather	moon	crescent | moon
🌚	sky & weather	moon face	face | moon | new moon face
🌛	sky & weather	quarter moon face	face | first quarter moon face | moon | quarter
🌜	sky & weather	quarter moon face	face | last quarter moon face | moon | quarter
🌡️	sky & weather		
🌡	sky & weather		thermometer | weather
☀️	sky & weather		
☀	sky & weather		bright | rays | sun | sunny
🌝	sky & weather	moon face	bright | face | full | moon | full-moon face
🌞	sky & weather	with face	bright | face | sun | sun with face
🪐	sky & weather	planet	ringed planet | saturn | saturnine
⭐	sky & weather		star
🌟	sky & weather	star	glittery | glow | glowing star | shining | sparkle | star
🌠	sky & weather	star	falling | shooting | star
🌌	sky & weather	way	milky way | space | Milky Way | Milky | Way
☁️	sky & weather		
☁	sky & weather		cloud | weather
⛅	sky & weather	behind cloud	cloud | sun | sun behind cloud
⛈️	sky & weather	with lightning and rain	
⛈	sky & weather	with lightning and rain	cloud | cloud with lightning and rain | rain | thunder
🌤️	sky & weather	behind small cloud	
🌤	sky & weather	behind small cloud	cloud | sun | sun behind small cloud
🌥️	sky & weather	behind large cloud	
🌥	sky & weather	behind large cloud	cloud | sun | sun behind large cloud
🌦️	sky & weather	behind rain cloud	
🌦	sky & weather	behind rain cloud	cloud | rain | sun | sun behind rain cloud
🌧️	sky & weather	with rain	
🌧	sky & weather	with rain	cloud | cloud with rain | rain
🌨️	sky & weather	with snow	
🌨	sky & weather	with snow	cloud | cloud with snow | cold | snow
🌩️	sky & weather	with lightning	
🌩	sky & weather	with lightning	cloud | cloud with lightning | lightning
🌪️	sky & weather		
🌪	sky & weather		cloud | tornado | whirlwind
🌫️	sky & weather		
🌫	sky & weather		cloud | fog
🌬️	sky & weather	face	
🌬	sky & weather	face	blow | cloud | face | wind
🌀	sky & weather		cyclone | dizzy | hurricane | twister | typhoon
🌈	sky & weather		rain | rainbow
🌂	sky & weather	umbrella	closed umbrella | clothing | rain | umbrella
☂️	sky & weather		
☂	sky & weather		clothing | rain | umbrella
☔	sky & weather	with rain drops	clothing | drop | rain | umbrella | umbrella with rain drops
⛱️	sky & weather	on ground	
⛱	sky & weather	on ground	rain | sun | umbrella | umbrella on ground | beach | sand
⚡	sky & weather	voltage	danger | electric | high voltage | lightning | voltage | zap
❄️	sky & weather		
❄	sky & weather		cold | snow | snowflake
☃️	sky & weather		
☃	sky & weather		cold | snow | snowman
⛄	sky & weather	without snow	cold | snow | snowman | snowman without snow
☄️	sky & weather		
☄	sky & weather		comet | space
🔥	sky & weather		fire | flame | tool
💧	sky & weather		cold | comic | drop | droplet | sweat
🌊	sky & weather	wave	ocean | water | wave
🎃	Activities	event		celebration | halloween | jack | jack-o-lantern | lantern | Halloween | jack-o’-lantern
🎄	Activities	event	tree	celebration | Christmas | tree
🎆	Activities	event		celebration | fireworks
🎇	Activities	event		celebration | fireworks | sparkle | sparkler
🧨	Activities	event		dynamite | explosive | firecracker | fireworks
✨	Activities	event		* | sparkle | sparkles | star
🎈	Activities	event		balloon | celebration
🎉	Activities	event	popper	celebration | party | popper | tada | ta-da
🎊	Activities	event	ball	ball | celebration | confetti
🎋	Activities	event	tree	banner | celebration | Japanese | tanabata tree | tree | Tanabata tree
🎍	Activities	event	decoration	bamboo | celebration | Japanese | pine | pine decoration | decoration
🎎	Activities	event	dolls	celebration | doll | festival | Japanese | Japanese dolls
🎏	Activities	event	streamer	carp | celebration | streamer | carp wind sock | Japanese wind socks | koinobori
🎐	Activities	event	chime	bell | celebration | chime | wind
🎑	Activities	event	viewing ceremony	celebration | ceremony | moon | moon viewing ceremony | moon-viewing ceremony
🧧	Activities	event	envelope	gift | good luck | hóngbāo | lai see | money | red envelope
🎀	Activities	event		celebration | ribbon
🎁	Activities	event	gift	box | celebration | gift | present | wrapped
🎗️	Activities	event	ribbon	
🎗	Activities	event	ribbon	celebration | reminder | ribbon
🎟️	Activities	event	tickets	
🎟	Activities	event	tickets	admission | admission tickets | ticket | entry
🎫	Activities	event		admission | ticket
🎖️	Activities	award-medal	medal	
🎖	Activities	award-medal	medal	celebration | medal | military
🏆	Activities	award-medal		prize | trophy | celebration
🏅	Activities	award-medal	medal	medal | sports medal | celebration | sports
🥇	Activities	award-medal	place medal	1st place medal | first | gold | medal
🥈	Activities	award-medal	place medal	2nd place medal | medal | second | silver
🥉	Activities	award-medal	place medal	3rd place medal | bronze | medal | third
⚽	Activities	sport	ball	ball | football | soccer
⚾	Activities	sport		ball | baseball
🥎	Activities	sport		ball | glove | softball | underarm
🏀	Activities	sport		ball | basketball | hoop
🏐	Activities	sport		ball | game | volleyball
🏈	Activities	sport	football	american | ball | football
🏉	Activities	sport	football	ball | football | rugby | australian football | rugby ball | rugby league | rugby union
🎾	Activities	sport		ball | racquet | tennis
🥏	Activities	sport	disc	flying disc | ultimate | frisbee | Frisbee
🎳	Activities	sport		ball | bowling | game | tenpin bowling
🏏	Activities	sport	game	ball | bat | cricket game | game | cricket | cricket match
🏑	Activities	sport	hockey	ball | field | game | hockey | stick
🏒	Activities	sport	hockey	game | hockey | ice | puck | stick
🥍	Activities	sport		ball | goal | lacrosse | stick
🏓	Activities	sport	pong	ball | bat | game | paddle | ping pong | table tennis | ping-pong
🏸	Activities	sport		badminton | birdie | game | racquet | shuttlecock
🥊	Activities	sport	glove	boxing | glove
🥋	Activities	sport	arts uniform	judo | karate | martial arts | martial arts uniform | taekwondo | uniform | MMA
🥅	Activities	sport	net	goal | net | goal cage
⛳	Activities	sport	in hole	flag in hole | golf | hole | flag
⛸️	Activities	sport	skate	
⛸	Activities	sport	skate	ice | skate | ice skating
🎣	Activities	sport	pole	fish | fishing pole | pole | fishing | rod | fishing rod
🤿	Activities	sport	mask	diving | diving mask | scuba | snorkeling | snorkelling
🎽	Activities	sport	shirt	athletics | running | sash | shirt
🎿	Activities	sport		ski | skis | snow | skiing
🛷	Activities	sport		sled | sledge | sleigh
🥌	Activities	sport	stone	curling stone | game | rock | curling | stone | curling rock
🎯	Activities	game		bullseye | dart | direct hit | game | hit | target | bull’s-eye
🪀	Activities	game		fluctuate | toy | yo-yo
🪁	Activities	game		fly | kite | soar
🔫	Activities	game	pistol	gun | handgun | pistol | revolver | tool | water | weapon | toy | water pistol
🎱	Activities	game	8 ball	8 | ball | billiard | eight | game | pool 8 ball | magic 8 ball
🔮	Activities	game	ball	ball | crystal | fairy tale | fantasy | fortune | tool
🪄	Activities	game	wand	magic | magic wand | witch | wizard
🎮	Activities	game	game	controller | game | video game
🕹️	Activities	game		
🕹	Activities	game		game | joystick | video game
🎰	Activities	game	machine	game | slot | slot machine | pokie | pokies
🎲	Activities	game	die	dice | die | game
🧩	Activities	game	piece	clue | interlocking | jigsaw | piece | puzzle
🧸	Activities	game	bear	plaything | plush | stuffed | teddy bear | toy
🪅	Activities	game		celebration | party | piñata
🪩	Activities	game	ball	dance | disco | glitter | mirror ball | party
🪆	Activities	game	dolls	doll | nesting | nesting dolls | russia | babushka | matryoshka | Russian dolls | Russia
♠️	Activities	game	suit	
♠	Activities	game	suit	card | game | spade suit
♥️	Activities	game	suit	
♥	Activities	game	suit	card | game | heart suit
♦️	Activities	game	suit	
♦	Activities	game	suit	card | diamond suit | game | diamonds
♣️	Activities	game	suit	
♣	Activities	game	suit	card | club suit | game | clubs
♟️	Activities	game	pawn	
♟	Activities	game	pawn	chess | chess pawn | dupe | expendable
🃏	Activities	game		card | game | joker | wildcard
🀄	Activities	game	red dragon	game | mahjong | mahjong red dragon | red | Mahjong | Mahjong red dragon
🎴	Activities	game	playing cards	card | flower | flower playing cards | game | Japanese | playing
🎭	Activities	arts & crafts	arts	art | mask | performing | performing arts | theater | theatre
🖼️	Activities	arts & crafts	picture	
🖼	Activities	arts & crafts	picture	art | frame | framed picture | museum | painting | picture
🎨	Activities	arts & crafts	palette	art | artist palette | museum | painting | palette
🧵	Activities	arts & crafts		needle | sewing | spool | string | thread
🪡	Activities	arts & crafts	needle	embroidery | needle | sewing | stitches | sutures | tailoring | needle and thread
🧶	Activities	arts & crafts		ball | crochet | knit | yarn
🪢	Activities	arts & crafts		knot | rope | tangled | tie | twine | twist
👓	Objects	clothing		clothing | eye | eyeglasses | eyewear | glasses
🕶️	Objects	clothing		
🕶	Objects	clothing		dark | eye | eyewear | glasses | sunglasses | sunnies
🥽	Objects	clothing		eye protection | goggles | swimming | welding
🥼	Objects	clothing	coat	doctor | experiment | lab coat | scientist
🦺	Objects	clothing	vest	emergency | safety | vest | hi-vis | high-vis | jacket | life jacket
👔	Objects	clothing		clothing | necktie | tie
👕	Objects	clothing		clothing | shirt | t-shirt | tshirt | T-shirt | tee | tee-shirt
👖	Objects	clothing		clothing | jeans | pants | trousers
🧣	Objects	clothing		neck | scarf
🧤	Objects	clothing		gloves | hand
🧥	Objects	clothing		coat | jacket
🧦	Objects	clothing		socks | stocking
👗	Objects	clothing		clothing | dress | woman’s clothes
👘	Objects	clothing		clothing | kimono
🥻	Objects	clothing		clothing | dress | sari
🩱	Objects	clothing	swimsuit	bathing suit | one-piece swimsuit | swimming costume
🩲	Objects	clothing		bathing suit | briefs | one-piece | swimsuit | underwear | pants | bathers | speedos
🩳	Objects	clothing		bathing suit | pants | shorts | underwear | boardshorts | swim shorts | boardies
👙	Objects	clothing		bikini | clothing | swim | swim suit | two-piece
👚	Objects	clothing	clothes	clothing | woman | woman’s clothes | blouse | top
🪭	Objects	clothing	hand fan	cooling | dance | fan | flutter | folding hand fan | hot | shy
👛	Objects	clothing		clothing | coin | purse | accessories
👜	Objects	clothing		bag | clothing | handbag | purse | accessories | tote
👝	Objects	clothing	bag	bag | clothing | clutch bag | pouch | accessories
🛍️	Objects	clothing	bags	
🛍	Objects	clothing	bags	bag | hotel | shopping | shopping bags
🎒	Objects	clothing		backpack | bag | rucksack | satchel | school
🩴	Objects	clothing	sandal	beach sandals | sandals | thong sandal | thong sandals | thongs | zōri | flip-flop | flipflop | zori | beach sandal | sandal | thong
👞	Objects	clothing	shoe	clothing | man | man’s shoe | shoe
👟	Objects	clothing	shoe	athletic | clothing | running shoe | shoe | sneaker | runners | trainer
🥾	Objects	clothing	boot	backpacking | boot | camping | hiking
🥿	Objects	clothing	shoe	ballet flat | flat shoe | slip-on | slipper | pump
👠	Objects	clothing	shoe	clothing | heel | high-heeled shoe | shoe | woman | stiletto
👡	Objects	clothing	sandal	clothing | sandal | shoe | woman | woman’s sandal
🩰	Objects	clothing	shoes	ballet | ballet shoes | dance
👢	Objects	clothing	boot	boot | clothing | shoe | woman | woman’s boot
🪮	Objects	clothing	pick	Afro | comb | hair | pick
👑	Objects	clothing		clothing | crown | king | queen
👒	Objects	clothing	hat	clothing | hat | woman | woman’s hat
🎩	Objects	clothing	hat	clothing | hat | top | tophat
🎓	Objects	clothing	cap	cap | celebration | clothing | graduation | hat
🧢	Objects	clothing	cap	baseball cap | billed cap
🪖	Objects	clothing	helmet	army | helmet | military | soldier | warrior
⛑️	Objects	clothing	worker’s helmet	
⛑	Objects	clothing	worker’s helmet	aid | cross | face | hat | helmet | rescue worker’s helmet
📿	Objects	clothing	beads	beads | clothing | necklace | prayer | religion
💄	Objects	clothing		cosmetics | lipstick | makeup | make-up
💍	Objects	clothing		diamond | ring
💎	Objects	clothing	stone	diamond | gem | gem stone | jewel | gemstone
🔇	Objects	sound	speaker	mute | muted speaker | quiet | silent | speaker
🔈	Objects	sound	low volume	soft | speaker low volume | low | quiet | speaker | volume
🔉	Objects	sound	medium volume	medium | speaker medium volume
🔊	Objects	sound	high volume	loud | speaker high volume
📢	Objects	sound		loud | loudspeaker | public address
📣	Objects	sound		cheering | megaphone
📯	Objects	sound	horn	horn | post | postal
🔔	Objects	sound		bell
🔕	Objects	sound	with slash	bell | bell with slash | forbidden | mute | quiet | silent
🎼	Objects	music	score	music | musical score | score
🎵	Objects	music	note	music | musical note | note
🎶	Objects	music	notes	music | musical notes | note | notes
🎙️	Objects	music	microphone	
🎙	Objects	music	microphone	mic | microphone | music | studio
🎚️	Objects	music	slider	
🎚	Objects	music	slider	level | music | slider
🎛️	Objects	music	knobs	
🎛	Objects	music	knobs	control | knobs | music
🎤	Objects	music		karaoke | mic | microphone
🎧	Objects	music		earbud | headphone
📻	Objects	music		radio | video | AM | FM | wireless
🎷	Objects	musical-instrument		instrument | music | sax | saxophone
🪗	Objects	musical-instrument		accordion | concertina | squeeze box
🎸	Objects	musical-instrument		guitar | instrument | music
🎹	Objects	musical-instrument	keyboard	instrument | keyboard | music | musical keyboard | piano | organ
🎺	Objects	musical-instrument		instrument | music | trumpet
🎻	Objects	musical-instrument		instrument | music | violin
🪕	Objects	musical-instrument		banjo | music | stringed
🥁	Objects	musical-instrument		drum | drumsticks | music | percussions
🪘	Objects	musical-instrument	drum	beat | conga | drum | long drum | rhythm
🪇	Objects	musical-instrument		instrument | maracas | music | percussion | rattle | shake
🪈	Objects	musical-instrument		fife | flute | music | pipe | recorder | woodwind
📱	Objects	phone	phone	cell | mobile | phone | telephone
📲	Objects	phone	phone with arrow	arrow | cell | mobile | mobile phone with arrow | phone | receive
☎️	Objects	phone		
☎	Objects	phone		phone | telephone | landline
📞	Objects	phone	receiver	phone | receiver | telephone
📟	Objects	phone		pager
📠	Objects	phone	machine	fax | fax machine
🔋	Objects	computer		battery
🪫	Objects	computer	battery	electronic | low battery | low energy
🔌	Objects	computer	plug	electric | electricity | plug
💻	Objects	computer		computer | laptop | pc | personal | PC
🖥️	Objects	computer	computer	
🖥	Objects	computer	computer	computer | desktop
🖨️	Objects	computer		
🖨	Objects	computer		computer | printer
⌨️	Objects	computer		
⌨	Objects	computer		computer | keyboard
🖱️	Objects	computer	mouse	
🖱	Objects	computer	mouse	computer | computer mouse
🖲️	Objects	computer		
🖲	Objects	computer		computer | trackball
💽	Objects	computer	disk	computer | disk | minidisk | optical
💾	Objects	computer	disk	computer | disk | floppy | diskette
💿	Objects	computer	disk	CD | computer | disk | optical
📀	Objects	computer		Blu-ray | computer | disk | DVD | optical | blu-ray
🧮	Objects	computer		abacus | calculation
🎥	Objects	light & video	camera	camera | cinema | movie
🎞️	Objects	light & video	frames	
🎞	Objects	light & video	frames	cinema | film | frames | movie
📽️	Objects	light & video	projector	
📽	Objects	light & video	projector	cinema | film | movie | projector | video
🎬	Objects	light & video	board	clapper | clapper board | movie | clapperboard | film
📺	Objects	light & video		television | tv | video | TV
📷	Objects	light & video		camera | video
📸	Objects	light & video	with flash	camera | camera with flash | flash | video
📹	Objects	light & video	camera	camera | video
📼	Objects	light & video		tape | vhs | video | videocassette | VHS | videotape
🔍	Objects	light & video	glass tilted left	glass | magnifying | magnifying glass tilted left | search | tool
🔎	Objects	light & video	glass tilted right	glass | magnifying | magnifying glass tilted right | search | tool
🕯️	Objects	light & video		
🕯	Objects	light & video		candle | light
💡	Objects	light & video	bulb	bulb | comic | electric | idea | light | globe
🔦	Objects	light & video		electric | flashlight | light | tool | torch
🏮	Objects	light & video	paper lantern	bar | lantern | light | red | red paper lantern
🪔	Objects	light & video	lamp	diya | lamp | oil
📔	Objects	book-paper	with decorative cover	book | cover | decorated | notebook | notebook with decorative cover
📕	Objects	book-paper	book	book | closed
📖	Objects	book-paper	book	book | open
📗	Objects	book-paper	book	book | green
📘	Objects	book-paper	book	blue | book
📙	Objects	book-paper	book	book | orange
📚	Objects	book-paper		book | books
📓	Objects	book-paper		notebook
📒	Objects	book-paper		ledger | notebook
📃	Objects	book-paper	with curl	curl | document | page | page with curl
📜	Objects	book-paper		paper | scroll
📄	Objects	book-paper	facing up	document | page | page facing up
📰	Objects	book-paper		news | newspaper | paper
🗞️	Objects	book-paper	newspaper	
🗞	Objects	book-paper	newspaper	news | newspaper | paper | rolled | rolled-up newspaper
📑	Objects	book-paper	tabs	bookmark | mark | marker | tabs
🔖	Objects	book-paper		bookmark | mark
🏷️	Objects	book-paper		
🏷	Objects	book-paper		label | tag
💰	Objects	money	bag	bag | dollar | money | moneybag
🪙	Objects	money		coin | gold | metal | money | silver | treasure
💴	Objects	money	banknote	banknote | bill | currency | money | note | yen
💵	Objects	money	banknote	banknote | bill | currency | dollar | money | note
💶	Objects	money	banknote	banknote | bill | currency | euro | money | note
💷	Objects	money	banknote	banknote | bill | currency | money | note | pound | sterling
💸	Objects	money	with wings	banknote | bill | fly | money | money with wings | wings
💳	Objects	money	card	card | credit | money
🧾	Objects	money		accounting | bookkeeping | evidence | proof | receipt
💹	Objects	money	increasing with yen	chart | chart increasing with yen | graph | growth | money | yen | graph increasing with yen
✉️	Objects	mail		
✉	Objects	mail		email | envelope | letter | e-mail
📧	Objects	mail		e-mail | email | letter | mail
📨	Objects	mail	envelope	e-mail | email | envelope | incoming | letter | receive
📩	Objects	mail	with arrow	arrow | e-mail | email | envelope | envelope with arrow | outgoing
📤	Objects	mail	tray	box | letter | mail | outbox | sent | tray | out tray
📥	Objects	mail	tray	box | inbox | letter | mail | receive | tray | in tray
📦	Objects	mail		box | package | parcel
📫	Objects	mail	mailbox with raised flag	closed | closed mailbox with raised flag | mail | mailbox | postbox | closed postbox with raised flag | letterbox | post | post box | closed letterbox with raised flag
📪	Objects	mail	mailbox with lowered flag	closed | closed mailbox with lowered flag | lowered | mail | mailbox | postbox | closed postbox with lowered flag | letterbox | post box | closed letterbox with lowered flag
📬	Objects	mail	mailbox with raised flag	mail | mailbox | open | open mailbox with raised flag | postbox | open postbox with raised flag | post | post box | open letterbox with raised flag
📭	Objects	mail	mailbox with lowered flag	lowered | mail | mailbox | open | open mailbox with lowered flag | postbox | open postbox with lowered flag | post | post box | open letterbox with lowered flag
📮	Objects	mail		mail | mailbox | postbox | post | post box
🗳️	Objects	mail	box with ballot	
🗳	Objects	mail	box with ballot	ballot | ballot box with ballot | box
✏️	Objects	writing		
✏	Objects	writing		pencil
✒️	Objects	writing	nib	
✒	Objects	writing	nib	black nib | nib | pen
🖋️	Objects	writing	pen	
🖋	Objects	writing	pen	fountain | pen
🖊️	Objects	writing		
🖊	Objects	writing		ballpoint | pen
🖌️	Objects	writing		
🖌	Objects	writing		paintbrush | painting
🖍️	Objects	writing		
🖍	Objects	writing		crayon
📝	Objects	writing		memo | pencil
💼	Objects	office		briefcase
📁	Objects	office	folder	file | folder
📂	Objects	office	file folder	file | folder | open
🗂️	Objects	office	index dividers	
🗂	Objects	office	index dividers	card | dividers | index
📅	Objects	office		calendar | date
📆	Objects	office	calendar	calendar | tear-off calendar
🗒️	Objects	office	notepad	
🗒	Objects	office	notepad	note | pad | spiral | spiral notepad
🗓️	Objects	office	calendar	
🗓	Objects	office	calendar	calendar | pad | spiral
📇	Objects	office	index	card | index | rolodex
📈	Objects	office	increasing	chart | chart increasing | graph | growth | trend | upward | graph increasing
📉	Objects	office	decreasing	chart | chart decreasing | down | graph | trend | graph decreasing
📊	Objects	office	chart	bar | chart | graph
📋	Objects	office		clipboard
📌	Objects	office		pin | pushpin | drawing-pin
📍	Objects	office	pushpin	pin | pushpin | round pushpin | round drawing-pin
📎	Objects	office		paperclip
🖇️	Objects	office	paperclips	
🖇	Objects	office	paperclips	link | linked paperclips | paperclip
📏	Objects	office	ruler	ruler | straight edge | straight ruler
📐	Objects	office	ruler	ruler | set | triangle | triangular ruler | set square
✂️	Objects	office		
✂	Objects	office		cutting | scissors | tool
🗃️	Objects	office	file box	
🗃	Objects	office	file box	box | card | file
🗄️	Objects	office	cabinet	
🗄	Objects	office	cabinet	cabinet | file | filing
🗑️	Objects	office		
🗑	Objects	office		wastebasket | rubbish bin | trash | waste paper basket
🔒	Objects	lock		closed | locked | padlock
🔓	Objects	lock		lock | open | unlock | unlocked | padlock
🔏	Objects	lock	with pen	ink | lock | locked with pen | nib | pen | privacy
🔐	Objects	lock	with key	closed | key | lock | locked with key | secure
🔑	Objects	lock		key | lock | password
🗝️	Objects	lock	key	
🗝	Objects	lock	key	clue | key | lock | old
🔨	Objects	tool		hammer | tool
🪓	Objects	tool		axe | chop | hatchet | split | wood
⛏️	Objects	tool		
⛏	Objects	tool		mining | pick | tool
⚒️	Objects	tool	and pick	
⚒	Objects	tool	and pick	hammer | hammer and pick | pick | tool
🛠️	Objects	tool	and wrench	
🛠	Objects	tool	and wrench	hammer | hammer and wrench | spanner | tool | wrench | hammer and spanner
🗡️	Objects	tool		
🗡	Objects	tool		dagger | knife | weapon
⚔️	Objects	tool	swords	
⚔	Objects	tool	swords	crossed | swords | weapon
💣	Objects	tool		bomb | comic
🪃	Objects	tool		boomerang | rebound | repercussion
🏹	Objects	tool	and arrow	archer | arrow | bow | bow and arrow | Sagittarius | zodiac
🛡️	Objects	tool		
🛡	Objects	tool		shield | weapon
🪚	Objects	tool	saw	carpenter | carpentry saw | lumber | saw | tool
🔧	Objects	tool		spanner | tool | wrench
🪛	Objects	tool		screw | screwdriver | tool
🔩	Objects	tool	and bolt	bolt | nut | nut and bolt | tool
⚙️	Objects	tool		
⚙	Objects	tool		cog | cogwheel | gear | tool
🗜️	Objects	tool		
🗜	Objects	tool		clamp | compress | tool | vice
⚖️	Objects	tool	scale	
⚖	Objects	tool	scale	balance | justice | Libra | scale | zodiac
🦯	Objects	tool	cane	accessibility | blind | white cane | guide cane | long mobility cane
🔗	Objects	tool		link
⛓️‍💥	Objects	tool	chain	
⛓‍💥	Objects	tool	chain	break | breaking | broken chain | chain | cuffs | freedom
⛓️	Objects	tool		
⛓	Objects	tool		chain | chains
🪝	Objects	tool		catch | crook | curve | ensnare | hook | selling point | fishing
🧰	Objects	tool		chest | mechanic | tool | toolbox
🧲	Objects	tool		attraction | horseshoe | magnet | magnetic
🪜	Objects	tool		climb | ladder | rung | step
⚗️	Objects	science		
⚗	Objects	science		alembic | chemistry | tool
🧪	Objects	science	tube	chemist | chemistry | experiment | lab | science | test tube
🧫	Objects	science	dish	bacteria | biologist | biology | culture | lab | petri dish
🧬	Objects	science		biologist | dna | evolution | gene | genetics | life | DNA
🔬	Objects	science		microscope | science | tool
🔭	Objects	science		science | telescope | tool
📡	Objects	science	antenna	antenna | dish | satellite
💉	Objects	medical		medicine | needle | shot | sick | syringe | ill | injection
🩸	Objects	medical	of blood	bleed | blood donation | drop of blood | injury | medicine | menstruation
💊	Objects	medical		doctor | medicine | pill | sick | capsule
🩹	Objects	medical	bandage	adhesive bandage | bandage | injury | plaster | sticking plaster | bandaid | dressing
🩼	Objects	medical		cane | crutch | disability | hurt | mobility aid | stick
🩺	Objects	medical		doctor | heart | medicine | stethoscope
🩻	Objects	medical		bones | doctor | medical | skeleton | x-ray | X-ray
🚪	Objects	household		door
🛗	Objects	household		accessibility | elevator | hoist | lift
🪞	Objects	household		mirror | reflection | reflector | speculum | looking glass
🪟	Objects	household		frame | fresh air | opening | transparent | view | window
🛏️	Objects	household		
🛏	Objects	household		bed | hotel | sleep
🛋️	Objects	household	and lamp	
🛋	Objects	household	and lamp	couch | couch and lamp | hotel | lamp | sofa | sofa and lamp
🪑	Objects	household		chair | seat | sit
🚽	Objects	household		toilet | facilities | loo | WC | lavatory
🪠	Objects	household		force cup | plumber | plunger | suction | toilet
🚿	Objects	household		shower | water
🛁	Objects	household		bath | bathtub
🪤	Objects	household	trap	bait | mouse trap | mousetrap | snare | trap | mouse
🪒	Objects	household		razor | sharp | shave | cut-throat
🧴	Objects	household	bottle	lotion | lotion bottle | moisturizer | shampoo | sunscreen | moisturiser
🧷	Objects	household	pin	diaper | punk rock | safety pin | nappy
🧹	Objects	household		broom | cleaning | sweeping | witch
🧺	Objects	household		basket | farming | laundry | picnic
🧻	Objects	household	of paper	paper towels | roll of paper | toilet paper | toilet roll
🪣	Objects	household		bucket | cask | pail | vat
🧼	Objects	household		bar | bathing | cleaning | lather | soap | soapdish
🫧	Objects	household		bubbles | burp | clean | soap | underwater
🪥	Objects	household		bathroom | brush | clean | dental | hygiene | teeth | toothbrush
🧽	Objects	household		absorbing | cleaning | porous | sponge
🧯	Objects	household	extinguisher	extinguish | fire | fire extinguisher | quench
🛒	Objects	household	cart	cart | shopping | trolley | basket
🚬	Objects	other-object		cigarette | smoking
⚰️	Objects	other-object		
⚰	Objects	other-object		coffin | death | casket
🪦	Objects	other-object		cemetery | grave | graveyard | headstone | tombstone
⚱️	Objects	other-object	urn	
⚱	Objects	other-object	urn	ashes | death | funeral | urn
🧿	Objects	other-object	amulet	bead | charm | evil-eye | nazar | nazar amulet | talisman | amulet | evil eye
🪬	Objects	other-object		amulet | Fatima | hamsa | hand | Mary | Miriam | protection
🗿	Objects	other-object		face | moai | moyai | statue
🪧	Objects	other-object		demonstration | picket | placard | protest | sign
🪪	Objects	other-object	card	credentials | ID | identification card | license | security | driving | licence
🏧	Symbols	transport-sign	sign	ATM | ATM sign | automated | bank | teller
🚮	Symbols	transport-sign	in bin sign	litter | litter bin | litter in bin sign | garbage | trash
🚰	Symbols	transport-sign	water	drinking | potable | water
♿	Symbols	transport-sign	symbol	access | wheelchair symbol | disabled access
🚹	Symbols	transport-sign	room	bathroom | lavatory | man | men’s room | restroom | toilet | WC | men’s | washroom | wc
🚺	Symbols	transport-sign	room	bathroom | lavatory | restroom | toilet | WC | woman | women’s room | ladies room | wc | women’s toilet | ladies’ room
🚻	Symbols	transport-sign		bathroom | lavatory | restroom | toilet | WC | washroom
🚼	Symbols	transport-sign	symbol	baby | baby symbol | changing | change room
🚾	Symbols	transport-sign	closet	bathroom | closet | lavatory | restroom | toilet | water | WC | wc | amenities | water closet
🛂	Symbols	transport-sign	control	control | passport | border | security
🛃	Symbols	transport-sign		customs
🛄	Symbols	transport-sign	claim	baggage | claim
🛅	Symbols	transport-sign	luggage	baggage | left luggage | locker | luggage
⚠️	Symbols	warning		
⚠	Symbols	warning		warning
🚸	Symbols	warning	crossing	child | children crossing | crossing | pedestrian | traffic
⛔	Symbols	warning	entry	entry | forbidden | no | not | prohibited | traffic | denied
🚫	Symbols	warning		entry | forbidden | no | not | prohibited | denied
🚳	Symbols	warning	bicycles	bicycle | bike | forbidden | no | no bicycles | prohibited
🚭	Symbols	warning	smoking	forbidden | no | not | prohibited | smoking | denied
🚯	Symbols	warning	littering	forbidden | litter | no | no littering | not | prohibited | denied
🚱	Symbols	warning	water	non-drinking | non-potable | water | non-drinkable water
🚷	Symbols	warning	pedestrians	forbidden | no | no pedestrians | not | pedestrian | prohibited | denied
📵	Symbols	warning	mobile phones	cell | forbidden | mobile | no | no mobile phones | phone
🔞	Symbols	warning	one under eighteen	18 | age restriction | eighteen | no one under eighteen | prohibited | underage
☢️	Symbols	warning		
☢	Symbols	warning		radioactive | sign
☣️	Symbols	warning		
☣	Symbols	warning		biohazard | sign
⬆️	Symbols	arrow	arrow	
⬆	Symbols	arrow	arrow	arrow | cardinal | direction | north | up arrow | up
↗️	Symbols	arrow	arrow	
↗	Symbols	arrow	arrow	arrow | direction | intercardinal | northeast | up-right arrow
➡️	Symbols	arrow	arrow	
➡	Symbols	arrow	arrow	arrow | cardinal | direction | east | right arrow
↘️	Symbols	arrow	arrow	
↘	Symbols	arrow	arrow	arrow | direction | down-right arrow | intercardinal | southeast
⬇️	Symbols	arrow	arrow	
⬇	Symbols	arrow	arrow	arrow | cardinal | direction | down | south
↙️	Symbols	arrow	arrow	
↙	Symbols	arrow	arrow	arrow | direction | down-left arrow | intercardinal | southwest
⬅️	Symbols	arrow	arrow	
⬅	Symbols	arrow	arrow	arrow | cardinal | direction | left arrow | west
↖️	Symbols	arrow	arrow	
↖	Symbols	arrow	arrow	arrow | direction | intercardinal | northwest | up-left arrow
↕️	Symbols	arrow	arrow	
↕	Symbols	arrow	arrow	arrow | up-down arrow
↔️	Symbols	arrow	arrow	
↔	Symbols	arrow	arrow	arrow | left-right arrow
↩️	Symbols	arrow	arrow curving left	
↩	Symbols	arrow	arrow curving left	arrow | right arrow curving left
↪️	Symbols	arrow	arrow curving right	
↪	Symbols	arrow	arrow curving right	arrow | left arrow curving right
⤴️	Symbols	arrow	arrow curving up	
⤴	Symbols	arrow	arrow curving up	arrow | right arrow curving up
⤵️	Symbols	arrow	arrow curving down	
⤵	Symbols	arrow	arrow curving down	arrow | down | right arrow curving down
🔃	Symbols	arrow	vertical arrows	arrow | clockwise | clockwise vertical arrows | reload
🔄	Symbols	arrow	arrows button	anticlockwise | arrow | counterclockwise | counterclockwise arrows button | withershins | anticlockwise arrows button
🔙	Symbols	arrow	arrow	arrow | BACK
🔚	Symbols	arrow	arrow	arrow | END
🔛	Symbols	arrow	arrow	arrow | mark | ON | ON!
🔜	Symbols	arrow	arrow	arrow | SOON
🔝	Symbols	arrow	arrow	arrow | TOP | up
🛐	Symbols	religion	of worship	place of worship | religion | worship
⚛️	Symbols	religion	symbol	
⚛	Symbols	religion	symbol	atheist | atom | atom symbol
🕉️	Symbols	religion		
🕉	Symbols	religion		Hindu | om | religion
✡️	Symbols	religion	of David	
✡	Symbols	religion	of David	David | Jew | Jewish | religion | star | star of David | Judaism | Star of David
☸️	Symbols	religion	of dharma	
☸	Symbols	religion	of dharma	Buddhist | dharma | religion | wheel | wheel of dharma
☯️	Symbols	religion	yang	
☯	Symbols	religion	yang	religion | tao | taoist | yang | yin | Tao | Taoist
✝️	Symbols	religion	cross	
✝	Symbols	religion	cross	Christian | cross | latin cross | religion | Latin cross
☦️	Symbols	religion	cross	
☦	Symbols	religion	cross	Christian | cross | orthodox cross | religion | Orthodox cross
☪️	Symbols	religion	and crescent	
☪	Symbols	religion	and crescent	islam | Muslim | religion | star and crescent | Islam
☮️	Symbols	religion	symbol	
☮	Symbols	religion	symbol	peace | peace symbol
🕎	Symbols	religion		candelabrum | candlestick | menorah | religion
🔯	Symbols	religion	six-pointed star	dotted six-pointed star | fortune | star
🪯	Symbols	religion		khanda | religion | Sikh
♈	Symbols	zodiac		Aries | ram | zodiac
♉	Symbols	zodiac		bull | ox | Taurus | zodiac
♊	Symbols	zodiac		Gemini | twins | zodiac
♋	Symbols	zodiac		Cancer | crab | zodiac
♌	Symbols	zodiac		Leo | lion | zodiac
♍	Symbols	zodiac		Virgo | zodiac | virgin
♎	Symbols	zodiac		balance | justice | Libra | scales | zodiac
♏	Symbols	zodiac		Scorpio | scorpion | scorpius | zodiac | Scorpius
♐	Symbols	zodiac		archer | Sagittarius | zodiac | centaur
♑	Symbols	zodiac		Capricorn | goat | zodiac
♒	Symbols	zodiac		Aquarius | bearer | water | zodiac | water bearer
♓	Symbols	zodiac		fish | Pisces | zodiac
⛎	Symbols	zodiac		bearer | Ophiuchus | serpent | snake | zodiac
🔀	Symbols	av-symbol	tracks button	arrow | crossed | shuffle tracks button
🔁	Symbols	av-symbol	button	arrow | clockwise | repeat | repeat button
🔂	Symbols	av-symbol	single button	arrow | clockwise | once | repeat single button
▶️	Symbols	av-symbol	button	
▶	Symbols	av-symbol	button	arrow | play | play button | right | triangle
⏩	Symbols	av-symbol	button	arrow | double | fast | fast-forward button | forward | fast forward button
⏭️	Symbols	av-symbol	track button	
⏭	Symbols	av-symbol	track button	arrow | next scene | next track | next track button | triangle
⏯️	Symbols	av-symbol	or pause button	
⏯	Symbols	av-symbol	or pause button	arrow | pause | play | play or pause button | right | triangle
◀️	Symbols	av-symbol	button	
◀	Symbols	av-symbol	button	arrow | left | reverse | reverse button | triangle
⏪	Symbols	av-symbol	reverse button	arrow | double | fast reverse button | rewind
⏮️	Symbols	av-symbol	track button	
⏮	Symbols	av-symbol	track button	arrow | last track button | previous scene | previous track | triangle
🔼	Symbols	av-symbol	button	arrow | button | upwards button | red | upward button
⏫	Symbols	av-symbol	up button	arrow | double | fast up button
🔽	Symbols	av-symbol	button	arrow | button | down | downwards button | downward button | red
⏬	Symbols	av-symbol	down button	arrow | double | down | fast down button
⏸️	Symbols	av-symbol	button	
⏸	Symbols	av-symbol	button	bar | double | pause | pause button | vertical
⏹️	Symbols	av-symbol	button	
⏹	Symbols	av-symbol	button	square | stop | stop button
⏺️	Symbols	av-symbol	button	
⏺	Symbols	av-symbol	button	circle | record | record button
⏏️	Symbols	av-symbol	button	
⏏	Symbols	av-symbol	button	eject | eject button
🎦	Symbols	av-symbol		camera | cinema | film | movie
🔅	Symbols	av-symbol	button	brightness | dim | dim button | low
🔆	Symbols	av-symbol	button	bright | bright button | brightness | brightness button
📶	Symbols	av-symbol	bars	antenna | antenna bars | bar | cell | mobile | phone
🛜	Symbols	av-symbol		computer | internet | network | wi-fi | wifi | wireless | Wi-Fi
📳	Symbols	av-symbol	mode	cell | mobile | mode | phone | telephone | vibration | vibrate
📴	Symbols	av-symbol	phone off	cell | mobile | off | phone | telephone
♀️	Symbols	gender	sign	
♀	Symbols	gender	sign	female sign | woman
♂️	Symbols	gender	sign	
♂	Symbols	gender	sign	male sign | man
⚧️	Symbols	gender	symbol	
⚧	Symbols	gender	symbol	transgender | transgender symbol | trans
✖️	Symbols	math		
✖	Symbols	math		× | cancel | multiplication | multiply | sign | x | heavy multiplication sign
➕	Symbols	math		+ | math | plus | sign | maths | add | addition
➖	Symbols	math		- | − | math | minus | sign | heavy minus sign | maths | – | subtraction
➗	Symbols	math		÷ | divide | division | math | sign
🟰	Symbols	math	equals sign	equality | heavy equals sign | math | maths
♾️	Symbols	math		
♾	Symbols	math		forever | infinity | unbounded | universal | eternal | unbound
‼️	Symbols	punctuation	exclamation mark	
‼	Symbols	punctuation	exclamation mark	! | !! | bangbang | double exclamation mark | exclamation | mark | punctuation
⁉️	Symbols	punctuation	question mark	
⁉	Symbols	punctuation	question mark	! | !? | ? | exclamation | interrobang | mark | punctuation | question | exclamation question mark
❓	Symbols	punctuation	question mark	? | mark | punctuation | question | red question mark
❔	Symbols	punctuation	question mark	? | mark | outlined | punctuation | question | white question mark
❕	Symbols	punctuation	exclamation mark	! | exclamation | mark | outlined | punctuation | white exclamation mark
❗	Symbols	punctuation	exclamation mark	! | exclamation | mark | punctuation | red exclamation mark
〰️	Symbols	punctuation	dash	
〰	Symbols	punctuation	dash	dash | punctuation | wavy
💱	Symbols	currency	exchange	bank | currency | exchange | money
💲	Symbols	currency	dollar sign	currency | dollar | heavy dollar sign | money
⚕️	Symbols	other-symbol	symbol	
⚕	Symbols	other-symbol	symbol	aesculapius | medical symbol | medicine | staff
♻️	Symbols	other-symbol	symbol	
♻	Symbols	other-symbol	symbol	recycle | recycling symbol
⚜️	Symbols	other-symbol		
⚜	Symbols	other-symbol		fleur-de-lis
🔱	Symbols	other-symbol	emblem	anchor | emblem | ship | tool | trident
📛	Symbols	other-symbol	badge	badge | name
🔰	Symbols	other-symbol	symbol for beginner	beginner | chevron | Japanese | Japanese symbol for beginner | leaf
⭕	Symbols	other-symbol	red circle	circle | hollow red circle | large | o | red
✅	Symbols	other-symbol	mark button	✓ | button | check | mark | tick
☑️	Symbols	other-symbol	box with check	
☑	Symbols	other-symbol	box with check	✓ | box | check | check box with check | tick | tick box with tick | ballot
✔️	Symbols	other-symbol	mark	
✔	Symbols	other-symbol	mark	✓ | check | mark | tick | check mark | heavy tick mark
❌	Symbols	other-symbol	mark	× | cancel | cross | mark | multiplication | multiply | x
❎	Symbols	other-symbol	mark button	× | cross mark button | mark | square | x
➰	Symbols	other-symbol	loop	curl | curly loop | loop
➿	Symbols	other-symbol	curly loop	curl | double | double curly loop | loop
〽️	Symbols	other-symbol	alternation mark	
〽	Symbols	other-symbol	alternation mark	mark | part | part alternation mark
✳️	Symbols	other-symbol	asterisk	
✳	Symbols	other-symbol	asterisk	* | asterisk | eight-spoked asterisk
✴️	Symbols	other-symbol	star	
✴	Symbols	other-symbol	star	* | eight-pointed star | star
❇️	Symbols	other-symbol		
❇	Symbols	other-symbol		* | sparkle
©️	Symbols	other-symbol		
©	Symbols	other-symbol		C | copyright
®️	Symbols	other-symbol		
®	Symbols	other-symbol		R | registered | r | trademark
™️	Symbols	other-symbol	mark	
™	Symbols	other-symbol	mark	mark | TM | trade mark | trademark
#️⃣	Symbols	keycap	#	
#⃣	Symbols	keycap	#	keycap | keycap: #
*️⃣	Symbols	keycap	*	
*⃣	Symbols	keycap	*	keycap | keycap: *
0️⃣	Symbols	keycap	0	
0⃣	Symbols	keycap	0	keycap | keycap: 0
1️⃣	Symbols	keycap	1	
1⃣	Symbols	keycap	1	keycap | keycap: 1
2️⃣	Symbols	keycap	2	
2⃣	Symbols	keycap	2	keycap | keycap: 2
3️⃣	Symbols	keycap	3	
3⃣	Symbols	keycap	3	keycap | keycap: 3
4️⃣	Symbols	keycap	4	
4⃣	Symbols	keycap	4	keycap | keycap: 4
5️⃣	Symbols	keycap	5	
5⃣	Symbols	keycap	5	keycap | keycap: 5
6️⃣	Symbols	keycap	6	
6⃣	Symbols	keycap	6	keycap | keycap: 6
7️⃣	Symbols	keycap	7	
7⃣	Symbols	keycap	7	keycap | keycap: 7
8️⃣	Symbols	keycap	8	
8⃣	Symbols	keycap	8	keycap | keycap: 8
9️⃣	Symbols	keycap	9	
9⃣	Symbols	keycap	9	keycap | keycap: 9
🔟	Symbols	keycap	10	keycap | keycap: 10
🔠	Symbols	alphanum	latin uppercase	ABCD | input | latin | letters | uppercase | input Latin uppercase | Latin
🔡	Symbols	alphanum	latin lowercase	abcd | input | latin | letters | lowercase | input Latin lowercase | Latin
🔢	Symbols	alphanum	numbers	1234 | input | numbers
🔣	Symbols	alphanum	symbols	〒♪&% | input | input symbols
🔤	Symbols	alphanum	latin letters	abc | alphabet | input | latin | letters | input Latin letters | Latin
🅰️	Symbols	alphanum	button (blood type)	
🅰	Symbols	alphanum	button (blood type)	A | A button (blood type) | blood type
🆎	Symbols	alphanum	button (blood type)	AB | AB button (blood type) | blood type
🅱️	Symbols	alphanum	button (blood type)	
🅱	Symbols	alphanum	button (blood type)	B | B button (blood type) | blood type
🆑	Symbols	alphanum	button	CL | CL button
🆒	Symbols	alphanum	button	COOL | COOL button
🆓	Symbols	alphanum	button	FREE | FREE button
ℹ️	Symbols	alphanum		
ℹ	Symbols	alphanum		i | information
🆔	Symbols	alphanum	button	ID | ID button | identity
Ⓜ️	Symbols	alphanum	M	
Ⓜ	Symbols	alphanum	M	circle | circled M | M
🆕	Symbols	alphanum	button	NEW | NEW button
🆖	Symbols	alphanum	button	NG | NG button
🅾️	Symbols	alphanum	button (blood type)	
🅾	Symbols	alphanum	button (blood type)	blood type | O | O button (blood type)
🆗	Symbols	alphanum	button	OK | OK button
🅿️	Symbols	alphanum	button	
🅿	Symbols	alphanum	button	P | P button | parking | car park | carpark
🆘	Symbols	alphanum	button	help | SOS | SOS button
🆙	Symbols	alphanum	button	mark | UP | UP! | UP! button
🆚	Symbols	alphanum	button	versus | VS | VS button
🈁	Symbols	alphanum	“here” button	“here” | Japanese | Japanese “here” button | katakana | ココ
🈂️	Symbols	alphanum	“service charge” button	
🈂	Symbols	alphanum	“service charge” button	“service charge” | Japanese | Japanese “service charge” button | katakana | サ
🈷️	Symbols	alphanum	“monthly amount” button	
🈷	Symbols	alphanum	“monthly amount” button	“monthly amount” | ideograph | Japanese | Japanese “monthly amount” button | 月
🈶	Symbols	alphanum	“not free of charge” button	“not free of charge” | ideograph | Japanese | Japanese “not free of charge” button | 有
🈯	Symbols	alphanum	“reserved” button	“reserved” | ideograph | Japanese | Japanese “reserved” button | 指
🉐	Symbols	alphanum	“bargain” button	“bargain” | ideograph | Japanese | Japanese “bargain” button | 得
🈹	Symbols	alphanum	“discount” button	“discount” | ideograph | Japanese | Japanese “discount” button | 割
🈚	Symbols	alphanum	“free of charge” button	“free of charge” | ideograph | Japanese | Japanese “free of charge” button | 無
🈲	Symbols	alphanum	“prohibited” button	“prohibited” | ideograph | Japanese | Japanese “prohibited” button | 禁
🉑	Symbols	alphanum	“acceptable” button	“acceptable” | ideograph | Japanese | Japanese “acceptable” button | 可
🈸	Symbols	alphanum	“application” button	“application” | ideograph | Japanese | Japanese “application” button | 申
🈴	Symbols	alphanum	“passing grade” button	“passing grade” | ideograph | Japanese | Japanese “passing grade” button | 合
🈳	Symbols	alphanum	“vacancy” button	“vacancy” | ideograph | Japanese | Japanese “vacancy” button | 空
㊗️	Symbols	alphanum	“congratulations” button	
㊗	Symbols	alphanum	“congratulations” button	“congratulations” | ideograph | Japanese | Japanese “congratulations” button | 祝
㊙️	Symbols	alphanum	“secret” button	
㊙	Symbols	alphanum	“secret” button	“secret” | ideograph | Japanese | Japanese “secret” button | 秘
🈺	Symbols	alphanum	“open for business” button	“open for business” | ideograph | Japanese | Japanese “open for business” button | 営
🈵	Symbols	alphanum	“no vacancy” button	“no vacancy” | ideograph | Japanese | Japanese “no vacancy” button | 満
🔴	Symbols	geometric	circle	circle | geometric | red
🟠	Symbols	geometric	circle	circle | orange
🟡	Symbols	geometric	circle	circle | yellow
🟢	Symbols	geometric	circle	circle | green
🔵	Symbols	geometric	circle	blue | circle | geometric
🟣	Symbols	geometric	circle	circle | purple
🟤	Symbols	geometric	circle	brown | circle
⚫	Symbols	geometric	circle	black circle | circle | geometric
⚪	Symbols	geometric	circle	circle | geometric | white circle
🟥	Symbols	geometric	square	red | square
🟧	Symbols	geometric	square	orange | square
🟨	Symbols	geometric	square	square | yellow
🟩	Symbols	geometric	square	green | square
🟦	Symbols	geometric	square	blue | square
🟪	Symbols	geometric	square	purple | square
🟫	Symbols	geometric	square	brown | square
⬛	Symbols	geometric	large square	black large square | geometric | square
⬜	Symbols	geometric	large square	geometric | square | white large square
◼️	Symbols	geometric	medium square	
◼	Symbols	geometric	medium square	black medium square | geometric | square
◻️	Symbols	geometric	medium square	
◻	Symbols	geometric	medium square	geometric | square | white medium square
◾	Symbols	geometric	medium-small square	black medium-small square | geometric | square
◽	Symbols	geometric	medium-small square	geometric | square | white medium-small square
▪️	Symbols	geometric	small square	
▪	Symbols	geometric	small square	black small square | geometric | square
▫️	Symbols	geometric	small square	
▫	Symbols	geometric	small square	geometric | square | white small square
🔶	Symbols	geometric	orange diamond	diamond | geometric | large orange diamond | orange
🔷	Symbols	geometric	blue diamond	blue | diamond | geometric | large blue diamond
🔸	Symbols	geometric	orange diamond	diamond | geometric | orange | small orange diamond
🔹	Symbols	geometric	blue diamond	blue | diamond | geometric | small blue diamond
🔺	Symbols	geometric	triangle pointed up	geometric | red | red triangle pointed up
🔻	Symbols	geometric	triangle pointed down	down | geometric | red | red triangle pointed down
💠	Symbols	geometric	with a dot	comic | diamond | diamond with a dot | geometric | inside
🔘	Symbols	geometric	button	button | geometric | radio
🔳	Symbols	geometric	square button	button | geometric | outlined | square | white square button
🔲	Symbols	geometric	square button	black square button | button | geometric | square
🏁	flag	flag	checkered | chequered | chequered flag | racing | checkered flag
🚩	flag	flag	post | triangular flag | red flag
🎌	flag	celebration | cross | crossed | crossed flags | Japanese
🏴	flag	flag	black flag | waving
🏳️	flag	flag	
🏳	flag	flag	waving | white flag | surrender
🏳️‍🌈	flag	flag	
🏳‍🌈	flag	flag	pride | rainbow | rainbow flag
🏳️‍⚧️	flag	flag	
🏳️‍⚧	flag	flag	
🏳‍⚧	flag	flag	flag | light blue | pink | transgender | white | trans
🏴‍☠️	flag	flag	
🏴‍☠	flag	flag	Jolly Roger | pirate | pirate flag | plunder | treasure
🇦🇨	country-flag	Ascension Island	flag | flag: Ascension Island
🇦🇩	country-flag	Andorra	flag | flag: Andorra
🇦🇪	country-flag	United Arab Emirates	flag | flag: United Arab Emirates
🇦🇫	country-flag	Afghanistan	flag | flag: Afghanistan
🇦🇬	country-flag	Antigua & Barbuda	flag | flag: Antigua & Barbuda | flag: Antigua and Barbuda
🇦🇮	country-flag	Anguilla	flag | flag: Anguilla
🇦🇱	country-flag	Albania	flag | flag: Albania
🇦🇲	country-flag	Armenia	flag | flag: Armenia
🇦🇴	country-flag	Angola	flag | flag: Angola
🇦🇶	country-flag	Antarctica	flag | flag: Antarctica
🇦🇷	country-flag	Argentina	flag | flag: Argentina
🇦🇸	country-flag	American Samoa	flag | flag: American Samoa
🇦🇹	country-flag	Austria	flag | flag: Austria
🇦🇺	country-flag	Australia	flag | flag: Australia
🇦🇼	country-flag	Aruba	flag | flag: Aruba
🇦🇽	country-flag	Åland Islands	flag | flag: Åland Islands
🇦🇿	country-flag	Azerbaijan	flag | flag: Azerbaijan
🇧🇦	country-flag	Bosnia & Herzegovina	flag | flag: Bosnia & Herzegovina | flag: Bosnia and Herzegovina
🇧🇧	country-flag	Barbados	flag | flag: Barbados
🇧🇩	country-flag	Bangladesh	flag | flag: Bangladesh
🇧🇪	country-flag	Belgium	flag | flag: Belgium
🇧🇫	country-flag	Burkina Faso	flag | flag: Burkina Faso
🇧🇬	country-flag	Bulgaria	flag | flag: Bulgaria
🇧🇭	country-flag	Bahrain	flag | flag: Bahrain
🇧🇮	country-flag	Burundi	flag | flag: Burundi
🇧🇯	country-flag	Benin	flag | flag: Benin
🇧🇱	country-flag	St. Barthélemy	flag | flag: St. Barthélemy | flag: St Barthélemy | flag: Saint-Barthélemy
🇧🇲	country-flag	Bermuda	flag | flag: Bermuda
🇧🇳	country-flag	Brunei	flag | flag: Brunei
🇧🇴	country-flag	Bolivia	flag | flag: Bolivia
🇧🇶	country-flag	Caribbean Netherlands	flag | flag: Caribbean Netherlands
🇧🇷	country-flag	Brazil	flag | flag: Brazil
🇧🇸	country-flag	Bahamas	flag | flag: Bahamas
🇧🇹	country-flag	Bhutan	flag | flag: Bhutan
🇧🇻	country-flag	Bouvet Island	flag | flag: Bouvet Island
🇧🇼	country-flag	Botswana	flag | flag: Botswana
🇧🇾	country-flag	Belarus	flag | flag: Belarus
🇧🇿	country-flag	Belize	flag | flag: Belize
🇨🇦	country-flag	Canada	flag | flag: Canada
🇨🇨	country-flag	Cocos (Keeling) Islands	flag | flag: Cocos (Keeling) Islands
🇨🇩	country-flag	Congo - Kinshasa	flag | flag: Congo - Kinshasa
🇨🇫	country-flag	Central African Republic	flag | flag: Central African Republic
🇨🇬	country-flag	Congo - Brazzaville	flag | flag: Congo - Brazzaville
🇨🇭	country-flag	Switzerland	flag | flag: Switzerland
🇨🇮	country-flag	Côte d’Ivoire	flag | flag: Côte d’Ivoire
🇨🇰	country-flag	Cook Islands	flag | flag: Cook Islands
🇨🇱	country-flag	Chile	flag | flag: Chile
🇨🇲	country-flag	Cameroon	flag | flag: Cameroon
🇨🇳	country-flag	China	flag | flag: China
🇨🇴	country-flag	Colombia	flag | flag: Colombia
🇨🇵	country-flag	Clipperton Island	flag | flag: Clipperton Island
🇨🇷	country-flag	Costa Rica	flag | flag: Costa Rica
🇨🇺	country-flag	Cuba	flag | flag: Cuba
🇨🇻	country-flag	Cape Verde	flag | flag: Cape Verde
🇨🇼	country-flag	Curaçao	flag | flag: Curaçao
🇨🇽	country-flag	Christmas Island	flag | flag: Christmas Island
🇨🇾	country-flag	Cyprus	flag | flag: Cyprus
🇨🇿	country-flag	Czechia	flag | flag: Czechia
🇩🇪	country-flag	Germany	flag | flag: Germany
🇩🇬	country-flag	Diego Garcia	flag | flag: Diego Garcia
🇩🇯	country-flag	Djibouti	flag | flag: Djibouti
🇩🇰	country-flag	Denmark	flag | flag: Denmark
🇩🇲	country-flag	Dominica	flag | flag: Dominica
🇩🇴	country-flag	Dominican Republic	flag | flag: Dominican Republic
🇩🇿	country-flag	Algeria	flag | flag: Algeria
🇪🇦	country-flag	Ceuta & Melilla	flag | flag: Ceuta & Melilla | flag: Ceuta and Melilla
🇪🇨	country-flag	Ecuador	flag | flag: Ecuador
🇪🇪	country-flag	Estonia	flag | flag: Estonia
🇪🇬	country-flag	Egypt	flag | flag: Egypt
🇪🇭	country-flag	Western Sahara	flag | flag: Western Sahara
🇪🇷	country-flag	Eritrea	flag | flag: Eritrea
🇪🇸	country-flag	Spain	flag | flag: Spain
🇪🇹	country-flag	Ethiopia	flag | flag: Ethiopia
🇪🇺	country-flag	European Union	flag | flag: European Union
🇫🇮	country-flag	Finland	flag | flag: Finland
🇫🇯	country-flag	Fiji	flag | flag: Fiji
🇫🇰	country-flag	Falkland Islands	flag | flag: Falkland Islands
🇫🇲	country-flag	Micronesia	flag | flag: Micronesia
🇫🇴	country-flag	Faroe Islands	flag | flag: Faroe Islands
🇫🇷	country-flag	France	flag | flag: France
🇬🇦	country-flag	Gabon	flag | flag: Gabon
🇬🇧	country-flag	United Kingdom	flag | flag: United Kingdom
🇬🇩	country-flag	Grenada	flag | flag: Grenada
🇬🇪	country-flag	Georgia	flag | flag: Georgia
🇬🇫	country-flag	French Guiana	flag | flag: French Guiana
🇬🇬	country-flag	Guernsey	flag | flag: Guernsey
🇬🇭	country-flag	Ghana	flag | flag: Ghana
🇬🇮	country-flag	Gibraltar	flag | flag: Gibraltar
🇬🇱	country-flag	Greenland	flag | flag: Greenland
🇬🇲	country-flag	Gambia	flag | flag: Gambia
🇬🇳	country-flag	Guinea	flag | flag: Guinea
🇬🇵	country-flag	Guadeloupe	flag | flag: Guadeloupe
🇬🇶	country-flag	Equatorial Guinea	flag | flag: Equatorial Guinea
🇬🇷	country-flag	Greece	flag | flag: Greece
🇬🇸	country-flag	South Georgia & South Sandwich Islands	flag | flag: South Georgia & South Sandwich Islands | flag: South Georgia and South Sandwich Islands
🇬🇹	country-flag	Guatemala	flag | flag: Guatemala
🇬🇺	country-flag	Guam	flag | flag: Guam
🇬🇼	country-flag	Guinea-Bissau	flag | flag: Guinea-Bissau
🇬🇾	country-flag	Guyana	flag | flag: Guyana
🇭🇰	country-flag	Hong Kong SAR China	flag | flag: Hong Kong SAR China
🇭🇲	country-flag	Heard & McDonald Islands	flag | flag: Heard & McDonald Islands | flag: Heard and McDonald Islands
🇭🇳	country-flag	Honduras	flag | flag: Honduras
🇭🇷	country-flag	Croatia	flag | flag: Croatia
🇭🇹	country-flag	Haiti	flag | flag: Haiti
🇭🇺	country-flag	Hungary	flag | flag: Hungary
🇮🇨	country-flag	Canary Islands	flag | flag: Canary Islands
🇮🇩	country-flag	Indonesia	flag | flag: Indonesia
🇮🇪	country-flag	Ireland	flag | flag: Ireland
🇮🇱	country-flag	Israel	flag | flag: Israel
🇮🇲	country-flag	Isle of Man	flag | flag: Isle of Man
🇮🇳	country-flag	India	flag | flag: India
🇮🇴	country-flag	British Indian Ocean Territory	flag | flag: British Indian Ocean Territory
🇮🇶	country-flag	Iraq	flag | flag: Iraq
🇮🇷	country-flag	Iran	flag | flag: Iran
🇮🇸	country-flag	Iceland	flag | flag: Iceland
🇮🇹	country-flag	Italy	flag | flag: Italy
🇯🇪	country-flag	Jersey	flag | flag: Jersey
🇯🇲	country-flag	Jamaica	flag | flag: Jamaica
🇯🇴	country-flag	Jordan	flag | flag: Jordan
🇯🇵	country-flag	Japan	flag | flag: Japan
🇰🇪	country-flag	Kenya	flag | flag: Kenya
🇰🇬	country-flag	Kyrgyzstan	flag | flag: Kyrgyzstan
🇰🇭	country-flag	Cambodia	flag | flag: Cambodia
🇰🇮	country-flag	Kiribati	flag | flag: Kiribati
🇰🇲	country-flag	Comoros	flag | flag: Comoros
🇰🇳	country-flag	St. Kitts & Nevis	flag | flag: St. Kitts & Nevis | flag: St Kitts & Nevis | flag: Saint Kitts and Nevis
🇰🇵	country-flag	North Korea	flag | flag: North Korea
🇰🇷	country-flag	South Korea	flag | flag: South Korea
🇰🇼	country-flag	Kuwait	flag | flag: Kuwait
🇰🇾	country-flag	Cayman Islands	flag | flag: Cayman Islands
🇰🇿	country-flag	Kazakhstan	flag | flag: Kazakhstan
🇱🇦	country-flag	Laos	flag | flag: Laos
🇱🇧	country-flag	Lebanon	flag | flag: Lebanon
🇱🇨	country-flag	St. Lucia	flag | flag: St. Lucia | flag: St Lucia | flag: Saint Lucia
🇱🇮	country-flag	Liechtenstein	flag | flag: Liechtenstein
🇱🇰	country-flag	Sri Lanka	flag | flag: Sri Lanka
🇱🇷	country-flag	Liberia	flag | flag: Liberia
🇱🇸	country-flag	Lesotho	flag | flag: Lesotho
🇱🇹	country-flag	Lithuania	flag | flag: Lithuania
🇱🇺	country-flag	Luxembourg	flag | flag: Luxembourg
🇱🇻	country-flag	Latvia	flag | flag: Latvia
🇱🇾	country-flag	Libya	flag | flag: Libya
🇲🇦	country-flag	Morocco	flag | flag: Morocco
🇲🇨	country-flag	Monaco	flag | flag: Monaco
🇲🇩	country-flag	Moldova	flag | flag: Moldova
🇲🇪	country-flag	Montenegro	flag | flag: Montenegro
🇲🇫	country-flag	St. Martin	flag | flag: St. Martin | flag: St Martin | flag: Saint Martin
🇲🇬	country-flag	Madagascar	flag | flag: Madagascar
🇲🇭	country-flag	Marshall Islands	flag | flag: Marshall Islands
🇲🇰	country-flag	North Macedonia	flag | flag: North Macedonia
🇲🇱	country-flag	Mali	flag | flag: Mali
🇲🇲	country-flag	Myanmar (Burma)	flag | flag: Myanmar (Burma)
🇲🇳	country-flag	Mongolia	flag | flag: Mongolia
🇲🇴	country-flag	Macao SAR China	flag | flag: Macao SAR China
🇲🇵	country-flag	Northern Mariana Islands	flag | flag: Northern Mariana Islands
🇲🇶	country-flag	Martinique	flag | flag: Martinique
🇲🇷	country-flag	Mauritania	flag | flag: Mauritania
🇲🇸	country-flag	Montserrat	flag | flag: Montserrat
🇲🇹	country-flag	Malta	flag | flag: Malta
🇲🇺	country-flag	Mauritius	flag | flag: Mauritius
🇲🇻	country-flag	Maldives	flag | flag: Maldives
🇲🇼	country-flag	Malawi	flag | flag: Malawi
🇲🇽	country-flag	Mexico	flag | flag: Mexico
🇲🇾	country-flag	Malaysia	flag | flag: Malaysia
🇲🇿	country-flag	Mozambique	flag | flag: Mozambique
🇳🇦	country-flag	Namibia	flag | flag: Namibia
🇳🇨	country-flag	New Caledonia	flag | flag: New Caledonia
🇳🇪	country-flag	Niger	flag | flag: Niger
🇳🇫	country-flag	Norfolk Island	flag | flag: Norfolk Island
🇳🇬	country-flag	Nigeria	flag | flag: Nigeria
🇳🇮	country-flag	Nicaragua	flag | flag: Nicaragua
🇳🇱	country-flag	Netherlands	flag | flag: Netherlands
🇳🇴	country-flag	Norway	flag | flag: Norway
🇳🇵	country-flag	Nepal	flag | flag: Nepal
🇳🇷	country-flag	Nauru	flag | flag: Nauru
🇳🇺	country-flag	Niue	flag | flag: Niue
🇳🇿	country-flag	New Zealand	flag | flag: New Zealand
🇴🇲	country-flag	Oman	flag | flag: Oman
🇵🇦	country-flag	Panama	flag | flag: Panama
🇵🇪	country-flag	Peru	flag | flag: Peru
🇵🇫	country-flag	French Polynesia	flag | flag: French Polynesia
🇵🇬	country-flag	Papua New Guinea	flag | flag: Papua New Guinea
🇵🇭	country-flag	Philippines	flag | flag: Philippines
🇵🇰	country-flag	Pakistan	flag | flag: Pakistan
🇵🇱	country-flag	Poland	flag | flag: Poland
🇵🇲	country-flag	St. Pierre & Miquelon	flag | flag: St. Pierre & Miquelon | flag: St Pierre & Miquelon | flag: Saint-Pierre-et-Miquelon
🇵🇳	country-flag	Pitcairn Islands	flag | flag: Pitcairn Islands
🇵🇷	country-flag	Puerto Rico	flag | flag: Puerto Rico
🇵🇸	country-flag	Palestinian Territories	flag | flag: Palestinian Territories | flag: Palestinian territories
🇵🇹	country-flag	Portugal	flag | flag: Portugal
🇵🇼	country-flag	Palau	flag | flag: Palau
🇵🇾	country-flag	Paraguay	flag | flag: Paraguay
🇶🇦	country-flag	Qatar	flag | flag: Qatar
🇷🇪	country-flag	Réunion	flag | flag: Réunion
🇷🇴	country-flag	Romania	flag | flag: Romania
🇷🇸	country-flag	Serbia	flag | flag: Serbia
🇷🇺	country-flag	Russia	flag | flag: Russia
🇷🇼	country-flag	Rwanda	flag | flag: Rwanda
🇸🇦	country-flag	Saudi Arabia	flag | flag: Saudi Arabia
🇸🇧	country-flag	Solomon Islands	flag | flag: Solomon Islands
🇸🇨	country-flag	Seychelles	flag | flag: Seychelles
🇸🇩	country-flag	Sudan	flag | flag: Sudan
🇸🇪	country-flag	Sweden	flag | flag: Sweden
🇸🇬	country-flag	Singapore	flag | flag: Singapore
🇸🇭	country-flag	St. Helena	flag | flag: St. Helena | flag: St Helena | flag: Saint Helena
🇸🇮	country-flag	Slovenia	flag | flag: Slovenia
🇸🇯	country-flag	Svalbard & Jan Mayen	flag | flag: Svalbard & Jan Mayen | flag: Svalbard and Jan Mayen
🇸🇰	country-flag	Slovakia	flag | flag: Slovakia
🇸🇱	country-flag	Sierra Leone	flag | flag: Sierra Leone
🇸🇲	country-flag	San Marino	flag | flag: San Marino
🇸🇳	country-flag	Senegal	flag | flag: Senegal
🇸🇴	country-flag	Somalia	flag | flag: Somalia
🇸🇷	country-flag	Suriname	flag | flag: Suriname
🇸🇸	country-flag	South Sudan	flag | flag: South Sudan
🇸🇹	country-flag	São Tomé & Príncipe	flag | flag: São Tomé & Príncipe | flag: São Tomé and Príncipe
🇸🇻	country-flag	El Salvador	flag | flag: El Salvador
🇸🇽	country-flag	Sint Maarten	flag | flag: Sint Maarten
🇸🇾	country-flag	Syria	flag | flag: Syria
🇸🇿	country-flag	Eswatini	flag | flag: Eswatini
🇹🇦	country-flag	Tristan da Cunha	flag | flag: Tristan da Cunha
🇹🇨	country-flag	Turks & Caicos Islands	flag | flag: Turks & Caicos Islands | flag: Turks and Caicos Islands
🇹🇩	country-flag	Chad	flag | flag: Chad
🇹🇫	country-flag	French Southern Territories	flag | flag: French Southern Territories
🇹🇬	country-flag	Togo	flag | flag: Togo
🇹🇭	country-flag	Thailand	flag | flag: Thailand
🇹🇯	country-flag	Tajikistan	flag | flag: Tajikistan
🇹🇰	country-flag	Tokelau	flag | flag: Tokelau
🇹🇱	country-flag	Timor-Leste	flag | flag: Timor-Leste
🇹🇲	country-flag	Turkmenistan	flag | flag: Turkmenistan
🇹🇳	country-flag	Tunisia	flag | flag: Tunisia
🇹🇴	country-flag	Tonga	flag | flag: Tonga
🇹🇷	country-flag	Turkey	flag | flag: Türkiye
🇹🇹	country-flag	Trinidad & Tobago	flag | flag: Trinidad & Tobago | flag: Trinidad and Tobago
🇹🇻	country-flag	Tuvalu	flag | flag: Tuvalu
🇹🇼	country-flag	Taiwan	flag | flag: Taiwan
🇹🇿	country-flag	Tanzania	flag | flag: TanzaniaE
🇺🇦	country-flag	Ukraine	flag | flag: Ukraine
🇺🇬	country-flag	Uganda	flag | flag: Uganda
🇺🇲	country-flag	U.S. Outlying Islands	flag | flag: U.S. Outlying Islands | flag: US Outlying Islands
🇺🇳	country-flag	United Nations	flag | flag: United Nations
🇺🇸	country-flag	United States	flag | flag: United States
🇺🇾	country-flag	Uruguay	flag | flag: Uruguay
🇺🇿	country-flag	Uzbekistan	flag | flag: Uzbekistan
🇻🇦	country-flag	Vatican City	flag | flag: Vatican City
🇻🇨	country-flag	St. Vincent & Grenadines	flag | flag: St. Vincent & Grenadines | flag: St Vincent & the Grenadines | flag: Saint Vincent and the Grenadines
🇻🇪	country-flag	Venezuela	flag | flag: Venezuela
🇻🇬	country-flag	British Virgin Islands	flag | flag: British Virgin Islands
🇻🇮	country-flag	U.S. Virgin Islands	flag | flag: U.S. Virgin Islands | flag: US Virgin Islands
🇻🇳	country-flag	Vietnam	flag | flag: Vietnam
🇻🇺	country-flag	Vanuatu	flag | flag: Vanuatu
🇼🇫	country-flag	Wallis & Futuna	flag | flag: Wallis & Futuna | flag: Wallis and Futuna
🇼🇸	country-flag	Samoa	flag | flag: Samoa
🇽🇰	country-flag	Kosovo	flag | flag: Kosovo
🇾🇪	country-flag	Yemen	flag | flag: Yemen
🇾🇹	country-flag	Mayotte	flag | flag: Mayotte
🇿🇦	country-flag	South Africa	flag | flag: South Africa
🇿🇲	country-flag	Zambia	flag | flag: Zambia
🇿🇼	country-flag	Zimbabwe	flag | flag: Zimbabwe
🏴󠁧󠁢󠁥󠁮󠁧󠁿	subdivision-flag	England	flag | flag: England
🏴󠁧󠁢󠁳󠁣󠁴󠁿	subdivision-flag	Scotland	flag | flag: Scotland
🏴󠁧󠁢󠁷󠁬󠁳󠁿	subdivision-flag	Wales	flag | flag: Wales
